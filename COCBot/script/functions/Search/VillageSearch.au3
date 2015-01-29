;Searches for a village that until meets conditions

Func VillageSearch($TakeSS=False) ;Control for searching a village that meets conditions
	While 1
		Switch $iradAttackMode
			Case 0
				SetLog("============Searching For Dead Base============")
			Case 1
				SetLog("============Searching For Weak Base============")
			Case 2
				SetLog("============Searching For All Base============")
		EndSwitch
		SetLog("~Gold: " & $MinGold & "; Elixir: " & $MinElixir & "; Dark: " & $MinDark & "; Trophy: " & $MinTrophy, $COLOR_GREEN)

		$SearchCount = 0
		While 1
			If _Sleep(1000) Then ExitLoop (2)
			GetResources() ;Reads Resource Values

			If $Restart = True Then ExitLoop (2)

			If $TakeSS = True Then
			   SetLog("Taking snapshot of your loot", $COLOR_ORANGE)
			   Local $Date = @MDAY & "." & @MON & "." & @YEAR
			   Local $Time = @HOUR & "." & @MIN & "." & @SEC
			   _CaptureRegion()
			   SetLog("Saving snapshoot of the town in " & @ScriptDir & "\AllTowns\" & $Date & " at " & $Time & ".png", $COLOR_ORANGE)
			   _GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\AllTowns\" & $Date & " at " & $Time & ".png")
			Else
			   SetLog("Skip saving snapshoot of the town", $COLOR_GREEN)
			EndIf
			If CompareResources() Then
				If $iradAttackMode = 0 Then
					If checkDeadBase() Then
						SetLog("~~~~~~~Dead Base Found!~~~~~~~")
						ExitLoop
					Else
						SetLog("~~~~~~~Not dead base, skipping~~~~~~~")
						Click(750, 500) ;Click Next
					EndIf
				Else
					ExitLoop
				EndIf
			Else
				Click(750, 500) ;Click Next
			EndIf
		WEnd
		If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
			TrayTip("Match Found!", "Gold: " & $searchGold & "; Elixir: " & $searchElixir & "; Dark: " & $searchDark & "; Trophy: " & $searchTrophy, "", 0)
			SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		EndIf
		SetLog("===============Searching Complete===============")
		readConfig()
		ExitLoop
	WEnd
EndFunc   ;==>VillageSearch