;Applies all of the  variable to the GUI

Func applyConfig() ;Applies the data from config to the controls in GUI
	;Search Settings------------------------------------------------------------------------
	GUICtrlSetData($txtMinGold, $MinGold)
	GUICtrlSetData($txtMinElixir, $MinElixir)
	GUICtrlSetData($txtMinDarkElixir, $MinDark)
	GUICtrlSetData($txtMinTrophy, $MinTrophy)

	If $chkConditions[0] = 1 Then
		GUICtrlSetState($chkMeetGxE, $GUI_CHECKED)
	ElseIf $chkConditions[0] = 0 Then
		GUICtrlSetState($chkMeetGxE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[1] = 1 Then
		GUICtrlSetState($chkMeetDE, $GUI_CHECKED)
	ElseIf $chkConditions[1] = 0 Then
		GUICtrlSetState($chkMeetDE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[2] = 1 Then
		GUICtrlSetState($chkMeetTrophy, $GUI_CHECKED)
	ElseIf $chkConditions[2] = 0 Then
		GUICtrlSetState($chkMeetTrophy, $GUI_UNCHECKED)
	EndIf
	;Attack Settings-------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbDeploy, $deploySettings)
	_GUICtrlComboBox_SetCurSel($cmbAlgorithm, $icmbAlgorithm)

	Switch $iradAttackMode
		Case 0
			GUICtrlSetState($radDeadBases, $GUI_CHECKED)
			GUICtrlSetState($radWeakBases, $GUI_UNCHECKED)
			GUICtrlSetState($radAllBases, $GUI_UNCHECKED)
		Case 1
			GUICtrlSetState($radDeadBases, $GUI_UNCHECKED)
			GUICtrlSetState($radWeakBases, $GUI_CHECKED)
			GUICtrlSetState($radAllBases, $GUI_UNCHECKED)
		Case 2
			GUICtrlSetState($radDeadBases, $GUI_UNCHECKED)
			GUICtrlSetState($radWeakBases, $GUI_UNCHECKED)
			GUICtrlSetState($radAllBases, $GUI_CHECKED)
	EndSwitch

	If $KingAttack[0] = 1 Then
		GUICtrlSetState($chkKingAttackDeadBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackDeadBases, $GUI_UNCHECKED)
	EndIf
	If $KingAttack[2] = 1 Then
		GUICtrlSetState($chkKingAttackAllBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackAllBases, $GUI_UNCHECKED)
	EndIf

	If $QueenAttack[0] = 1 Then
		GUICtrlSetState($chkQueenAttackDeadBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackDeadBases, $GUI_UNCHECKED)
	EndIf
	If $QueenAttack[2] = 1 Then
		GUICtrlSetState($chkQueenAttackAllBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackAllBases, $GUI_UNCHECKED)
	EndIf
	;Donate Settings-------------------------------------------------------------------------
	If $ichkRequest = 1 Then
		GUICtrlSetState($chkRequest, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRequest, $GUI_UNCHECKED)
	EndIf

	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateBarbarians = 1 Then
		GUICtrlSetState($chkDonateBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllBarbarians = 1 Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
	EndIf
	;````````````````````````````````````````````````
	If $ichkDonateArchers = 1 Then
		GUICtrlSetState($chkDonateArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllArchers = 1 Then
		GUICtrlSetState($chkDonateAllArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
	EndIf
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateGiants = 1 Then
		GUICtrlSetState($chkDonateGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllGiants = 1 Then
		GUICtrlSetState($chkDonateAllGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
	EndIf

	GUICtrlSetData($txtDonateBarbarians, $itxtDonateBarbarians)
	GUICtrlSetData($txtDonateArchers, $itxtDonateArchers)
	GUICtrlSetData($txtDonateGiants, $itxtDonateGiants)

	GUICtrlSetData($txtRequest, $itxtRequest)
	chkRequest()
	;Troop Settings--------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbTroopComp, $icmbTroopComp)
	SetComboTroopComp()

	_GUICtrlComboBox_SetCurSel($cmbBarrack1, $barrackTroop[0])
	_GUICtrlComboBox_SetCurSel($cmbBarrack2, $barrackTroop[1])
	_GUICtrlComboBox_SetCurSel($cmbBarrack3, $barrackTroop[2])
	_GUICtrlComboBox_SetCurSel($cmbBarrack4, $barrackTroop[3])
	;General Settings--------------------------------------------------------------------------
	If $frmBotPosX <> -32000 Then WinMove($sBotTitle, "", $frmBotPosX, $frmBotPosY)
	GUICtrlSetData($txtMaxTrophy, $itxtMaxTrophy)

	If $ichkBackground = 1 Then
		GUICtrlSetState($chkBackground, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBackground, $GUI_UNCHECKED)
	EndIf
	chkBackground() ;Applies it to hidden button
EndFunc   ;==>applyConfig