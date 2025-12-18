#!/bin/sh

INTERVAL=5

COLOR_DEFAULT="#ffffff"
COLOR_RED="#ff0000"
COLOR_GREEN="#00ff00"


json_escape() {
  # Escape \ and " and newlines for JSON strings
  # (keep it simple; enough for our fields)
  printf '%s' "$1" | sed \
    -e 's/\\/\\\\/g' \
    -e 's/"/\\"/g' \
    -e ':a;N;$!ba;s/\n/\\n/g' \
    -e 's/\r/\\r/g'
}

first_match() {
  pat="$1"
  for d in /sys/class/net/*; do
    iface="$(basename "$d")"
    echo "$iface" | grep -Eq "$pat" || continue
    echo "$iface"
    return 0
  done
  return 1
}

WIFI_IFACE="${WIFI_IFACE:-$(first_match '^(wl|wlan|wlp)')}"
ETH_IFACE="${ETH_IFACE:-$(first_match '^(en|eth|eno|enp)')}"

net_up() {
  iface="$1"
  [ -n "$iface" ] || return 1
  [ -f "/sys/class/net/$iface/operstate" ] || return 1
  [ "$(cat "/sys/class/net/$iface/operstate" 2>/dev/null)" = "up" ]
}

default_dev() {
  ip route show default 2>/dev/null | awk 'NR==1{for(i=1;i<=NF;i++) if($i=="dev"){print $(i+1); exit}}'
}

ip_of() {
  ip -4 -o addr show dev "$1" scope global 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | head -n1
}

link_bw() {
  iface="$1"
  [ -n "$iface" ] || return

  # Wired: negotiated speed in Mb/s (often works with no extra tools)
  if [ -r "/sys/class/net/$iface/speed" ]; then
    sp="$(cat "/sys/class/net/$iface/speed" 2>/dev/null)"
    case "$sp" in
      ''|-1|0) ;;
      *)
        if [ "$sp" -ge 1000 ] 2>/dev/null; then
          awk -v s="$sp" 'BEGIN{printf "%.1fGb/s", s/1000.0}' | sed 's/\.0Gb\/s/Gb\/s/'
        else
          printf "%sMb/s" "$sp"
        fi
        return
      ;;
    esac
  fi

  # WiFi: best effort if `iw` is installed (optional)
  if command -v iw >/dev/null 2>&1; then
    br="$(iw dev "$iface" link 2>/dev/null | awk -F': ' '/tx bitrate:/{print $2; exit}' | awk '{print $1 $2}' )"
    [ -n "$br" ] && printf "%s" "$br" | sed 's/MBit\/s/Mb\/s/; s/GBit\/s/Gb\/s/'
  fi
}


human_rate() {
  awk -v b="$1" 'BEGIN{
    split("B K M G T",u," ");
    i=1;
    while (b>=1024 && i<5) { b/=1024; i++; }
    if (i==1) printf "%.0f%s/s", b, u[i];
    else      printf "%.1f%s/s", b, u[i];
  }'
}

cpu_temp_c() {
  for z in /sys/class/thermal/thermal_zone*; do
    [ -f "$z/temp" ] || continue
    t="$(cat "$z/type" 2>/dev/null)"
    echo "$t" | grep -Eqi 'x86_pkg_temp|cpu|package' || continue
    v="$(cat "$z/temp" 2>/dev/null)"
    [ -n "$v" ] && echo $((v/1000)) && return
  done
  [ -f /sys/class/thermal/thermal_zone0/temp ] && v="$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)" && [ -n "$v" ] && echo $((v/1000)) && return
  echo ""
}

battery_pct() {
  for b in /sys/class/power_supply/BAT*; do
    [ -f "$b/capacity" ] || continue
    cat "$b/capacity" 2>/dev/null
    return
  done
  echo ""
}

ac_online() {
  for a in /sys/class/power_supply/AC* /sys/class/power_supply/ADP* /sys/class/power_supply/Mains*; do
    [ -f "$a/online" ] || continue
    [ "$(cat "$a/online" 2>/dev/null)" = "1" ] && return 0
  done
  return 1
}


battery_status() {
  for b in /sys/class/power_supply/BAT*; do
    [ -f "$b/status" ] || continue
    cat "$b/status" 2>/dev/null
    return
  done
  echo ""
}


# --- i3bar JSON stream header ---
printf '{"version":1}\n[\n'

first=1
prev_dev=""
prev_rx=0
prev_tx=0

while :; do
  items=""

  add_item() {
    text="$1"
    color="$2"
    esc="$(json_escape "$text")"
    if [ -n "$color" ]; then
      obj="{\"full_text\":\"$esc\",\"color\":\"$color\"}"
    else
      obj="{\"full_text\":\"$esc\"}"
    fi
    if [ -z "$items" ]; then
      items="$obj"
    else
      items="$items,$obj"
    fi
  }

    cpu="$(cpu_temp_c)"
    if [ -n "$cpu" ]; then
      if [ "$cpu" -ge 80 ] 2>/dev/null; then
        add_item "CPU ${cpu}°C" "$COLOR_RED"
      else
        add_item "CPU ${cpu}°C" "$COLOR_DEFAULT"
      fi
    fi

    wifi_ok=0
    eth_ok=0

    if net_up "$WIFI_IFACE"; then
      add_item "WiFi" "$COLOR_DEFAULT"
      wifi_ok=1
    fi

    if net_up "$ETH_IFACE"; then
      add_item "Eth" "$COLOR_DEFAULT"
      eth_ok=1
    fi

    if [ "$wifi_ok" -eq 0 ] && [ "$eth_ok" -eq 0 ]; then
      add_item "no" "$COLOR_RED"
    fi

    dev="$(default_dev)"
    ipaddr=""
    bw=""

    if [ -n "$dev" ]; then
      ipaddr="$(ip_of "$dev")"
      bw="$(link_bw "$dev")"
    fi

    if [ -n "$ipaddr" ]; then
      if [ -n "$bw" ]; then
        add_item "${ipaddr} ${bw}" "$COLOR_DEFAULT"
      else
        add_item "${ipaddr}" "$COLOR_DEFAULT"
      fi
    else
      add_item "ip kil" "$COLOR_RED"
    fi

    bat="$(battery_pct)"
    bst="$(battery_status)"

    if [ -n "$bat" ]; then
      if [ "$bat" -le 20 ] 2>/dev/null; then
        add_item "BAT ${bat}%" "$COLOR_RED"
      elif ac_online || [ "$bst" = "Charging" ] || [ "$bst" = "Full" ]; then
        add_item "BAT ${bat}%" "$COLOR_GREEN"
      else
        add_item "BAT ${bat}%" "$COLOR_DEFAULT"
      fi
    fi

  add_item "$(date '+%Y-%m-%d %I:%M %p')" ""

  json="[${items}]"

  if [ "$first" -eq 1 ]; then
    printf '%s\n' "$json"
    first=0
  else
    printf ',%s\n' "$json"
  fi

  sleep "$INTERVAL"
done
