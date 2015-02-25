$frmBot = GUICreate($sBotTitle, 470, 605)
GUISetIcon(@ScriptDir & "\Icons\cocbot.ico")
TraySetIcon(@ScriptDir & "\Icons\cocbot.ico")
$tabMain = GUICtrlCreateTab(40, 85, 450, 395, BitOR($TCS_MULTILINE, $TCS_BUTTONS, $TCS_FIXEDWIDTH)) ;dont use as reference points (true size of tab = (150, 80, 450, 400)
GUICtrlSetOnEvent(-1, "tabMain")
GUICtrlCreatePic (@ScriptDir & "\Icons\logo.jpg", 0, 0, 470, 80)

;~ ------------------------------------------------------

;current loot
   $CurrentLoot = GUICtrlCreateGroup("Current Loot", 236, 470, 220, 105)
	  $lblgoldnow = GUICtrlCreateLabel("Gold Now :",290, 490, 60, 15)
	  GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", 261, 490, 15, 15)
	  $lblresultgoldnow = GUICtrlCreateLabel("0", 385, 490, 60, 15, $SS_RIGHT)
	  $lblelixirnow = GUICtrlCreateLabel("Elixir Now :", 290, 510, 60, 15)
	  $lblresultelixirnow = GUICtrlCreateLabel("0", 385, 510, 60, 15, $SS_RIGHT)
	  GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", 261, 510, 15, 15)
	  $lbldenow = GUICtrlCreateLabel("DE Now :", 290, 530, 60, 15)
	  $lblresultdenow = GUICtrlCreateLabel("0", 385, 530, 60, 15, $SS_RIGHT)
	  GUICtrlCreatePic (@ScriptDir & "\Icons\Dark.jpg", 261, 530, 15, 15)
	  $lbltrophynow = GUICtrlCreateLabel("Trophies Now :", 290, 550, 80, 15)
	  $lblresulttrophynow = GUICtrlCreateLabel("0", 385, 550, 60, 15, $SS_RIGHT)
	  GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", 261, 550, 15, 15)

$StartStop = GUICtrlCreateGroup("", 16, 470, 215, 105)
	  $btnStart = GUICtrlCreateButton("Start Bot", 25, 480, 110, 40)
	  GUICtrlSetOnEvent(-1, "btnStart")
;~ 	  GUICtrlSetBkColor(-1, 0x33CC33)
	  $btnStop = GUICtrlCreateButton("Stop Bot", 25, 483, 110, 40)
	  GUICtrlSetOnEvent(-1, "btnStop")
;~ 	  GUICtrlSetBkColor(-1, 0xFA0334)
	  GUICtrlSetState(-1, $GUI_HIDE)
	  $btnHide = GUICtrlCreateButton("Hide BS", 25, 527, 110, 40)
	  GUICtrlSetOnEvent(-1, "btnHide")
;~ 	  GUICtrlSetBkColor(-1, 0x22C4F5)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkNoAttack = GUICtrlCreateCheckbox("Donate/Train Only", 143, 485, 80, 30, $BS_MULTILINE)
	  GUICtrlSetOnEvent(-1, "chkNoAttack")
	  GUICtrlSetTip(-1, "Click here to disable attacking, and only do collections/training/donating")
	  $chkBackground = GUICtrlCreateCheckbox("Background Mode", 143, 535, 80, 30, $BS_MULTILINE)
	  GUICtrlSetOnEvent(-1, "chkBackground")
	  GUICtrlSetState(-1, $GUI_UNCHECKED)

;~ -------------------------------------------------------

;General Tab
$pageGeneral = GUICtrlCreateTabItem("General")

   $txtLog = _GUICtrlRichEdit_Create($frmBot, "", 16, 137, 440, 226, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912))

   $Controls = GUICtrlCreateGroup("Halt Attack", 16, 370, 440, 50)
	  $chkBotStop = GUICtrlCreateCheckbox("", 50, 390, 16, 16)
	  $cmbBotCommand = GUICtrlCreateCombo("", 70, 387, 90, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "Halt Attack|Shutdown PC|Sleep PC", "Halt Attack")
	  $lblPC = GUICtrlCreateLabel("IF :", 170, 390, 25, 17)
	  $cmbBotCond = GUICtrlCreateCombo("", 190, 387, 150, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "G and E Full and Max.Trophy|(G and E) Full or Max.Trophy|(G or E) Full and Max.Trophy|G or E Full or Max.Trophy|Gold and Elixir Full|Gold or Elixir Full|Gold Full and Max.Trophy|Elixir Full and Max.Trophy|Gold Full or Max.Trophy|Elixir Full or Max.Trophy|Gold Full|Elixir Full|Reach Max. Trophy|Bot running for", "Bot running for")
	  GUICtrlSetOnEvent(-1, "cmbBotCond")
	  $cmbHoursStop = GUICtrlCreateCombo("", 343, 387, 80, 35, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "-|1 Hour|2 Hours|3 Hours|4 Hours|5 Hours|6 Hours|7 Hours|8 Hours|9 Hours|10 Hours|11 Hours|12 Hours|13 Hours|14 Hours|15 Hours|16 Hours|17 Hours|18 Hours|19 Hours|20 Hours|21 Hours|22 Hours|23 Hours|24 Hours", "1 Hour")
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $otherSettings = GUICtrlCreateGroup("Other Settings", 16, 420, 440, 50)
	  $lblBoostBarracks = GUICtrlCreateLabel("Barracks Boosts left :", 50, 440, 100, 17)
	  $cmbBoostBarracks = GUICtrlCreateCombo("", 180, 438, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "0|1|2|3|4|5", "0")
	  $lblMaxTrophy = GUICtrlCreateLabel("Max Trophy :", 280, 440, 66, 17)
	  $txtMaxTrophy = GUICtrlCreateInput("3000", 350, 438, 71, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 4)
	  GUICtrlSetTip(-1, "Bot will drop trophies if your trophy count is greater than this.")
   GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------

;Search Tab
$pageSearchSetting = GUICtrlCreateTabItem("Search")

   $Conditions = GUICtrlCreateGroup("Conditions", 16, 140, 216, 200)
	  $chkMeetGxE = GUICtrlCreateRadio("Meet Gold and Elixir", 40, 164, 113, 17)
	  $chkMeetGorE = GUICtrlCreateRadio("Meet Gold or Elixir", 40, 186, 113, 17)
	  GUICtrlSetState(-1, $GUI_CHECKED)
	  $chkMeetDE = GUICtrlCreateCheckbox("Meet Dark Elixir", 40, 212, 97, 17)
	  $chkMeetTrophy = GUICtrlCreateCheckbox("Meet Trophy Count", 40, 236, 113, 17)
	  $chkMeetTH = GUICtrlCreateCheckbox("Meet Townhall Level", 40, 260, 115, 17)
	  $chkMeetTHO = GUICtrlCreateCheckbox("Meet Townhall Outside", 40, 284, 125, 17)
	  $chkMeetOne = GUICtrlCreateCheckbox("Meet One Then Attack", 40, 308, 125, 17)


   $Resources = GUICtrlCreateGroup("Resources and TH", 236, 140, 220, 200)
	  $lblMinGold = GUICtrlCreateLabel("Minimum Gold: ", 254, 164, 76, 17)
	  $lblMinElixir = GUICtrlCreateLabel("Minimum Elixir:", 254, 188, 72, 17)
	  $lblMinDarkElixir = GUICtrlCreateLabel("Minimum Dark Elixir:", 254, 212, 98, 17)
	  $lblMinTrophy = GUICtrlCreateLabel("Minimum Trophy Count:", 254, 236, 115, 17)
	  $lblMinTH = GUICtrlCreateLabel("Maximum TH Level:", 254, 260, 115, 17)
	  $txtMinGold = GUICtrlCreateInput("80000", 378, 161, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 6)
	  $txtMinElixir = GUICtrlCreateInput("80000", 378, 185, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 6)
	  $txtMinDarkElixir = GUICtrlCreateInput("0", 378, 209, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 6)
	  $txtMinTrophy = GUICtrlCreateInput("0", 378, 233, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 2)
	  $cmbTH = GUICtrlCreateCombo("", 378, 257, 61, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	  $lblResources = GUICtrlCreateLabel("Bot will stop when a base is found with resources higher or equal to the minimum resources.", 259, 292, 168, 51, $SS_CENTER)


   $OtherSearchSettings = GUICtrlCreateGroup("", 16, 360, 440, 60)
	  $chkAlertSearch = GUICtrlCreateCheckbox("Alert when Base is Found", 55, 384, 135, 17)
	  GUICtrlSetState(-1, $GUI_CHECKED)
	  $chkTakeTownSS = GUICtrlCreateCheckbox("Take All Towns Snapshots", 245, 376, 142, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkTakeLootSS = GUICtrlCreateCheckbox("Take All Loot Snapshots", 245, 396, 132, 17)
	  GUICtrlSetState(-1, $GUI_CHECKED)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $Searchonly = GUICtrlCreateGroup("Search Only", 16, 420, 440, 50)
	  $btnSearchMode = GUICtrlCreateButton("Search Mode", 50, 434, 368, 25)
	  GUICtrlSetOnEvent(-1, "btnSearchMode")
   GUICtrlSetTip(-1, "Does not attack. Searches for base that meets conditions.")
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------

;Attack Tab
$pageAttackSettings = GUICtrlCreateTabItem("Attack")

   $WeakBaseSettings = GUICtrlCreateGroup("Weak Base Settings", 16, 140, 152, 230)     ;15, 35, 130, 230
	  $lblMortar = GUICtrlCreateLabel("Max Mortar Lvl:", 35, 163, 77, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $cmbMortar = GUICtrlCreateCombo("", 115, 160, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8", "5")
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $lblWizardTower = GUICtrlCreateLabel("Wiz Tower Lvl:", 35, 188, 75, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $cmbWizTower = GUICtrlCreateCombo("", 115, 185, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8", "4")
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $lblCannon = GUICtrlCreateLabel("Cannon Lvl:", 35, 213, 61, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $lblArcher = GUICtrlCreateLabel("Archer Lvl:", 35, 238, 55, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkWithKing = GUICtrlCreateCheckbox("Attack their King", 35, 285, 112, 17, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_RIGHTBUTTON))
	  GUICtrlSetState(-1, $GUI_CHECKED)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkWithQueen = GUICtrlCreateCheckbox("Attack their Queen", 35, 305, 112, 17, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_RIGHTBUTTON))
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $cmbCannon = GUICtrlCreateCombo("", 115, 210, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "8")
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $cmbArcher = GUICtrlCreateCombo("", 115, 235, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "8")
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $lblWeakDescription = GUICtrlCreateLabel("Bot will attack bases that meet your requirements.", 32, 330, 125, 32, $SS_CENTER)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $lblxBow = GUICtrlCreateLabel("X-Bow Lvl:", 35, 263, 55, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $cmbxBow = GUICtrlCreateCombo("", 115, 260, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "0")
	  GUICtrlSetState(-1, $GUI_DISABLE)
	     GUICtrlCreateGroup("", -99, -99, 1, 1)

   $AttackMode = GUICtrlCreateGroup("Attack Mode", 171, 140, 285, 96)
	  $radDeadBases = GUICtrlCreateRadio("Dead Bases - Meets condition, full collectors", 190, 160, 238, 17)
	  $radWeakBases = GUICtrlCreateRadio("Weak Bases - Meets condition and able 50%", 190, 180, 228, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $radAllBases = GUICtrlCreateRadio("All Bases - Attack all that meets search.", 190, 200, 228, 17)
	  GUICtrlSetState(-1, $GUI_CHECKED)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $HeroesSettings = GUICtrlCreateGroup("Royals and Clan Castle Settings", 171, 235, 285, 135)
	  $lblKingSettings = GUICtrlCreateLabel("King Settings:", 195, 255, 69, 17)
	  $chkKingAttackDeadBases = GUICtrlCreateCheckbox("Atk Dead Bases", 195, 275, 97, 17)
	  $chkKingAttackWeakBases = GUICtrlCreateCheckbox("Atk Weak Bases", 195, 295, 97, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkKingAttackAllBases = GUICtrlCreateCheckbox("Atk All Bases", 195, 315, 97, 17)
	  $lblQueenSettings = GUICtrlCreateLabel("Queen Settings:", 325, 255, 80, 17)
	  $chkQueenAttackDeadBases = GUICtrlCreateCheckbox("Atk Dead Bases", 325, 275, 97, 17)
	  $chkQueenAttackWeakBases = GUICtrlCreateCheckbox("Atk Weak Bases", 325, 295, 97, 17)
	  GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkQueenAttackAllBases = GUICtrlCreateCheckbox("Atk All Bases", 325, 315, 97, 17)
	  $chkUseClanCastle = GUICtrlCreateCheckbox("Atk using Clan Castle troops if available", 195, 340, 210, 17)
   GUICtrlCreateGroup("", -99, -99, 1, 1)


   $AtkSpeed = GUICtrlCreateGroup("Attack Speed", 16, 370, 440, 100)
	  $lblUnitDelay = GUICtrlCreateLabel("Unit Delay:", 50, 390, 75, 17)
	  $cmbUnitDelay = GUICtrlCreateCombo("", 120, 387, 72, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
	  $lblWaveDelay = GUICtrlCreateLabel("Wave Delay:", 246, 390, 75, 17)
	  $cmbWaveDelay = GUICtrlCreateCombo("", 340, 387, 70, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
	  $Randomspeedatk = GUICtrlCreateCheckbox("Random Deployment Speeds", 140, 414, 190, 17)
	  GUICtrlSetOnEvent(-1, "Randomspeedatk")
	  $lblAttackdelay = GUICtrlCreateLabel("This delays the deployment of troops, 1 (fast) = like a Bot, 10 (slow) = Like a Human. Random will make bot more varied and closer to a person.", 50, 435, 350, 67, $SS_CENTER)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------

;Donate Tab
$pageDonateSettings = GUICtrlCreateTabItem("Donate")

$Donation = GUICtrlCreateGroup("", 16, 140, 440, 50)

   $chkRequest = GUICtrlCreateCheckbox("Request for :", 50, 159, 110, 17)
	  GUICtrlSetState(-1, $GUI_CHECKED)
	  GUISetOnEvent(-1, "chkRequest")
	  $txtRequest = GUICtrlCreateInput("Anything please", 168, 157, 250, 21)
   GUICtrlSetTip(-1, "Request for input.")

   $Barbarians = GUICtrlCreateGroup("Barbarians", 16, 190, 140, 280)
	  $chkDonateAllBarbarians = GUICtrlCreateCheckbox("Donate to All", 36, 220, 97, 17)
	  $txtDonateBarbarians = GUICtrlCreateEdit("", 29, 250, 110, 179, BitOR($ES_WANTRETURN, $ES_CENTER))
	  GUICtrlSetData(-1, StringFormat("barbarians\r\nbarb"))
	  GUICtrlSetTip(-1, "Keywords for donating Barbarians")
   GUICtrlCreateGroup("", -99, -99, 1, 1)
   $chkDonateBarbarians = GUICtrlCreateCheckbox("Donate Barbarians", 36, 440, 112, 17)
   GUICtrlSetState(-1, $GUI_CHECKED)

   $Archers = GUICtrlCreateGroup("Archers", 163, 190, 143, 280)
	  $chkDonateAllArchers = GUICtrlCreateCheckbox("Donate to All", 193, 220, 97, 17)
	  $txtDonateArchers = GUICtrlCreateEdit("", 177, 250, 110, 180, BitOR($ES_WANTRETURN, $ES_CENTER))
	  GUICtrlSetData(-1, StringFormat("archers\r\narch\r\nany\r\nreinforcement\r\nar\r\ndef"))
	  GUICtrlSetTip(-1, "Keywords for donating Archers")
   GUICtrlCreateGroup("", -99, -99, 1, 1)
   $chkDonateArchers = GUICtrlCreateCheckbox("Donate Archers", 193, 440, 97, 17)
   GUICtrlSetState(-1, $GUI_CHECKED)

   $Giants = GUICtrlCreateGroup("Giants", 313, 190, 143, 280)
   $chkDonateAllGiants = GUICtrlCreateCheckbox("Donate to All", 344, 220, 97, 17)
	  $txtDonateGiants = GUICtrlCreateEdit("", 330, 250, 110, 180, BitOR($ES_WANTRETURN, $ES_CENTER))
	  GUICtrlSetData(-1, StringFormat("giants\r\ngiant\r\nany\r\nreinforcement"))
	  GUICtrlSetTip(-1, "Keywords for donating Giants")
   GUICtrlCreateGroup("", -99, -99, 1, 1)
   $chkDonateGiants = GUICtrlCreateCheckbox("Donate Giants", 344, 440, 97, 17)
   GUICtrlSetState(-1, $GUI_CHECKED)

   GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------

;Troops Tab
$pageTroopSettings = GUICtrlCreateTabItem("Troops")

   $Barracks = GUICtrlCreateGroup("Troops", 16, 140, 216, 230)
	  $lblBarbarians = GUICtrlCreateLabel("Barbarians :", 30, 168, 60, 17)
	  $lblArchers = GUICtrlCreateLabel("Archers :", 30, 193, 46, 17)
	  $lblGoblins = GUICtrlCreateLabel("Goblins :", 30, 218, 45, 17)
	  $txtBarbarians = GUICtrlCreateInput("30", 140, 165, 56, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
	  GUICtrlSetLimit(-1, 3)
	  $txtArchers = GUICtrlCreateInput("60", 140, 190, 56, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 3)
	  $txtGoblins = GUICtrlCreateInput("10", 140, 215, 56, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 3)
	  $lblPercentBarbarians = GUICtrlCreateLabel("%", 200, 168, 12, 17)
	  $lblPercentArchers = GUICtrlCreateLabel("%", 200, 193, 12, 17)
	  $lblPercentGoblins = GUICtrlCreateLabel("%", 200, 218, 12, 17)
	  $cmbTroopComp = GUICtrlCreateCombo("", 50, 275, 131, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUISetOnEvent(-1, "cmbTroopComp")
	  GUICtrlSetData(-1, "Archers|Barbarians|Goblins|B.Arch|B.A.G.G.|B.A.Giant|B.A.Goblin|B.A.G.G.Wall|Use Barracks|Custom Troops", "Use Barracks") ;"Archers|Barbarians|Goblins|B.Arch|B.A.G.G.|B.A.Giant|B.A.Goblin|B.A.G.G.Wall|Use Barracks|Custom Troops"
	  $lblBarracks = GUICtrlCreateLabel("Troop capacity must equal to 100%", 40, 305, 140, 67, $SS_CENTER)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $OtherTroops = GUICtrlCreateGroup("Other Troops", 236, 140, 220, 230)
	  $lblGiants = GUICtrlCreateLabel("Number of Giants:", 250, 168, 89, 17)
	  $txtNumGiants = GUICtrlCreateInput("4", 370, 165, 46, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	  GUICtrlSetLimit(-1, 3)

	  $lblWallBreakers = GUICtrlCreateLabel("Number of Wall Breakers:", 250, 193, 125, 17)
	  $txtNumWallbreakers = GUICtrlCreateInput("4", 370, 190, 46, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	  GUICtrlSetLimit(-1, 3)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $BarrackGroup = GUICtrlCreateGroup("Barracks", 247, 230, 200, 130)
	  $lblBarrack1 = GUICtrlCreateLabel("Barrack 1:", 257, 253, 53, 17)
		 $cmbBarrack1 = GUICtrlCreateCombo("", 325, 250, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Barbarians") ; "Barbarians|Archers|Giants|Goblins"
	  $lblBarrack2 = GUICtrlCreateLabel("Barrack 2:", 257, 278, 53, 17)
		 $cmbBarrack2 = GUICtrlCreateCombo("", 325, 275, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Archers") ; "Barbarians|Archers|Giants|Goblins"
	  $lblBarrack3 = GUICtrlCreateLabel("Barrack 3:", 257, 303, 53, 17)
		 $cmbBarrack3 = GUICtrlCreateCombo("", 325, 300, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Archers") ; "Barbarians|Archers|Giants|Goblins"
	  $lblBarrack4 = GUICtrlCreateLabel("Barrack 4:", 257, 328, 53, 17)
		 $cmbBarrack4 = GUICtrlCreateCombo("", 325, 325, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Goblins") ; "Barbarians|Archers|Giants|Goblins"
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $deploySettings = GUICtrlCreateGroup("Deploy Settings", 16, 370, 440, 100)
	  $cmbDeploy = GUICtrlCreateCombo("", 50, 400, 368, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "Attack on a single side, penetrates through base|Attack on two sides, penetrates through base|Attack on three sides, gets outer and some inside of base|Attack on all sides equally, gets most of outer base", "Attack on all sides equally, gets most of outer base")
	  $cmbAlgorithm = GUICtrlCreateCombo("", 50, 434, 215, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "Archers|Barbarians|Goblins|Barbarians + Archers|Barb + Arch + Goblin + Giant|Barb + Arch + Giant|Barb + Arch + Goblin|Barb + Arch + Goblin + Giant + Wallbreakers|Use Barracks|Use All Troops", "Use All Troops") ;"Archers|Barbarians|Goblins|Barbarians + Archers|Barb + Arch + Goblin + Giant|Barb + Arch + Giant|Barb + Arch + Goblin|Barb + Arch + Goblin + Giant + Wallbreakers|Use Barracks"
	  $chkAttackTH = GUICtrlCreateCheckbox("Attack Townhall (Outside)", 280, 436, 142, 17)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

	GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
	GUICtrlSetState($txtArchers, $GUI_DISABLE)
	GUICtrlSetState($txtGoblins, $GUI_DISABLE)
	GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
	GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)

;~ -------------------------------------------------------------

;Misc Tab
$pageOtherSettings = GUICtrlCreateTabItem("Misc")

   $Walls = GUICtrlCreateGroup("Walls ", 16, 140, 440, 130)
	  $chkWalls = GUICtrlCreateCheckbox("Auto Wall Upgrade", 40, 160, 115, 17)
	  GUICtrlSetState(-1, $GUI_ENABLE)
	  $UseGold = GUICtrlCreateRadio("Use Only Gold", 50, 185, 115, 17)
	  GUICtrlSetState(-1, $GUI_ENABLE)
	  $WallMinGold = GUICtrlCreateLabel("Minimum Gold: ", 250, 190, 76, 17)
	  $txtWallMinGold = GUICtrlCreateInput("1300000", 360, 185, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 7)
	  GUICtrlSetState(-1, $GUI_ENABLE)
	  $UseElixir = GUICtrlCreateRadio("Use Only Elixir", 50, 210, 115, 17)
	   $WallMinElixir = GUICtrlCreateLabel("Minimum Elixir:", 250, 215, 72, 17)
	  $txtWallMinElixir = GUICtrlCreateInput("1300000", 360, 210, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	  GUICtrlSetLimit(-1, 7)
	  GUICtrlSetState(-1, $GUI_ENABLE)
	  $UseGoldElix = GUICtrlCreateRadio("Use Elixir. If not enough, Gold", 50, 235, 160, 17)
	  $lblWalls = GUICtrlCreateLabel("Current Wall Level:", 250, 162, 100, 17)
	  $cmbWalls = GUICtrlCreateCombo("", 360, 158, 40, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1, "4|5|6|7|8|9|10", "4")
	  GUICtrlSetState(-1, $GUI_ENABLE)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

$ACsetup = GUICtrlCreateGroup("", 16, 270, 440, 50)
   $btnLocateArmyCamp = GUICtrlCreateButton("Locate Army Camp Manually", 50, 284, 368, 25)
	  GUICtrlSetOnEvent(-1, "btnLocateArmyCamp")

$BARsetup = GUICtrlCreateGroup("", 16, 320, 440, 50)
   $btnLocateBarracks = GUICtrlCreateButton("Locate Barrack Manually", 50, 334, 368, 25)
	  GUICtrlSetOnEvent(-1, "btnLocateBarracks")

$THsetup = GUICtrlCreateGroup("", 16, 370, 440, 50)
   $chkTrap = GUICtrlCreateCheckbox("Auto Rearm Traps", 52, 390, 110, 16)
	  $btnLocateTownHall = GUICtrlCreateButton("Locate Townhall Manually", 168, 384, 250, 25)
	  GUICtrlSetOnEvent(-1, "btnLocateTownHall")

$CCsetup = GUICtrlCreateGroup("", 16, 420, 440, 50)
   $btnLocateClanCastle = GUICtrlCreateButton("Locate Clan Castle Manually", 50, 434, 368, 25)
	  GUICtrlSetOnEvent(-1, "btnLocateClanCastle")

GUICtrlCreateGroup("", -99, -99, 1, 1)

  GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------

;Stats Tab
$pageSearchSetting = GUICtrlCreateTabItem("Stats")

   $resourceonstart = GUICtrlCreateGroup("Resources at Start", 16, 140, 216, 140)
	  $lblgoldonstart = GUICtrlCreateLabel("Gold at Start :", 40, 168, 60, 17)
	  $lblresultgoldtstart = GUICtrlCreateLabel("0", 160, 168, 60, 17, $SS_RIGHT)
	  $lblelixironstart = GUICtrlCreateLabel("Elixir at Start :", 40, 193, 60, 17)
	  $lblresultelixirstart = GUICtrlCreateLabel("0", 160, 193, 60, 17, $SS_RIGHT)
	  $lbldeonstart = GUICtrlCreateLabel("DE at Start :", 40, 218, 60, 17)
	  $lblresultdestart = GUICtrlCreateLabel("0", 160, 218, 60, 17, $SS_RIGHT)
	  $lbltrophyonstart = GUICtrlCreateLabel("Trophies at Start :", 40, 243, 100, 17)
	  $lblresulttrophystart = GUICtrlCreateLabel("0", 160, 243, 60, 17, $SS_RIGHT)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $Currentresource = GUICtrlCreateGroup("Other Stats", 236, 140, 220, 140)
	  $lblvillagesattacked = GUICtrlCreateLabel("Attacked :", 260, 168, 100, 17)
	  $lblresultvillagesattacked = GUICtrlCreateLabel("0", 380, 168, 60, 17, $SS_RIGHT)
	  $lblvillagesskipped = GUICtrlCreateLabel("Skipped :", 260, 193, 100, 17)
	  $lblresultvillagesskipped = GUICtrlCreateLabel("0", 380, 193, 60, 17, $SS_RIGHT)
	  $lbltrophiesdropped = GUICtrlCreateLabel("Trophies Dropped :", 260, 218, 100, 17)
	  $lblresulttrophiesdropped = GUICtrlCreateLabel("0", 380, 218, 60, 17, $SS_RIGHT)
	  $lblruntime = GUICtrlCreateLabel("Bot Run Time :", 260, 243, 100, 17)
	  $lblresultruntime = GUICtrlCreateLabel("00:00:00", 380, 243, 60, 17, $SS_RIGHT)

   GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------

;Setup Tab
$pageSetting = GUICtrlCreateTabItem("About Us")

$lblResources = GUICtrlCreateLabel(" The Number 1 Free Auto It Clash Of Clans Bot Download IT ONLY AT https://the.bytecode.club and http://clashbot.org", 130, 220, 230, 230, $SS_CENTER)


;~ -------------------------------------------------------------

;Bottom status bar
$statLog = _GUICtrlStatusBar_Create($frmBot)
_GUICtrlStatusBar_SetSimple($statLog)
_GUICtrlStatusBar_SetText($statLog, "Status : Idle")
$tiAbout = TrayCreateItem("About")
TrayCreateItem("")
$tiExit = TrayCreateItem("Exit")
GUISetState(@SW_SHOW)