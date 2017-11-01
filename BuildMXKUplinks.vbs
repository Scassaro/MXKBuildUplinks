#$language = "VBScript"
#$interface = "1.0"

'This program is intended to speed up adding MXK uplink bridges for bridge type testing.
'Author: Stephen Cassaro
'Company: Dasan Zhone Solutions

crt.Screen.Synchronous = True

Sub Main

'Detemine MXK type to choose uplink building commands correctly.
	
	Dim ButtonResponse
	Dim UplinkPort
	Dim UplinkLocation
	ButtonResponse = MsgBox("What type of MXK is this? (Abort = MXK, Retry = F, Ignore = 219)", vbAbortRetryIgnore, "MXK Type")
	If ButtonResponse = 3 Then
		UplinkPort = "1-a-2-0/eth"
		UplinkLocation = 2
	ElseIf ButtonResponse = 4 Then
		UplinkPort = "1-a-3-0/eth"
		UplinkLocation = 3
	Else	
		UplinkPort = "1-1-101-0/eth"
		UplinkLocation = 101
	End If
	
	Call BuildUplinks(UplinkPort, UplinkLocation)
	
	MsgBox("Uplinks built.", BuildUplinks)

End Sub

Sub BuildUplinks(ByVal UplinkPort, ByVal UplinkLocation)

	crt.Screen.Send "bridge add " & UplinkPort & " uplink vlan 500 tagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " uplink vlan 101 slan 502 stagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " tls vlan 3003 tagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " tls vlan 102 slan 3004 stagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " wire vlan 3005 tagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " wire vlan 103 slan 3006 stagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " uplink vlan 998 tagged igmpproxy" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " mvr vlan 997 tagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " uplink vlan 1997 tagged igmpproxy" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " mvr vlan 995 tagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " mvr vlan 996 tagged" & chr(13)
	crt.Screen.WaitForString "zSH> "
	
	'Use ButtonResponse to figure out which port the 995 bridge was built on to modify the bridge path.
	
	crt.Screen.Send "bridge-path add ethernet" & UplinkLocation & "-995/bridge vlan 996 secmvr" & chr(13)
	crt.Screen.WaitForString "zSH> "
	crt.Screen.Send "bridge add " & UplinkPort & " uplink vlan 1996 tagged igmpproxy" & chr(13)
	crt.Screen.WaitForString "zSH> "

End Sub