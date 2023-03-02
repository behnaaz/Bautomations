on appIsRunning(appName)
	tell application "System Events" to (name of processes) contains appName
end appIsRunning

if my appIsRunning("iTerm2") then
	tell application "iTerm2"
		set skipDev to false
		set skipGozar to false
		repeat with w in windows
			if (count of (tabs of w)) is 0 then
				exit repeat
			end if
			set s to w's current tab's current session
			set thetitle to get name of s
			if thetitle is "ssh" then
				set skipDev to true
			else
				tell s
        				write text "pwd"
        				set terminalContent to text of s
    				end tell
				if terminalContent contains "gozar" then
					set skipGozar to true
				end if
			end if
		end repeat
		if skipDev is false then
    			set newWindow to (create window with default profile)
    			tell current session of newWindow
        			write text "dev"
    			end tell
		end if
		if skipGozar is false then
    			set newWindow to (create window with default profile)
    			tell current session of newWindow
        			write text "cd ~/gozar; pwd"
    			end tell
		end if
	end tell
end if
