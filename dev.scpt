on appIsRunning(appName)
	tell application "System Events" to (name of processes) contains appName
end appIsRunning

if my appIsRunning("iTerm2") then
	tell application "iTerm2"
		set skipDev to false
		set skipGozar to false
		repeat with w in windows
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
		if skipDev is false and (count of (tabs of current window)) < 5 then
				tell application "iTerm2"
					  tell current window
				  	  set terminalContent to text of s
					  if terminalContent contains "dev" then 
				 	     set skipDev to true 

					  else		
	        				set newTab to (create tab with default profile)
        					tell current session of newTab
	    						write text "dev"
        						set skipDev to true 
        						delay 10
       				 		end tell
					  end if
  					end tell
				end tell
		end if
		if skipGozar is false and (count of (tabs of current window)) < 5 then
				tell application "iTerm2"
					tell current window
	        				set newTab to (create tab with default profile)
        					tell current session of newTab
        						write text "cd ~/gozar; pwd"
        						set skipGozar to true
        					end tell	
    					end tell
				end tell
		end if
	end tell
end if
