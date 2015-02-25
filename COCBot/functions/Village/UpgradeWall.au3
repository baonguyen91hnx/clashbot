Global $wallbuild
Global $walllowlevel
Func UpgradeWall ()
    VillageReport()
    SetLog("Checking Upgrade Walls")
			$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
			$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)
			Local $MinWallGold = Number($GoldCount) > Number($itxtWallMinGold)
			Local $MinWallElixir = Number($ElixirCount) > Number($itxtWallMinElixir)
	  If GUICtrlRead($UseGold) = $GUI_CHECKED Then
			$iUseStorage = 1
	  ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
			$iUseStorage = 2
	  ElseIf GUICtrlRead($UseGoldElix) = $GUI_CHECKED Then
			$iUseStorage = 3
	  EndIf
			   IF GUICtrlRead ($chkWalls) = $GUI_CHECKED Then
							 If  $iUseStorage = 1 Then
									   if $MinWallGold Then
								 SetLog("Upgrading Walls Using Gold", $COLOR_BLUE)
								 UpgradeWallGold()
								 Return True
									   Else
									   SetLog("Gold is lower than GoldMin, Skip Upgrade", $COLOR_RED)
									   EndIf

							  ElseIf $iUseStorage = 2  then
									if $MinWallElixir Then
									Setlog ("Upgrading Walls Using Elix", $COLOR_BLUE)
									UpgradeWallElix()
									Return True
									Else
									Setlog ("Elix is lower than ElixMin, Skip Ugrade", $COLOR_BLUE)
								    Endif

							  ElseIf $iUseStorage = 3 Then
									if $MinWallGold Then
								 	SetLog("Upgrading Walls Using Gold", $COLOR_BLUE)
									UpgradeWallGold()
									   If $wallbuild = 0 Then
										   If $walllowlevel = 0 Then
										  		  SetLog("Upgrade by Gold fail, Trying Upgrade Walls Using Elix", $COLOR_BLUE)
										  UpgradeWallElix()
										  Else
											 SetLog("Wall Low Level Than 8, Skip Upgrade by Elixir", $COLOR_BLUE)
										  EndIf
									   Else
										  UpgradeWallGold()

									   EndIf
									Else
									   SetLog("Gold is lower than GoldMin, Trying Upgrade Walls Using Elix", $COLOR_RED)
											 if $MinWallElixir Then
											 UpgradeWallElix()
										  Else
											 Setlog ("Elix is lower than ElixMin, Skip Ugrade", $COLOR_BLUE)
										  EndIf
									EndIf


							  EndIf
			   Else
						SetLog("Uncheck Upgrade Wall option, Skip Upgrade ", $COLOR_RED)
			   EndIf
EndFunc


Func UpgradeWallelix()

   	  If $FreeBuilder = 0 Then
						SetLog("Don't have any free builders", $COLOR_RED)
	  Else
						checkWall()
				if $checkwalllogic = True Then
						Click(1, 1) ; Click Away
						_Sleep(600)
						Click($WallX, $WallY)
						_Sleep(600)
						_CaptureRegion()
							  If _ColorCheck(_GetPixelColor(596, 570), Hex(0xFFFFFF, 6), 20) = False Then
								 SetLog("Not enough Elix or your Wall is lower than level 8 ", $COLOR_ORANGE)

							  Else
									If _ColorCheck(_GetPixelColor(596, 570), Hex(0xFFFFFF, 6), 20) = True  or _ColorCheck(_GetPixelColor(583, 570), Hex(0xFFFFFF, 6), 20) = True Then
										  Click(560, 599) ; Click Upgrade
											 _Sleep(2000)
										  Click(472, 482) ; Click Okay
										  SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
													  _Sleep(1000)
									Else
													  Click(1, 1) ; Click away
													  _Sleep(1000)
									Endif
								 EndIf
				  Else
				  EndIf

	  EndIf
		 Click(1, 1) ; Click Away
	  EndFunc






Func UpgradeWallGold()

   	 If $FreeBuilder = 0 Then
				  SetLog("Don't have any free builders", $COLOR_RED)
			Else

					 checkWall()
					 if $checkwalllogic = True Then
						Click(1, 1) ; Click Away
						_Sleep(600)
						Click($WallX, $WallY)
						_Sleep(600)
						_CaptureRegion()
					 If _ColorCheck(_GetPixelColor(523, 641), Hex(0x000000, 6), 20) = False Then  ; checking wall level high than level 8
						$walllowlevel = 0

						   	  If _ColorCheck(_GetPixelColor(500, 570), Hex(0xE70A12, 6), 20) or  _ColorCheck(_GetPixelColor(496, 570), Hex(0xE70A12, 6), 20)  Then
								 SetLog("Not enough Gold...", $COLOR_ORANGE)
								 Click(1, 1) ; Click Away
								 $wallbuild = 0
							  Else
									If _ColorCheck(_GetPixelColor(500, 570), Hex(0xFFFFFF, 6), 20) = True  or _ColorCheck(_GetPixelColor(583, 570), Hex(0xFFFFFF, 6), 20) = True  Then
										  Click(505, 596) ; Click Upgrade
											 _Sleep(2000)
										  Click(472, 482) ; Click Okay
										  SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
										  $wallbuild =1
													  _Sleep(1000)
									Else
													  Click(1, 1) ; Click away
													  _Sleep(1000)
									Endif
							  EndIf
						   Else ; check wall level lower than 8
							  $walllowlevel=1
							  If _ColorCheck(_GetPixelColor(549, 570), Hex(0xE70A12, 6), 20) or  _ColorCheck(_GetPixelColor(540, 570), Hex(0xE70A12, 6), 20)  Then
								 SetLog("Not enough Gold...", $COLOR_ORANGE)
								 Click(1, 1) ; Click Away
								 $wallbuild = 0
							  Else
									If _ColorCheck(_GetPixelColor(549, 570), Hex(0xFFFFFF, 6), 20) or  _ColorCheck(_GetPixelColor(540, 570), Hex(0xFFFFFF, 6), 20)  Then
									Click(505, 596) ; Click Upgrade
											 _Sleep(2000)
										  Click(472, 482) ; Click Okay
										  SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
										  $wallbuild =1
													  _Sleep(1000)
									Else
									   		  Click(1, 1) ; Click away
											 _Sleep(1000)
									EndIf
							  EndIf

					EndIf
				  Else
				  EndIf

	  EndIf
		 Click(1, 1) ; Click Away
	  EndFunc