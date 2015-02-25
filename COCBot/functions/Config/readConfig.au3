;Reads config file and sets variables

Func readConfig() ;Reads config and sets it to the variables
	If FileExists($config) Then
		;Search Settings------------------------------------------------------------------------
		$MinGold = IniRead($config, "search", "searchGold", "80000")
		$MinElixir = IniRead($config, "search", "searchElixir", "80000")
		$MinDark = IniRead($config, "search", "searchDark", "0")
		$MinTrophy = IniRead($config, "search", "searchTrophy", "0")

		$chkConditions[0] = IniRead($config, "search", "conditionGoldElixir", "0")
		$chkConditions[1] = IniRead($config, "search", "conditionDark", "0")
		$chkConditions[2] = IniRead($config, "search", "conditionTrophy", "0")
		$chkConditions[3] = IniRead($config, "search", "conditionGoldorElixir", "0")
		$chkConditions[4] = IniRead($config, "search", "conditionTownHall", "0")
		$chkConditions[5] = IniRead($config, "search", "conditionTownHallO", "0")
		$icmbTH = IniRead($config, "search", "THLevel", "0")
		$ichkMeetOne = IniRead($config, "search", "conditionOne", "0")

		$TakeLootSnapShot = IniRead($config, "search", "TakeLootSnapShot", "0")
		$TakeAllTownSnapShot = IniRead($config, "search", "TakeAllTownSnapShot", "0")

		;Attack Settings-------------------------------------------------------------------------
		$deploySettings = IniRead($config, "attack", "deploy", "0")
		$icmbAlgorithm = IniRead($config, "attack", "algorithm", "0")
		$iradAttackMode = IniRead($config, "attack", "mode", "0")

		$KingAttack[0] = IniRead($config, "attack", "king-dead", "0")
		$KingAttack[2] = IniRead($config, "attack", "king-all", "0")

		$QueenAttack[0] = IniRead($config, "attack", "queen-dead", "0")
		$QueenAttack[2] = IniRead($config, "attack", "queen-all", "0")

		$checkUseClanCastle = IniRead($config, "attack", "use-cc", "0")
		$chkATH = IniRead($config, "attack", "townhall", "0")

		;Donate Settings-------------------------------------------------------------------------
		$CCPos[0] = IniRead($config, "donate", "xCCPos", "0")
		$CCPos[1] = IniRead($config, "donate", "yCCPos", "0")

		$ichkRequest = IniRead($config, "donate", "chkRequest", "0")
		$itxtRequest = IniRead($config, "donate", "txtRequest", "")

		$ichkDonateBarbarians = IniRead($config, "donate", "chkDonateBarbarians", "0")
		$ichkDonateAllBarbarians = IniRead($config, "donate", "chkDonateAllBarbarians", "0")
		$itxtDonateBarbarians = StringReplace(IniRead($config, "donate", "txtDonateBarbarians", "barbarians|barb|any"), "|", @CRLF)

		$ichkDonateArchers = IniRead($config, "donate", "chkDonateArchers", "0")
		$ichkDonateAllArchers = IniRead($config, "donate", "chkDonateAllArchers", "0")
		$itxtDonateArchers = StringReplace(IniRead($config, "donate", "txtDonateArchers", "archers|arch|any"), "|", @CRLF)

		$ichkDonateGiants = IniRead($config, "donate", "chkDonateGiants", "0")
		$ichkDonateAllGiants = IniRead($config, "donate", "chkDonateAllGiants", "0")
		$itxtDonateGiants = StringReplace(IniRead($config, "donate", "txtDonateGiants", "giants|giant|any"), "|", @CRLF)

		;Troop Settings--------------------------------------------------------------------------
		$icmbTroopComp = IniRead($config, "troop", "composition", "0")
		;$icmbTroopCap = IniRead($config, "troop", "capacity", "0")
		$BarbariansComp = IniRead($config, "troop", "barbarian", "0")
		$ArchersComp = IniRead($config, "troop", "archer", "0")
		$GiantsComp = IniRead($config, "troop", "giant", "0")
		$GoblinsComp = IniRead($config, "troop", "goblin", "0")
		$WBComp = IniRead($config, "troop", "WB", "0")

		$barrackPos[0] = IniRead($config, "troop", "xBarrack", "0")
		$barrackPos[1] = IniRead($config, "troop", "yBarrack", "0")
		For $i = 0 To 3 ;Covers all 4 Barracks
			$barrackTroop[$i] = IniRead($config, "troop", "troop" & $i + 1, "0")
		Next

		$ArmyPos[0] = IniRead($config, "troop", "xArmy", "0")
		$ArmyPos[1] = IniRead($config, "troop", "yArmy", "0")

		;Other Settings--------------------------------------------------------------------------
		;Walls
		$ichkWalls = IniRead($config, "other", "auto-wall", "0")
		$icmbWalls = IniRead($config, "other", "walllvl", "0")
		$iUseStorage = IniRead($config, "other", "use-storage", "0")
		$itxtWallMinGold = IniRead($config, "other", "minwallgold", "0")
		$itxtWallMinElixir = IniRead($config, "other", "minwallelixir", "0")
	    $icmbUnitDelay = IniRead($config, "other", "UnitD", "0")
	    $icmbWaveDelay = IniRead($config, "other", "WaveD", "0")
		$ichkTrap = IniRead($config, "other", "chkTrap", "0")
		$TownHallPos[0] = IniRead($config, "other", "xTownHall", "-1")
		$TownHallPos[1] = IniRead($config, "other", "yTownHall", "-1")
	    $iRandomspeedatk = IniRead($config, "other", "randomatk", "0")

		;General Settings--------------------------------------------------------------------------
		$frmBotPosX = IniRead($config, "general", "frmBotPosX", "207")
		$frmBotPosY = IniRead($config, "general", "frmBotPosY", "158")
		$itxtMaxTrophy = IniRead($config, "general", "MaxTrophy", "3000")
		$ichkBackground = IniRead($config, "general", "Background", "0")
		$ichkBotStop = IniRead($config, "general", "BotStop", "0")
		$icmbBotCommand = IniRead($config, "general", "Command", "0")
		$icmbBotCond = IniRead($config, "general", "Cond", "0")
		$icmbHoursStop = IniRead($config, "general", "Hour", "0")
#cs
		For $i = 0 To 16 ;Covers all Collectors
		   $collectorPos[$i][0] = IniRead($config, "general", "xCollector" & $i + 1, "0")
		   $collectorPos[$i][1] = IniRead($config, "general", "yCollector" & $i + 1, "0")
		Next
#ce
	Else
		Return False
	EndIf
EndFunc   ;==>readConfig