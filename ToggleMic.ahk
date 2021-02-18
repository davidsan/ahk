; AutoHotkey script to toggle mute microphone

; Use Soundcard Analysis to determine MicDeviceNumber
; https://www.autohotkey.com/docs/commands/SoundSet.htm#Soundcard
MicDeviceNumber := 3

#SingleInstance, force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu, Tray, NoStandard
Menu, Tray, Add, M&ute Mic,ExitSub
Menu, Tray, ToggleEnable, M&ute Mic
Menu, Tray, Add
Menu, Tray, Add, E&xit, ExitSub
Menu, Tray, Icon, imageres.dll, 233, 1
Menu, Tray, Tip, Mic Muted

OnExit, ExitSub
SoundSet, 1, , MUTE, MicDeviceNumber
Return

MuteMic() {
	local MM
	SoundSet, +1, , MUTE, MicDeviceNumber
	SoundGet, MM, , MUTE, MicDeviceNumber

	SoundSet, 79, , VOLUME, MicDeviceNumber

	#Persistent
	SoundBeep, % (MM == "On" ? "200" : "300")
	ToolTip, % (MM == "On" ? "Mic Muted" : "Mic Active")
	Menu, Tray, Tip, % (MM == "On" ? "Mic Muted" : "Mic Active")
	Menu, Tray, Icon, imageres.dll, % (MM == "On" ? "233" : "228"), 1

	SetTimer, RemoveMuteMicTooltip, 700
	return
}

RemoveMuteMicTooltip:
	SetTimer, RemoveMuteMicTooltip, Off
	ToolTip
	return

$Pause::MuteMic()

ExitSub:
	SoundSet, 0, , MUTE, MicDeviceNumber
	ExitApp
