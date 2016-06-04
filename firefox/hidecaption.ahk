#Persistent
SetBatchLines, -1
Process, Priority,, High

Gui +hWndhWnd

DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
Return

ShellMessage( wParam,lParam ) {
  If ( wParam = 4 ) ;  HSHELL_WINDOWACTIVATED := 4
    {
    WinGetClass, Class, ahk_id %lParam%
    If  ( class = "MozillaWindowClass" ) 
        {
            WinSet, Style, -0x80000, ahk_class MozillaWindowClass
        }
    }
}
