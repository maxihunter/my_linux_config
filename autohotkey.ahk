; This should be replaced by whatever your native language is. See 
; http://msdn.microsoft.com/en-us/library/dd318693%28v=vs.85%29.aspx
; for the language identifiers list.
ru := DllCall("LoadKeyboardLayout", "Str", "00000419", "Int", 1)
en := DllCall("LoadKeyboardLayout", "Str", "00000409", "Int", 1)
ch := DllCall("LoadKeyboardLayout", "Str", "00000804", "Int", 1)

#a::
SetDefaultKeyboard(0x0419)
PostMessage 0x50, 0, %ru%,, A
return

#s::
SetDefaultKeyboard(0x0409)
;PostMessage 0x50, 0, %en%,, A
return

#w::
SetDefaultKeyboard(0x0804)
;PostMessage 0x50, 0, %ch%,, A
return

;w := DllCall("GetForegroundWindow")
;pid := DllCall("GetWindowThreadProcessId", "UInt", w, "Ptr", 0)
;l := DllCall("GetKeyboardLayout", "UInt", pid)
;if (l = en)
;{
;    PostMessage 0x50, 0, %ru%,, A
;}
;else
;{
;   PostMessage 0x50, 0, %en%,, A
;}

SetDefaultKeyboard(LocaleID){
	Global
	SPI_SETDEFAULTINPUTLANG := 0x005A
	SPIF_SENDWININICHANGE := 2
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(Lan%LocaleID%, 4, 0)
	NumPut(LocaleID, Lan%LocaleID%)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
	WinGet, windows, List
	Loop %windows% {
		PostMessage 0x50, 0, %Lan%, , % "ahk_id " windows%A_Index%
	}
}
