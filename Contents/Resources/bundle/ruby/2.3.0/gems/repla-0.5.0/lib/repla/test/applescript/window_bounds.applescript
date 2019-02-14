on run windowid
	tell application "Repla"

		if windowid is {} then
			set theWindow to window 1
		else
			set theWindow to window id windowid
		end if

		set theBounds to bounds of theWindow

		
		set originalTextItemDelimiters to AppleScript's text item delimiters
		set AppleScript's text item delimiters to ", "
		set theTextBounds to theBounds as text
		set AppleScript's text item delimiters to originalTextItemDelimiters
		
		return theTextBounds
	end tell
end run
