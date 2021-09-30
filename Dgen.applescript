--DGen Launcher By Alex Free 8/13/2020
--Updated 9/27/2021
global bin_path
set bin_path to ""

tell application "Finder"
	set bin_path to POSIX path of ((path to me as text))
end tell

tell me
	activate
	set actionChoice to (choose from list {"About", "Configure", "Configure Xbox 360 Controller(s) Support", "Load ROM"} with prompt "Dgen" OK button name "OK" cancel button name "Cancel" default items "Load ROM" without multiple selections allowed) as text
end tell

if actionChoice is "About" then
	set dabout to do shell script ("" & bin_path & "/bin/dgen -v")
	display dialog ("" & dabout) buttons "OK"
else if actionChoice is "Configure" then
	do shell script ("if  [ ! -f ~/.dgen/dgenrc ]; then mkdir -p ~/.dgen; touch ~/.dgen/dgenrc; open -e ~/.dgen/dgenrc; else open -e ~/.dgen/dgenrc; fi")
	display dialog ("Please save the text edit window to apply any changes to the DGEN config file.") buttons "OK"
else if actionChoice is "Configure Xbox 360 Controller(s) Support" then
	do shell script ("mkdir -p ~/.dgen; cp  " & bin_path & "/xbox360config ~/.dgen/dgenrc;")
	display dialog ("Xbox 360 Controller(s) support has been configured") buttons "OK"
else if actionChoice is "Load ROM" then
	set rom to POSIX path of (choose file with prompt "Select ROM (.md,.bin,.zip,.gz,etc...)")
	tell application "System Events"
		set terminalRunning to count of (every process whose name is "Terminal")
		if terminalRunning is 1 then
			tell application "Terminal"
				activate
			end tell
			tell application "System Events" to keystroke "n" using command down
			tell application "Terminal"
				set background color of first window to "black"
				set cursor color of first window to "white"
				set normal text color of first window to "white"
				set bold text color of first window to "white"
			end tell
		else
			tell application "Terminal"
				activate
			end tell
			tell application "Terminal"
				set background color of first window to "black"
				set cursor color of first window to "white"
				set normal text color of first window to "white"
				set bold text color of first window to "white"
			end tell
		end if
	end tell
	
	tell application "Terminal"
		do script "clear; " & bin_path & "/bin/dgen \"" & rom & "\"" in first window
	end tell
end if