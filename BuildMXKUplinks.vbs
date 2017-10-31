
Sub Main

'Detemine MXK type to choose commands correctly.
	
	Dim ButtonResponse
	Dim MXKType
	ButtonResponse = MsgBox("What type of MXK is this? (Abort = MXK, Retry = F, Ignore = 219)", vbAbortRetryIgnore, "MXK Type")
	If ButtonResponse = 3 Then
		MXKType = "MXK"
	ElseIf ButtonResponse = 4 Then
		MXKType = "MXK-F" 
	Else	
		MXKType = "219"
	End If
	
Main