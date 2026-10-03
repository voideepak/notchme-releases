# NotchMe

A macOS app that turns the MacBook notch into a small dashboard: a Pomodoro timer, a Timer and Stopwatch, today's Calendar, To-dos from Apple Reminders, Spotify, Apple Notes, a Teleprompter, Claude Code and Codex sessions and usage, App Time, the top processes, and a Clipboard History.

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

NotchMe checks for a new version at launch and once a day, and shows it in Settings › General with a dot on the gear. **Download** opens the release page; replace the app the same way. Turn the check off in Settings if you'd rather it stayed offline.

NotchMe has no Dock icon. It lives in the notch: hover to see it, click to open it, or press **⌥⌘N** from any app. Settings (the gear) lets you change that shortcut, pick the Accent colour of the open notch, pin up to 8 Tabs to the Tab bar and put them in your own order (the rest wait under **⋯ More**), choose what the collapsed notch shows, and pick which figure stands for Claude and Codex on Home and in the notch.

The notch shows on every display. On an external monitor, or with the lid closed, NotchMe draws one at the top centre of the screen. It opens on the display you click, or the one with the pointer for ⌥⌘N, Tab shortcuts, and a Phase or Timer running out. Clicking another display's notch while it's open moves it there. It steps aside over a fullscreen app on an external monitor, but still opens there for ⌥⌘N or a Phase or Timer running out. Turn off **Notch on every display** in Settings › General to keep it on the MacBook only.

Home is yours to arrange. Click the pencil in the Tab bar (or right-click a card and choose **Edit Home**) to add a card for any Tab with **+**, remove one with ⊖, drag cards around, and resize them with the corner handle or right-click › **Size**. Cards snap to a 4×2 grid, each in the sizes that suit it, and dropping a card on another swaps them. **Reset** puts back the default; **Done** or Esc finishes.

### Shortcuts

| Keys | Does |
|---|---|
| ⌥⌘N | Open or close the notch (change it in Settings › General) |
| ⌥⌘1–⌥⌘9 | Open the notch on that Tab from any app (Home, then your pinned Tabs, as in the Tab bar; pin and reorder in Settings › Tabs); again to close |
| ⌘1–⌘9 | Switch Tabs while the notch is open |
| Esc | Close the notch; while typing, stop editing first (a rename goes back to the old title) |
| ⌥⌘P | Play or pause the Teleprompter, while its Tab is open |
| ⌥⌘↑ / ⌥⌘↓ | Teleprompter faster / slower, while its Tab is open |

While the Teleprompter is playing, the notch stays open when you click into another app, so you can read while you record. Esc or ⌥⌘N closes it and pauses, and so does switching to another Tab. Keep as many Scripts as you like, each remembering where you stopped, or import one from a recent Apple Note. Playing from the top starts with a 3-2-1 Countdown, and **Mirrored** flips the text for a beamsplitter (both in Settings › General).

On the To-do Tab, double-click a To-do to rename it; click its due date, **Add date**, or **…** to change the date or Priority; and use the trash to delete it (with 3 seconds to undo). The first line of a reminder's notes shows under its title.

The Clock Tab holds the Pomodoro, a Timer with presets from 1 to 60 minutes, and a Stopwatch with Laps; pick one at its top. When a Phase or Timer runs out, the notch opens on Clock with a sound; all three keep running while the notch is closed or NotchMe is quit.

The Clipboard Tab keeps the last 20 pieces of text you copied; click one to copy it again. It keeps nothing a password manager marks as a password, and it forgets everything on quit or when you switch off **Keep Clipboard History** in Settings › General.

While Spotify plays, the collapsed notch shows the album art with small bars beside it, coloured from the art. The Spotify Tab shows the album, shuffle and repeat, and lets you click or drag the progress bar to jump within the track. The speech-bubble button swaps the art for the track's lyrics: timed lyrics follow along, and clicking a line jumps there. Lyrics come from [LRCLIB](https://lrclib.net), which is only asked, with the track's title, artist, album, and length, while lyrics are on screen.

### Permissions

macOS asks the first time each feature needs one. Every release is signed with the same certificate, so updates keep the permissions you've already given.

| Asked for | Used for |
|---|---|
| Calendar | today's Agenda, Meeting countdowns, and Join buttons |
| Reminders | To-dos from the list you choose: adding, completing, deleting, renaming, due dates, Priority, and Done Today |
| Automation: Spotify | now playing, playback controls, shuffle, repeat, and jumping within a track |
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
