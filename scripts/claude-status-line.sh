#!/bin/sh
# Claude Code status line for NotchMe. Saves Usage Limits and the live session's context
# window size under ~/.claude/notchme, then prints "5h 42% · Wk 18%" for the status line.
input=$(cat)
dir="$HOME/.claude/notchme"

if printf '%s' "$input" | jq -e '.rate_limits' >/dev/null 2>&1; then
    mkdir -p "$dir"
    printf '%s' "$input" | jq -c --argjson readAt "$(date +%s)" '{read_at: $readAt, rate_limits: .rate_limits}' \
        > "$dir/usage-limits.json.tmp" && mv "$dir/usage-limits.json.tmp" "$dir/usage-limits.json"
fi

session_id=$(printf '%s' "$input" | jq -r '.session_id // empty' 2>/dev/null)
context_window_size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // empty' 2>/dev/null)
case "$session_id" in
    ''|*[!A-Za-z0-9_-]*) ;;
    *)
        case "$context_window_size" in
            ''|*[!0-9]*|0) ;;
            *)
                context_dir="$dir/context-windows"
                mkdir -p "$context_dir"
                printf '%s' "$input" | jq -c '{context_window: {context_window_size: .context_window.context_window_size}}' \
                    > "$context_dir/$session_id.json.tmp.$$" && mv "$context_dir/$session_id.json.tmp.$$" "$context_dir/$session_id.json"
                ;;
        esac
        ;;
esac

printf '%s' "$input" | jq -r '[
    (.rate_limits.five_hour.used_percentage // empty | "5h \(round)%"),
    (.rate_limits.seven_day.used_percentage // empty | "Wk \(round)%")
] | join(" · ")'
