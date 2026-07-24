#Requires AutoHotkey v2.0
; Use Caps Lock to switch the input language on older versions of Windows.

SetCapsLockState "AlwaysOff"

CapsLock::Send "#{Space}"

+CapsLock::SetCapsLockState !GetKeyState("CapsLock", "T")
