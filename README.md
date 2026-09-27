# NotchMe

A macOS app that turns the MacBook notch into a small dashboard: a Pomodoro timer, today's Calendar, To-dos from Apple Reminders, Spotify, Apple Notes, a Teleprompter, Claude Code and Codex sessions and usage, App Time, and the top processes.

Requires a Mac with a notch and macOS 14 or later.

## Install

1. Download `NotchMe-<version>.dmg` from the [Releases page](https://github.com/voideepak/notchme-releases/releases) and open it.
2. Drag **NotchMe** to **Applications**. Don't run it from inside the disk image.

NotchMe isn't notarized by Apple, so macOS blocks the first launch: it says the app is from an unidentified developer, or that it can't check the app for malicious software. Get past this once, in any of these ways:

- **A. Right-click → Open (macOS 14 and earlier).** In Finder → Applications, Control-click (or right-click) **NotchMe → Open**, then click **Open** in the warning.
- **B. Privacy & Security (any macOS; the only click-through on macOS 15 and later).** Try to open NotchMe once and dismiss the warning. Then open **System Settings → Privacy & Security**, scroll down to the message about NotchMe, click **Open Anyway**, and enter your password. The button only shows for about an hour after the blocked attempt.
- **C. Terminal (any macOS).** Run this, then open NotchMe normally:

  ```sh
  xattr -dr com.apple.quarantine /Applications/NotchMe.app
  ```

After that, NotchMe opens like any other app. You do this once per download.

NotchMe has no Dock icon. It lives in the notch: hover to see it, click to open it, or press **⌥⌘N** from any app. Settings (the gear) lets you change that shortcut, hide Tabs you don't use, choose what the collapsed notch shows, and pick which figure stands for Claude and Codex on Home and in the notch.

### Shortcuts

| Keys | Does |
|---|---|
| ⌥⌘N | Open or close the notch (change it in Settings › General) |
| ⌥⌘1–⌥⌘9 | Open the notch on that Tab from any app (numbered as in the Tab bar); again to close |
| ⌘1–⌘9 | Switch Tabs while the notch is open |
| Esc | Close the notch; while typing, stop editing first (a rename goes back to the old title) |
| ⌥⌘P | Play or pause the Teleprompter, while its Tab is open |
| ⌥⌘↑ / ⌥⌘↓ | Teleprompter faster / slower, while its Tab is open |

While the Teleprompter is playing, the notch stays open when you click into another app, so you can read while you record. Esc or ⌥⌘N closes it and pauses, and so does switching to another Tab. Keep as many Scripts as you like, each remembering where you stopped, or import one from a recent Apple Note.

On the To-do Tab, double-click a To-do to rename it, and click its due date (or **Add date**) to change or clear it.

### Permissions

macOS asks the first time each feature needs one. Every release is signed with the same certificate, so updates keep the permissions you've already given.

| Asked for | Used for |
|---|---|
| Calendar | today's Agenda, Meeting countdowns, and Join buttons |
| Reminders | To-dos from the list you choose: adding, completing, renaming, due dates, and Done Today |
| Automation: Spotify | now playing and playback controls |
| Automation: Notes | recent notes, Quick Capture, and importing a note as a Script |
| Automation: iTerm2 | bringing a waiting Claude or Codex session's tab to the front |

## Claude Code usage limits and context

The Claude Tab reads what Claude Code already writes under `~/.claude`. Usage Limits and the context window size come from Claude Code's status line, so NotchMe ships a status line script that saves them. It needs [`jq`](https://jqlang.org) (`brew install jq`).

Copy [`scripts/claude-status-line.sh`](scripts/claude-status-line.sh) somewhere permanent, make it executable, and point Claude Code at it in `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/path/to/claude-status-line.sh"
  }
}
```

Your status line then shows `5h 42% · Wk 18%`. If you already use a status line, NotchMe works without this script. The Claude Tab still shows sessions, activity, and tokens, but no Usage Limits, and context only as a count.
