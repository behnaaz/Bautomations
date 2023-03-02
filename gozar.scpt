tell application "iTerm"
    set newWindow to (create window with default profile)
    tell current session of newWindow
	write text "cd ~/gozar"
    end tell
end tell
