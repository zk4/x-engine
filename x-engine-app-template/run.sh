osascript -e 'tell application "Xcode"
    activate
    tell application "System Events"
        perform (keystroke "r" using command down)
    end tell
end tell'
