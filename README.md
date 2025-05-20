# 🧼 Mac Auto Cleaner + Countdown Widget

This project includes everything you need to:
- Automatically clean your Mac's memory and cache every 2 hours
- Display a live countdown timer on your desktop using the [Übersicht](http://tracesof.net/uebersicht/) widget system

---

## 📁 What's Included

| File | Purpose |
|------|---------|
| `clean_mac.sh` | Shell script to clear inactive memory and delete cache files |
| `com.user.maccleaner.plist` | `launchd` agent that runs the script every 2 hours |
| `Countdown.widget/index.coffee` | Übersicht widget showing countdown to next cleanup |
| `README.md` | Setup guide and explanations |

---

## 🛠️ Setup Instructions

### Step 1: Create the Shell Script

1. Open **Terminal**
2. Create the script file:
   ```bash
   nano ~/clean_mac.sh
3. Paste this code:
#!/bin/bash
purge
rm -rf ~/Library/Caches/*
osascript -e 'display notification "Mac cleanup complete!" with title "Auto Cleaner"'
Save and exit: Control + X, then Y, then Enter
Make it executable:
chmod +x ~/clean_mac.sh
✅ This script deletes temporary cache and triggers a notification. purge is used to free up inactive RAM.
Step 2: Schedule the Script with launchd
Open:
nano ~/Library/LaunchAgents/com.user.maccleaner.plist
Paste:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.user.maccleaner</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>/Users/YOUR_USERNAME/clean_mac.sh</string>
  </array>
  <key>StartInterval</key>
  <integer>7200</integer> <!-- 2 hours -->
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
Replace YOUR_USERNAME with your Mac username (use whoami in Terminal to find it)
Load the script:
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.user.maccleaner.plist
🧠 launchd is macOS's built-in task scheduler. This .plist file tells it to run the script every 7200 seconds (2 hours).
Step 3: Add Countdown Widget with Übersicht
Install Übersicht
Click the menu icon > Open Widgets Folder
Create a new folder named:
Countdown.widget
Inside that folder, create a file named index.coffee
Paste this code:
command: "echo $((7200 - $(($(date +%s) % 7200))))"

refreshFrequency: 1000

render: (output) ->
  minutes = Math.floor(output / 60)
  seconds = output % 60
  """
  <div class='container'>
    <div class='title'>Next Cleanup In:</div>
    <div class='timer'>#{minutes}m #{seconds}s</div>
  </div>
  """

style: """
  top: 20px
  left: 20px
  color: #ffffff
  font-family: Helvetica Neue
  font-size: 24px
  background-color: rgba(0, 0, 0, 0.5)
  padding: 10px
  border-radius: 10px
  .title
    font-size: 14px
    color: #cccccc
  .timer
    font-size: 24px
    font-weight: bold
"""
Save and Reload Widgets from the Übersicht menu
🧠 This widget calculates how many seconds are left until the next 2-hour cycle completes. It refreshes every second and updates on-screen.
