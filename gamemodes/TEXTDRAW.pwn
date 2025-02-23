//------------[ Textdraw ]------------


//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];
new Text:TextTime, Text:TextDate;

//Animation
new Text:AnimationTD;

//DevVinzz
new PlayerText:TD_INJURED[MAX_PLAYERS][5];
new Text: TD_LOGINBYEXECUTIVE[5];
new PlayerText:HbeJgrpCuy[MAX_PLAYERS][8];
new PlayerText:JGMVSPEED[MAX_PLAYERS];
new PlayerText:JGMVHP[MAX_PLAYERS];
new PlayerText:JGMVFUEL[MAX_PLAYERS];
new PlayerText:JGMHUNGER[MAX_PLAYERS];
new PlayerText:JGMTHIRST[MAX_PLAYERS];

//hbe baru
new PlayerText: hbeNew[MAX_PLAYERS][7];
new PlayerText: FOOD[MAX_PLAYERS];
new PlayerText: DRINK[MAX_PLAYERS];
new PlayerText: BLADDER[MAX_PLAYERS];
new PlayerText: HEALTHVEH[MAX_PLAYERS];
new PlayerText: MPH[MAX_PLAYERS];
new PlayerText: BENSIN[MAX_PLAYERS];
new PlayerText: NAMEVEH[MAX_PLAYERS];

// Phone Textdraws IndoVexcity
new Text:PhoneTD[33];
new Text:phoneclosetd;
new Text:mesaagetd;
new Text:contactstd;
new Text:calltd;
new Text:twittertd;
new Text:banktd;
new Text:apptd;
new Text:gpstd;
new Text:settingtd;
new Text:cameratd;
//Vehicle textdraw
new Text:VehicleTD[7];
//Stats td
new Text:StatsTD[8];

new Text:DPvehfare[MAX_PLAYERS];

//HBE textdraw Simple
new PlayerText:SPvehname[MAX_PLAYERS];
new PlayerText:SPvehengine[MAX_PLAYERS];
new PlayerText:SPvehspeed[MAX_PLAYERS];
new PlayerText:VModelTD[MAX_PLAYERS];

new PlayerText:PNameStats[MAX_PLAYERS];
new PlayerText:PSkinStats[MAX_PLAYERS];
new PlayerText:ActiveTD[MAX_PLAYERS];

//nama server
new Text: NamaServerNew[3];

//SHOW SPEC PLAYERS
new Text:SpecBox;
new PlayerText:SpecName[MAX_PLAYERS];
new PlayerText:SpecCash[MAX_PLAYERS];
new PlayerText:SpecHP[MAX_PLAYERS];
new PlayerText:SpecAP[MAX_PLAYERS];
new PlayerText:SpecInt[MAX_PLAYERS];
new PlayerText:SpecWorld[MAX_PLAYERS];


new Text:Cent[2];

new
Text:boxlator[1],
    Text:Line1,
    Text:Line2,
    Text:Line3,
    Text:Line4,
    Text:tdbox[11],
    Text:zahl1,
    Text:zahl2,
    Text:zahl3,
    Text:zahl4,
    Text:zahl5,
    Text:zahl6,
    Text:zahl7,
    Text:zahl8,
    Text:zahl9,
    Text:plus,
    Text:minus,
    Text:mal,
    Text:geteilt,
    Text:gleich,
    Text:ergebniss,
    Text:rechnung,
    Text:exxit,
    PlayerText:neu[MAX_PLAYERS][1],
    Text:Logo;

new PlayerText:MTTeks[MAX_PLAYERS][3];

//jobs
new Text:PlayerCrateTD;
new PlayerText:PlayerCrate[MAX_PLAYERS][2];

CreatePlayerTextDraws(playerid) {

    //DevVinzz
    TD_INJURED[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 0.000000, "_");
	PlayerTextDrawFont(playerid, TD_INJURED[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, TD_INJURED[playerid][0], 1000.000000, 1000.000000);
	PlayerTextDrawTextSize(playerid, TD_INJURED[playerid][0], 1000.000000, 1000.000000);
	PlayerTextDrawSetOutline(playerid, TD_INJURED[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_INJURED[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, TD_INJURED[playerid][0], 2);
	PlayerTextDrawColor(playerid, TD_INJURED[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_INJURED[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, TD_INJURED[playerid][0], -16777046);
	PlayerTextDrawUseBox(playerid, TD_INJURED[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_INJURED[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, TD_INJURED[playerid][0], 0);

	TD_INJURED[playerid][1] = CreatePlayerTextDraw(playerid, 320.000000, 350.000000, "Tekan [N] Untuk Mengirim Sinyal");
	PlayerTextDrawFont(playerid, TD_INJURED[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, TD_INJURED[playerid][1], 0.300000, 1.500000);
	PlayerTextDrawTextSize(playerid, TD_INJURED[playerid][1], 400.000000, 500.000000);
	PlayerTextDrawSetOutline(playerid, TD_INJURED[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_INJURED[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, TD_INJURED[playerid][1], 2);
	PlayerTextDrawColor(playerid, TD_INJURED[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_INJURED[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, TD_INJURED[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, TD_INJURED[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TD_INJURED[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, TD_INJURED[playerid][1], 0);

	TD_INJURED[playerid][2] = CreatePlayerTextDraw(playerid, 320.000000, 365.000000, "Tekan [H] Jika Tidak Terlihat Oleh Player Lain");
	PlayerTextDrawFont(playerid, TD_INJURED[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, TD_INJURED[playerid][2], 0.300000, 1.500000);
	PlayerTextDrawTextSize(playerid, TD_INJURED[playerid][2], 400.000000, 500.000000);
	PlayerTextDrawSetOutline(playerid, TD_INJURED[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TD_INJURED[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, TD_INJURED[playerid][2], 2);
	PlayerTextDrawColor(playerid, TD_INJURED[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_INJURED[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, TD_INJURED[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, TD_INJURED[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TD_INJURED[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, TD_INJURED[playerid][2], 0);

	TD_INJURED[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 380.000000, "Tekan [Y] Untuk Respawn Kedalam Interior Rumah Sakit");
	PlayerTextDrawFont(playerid, TD_INJURED[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, TD_INJURED[playerid][3], 0.300000, 1.500000);
	PlayerTextDrawTextSize(playerid, TD_INJURED[playerid][3], 400.000000, 500.000000);
	PlayerTextDrawSetOutline(playerid, TD_INJURED[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_INJURED[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, TD_INJURED[playerid][3], 2);
	PlayerTextDrawColor(playerid, TD_INJURED[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_INJURED[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, TD_INJURED[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, TD_INJURED[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, TD_INJURED[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, TD_INJURED[playerid][3], 0);

	TD_INJURED[playerid][4] = CreatePlayerTextDraw(playerid, 320.000000, 395.000000, "Untuk Melakukan Respawn Anda Perlu Menunggu 500 Detik");
	PlayerTextDrawFont(playerid, TD_INJURED[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, TD_INJURED[playerid][4], 0.300000, 1.500000);
	PlayerTextDrawTextSize(playerid, TD_INJURED[playerid][4], 400.000000, 500.000000);
	PlayerTextDrawSetOutline(playerid, TD_INJURED[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_INJURED[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, TD_INJURED[playerid][4], 2);
	PlayerTextDrawColor(playerid, TD_INJURED[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_INJURED[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, TD_INJURED[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, TD_INJURED[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, TD_INJURED[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, TD_INJURED[playerid][4], 0);

    TD_LOGINBYEXECUTIVE[0] = TextDrawCreate(181.000, 97.000, "_");
	TextDrawLetterSize(TD_LOGINBYEXECUTIVE[0], -0.008, 28.600);
	TextDrawTextSize(TD_LOGINBYEXECUTIVE[0], 442.000, 0.000);
	TextDrawAlignment(TD_LOGINBYEXECUTIVE[0], 1);
	TextDrawColor(TD_LOGINBYEXECUTIVE[0], -218);
	TextDrawUseBox(TD_LOGINBYEXECUTIVE[0], 1);
	TextDrawBoxColor(TD_LOGINBYEXECUTIVE[0], 65);
	TextDrawSetShadow(TD_LOGINBYEXECUTIVE[0], 1);
	TextDrawSetOutline(TD_LOGINBYEXECUTIVE[0], 1);
	TextDrawBackgroundColor(TD_LOGINBYEXECUTIVE[0], 150);
	TextDrawFont(TD_LOGINBYEXECUTIVE[0], 1);
	TextDrawSetProportional(TD_LOGINBYEXECUTIVE[0], 1);
	
	TD_LOGINBYEXECUTIVE[1] = TextDrawCreate(283.000, 78.000, "LEVANAPRIDE");
	TextDrawLetterSize(TD_LOGINBYEXECUTIVE[1], 0.280, 1.700);
	TextDrawAlignment(TD_LOGINBYEXECUTIVE[1], 1);
	TextDrawColor(TD_LOGINBYEXECUTIVE[1], 0x00aaffAA);
	TextDrawSetShadow(TD_LOGINBYEXECUTIVE[1], 1);
	TextDrawSetOutline(TD_LOGINBYEXECUTIVE[1], 1);
	TextDrawBackgroundColor(TD_LOGINBYEXECUTIVE[1], 150);
	TextDrawFont(TD_LOGINBYEXECUTIVE[1], 1);
	TextDrawSetProportional(TD_LOGINBYEXECUTIVE[1], 1);
	
	TD_LOGINBYEXECUTIVE[2] = TextDrawCreate(291.000, 88.000, "ROLEPLAY");
	TextDrawLetterSize(TD_LOGINBYEXECUTIVE[2], 0.270, 1.098);
	TextDrawAlignment(TD_LOGINBYEXECUTIVE[2], 1);
	TextDrawColor(TD_LOGINBYEXECUTIVE[2], -1);
	TextDrawSetShadow(TD_LOGINBYEXECUTIVE[2], 13);
	TextDrawSetOutline(TD_LOGINBYEXECUTIVE[2], 1);
	TextDrawBackgroundColor(TD_LOGINBYEXECUTIVE[2], 150);
	TextDrawFont(TD_LOGINBYEXECUTIVE[2], 1);
	TextDrawSetProportional(TD_LOGINBYEXECUTIVE[2], 1);
	
	TD_LOGINBYEXECUTIVE[3] = TextDrawCreate(179.000, 348.000, "levanapride.net");
	TextDrawLetterSize(TD_LOGINBYEXECUTIVE[3], 0.189, 0.999);
	TextDrawAlignment(TD_LOGINBYEXECUTIVE[3], 1);
	TextDrawColor(TD_LOGINBYEXECUTIVE[3], 0x00aaffAA);
	TextDrawSetShadow(TD_LOGINBYEXECUTIVE[3], 13);
	TextDrawSetOutline(TD_LOGINBYEXECUTIVE[3], 1);
	TextDrawBackgroundColor(TD_LOGINBYEXECUTIVE[3], 150);
	TextDrawFont(TD_LOGINBYEXECUTIVE[3], 1);
	TextDrawSetProportional(TD_LOGINBYEXECUTIVE[3], 1);
	
	TD_LOGINBYEXECUTIVE[4] = TextDrawCreate(283.000, 76.000, "LEVANAPRIDE");
	TextDrawLetterSize(TD_LOGINBYEXECUTIVE[4], 0.280, 1.700);
	TextDrawAlignment(TD_LOGINBYEXECUTIVE[4], 1);
	TextDrawColor(TD_LOGINBYEXECUTIVE[4], 0x00aaffAA);
	TextDrawSetShadow(TD_LOGINBYEXECUTIVE[4], 1);
	TextDrawSetOutline(TD_LOGINBYEXECUTIVE[4], 1);
	TextDrawBackgroundColor(TD_LOGINBYEXECUTIVE[4], 150);
	TextDrawFont(TD_LOGINBYEXECUTIVE[4], 1);
	TextDrawSetProportional(TD_LOGINBYEXECUTIVE[4], 1);


    HbeJgrpCuy[playerid][0] = CreatePlayerTextDraw(playerid, 579.000000, 352.000000, "ld_bum:blkdot");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][0], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][0], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][0], 61.000000, 50.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][0], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][0], 150);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][0], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][0], 0);

    HbeJgrpCuy[playerid][1] = CreatePlayerTextDraw(playerid, 579.000000, 287.000000, "ld_bum:blkdot");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][1], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][1], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][1], 61.000000, 63.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][1], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][1], 150);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][1], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][1], 0);

    HbeJgrpCuy[playerid][2] = CreatePlayerTextDraw(playerid, 583.000000, 355.000000, "HUD:radar_dateFood");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][2], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][2], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][2], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][2], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][2], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][2], 0);

    HbeJgrpCuy[playerid][3] = CreatePlayerTextDraw(playerid, 583.000000, 378.000000, "HUD:radar_diner");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][3], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][3], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][3], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][3], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][3], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][3], 0);

    HbeJgrpCuy[playerid][4] = CreatePlayerTextDraw(playerid, 583.000000, 286.000000, "HUD:radar_impound");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][4], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][4], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][4], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][4], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][4], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][4], 0);

    HbeJgrpCuy[playerid][5] = CreatePlayerTextDraw(playerid, 583.000000, 309.000000, "HUD:radar_modGarage");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][5], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][5], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][5], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][5], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][5], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][5], 0);

    HbeJgrpCuy[playerid][6] = CreatePlayerTextDraw(playerid, 583.000000, 330.000000, "HUD:radar_spray");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][6], 4);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][6], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][6], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][6], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][6], 135);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][6], 0);

    JGMVSPEED[playerid] = CreatePlayerTextDraw(playerid, 612.000000, 291.000000, "100");
    PlayerTextDrawFont(playerid, JGMVSPEED[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMVSPEED[playerid], 0.304165, 1.149999);
    PlayerTextDrawTextSize(playerid, JGMVSPEED[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMVSPEED[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMVSPEED[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMVSPEED[playerid], 2);
    PlayerTextDrawColor(playerid, JGMVSPEED[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMVSPEED[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMVSPEED[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMVSPEED[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMVSPEED[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMVSPEED[playerid], 0);

    HbeJgrpCuy[playerid][7] = CreatePlayerTextDraw(playerid, 632.000000, 291.000000, "Mph");
    PlayerTextDrawFont(playerid, HbeJgrpCuy[playerid][7], 3);
    PlayerTextDrawLetterSize(playerid, HbeJgrpCuy[playerid][7], 0.245831, 1.149999);
    PlayerTextDrawTextSize(playerid, HbeJgrpCuy[playerid][7], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HbeJgrpCuy[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, HbeJgrpCuy[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, HbeJgrpCuy[playerid][7], 2);
    PlayerTextDrawColor(playerid, HbeJgrpCuy[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, HbeJgrpCuy[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, HbeJgrpCuy[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, HbeJgrpCuy[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, HbeJgrpCuy[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, HbeJgrpCuy[playerid][7], 0);

    JGMVHP[playerid] = CreatePlayerTextDraw(playerid, 621.000000, 310.000000, "100%");
    PlayerTextDrawFont(playerid, JGMVHP[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMVHP[playerid], 0.304165, 1.149999);
    PlayerTextDrawTextSize(playerid, JGMVHP[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMVHP[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMVHP[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMVHP[playerid], 2);
    PlayerTextDrawColor(playerid, JGMVHP[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMVHP[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMVHP[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMVHP[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMVHP[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMVHP[playerid], 0);

    JGMVFUEL[playerid] = CreatePlayerTextDraw(playerid, 621.000000, 333.000000, "100%");
    PlayerTextDrawFont(playerid, JGMVFUEL[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMVFUEL[playerid], 0.304165, 1.149999);
    PlayerTextDrawTextSize(playerid, JGMVFUEL[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMVFUEL[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMVFUEL[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMVFUEL[playerid], 2);
    PlayerTextDrawColor(playerid, JGMVFUEL[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMVFUEL[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMVFUEL[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMVFUEL[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMVFUEL[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMVFUEL[playerid], 0);

    JGMHUNGER[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 357.000000, "100%");
    PlayerTextDrawFont(playerid, JGMHUNGER[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMHUNGER[playerid], 0.299997, 1.399999);
    PlayerTextDrawTextSize(playerid, JGMHUNGER[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMHUNGER[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMHUNGER[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMHUNGER[playerid], 1);
    PlayerTextDrawColor(playerid, JGMHUNGER[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMHUNGER[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMHUNGER[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMHUNGER[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMHUNGER[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMHUNGER[playerid], 0);

    JGMTHIRST[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 381.000000, "100%");
    PlayerTextDrawFont(playerid, JGMTHIRST[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMTHIRST[playerid], 0.299997, 1.399999);
    PlayerTextDrawTextSize(playerid, JGMTHIRST[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMTHIRST[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMTHIRST[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMTHIRST[playerid], 1);
    PlayerTextDrawColor(playerid, JGMTHIRST[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMTHIRST[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMTHIRST[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMTHIRST[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMTHIRST[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMTHIRST[playerid], 0);


    //jobs
    PlayerCrate[playerid][0] = CreatePlayerTextDraw(playerid, 552.000000, 107.000000, "Storage");
    PlayerTextDrawFont(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawLetterSize(playerid, PlayerCrate[playerid][0], 0.479166, 1.850000);
    PlayerTextDrawTextSize(playerid, PlayerCrate[playerid][0], 755.000000, 167.000000);
    PlayerTextDrawSetOutline(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, PlayerCrate[playerid][0], 2);
    PlayerTextDrawColor(playerid, PlayerCrate[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerCrate[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, PlayerCrate[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, PlayerCrate[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerCrate[playerid][0], 0);

    PlayerCrate[playerid][1] = CreatePlayerTextDraw(playerid, 507.000000, 133.000000, "Trash~n~0/10");
    PlayerTextDrawFont(playerid, PlayerCrate[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, PlayerCrate[playerid][1], 0.325000, 1.100000);
    PlayerTextDrawTextSize(playerid, PlayerCrate[playerid][1], 755.000000, 167.000000);
    PlayerTextDrawSetOutline(playerid, PlayerCrate[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, PlayerCrate[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, PlayerCrate[playerid][1], 1);
    PlayerTextDrawColor(playerid, PlayerCrate[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerCrate[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, PlayerCrate[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, PlayerCrate[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, PlayerCrate[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerCrate[playerid][1], 0);

    PlayerCrateTD = TextDrawCreate(552.000000, 110.000000, "_");
    TextDrawFont(PlayerCrateTD, 1);
    TextDrawLetterSize(PlayerCrateTD, 0.600000, 6.099998);
    TextDrawTextSize(PlayerCrateTD, 298.500000, 95.000000);
    TextDrawSetOutline(PlayerCrateTD, 1);
    TextDrawSetShadow(PlayerCrateTD, 0);
    TextDrawAlignment(PlayerCrateTD, 2);
    TextDrawColor(PlayerCrateTD, -1);
    TextDrawBackgroundColor(PlayerCrateTD, 255);
    TextDrawBoxColor(PlayerCrateTD, 190);
    TextDrawUseBox(PlayerCrateTD, 1);
    TextDrawSetProportional(PlayerCrateTD, 1);
    TextDrawSetSelectable(PlayerCrateTD, 0);

    //nama server
    NamaServerNew[0] = TextDrawCreate(300.000, 5.000, "/");
    TextDrawLetterSize(NamaServerNew[0], 0.899, 3.500);
    TextDrawAlignment(NamaServerNew[0], 1);
    TextDrawColor(NamaServerNew[0], 52735);
    TextDrawSetShadow(NamaServerNew[0], 0);
    TextDrawSetOutline(NamaServerNew[0], 0);
    TextDrawBackgroundColor(NamaServerNew[0], 150);
    TextDrawFont(NamaServerNew[0], 1);
    TextDrawSetProportional(NamaServerNew[0], 1);

    NamaServerNew[1] = TextDrawCreate(300.000, 12.000, "-");
    TextDrawLetterSize(NamaServerNew[1], 2.000, 4.500);
    TextDrawAlignment(NamaServerNew[1], 1);
    TextDrawColor(NamaServerNew[1], 421097727);
    TextDrawSetShadow(NamaServerNew[1], 0);
    TextDrawSetOutline(NamaServerNew[1], 0);
    TextDrawBackgroundColor(NamaServerNew[1], 150);
    TextDrawFont(NamaServerNew[1], 0);
    TextDrawSetProportional(NamaServerNew[1], 1);

    NamaServerNew[2] = TextDrawCreate(278.000, 38.000, "Levana Roleplay");
    TextDrawLetterSize(NamaServerNew[2], 0.300, 1.500);
    TextDrawAlignment(NamaServerNew[2], 1);
    TextDrawColor(NamaServerNew[2], -1);
    TextDrawSetShadow(NamaServerNew[2], 1);
    TextDrawSetOutline(NamaServerNew[2], 0);
    TextDrawBackgroundColor(NamaServerNew[2], 150);
    TextDrawFont(NamaServerNew[2], 1);
    TextDrawSetProportional(NamaServerNew[2], 1);

    //hbe by raps
    hbeNew[playerid][0] = CreatePlayerTextDraw(playerid, 545.000, 375.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, hbeNew[playerid][0], 115.000, 90.000);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][0], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][0], 150);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][0], 255);
    PlayerTextDrawFont(playerid, hbeNew[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][0], 1);

    hbeNew[playerid][1] = CreatePlayerTextDraw(playerid, 550.000, 378.000, "HUD:radar_burgerShot");
    PlayerTextDrawTextSize(playerid, hbeNew[playerid][1], 15.000, 19.000);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][1], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][1], 255);
    PlayerTextDrawFont(playerid, hbeNew[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][1], 1);

    hbeNew[playerid][2] = CreatePlayerTextDraw(playerid, 550.000, 402.000, "HUD:radar_diner");
    PlayerTextDrawTextSize(playerid, hbeNew[playerid][2], 15.000, 19.000);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][2], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][2], 255);
    PlayerTextDrawFont(playerid, hbeNew[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][2], 1);

    hbeNew[playerid][3] = CreatePlayerTextDraw(playerid, 550.000, 427.000, "HUD:radar_gangN");
    PlayerTextDrawTextSize(playerid, hbeNew[playerid][3], 15.000, 19.000);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][3], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][3], 255);
    PlayerTextDrawFont(playerid, hbeNew[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][3], 1);

    hbeNew[playerid][4] = CreatePlayerTextDraw(playerid, 545.000, 361.000, "LD_SPAC:black");
    PlayerTextDrawTextSize(playerid, hbeNew[playerid][4], 90.000, 10.000);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][4], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][4], 255);
    PlayerTextDrawFont(playerid, hbeNew[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][4], 1);

    hbeNew[playerid][5] = CreatePlayerTextDraw(playerid, 582.000, 345.000, "mp/h");
    PlayerTextDrawLetterSize(playerid, hbeNew[playerid][5], 0.300, 1.500);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][5], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][5], 1);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][5], 1);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][5], 150);
    PlayerTextDrawFont(playerid, hbeNew[playerid][5], 3);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][5], 1);

    hbeNew[playerid][6] = CreatePlayerTextDraw(playerid, 604.000, 333.000, "L");
    PlayerTextDrawLetterSize(playerid, hbeNew[playerid][6], 0.300, 1.500);
    PlayerTextDrawAlignment(playerid, hbeNew[playerid][6], 1);
    PlayerTextDrawColor(playerid, hbeNew[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, hbeNew[playerid][6], 1);
    PlayerTextDrawSetOutline(playerid, hbeNew[playerid][6], 1);
    PlayerTextDrawBackgroundColor(playerid, hbeNew[playerid][6], 150);
    PlayerTextDrawFont(playerid, hbeNew[playerid][6], 3);
    PlayerTextDrawSetProportional(playerid, hbeNew[playerid][6], 1);

    FOOD[playerid] = CreatePlayerTextDraw(playerid, 570.000, 384.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, FOOD[playerid], 60.000, 7.000);
    PlayerTextDrawAlignment(playerid, FOOD[playerid], 1);
    PlayerTextDrawColor(playerid, FOOD[playerid], -1);
    PlayerTextDrawSetShadow(playerid, FOOD[playerid], 0);
    PlayerTextDrawSetOutline(playerid, FOOD[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, FOOD[playerid], 255);
    PlayerTextDrawFont(playerid, FOOD[playerid], 4);
    PlayerTextDrawSetProportional(playerid, FOOD[playerid], 1);

    DRINK[playerid] = CreatePlayerTextDraw(playerid, 570.000, 409.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, DRINK[playerid], 60.000, 7.000);
    PlayerTextDrawAlignment(playerid, DRINK[playerid], 1);
    PlayerTextDrawColor(playerid, DRINK[playerid], -1);
    PlayerTextDrawSetShadow(playerid, DRINK[playerid], 0);
    PlayerTextDrawSetOutline(playerid, DRINK[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, DRINK[playerid], 255);
    PlayerTextDrawFont(playerid, DRINK[playerid], 4);
    PlayerTextDrawSetProportional(playerid, DRINK[playerid], 1);

    BLADDER[playerid] = CreatePlayerTextDraw(playerid, 570.000, 432.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, BLADDER[playerid], 60.000, 7.000);
    PlayerTextDrawAlignment(playerid, BLADDER[playerid], 1);
    PlayerTextDrawColor(playerid, BLADDER[playerid], -1);
    PlayerTextDrawSetShadow(playerid, BLADDER[playerid], 0);
    PlayerTextDrawSetOutline(playerid, BLADDER[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, BLADDER[playerid], 255);
    PlayerTextDrawFont(playerid, BLADDER[playerid], 4);
    PlayerTextDrawSetProportional(playerid, BLADDER[playerid], 1);

    HEALTHVEH[playerid] = CreatePlayerTextDraw(playerid, 547.000, 363.500, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, HEALTHVEH[playerid], 86.000, 5.000);
    PlayerTextDrawAlignment(playerid, HEALTHVEH[playerid], 1);
    PlayerTextDrawColor(playerid, HEALTHVEH[playerid], -1);
    PlayerTextDrawSetShadow(playerid, HEALTHVEH[playerid], 0);
    PlayerTextDrawSetOutline(playerid, HEALTHVEH[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, HEALTHVEH[playerid], 255);
    PlayerTextDrawFont(playerid, HEALTHVEH[playerid], 4);
    PlayerTextDrawSetProportional(playerid, HEALTHVEH[playerid], 1);

    MPH[playerid] = CreatePlayerTextDraw(playerid, 547.000, 332.000, "000");
    PlayerTextDrawLetterSize(playerid, MPH[playerid], 0.500, 3.200);
    PlayerTextDrawAlignment(playerid, MPH[playerid], 1);
    PlayerTextDrawColor(playerid, MPH[playerid], -1);
    PlayerTextDrawSetShadow(playerid, MPH[playerid], 1);
    PlayerTextDrawSetOutline(playerid, MPH[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, MPH[playerid], 150);
    PlayerTextDrawFont(playerid, MPH[playerid], 3);
    PlayerTextDrawSetProportional(playerid, MPH[playerid], 1);

    BENSIN[playerid] = CreatePlayerTextDraw(playerid, 582.000, 334.000, "000");
    PlayerTextDrawLetterSize(playerid, BENSIN[playerid], 0.300, 1.500);
    PlayerTextDrawAlignment(playerid, BENSIN[playerid], 1);
    PlayerTextDrawColor(playerid, BENSIN[playerid], -1);
    PlayerTextDrawSetShadow(playerid, BENSIN[playerid], 1);
    PlayerTextDrawSetOutline(playerid, BENSIN[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, BENSIN[playerid], 150);
    PlayerTextDrawFont(playerid, BENSIN[playerid], 3);
    PlayerTextDrawSetProportional(playerid, BENSIN[playerid], 1);

    NAMEVEH[playerid] = CreatePlayerTextDraw(playerid, 547.000, 310.000, "Sultan");
    PlayerTextDrawLetterSize(playerid, NAMEVEH[playerid], 0.500, 2.500);
    PlayerTextDrawAlignment(playerid, NAMEVEH[playerid], 1);
    PlayerTextDrawColor(playerid, NAMEVEH[playerid], 512819199);
    PlayerTextDrawSetShadow(playerid, NAMEVEH[playerid], 1);
    PlayerTextDrawSetOutline(playerid, NAMEVEH[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, NAMEVEH[playerid], 150);
    PlayerTextDrawFont(playerid, NAMEVEH[playerid], 3);
    PlayerTextDrawSetProportional(playerid, NAMEVEH[playerid], 1);

    //Maintance Teks
    MTTeks[playerid][0] = CreatePlayerTextDraw(playerid, 224.000, 6.000, "Server Maintance");
    PlayerTextDrawLetterSize(playerid, MTTeks[playerid][0], 0.220, 1.600);
    PlayerTextDrawAlignment(playerid, MTTeks[playerid][0], 1);
    PlayerTextDrawColor(playerid, MTTeks[playerid][0], -16776961);
    PlayerTextDrawSetShadow(playerid, MTTeks[playerid][0], 1);
    PlayerTextDrawSetOutline(playerid, MTTeks[playerid][0], 1);
    PlayerTextDrawBackgroundColor(playerid, MTTeks[playerid][0], 150);
    PlayerTextDrawFont(playerid, MTTeks[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, MTTeks[playerid][0], 1);

    MTTeks[playerid][1] = CreatePlayerTextDraw(playerid, 295.000, 6.000, "50");
    PlayerTextDrawLetterSize(playerid, MTTeks[playerid][1], 0.220, 1.600);
    PlayerTextDrawAlignment(playerid, MTTeks[playerid][1], 1);
    PlayerTextDrawColor(playerid, MTTeks[playerid][1], 1768516095);
    PlayerTextDrawSetShadow(playerid, MTTeks[playerid][1], 1);
    PlayerTextDrawSetOutline(playerid, MTTeks[playerid][1], 1);
    PlayerTextDrawBackgroundColor(playerid, MTTeks[playerid][1], 150);
    PlayerTextDrawFont(playerid, MTTeks[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, MTTeks[playerid][1], 1);

    MTTeks[playerid][2] = CreatePlayerTextDraw(playerid, 312.000, 6.000, "Seconds");
    PlayerTextDrawLetterSize(playerid, MTTeks[playerid][2], 0.220, 1.600);
    PlayerTextDrawAlignment(playerid, MTTeks[playerid][2], 1);
    PlayerTextDrawColor(playerid, MTTeks[playerid][2], -12254977);
    PlayerTextDrawSetShadow(playerid, MTTeks[playerid][2], 1);
    PlayerTextDrawSetOutline(playerid, MTTeks[playerid][2], 1);
    PlayerTextDrawBackgroundColor(playerid, MTTeks[playerid][2], 150);
    PlayerTextDrawFont(playerid, MTTeks[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, MTTeks[playerid][2], 1);

    //Player Textdraws Spectating
    SpecName[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 352.000000, "~g~Juan_Coki (12)");
    PlayerTextDrawFont(playerid, SpecName[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpecName[playerid], 0.500000, 1.750000);
    PlayerTextDrawTextSize(playerid, SpecName[playerid], 495.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpecName[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpecName[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpecName[playerid], 1);
    PlayerTextDrawColor(playerid, SpecName[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpecName[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpecName[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpecName[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpecName[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpecName[playerid], 0);

    SpecCash[playerid] = CreatePlayerTextDraw(playerid, 265.000000, 367.000000, "~w~Cash: ~y~$9.10");
    PlayerTextDrawFont(playerid, SpecCash[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpecCash[playerid], 0.500000, 1.750000);
    PlayerTextDrawTextSize(playerid, SpecCash[playerid], 495.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpecCash[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpecCash[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpecCash[playerid], 1);
    PlayerTextDrawColor(playerid, SpecCash[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpecCash[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpecCash[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpecCash[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpecCash[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpecCash[playerid], 0);

    SpecHP[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 382.000000, "~w~HP: ~y~100.0");
    PlayerTextDrawFont(playerid, SpecHP[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpecHP[playerid], 0.500000, 1.750000);
    PlayerTextDrawTextSize(playerid, SpecHP[playerid], 495.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpecHP[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpecHP[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpecHP[playerid], 1);
    PlayerTextDrawColor(playerid, SpecHP[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpecHP[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpecHP[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpecHP[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpecHP[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpecHP[playerid], 0);

    SpecAP[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 396.000000, "~w~AP: ~y~100.0");
    PlayerTextDrawFont(playerid, SpecAP[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpecAP[playerid], 0.500000, 1.750000);
    PlayerTextDrawTextSize(playerid, SpecAP[playerid], 495.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpecAP[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpecAP[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpecAP[playerid], 1);
    PlayerTextDrawColor(playerid, SpecAP[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpecAP[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpecAP[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpecAP[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpecAP[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpecAP[playerid], 0);

    SpecInt[playerid] = CreatePlayerTextDraw(playerid, 292.000000, 410.000000, "~w~Int: ~y~1");
    PlayerTextDrawFont(playerid, SpecInt[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpecInt[playerid], 0.500000, 1.750000);
    PlayerTextDrawTextSize(playerid, SpecInt[playerid], 495.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpecInt[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpecInt[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpecInt[playerid], 1);
    PlayerTextDrawColor(playerid, SpecInt[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpecInt[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpecInt[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpecInt[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpecInt[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpecInt[playerid], 0);

    SpecWorld[playerid] = CreatePlayerTextDraw(playerid, 281.000000, 423.000000, "~w~World: ~y~1");
    PlayerTextDrawFont(playerid, SpecWorld[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpecWorld[playerid], 0.500000, 1.750000);
    PlayerTextDrawTextSize(playerid, SpecWorld[playerid], 495.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpecWorld[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpecWorld[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpecWorld[playerid], 1);
    PlayerTextDrawColor(playerid, SpecWorld[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpecWorld[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpecWorld[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpecWorld[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpecWorld[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpecWorld[playerid], 0);

    //Info textdraw
    InfoTD[playerid] = CreatePlayerTextDraw(playerid, 281.000, 393.000, "Selamat datang kota");
    PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.190, 1.299);
    PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
    PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid, InfoTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid, InfoTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 150);
    PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
    PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);

    ActiveTD[playerid] = CreatePlayerTextDraw(playerid, 274.000000, 176.583435, "Mengisi Ulang...");
    PlayerTextDrawLetterSize(playerid, ActiveTD[playerid], 0.374000, 1.349166);
    PlayerTextDrawAlignment(playerid, ActiveTD[playerid], 1);
    PlayerTextDrawColor(playerid, ActiveTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ActiveTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ActiveTD[playerid], 255);
    PlayerTextDrawFont(playerid, ActiveTD[playerid], 1);
    PlayerTextDrawSetProportional(playerid, ActiveTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);

    DPvehfare[playerid] = TextDrawCreate(462.000000, 401.166687, "$500.000");
    TextDrawLetterSize(DPvehfare[playerid], 0.216000, 0.952498);
    TextDrawAlignment(DPvehfare[playerid], 1);
    TextDrawColor(DPvehfare[playerid], 16711935);
    TextDrawSetShadow(DPvehfare[playerid], 0);
    TextDrawSetOutline(DPvehfare[playerid], 1);
    TextDrawBackgroundColor(DPvehfare[playerid], 255);
    TextDrawFont(DPvehfare[playerid], 1);
    TextDrawSetProportional(DPvehfare[playerid], 1);
    TextDrawSetShadow(DPvehfare[playerid], 0);

    //HBE textdraw Simple
    SPvehname[playerid] = CreatePlayerTextDraw(playerid, 398.000000, 367.000000, "Washington");
    PlayerTextDrawFont(playerid, SPvehname[playerid], 0);
    PlayerTextDrawLetterSize(playerid, SPvehname[playerid], 0.395832, 1.350000);
    PlayerTextDrawTextSize(playerid, SPvehname[playerid], 640.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SPvehname[playerid], 0);
    PlayerTextDrawSetShadow(playerid, SPvehname[playerid], 1);
    PlayerTextDrawAlignment(playerid, SPvehname[playerid], 1);
    PlayerTextDrawColor(playerid, SPvehname[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SPvehname[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SPvehname[playerid], 50);
    PlayerTextDrawUseBox(playerid, SPvehname[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SPvehname[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SPvehname[playerid], 0);

    SPvehspeed[playerid] = CreatePlayerTextDraw(playerid, 369.000000, 389.000000, "0 Mph");
    PlayerTextDrawFont(playerid, SPvehspeed[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SPvehspeed[playerid], 0.324997, 1.299998);
    PlayerTextDrawTextSize(playerid, SPvehspeed[playerid], 640.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SPvehspeed[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SPvehspeed[playerid], 0);
    PlayerTextDrawAlignment(playerid, SPvehspeed[playerid], 1);
    PlayerTextDrawColor(playerid, SPvehspeed[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SPvehspeed[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SPvehspeed[playerid], 50);
    PlayerTextDrawUseBox(playerid, SPvehspeed[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SPvehspeed[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SPvehspeed[playerid], 0);

    SPvehengine[playerid] = CreatePlayerTextDraw(playerid, 388.000000, 403.000000, "off");
    PlayerTextDrawFont(playerid, SPvehengine[playerid], 3);
    PlayerTextDrawLetterSize(playerid, SPvehengine[playerid], 0.395832, 1.350000);
    PlayerTextDrawTextSize(playerid, SPvehengine[playerid], 640.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SPvehengine[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SPvehengine[playerid], 0);
    PlayerTextDrawAlignment(playerid, SPvehengine[playerid], 1);
    PlayerTextDrawColor(playerid, SPvehengine[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SPvehengine[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SPvehengine[playerid], 50);
    PlayerTextDrawUseBox(playerid, SPvehengine[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SPvehengine[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SPvehengine[playerid], 0);

    //TD Name Stats
    PNameStats[playerid] = CreatePlayerTextDraw(playerid, 503.000000, 367.000000, "James Peterson");
    PlayerTextDrawFont(playerid, PNameStats[playerid], 0);
    PlayerTextDrawLetterSize(playerid, PNameStats[playerid], 0.395832, 1.350000);
    PlayerTextDrawTextSize(playerid, PNameStats[playerid], 640.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PNameStats[playerid], 0);
    PlayerTextDrawSetShadow(playerid, PNameStats[playerid], 1);
    PlayerTextDrawAlignment(playerid, PNameStats[playerid], 1);
    PlayerTextDrawColor(playerid, PNameStats[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, PNameStats[playerid], 255);
    PlayerTextDrawBoxColor(playerid, PNameStats[playerid], 50);
    PlayerTextDrawUseBox(playerid, PNameStats[playerid], 0);
    PlayerTextDrawSetProportional(playerid, PNameStats[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, PNameStats[playerid], 0);

    PSkinStats[playerid] = CreatePlayerTextDraw(playerid, 556.000000, 369.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, PSkinStats[playerid], 5);
    PlayerTextDrawLetterSize(playerid, PSkinStats[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, PSkinStats[playerid], 124.000000, 140.000000);
    PlayerTextDrawSetOutline(playerid, PSkinStats[playerid], 0);
    PlayerTextDrawSetShadow(playerid, PSkinStats[playerid], 0);
    PlayerTextDrawAlignment(playerid, PSkinStats[playerid], 1);
    PlayerTextDrawColor(playerid, PSkinStats[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, PSkinStats[playerid], 0);
    PlayerTextDrawBoxColor(playerid, PSkinStats[playerid], 255);
    PlayerTextDrawUseBox(playerid, PSkinStats[playerid], 0);
    PlayerTextDrawSetProportional(playerid, PSkinStats[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, PSkinStats[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, PSkinStats[playerid], 2);
    PlayerTextDrawSetPreviewRot(playerid, PSkinStats[playerid], -10.000000, 0.000000, -27.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, PSkinStats[playerid], 1, 1);

    VModelTD[playerid] = CreatePlayerTextDraw(playerid, 434.000000, 363.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VModelTD[playerid], 5);
    PlayerTextDrawLetterSize(playerid, VModelTD[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VModelTD[playerid], 66.000000, 98.000000);
    PlayerTextDrawSetOutline(playerid, VModelTD[playerid], 0);
    PlayerTextDrawSetShadow(playerid, VModelTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, VModelTD[playerid], 1);
    PlayerTextDrawColor(playerid, VModelTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, VModelTD[playerid], 0);
    PlayerTextDrawBoxColor(playerid, VModelTD[playerid], 255);
    PlayerTextDrawUseBox(playerid, VModelTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, VModelTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, VModelTD[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, VModelTD[playerid], 515);
    PlayerTextDrawSetPreviewRot(playerid, VModelTD[playerid], -10.000000, 0.000000, -27.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VModelTD[playerid], 1, 1);

    //Kalkulator Textdraw
    rrechnung[playerid] = 0;
    neu[playerid][0] = CreatePlayerTextDraw(playerid, 321.872, 204.750, "~>~Reset");
    PlayerTextDrawLetterSize(playerid, neu[playerid][0], 0.365, 1.353);
    PlayerTextDrawAlignment(playerid, neu[playerid][0], 1);
    PlayerTextDrawColor(playerid, neu[playerid][0], -1);
    PlayerTextDrawSetOutline(playerid, neu[playerid][0], 1);
    PlayerTextDrawBackgroundColor(playerid, neu[playerid][0], 51);
    PlayerTextDrawFont(playerid, neu[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, neu[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, neu[playerid][0], true);
    PlayerTextDrawTextSize(playerid, neu[playerid][0], 335, 15);

}

CreateTextDraw() {

    //Textdraws Spectating
    SpecBox = TextDrawCreate(318.000000, 351.000000, "_");
    TextDrawFont(SpecBox, 1);
    TextDrawLetterSize(SpecBox, 0.600000, 10.349996);
    TextDrawTextSize(SpecBox, 298.500000, 215.000000);
    TextDrawSetOutline(SpecBox, 1);
    TextDrawSetShadow(SpecBox, 0);
    TextDrawAlignment(SpecBox, 2);
    TextDrawColor(SpecBox, -1);
    TextDrawBackgroundColor(SpecBox, 255);
    TextDrawBoxColor(SpecBox, 235);
    TextDrawUseBox(SpecBox, 1);
    TextDrawSetProportional(SpecBox, 1);
    TextDrawSetSelectable(SpecBox, 0);

    Cent[0] = TextDrawCreate(580.000000, 54.000000, ".");
    TextDrawFont(Cent[0], 2);
    TextDrawLetterSize(Cent[0], 0.924999, 5.700003);
    TextDrawTextSize(Cent[0], 400.000000, 17.000000);
    TextDrawSetOutline(Cent[0], 1);
    TextDrawSetShadow(Cent[0], 0);
    TextDrawAlignment(Cent[0], 1);
    TextDrawColor(Cent[0], 6553855);
    TextDrawBackgroundColor(Cent[0], 255);
    TextDrawBoxColor(Cent[0], 50);
    TextDrawUseBox(Cent[0], 0);
    TextDrawSetProportional(Cent[0], 1);
    TextDrawSetSelectable(Cent[0], 0);

    Cent[1] = TextDrawCreate(542.000000, 75.000000, ",");
    TextDrawFont(Cent[1], 2);
    TextDrawLetterSize(Cent[1], 0.745832, 2.849998);
    TextDrawTextSize(Cent[1], 400.000000, 17.000000);
    TextDrawSetOutline(Cent[1], 1);
    TextDrawSetShadow(Cent[1], 0);
    TextDrawAlignment(Cent[1], 1);
    TextDrawColor(Cent[1], 6553855);
    TextDrawBackgroundColor(Cent[1], 255);
    TextDrawBoxColor(Cent[1], 50);
    TextDrawUseBox(Cent[1], 0);
    TextDrawSetProportional(Cent[1], 1);
    TextDrawSetSelectable(Cent[1], 0);

    //Kalkulator
    boxlator[0] = TextDrawCreate(374.941, 136.250, "box");
    TextDrawLetterSize(boxlator[0], 0.000, 24.885);
    TextDrawTextSize(boxlator[0], 239.287, 0.000);
    TextDrawAlignment(boxlator[0], 1);
    TextDrawColor(boxlator[0], 0);
    TextDrawUseBox(boxlator[0], 1);
    TextDrawBoxColor(boxlator[0], 188);
    TextDrawFont(boxlator[0], 0);

    Line1 = TextDrawCreate(236.791, 367.583, "LD_NONE:tvcorn");
    TextDrawTextSize(Line1, 63.715, -126.000);
    TextDrawAlignment(Line1, 1);
    TextDrawColor(Line1, -1);
    TextDrawFont(Line1, 4);

    Line2 = TextDrawCreate(377.846, 368.083, "LD_NONE:tvcorn");
    TextDrawTextSize(Line2, -77.305, -129.498);
    TextDrawAlignment(Line2, 1);
    TextDrawColor(Line2, -1);
    TextDrawFont(Line2, 4);

    Line3 = TextDrawCreate(377.410, 129.416, "LD_NONE:tvcorn");
    TextDrawTextSize(Line3, -72.620, 113.166);
    TextDrawAlignment(Line3, 1);
    TextDrawColor(Line3, -1);
    TextDrawFont(Line3, 4);

    Line4 = TextDrawCreate(236.291, 129.082, "LD_NONE:tvcorn");
    TextDrawTextSize(Line4, 68.872, 114.333);
    TextDrawAlignment(Line4, 1);
    TextDrawColor(Line4, -1);
    TextDrawFont(Line4, 4);

    tdbox[0] = TextDrawCreate(359.013, 174.166, "box");
    TextDrawLetterSize(tdbox[0], 0.000, 2.404);
    TextDrawTextSize(tdbox[0], 253.343, 0.000);
    TextDrawAlignment(tdbox[0], 1);
    TextDrawColor(tdbox[0], 0);
    TextDrawUseBox(tdbox[0], 1);
    TextDrawBoxColor(tdbox[0], 659344823);
    TextDrawFont(tdbox[0], 0);

    tdbox[1] = TextDrawCreate(276.114, 206.166, "box");
    TextDrawLetterSize(tdbox[1], 0.000, 2.029);
    TextDrawTextSize(tdbox[1], 253.343, 0.000);
    TextDrawAlignment(tdbox[1], 1);
    TextDrawColor(tdbox[1], 0);
    TextDrawUseBox(tdbox[1], 1);
    TextDrawBoxColor(tdbox[1], 659344823);
    TextDrawFont(tdbox[1], 0);

    tdbox[2] = TextDrawCreate(296.294, 206.082, "box");
    TextDrawLetterSize(tdbox[2], 0.000, 2.029);
    TextDrawTextSize(tdbox[2], 273.022, 0.000);
    TextDrawAlignment(tdbox[2], 1);
    TextDrawColor(tdbox[2], 0);
    TextDrawUseBox(tdbox[2], 1);
    TextDrawBoxColor(tdbox[2], 659344823);
    TextDrawFont(tdbox[2], 0);

    tdbox[3] = TextDrawCreate(316.941, 205.998, "box");
    TextDrawLetterSize(tdbox[3], 0.000, 2.029);
    TextDrawTextSize(tdbox[3], 293.169, 0.000);
    TextDrawAlignment(tdbox[3], 1);
    TextDrawColor(tdbox[3], 0);
    TextDrawUseBox(tdbox[3], 1);
    TextDrawBoxColor(tdbox[3], 659344823);
    TextDrawFont(tdbox[3], 0);

    tdbox[4] = TextDrawCreate(296.325, 229.914, "box");
    TextDrawLetterSize(tdbox[4], 0.000, 2.029);
    TextDrawTextSize(tdbox[4], 273.022, 0.000);
    TextDrawAlignment(tdbox[4], 1);
    TextDrawColor(tdbox[4], 0);
    TextDrawUseBox(tdbox[4], 1);
    TextDrawBoxColor(tdbox[4], 659344823);
    TextDrawFont(tdbox[4], 0);

    tdbox[5] = TextDrawCreate(316.971, 230.414, "box");
    TextDrawLetterSize(tdbox[5], 0.000, 1.980);
    TextDrawTextSize(tdbox[5], 293.166, 0.000);
    TextDrawAlignment(tdbox[5], 1);
    TextDrawColor(tdbox[5], 0);
    TextDrawUseBox(tdbox[5], 1);
    TextDrawBoxColor(tdbox[5], 659344823);
    TextDrawFont(tdbox[5], 0);

    tdbox[6] = TextDrawCreate(276.239, 230.330, "box");
    TextDrawLetterSize(tdbox[6], 0.000, 1.980);
    TextDrawTextSize(tdbox[6], 253.343, 0.000);
    TextDrawAlignment(tdbox[6], 1);
    TextDrawColor(tdbox[6], 0);
    TextDrawUseBox(tdbox[6], 1);
    TextDrawBoxColor(tdbox[6], 659344823);
    TextDrawBackgroundColor(tdbox[6], 102);
    TextDrawFont(tdbox[6], 0);

    tdbox[7] = TextDrawCreate(275.802, 254.162, "box");
    TextDrawLetterSize(tdbox[7], 0.000, 1.980);
    TextDrawTextSize(tdbox[7], 253.343, 0.000);
    TextDrawAlignment(tdbox[7], 1);
    TextDrawColor(tdbox[7], 0);
    TextDrawUseBox(tdbox[7], 1);
    TextDrawBoxColor(tdbox[7], 659344823);
    TextDrawBackgroundColor(tdbox[7], 102);
    TextDrawFont(tdbox[7], 0);

    tdbox[8] = TextDrawCreate(296.449, 254.080, "box");
    TextDrawLetterSize(tdbox[8], 0.000, 2.026);
    TextDrawTextSize(tdbox[8], 272.552, 0.000);
    TextDrawAlignment(tdbox[8], 1);
    TextDrawColor(tdbox[8], 0);
    TextDrawUseBox(tdbox[8], 1);
    TextDrawBoxColor(tdbox[8], 659344823);
    TextDrawBackgroundColor(tdbox[8], 102);
    TextDrawFont(tdbox[8], 0);

    tdbox[9] = TextDrawCreate(317.095, 253.996, "box");
    TextDrawLetterSize(tdbox[9], 0.000, 2.026);
    TextDrawTextSize(tdbox[9], 293.165, 0.000);
    TextDrawAlignment(tdbox[9], 1);
    TextDrawColor(tdbox[9], 0);
    TextDrawUseBox(tdbox[9], 1);
    TextDrawBoxColor(tdbox[9], 659344823);
    TextDrawBackgroundColor(tdbox[9], 102);
    TextDrawFont(tdbox[9], 1);

    tdbox[10] = TextDrawCreate(318.532, 290.079, "box");
    TextDrawLetterSize(tdbox[10], 0.000, 5.585);
    TextDrawTextSize(tdbox[10], 253.341, 0.000);
    TextDrawAlignment(tdbox[10], 1);
    TextDrawColor(tdbox[10], 0);
    TextDrawUseBox(tdbox[10], 1);
    TextDrawBoxColor(tdbox[10], 659344823);
    TextDrawBackgroundColor(tdbox[10], 102);
    TextDrawFont(tdbox[10], 1);

    zahl1 = TextDrawCreate(259.558, 208.248, "1");
    TextDrawLetterSize(zahl1, 0.449, 1.600);
    TextDrawAlignment(zahl1, 1);
    TextDrawColor(zahl1, -1);
    TextDrawSetOutline(zahl1, 1);
    TextDrawBackgroundColor(zahl1, 51);
    TextDrawFont(zahl1, 1);
    TextDrawSetProportional(zahl1, 1);
    TextDrawSetSelectable(zahl1, true);
    TextDrawTextSize(zahl1, 270, 15);

    zahl2 = TextDrawCreate(279.269, 208.748, "2");
    TextDrawLetterSize(zahl2, 0.449, 1.600);
    TextDrawAlignment(zahl2, 1);
    TextDrawColor(zahl2, -1);
    TextDrawSetOutline(zahl2, 1);
    TextDrawBackgroundColor(zahl2, 51);
    TextDrawFont(zahl2, 1);
    TextDrawSetProportional(zahl2, 1);
    TextDrawSetSelectable(zahl2, true);
    TextDrawTextSize(zahl2, 290, 15);

    zahl3 = TextDrawCreate(299.915, 208.666, "3");
    TextDrawLetterSize(zahl3, 0.449, 1.600);
    TextDrawAlignment(zahl3, 1);
    TextDrawColor(zahl3, -1);
    TextDrawSetOutline(zahl3, 1);
    TextDrawBackgroundColor(zahl3, 51);
    TextDrawFont(zahl3, 1);
    TextDrawSetProportional(zahl3, 1);
    TextDrawSetSelectable(zahl3, true);
    TextDrawTextSize(zahl3, 310, 15);

    zahl4 = TextDrawCreate(259.653, 232.498, "4");
    TextDrawLetterSize(zahl4, 0.449, 1.600);
    TextDrawAlignment(zahl4, 1);
    TextDrawColor(zahl4, -1);
    TextDrawSetOutline(zahl4, 1);
    TextDrawBackgroundColor(zahl4, 51);
    TextDrawFont(zahl4, 1);
    TextDrawSetProportional(zahl4, 1);
    TextDrawSetSelectable(zahl4, true);
    TextDrawTextSize(zahl4, 270, 15);

    zahl5 = TextDrawCreate(280.302, 232.416, "5");
    TextDrawLetterSize(zahl5, 0.449, 1.600);
    TextDrawAlignment(zahl5, 1);
    TextDrawColor(zahl5, -1);
    TextDrawSetOutline(zahl5, 1);
    TextDrawBackgroundColor(zahl5, 51);
    TextDrawFont(zahl5, 1);
    TextDrawSetProportional(zahl5, 1);
    TextDrawSetSelectable(zahl5, true);
    TextDrawTextSize(zahl5, 290, 15);

    zahl6 = TextDrawCreate(300.480, 232.332, "6");
    TextDrawLetterSize(zahl6, 0.449, 1.600);
    TextDrawAlignment(zahl6, 1);
    TextDrawColor(zahl6, -1);
    TextDrawSetOutline(zahl6, 1);
    TextDrawBackgroundColor(zahl6, 51);
    TextDrawFont(zahl6, 1);
    TextDrawSetProportional(zahl6, 1);
    TextDrawSetSelectable(zahl6, true);
    TextDrawTextSize(zahl6, 310, 15);

    zahl7 = TextDrawCreate(259.747, 256.747, "7");
    TextDrawLetterSize(zahl7, 0.449, 1.600);
    TextDrawAlignment(zahl7, 1);
    TextDrawColor(zahl7, -1);
    TextDrawSetOutline(zahl7, 1);
    TextDrawBackgroundColor(zahl7, 51);
    TextDrawFont(zahl7, 1);
    TextDrawSetProportional(zahl7, 1);
    TextDrawSetSelectable(zahl7, true);
    TextDrawTextSize(zahl7, 270, 15);

    zahl8 = TextDrawCreate(279.459, 256.665, "8");
    TextDrawLetterSize(zahl8, 0.449, 1.600);
    TextDrawAlignment(zahl8, 1);
    TextDrawColor(zahl8, -1);
    TextDrawSetOutline(zahl8, 1);
    TextDrawBackgroundColor(zahl8, 51);
    TextDrawFont(zahl8, 1);
    TextDrawSetProportional(zahl8, 1);
    TextDrawSetSelectable(zahl8, true);
    TextDrawTextSize(zahl8, 290, 15);

    zahl9 = TextDrawCreate(300.574, 256.583, "9");
    TextDrawLetterSize(zahl9, 0.449, 1.600);
    TextDrawAlignment(zahl9, 1);
    TextDrawColor(zahl9, -1);
    TextDrawSetOutline(zahl9, 1);
    TextDrawBackgroundColor(zahl9, 51);
    TextDrawFont(zahl9, 1);
    TextDrawSetProportional(zahl9, 1);
    TextDrawSetSelectable(zahl9, true);
    TextDrawTextSize(zahl9, 310, 15);


    plus = TextDrawCreate(259.842, 293.247, "+");
    TextDrawLetterSize(plus, 0.449, 1.600);
    TextDrawAlignment(plus, 1);
    TextDrawColor(plus, -1);
    TextDrawSetOutline(plus, 1);
    TextDrawBackgroundColor(plus, 51);
    TextDrawFont(plus, 1);
    TextDrawSetProportional(plus, 1);
    TextDrawSetSelectable(plus, true);
    TextDrawTextSize(plus, 270, 15);

    geteilt = TextDrawCreate(302.979, 293.165, ":");
    TextDrawLetterSize(geteilt, 0.449, 1.600);
    TextDrawAlignment(geteilt, 1);
    TextDrawColor(geteilt, -1);
    TextDrawSetOutline(geteilt, 1);
    TextDrawBackgroundColor(geteilt, 51);
    TextDrawFont(geteilt, 1);
    TextDrawSetProportional(geteilt, 1);
    TextDrawSetSelectable(geteilt, true);
    TextDrawTextSize(geteilt, 310, 15);

    minus = TextDrawCreate(275.368, 293.083, "-");
    TextDrawLetterSize(minus, 0.449, 1.600);
    TextDrawAlignment(minus, 1);
    TextDrawColor(minus, -1);
    TextDrawSetOutline(minus, 1);
    TextDrawBackgroundColor(minus, 51);
    TextDrawFont(minus, 1);
    TextDrawSetProportional(minus, 1);
    TextDrawSetSelectable(minus, true);
    TextDrawTextSize(minus, 285, 15);

    mal = TextDrawCreate(287.113, 293.583, "x");
    TextDrawLetterSize(mal, 0.449, 1.600);
    TextDrawAlignment(mal, 1);
    TextDrawColor(mal, -1);
    TextDrawSetOutline(mal, 1);
    TextDrawBackgroundColor(mal, 51);
    TextDrawFont(mal, 1);
    TextDrawSetProportional(mal, 1);
    TextDrawSetSelectable(mal, true);
    TextDrawTextSize(mal, 297, 15);

    gleich = TextDrawCreate(255.753, 321.497, "=");
    TextDrawLetterSize(gleich, 0.587, 2.328);
    TextDrawTextSize(gleich, 29.048, 37.333);
    TextDrawAlignment(gleich, 1);
    TextDrawColor(gleich, -1);
    TextDrawSetOutline(gleich, 1);
    TextDrawBackgroundColor(gleich, 51);
    TextDrawFont(gleich, 1);
    TextDrawSetProportional(gleich, 1);
    TextDrawSetSelectable(gleich, true);
    TextDrawTextSize(gleich, 265, 15);

    ergebniss = TextDrawCreate(270.777, 325.497, "1234");
    TextDrawLetterSize(ergebniss, 0.379, 1.518);
    TextDrawTextSize(ergebniss, 29.048, 37.333);
    TextDrawAlignment(ergebniss, 1);
    TextDrawColor(ergebniss, -1);
    TextDrawSetOutline(ergebniss, 1);
    TextDrawBackgroundColor(ergebniss, 51);
    TextDrawFont(ergebniss, 1);
    TextDrawSetProportional(ergebniss, 1);
    TextDrawSetSelectable(ergebniss, true);

    rechnung = TextDrawCreate(260.968, 180.164, "12+12");
    TextDrawLetterSize(rechnung, 0.379, 1.518);
    TextDrawTextSize(rechnung, 29.048, 37.333);
    TextDrawAlignment(rechnung, 1);
    TextDrawColor(rechnung, -1);
    TextDrawBackgroundColor(rechnung, 51);
    TextDrawFont(rechnung, 1);
    TextDrawSetProportional(rechnung, 1);
    TextDrawSetSelectable(rechnung, true);

    exxit = TextDrawCreate(360.824, 130.500, "LD_CHAT:thumbdn");
    TextDrawTextSize(exxit, 15.461, 12.248);
    TextDrawAlignment(exxit, 1);
    TextDrawColor(exxit, -1);
    TextDrawFont(exxit, 4);
    TextDrawSetSelectable(exxit, true);

    Logo = TextDrawCreate(264.713, 117.833, "Kalkulator");
    TextDrawLetterSize(Logo, 0.312, 1.220);
    TextDrawAlignment(Logo, 1);
    TextDrawColor(Logo, 933625855);
    TextDrawSetOutline(Logo, 1);
    TextDrawBackgroundColor(Logo, 51);
    TextDrawFont(Logo, 3);
    TextDrawSetProportional(Logo, 1);

    //Date and Time
    TextDate = TextDrawCreate(71.000000, 430.000000, "24 - March - 2021");
    TextDrawFont(TextDate, 1);
    TextDrawLetterSize(TextDate, 0.308332, 1.349998);
    TextDrawTextSize(TextDate, 404.500000, 114.500000);
    TextDrawSetOutline(TextDate, 1);
    TextDrawSetShadow(TextDate, 0);
    TextDrawAlignment(TextDate, 2);
    TextDrawColor(TextDate, -1);
    TextDrawBackgroundColor(TextDate, 255);
    TextDrawBoxColor(TextDate, 50);
    TextDrawSetProportional(TextDate, 1);
    TextDrawSetSelectable(TextDate, 0);

    TextTime = TextDrawCreate(547.000000, 28.000000, "-:-:-");
    TextDrawFont(TextTime, 1);
    TextDrawLetterSize(TextTime, 0.400000, 2.000000);
    TextDrawTextSize(TextTime, 400.000000, 1.399999);
    TextDrawSetOutline(TextTime, 1);
    TextDrawSetShadow(TextTime, 0);
    TextDrawAlignment(TextTime, 1);
    TextDrawColor(TextTime, -1);
    TextDrawBackgroundColor(TextTime, 255);
    TextDrawBoxColor(TextTime, 50);
    TextDrawUseBox(TextTime, 0);
    TextDrawSetProportional(TextTime, 1);
    TextDrawSetSelectable(TextTime, 0);

    // Animation textdraw
    AnimationTD = TextDrawCreate(261.000000, 395.000000, "Gunakan ~b~H~w~ untuk stop anim");
    TextDrawFont(AnimationTD, 2);
    TextDrawLetterSize(AnimationTD, 0.199996, 1.649996);
    TextDrawTextSize(AnimationTD, 636.500000, -174.500000);
    TextDrawSetOutline(AnimationTD, 1);
    TextDrawSetShadow(AnimationTD, 0);
    TextDrawAlignment(AnimationTD, 1);
    TextDrawColor(AnimationTD, -1);
    TextDrawBackgroundColor(AnimationTD, 255);
    TextDrawBoxColor(AnimationTD, 50);
    TextDrawUseBox(AnimationTD, 0);
    TextDrawSetProportional(AnimationTD, 1);
    TextDrawSetSelectable(AnimationTD, 0);

    StatsTD[0] = TextDrawCreate(585.000000, 364.000000, "_");
    TextDrawFont(StatsTD[0], 1);
    TextDrawLetterSize(StatsTD[0], 0.600000, 9.550009);
    TextDrawTextSize(StatsTD[0], 296.000000, 172.500000);
    TextDrawSetOutline(StatsTD[0], 1);
    TextDrawSetShadow(StatsTD[0], 0);
    TextDrawAlignment(StatsTD[0], 2);
    TextDrawColor(StatsTD[0], -1);
    TextDrawBackgroundColor(StatsTD[0], 255);
    TextDrawBoxColor(StatsTD[0], 125);
    TextDrawUseBox(StatsTD[0], 1);
    TextDrawSetProportional(StatsTD[0], 1);
    TextDrawSetSelectable(StatsTD[0], 0);

    StatsTD[1] = TextDrawCreate(587.000000, 366.000000, "_");
    TextDrawFont(StatsTD[1], 1);
    TextDrawLetterSize(StatsTD[1], 0.600000, 9.550009);
    TextDrawTextSize(StatsTD[1], 296.000000, 172.500000);
    TextDrawSetOutline(StatsTD[1], 1);
    TextDrawSetShadow(StatsTD[1], 0);
    TextDrawAlignment(StatsTD[1], 2);
    TextDrawColor(StatsTD[1], -1);
    TextDrawBackgroundColor(StatsTD[1], 255);
    TextDrawBoxColor(StatsTD[1], -1);
    TextDrawUseBox(StatsTD[1], 1);
    TextDrawSetProportional(StatsTD[1], 1);
    TextDrawSetSelectable(StatsTD[1], 0);

    StatsTD[2] = TextDrawCreate(622.000000, 368.000000, "_");
    TextDrawFont(StatsTD[2], 1);
    TextDrawLetterSize(StatsTD[2], 0.600000, 9.200004);
    TextDrawTextSize(StatsTD[2], 298.500000, 42.500000);
    TextDrawSetOutline(StatsTD[2], 1);
    TextDrawSetShadow(StatsTD[2], 0);
    TextDrawAlignment(StatsTD[2], 2);
    TextDrawColor(StatsTD[2], -1);
    TextDrawBackgroundColor(StatsTD[2], 255);
    TextDrawBoxColor(StatsTD[2], 135);
    TextDrawUseBox(StatsTD[2], 1);
    TextDrawSetProportional(StatsTD[2], 1);
    TextDrawSetSelectable(StatsTD[2], 0);

    StatsTD[3] = TextDrawCreate(549.000000, 388.000000, "_");
    TextDrawFont(StatsTD[3], 1);
    TextDrawLetterSize(StatsTD[3], 0.600000, 9.200004);
    TextDrawTextSize(StatsTD[3], 298.500000, 94.000000);
    TextDrawSetOutline(StatsTD[3], 1);
    TextDrawSetShadow(StatsTD[3], 0);
    TextDrawAlignment(StatsTD[3], 2);
    TextDrawColor(StatsTD[3], -1);
    TextDrawBackgroundColor(StatsTD[3], 255);
    TextDrawBoxColor(StatsTD[3], 135);
    TextDrawUseBox(StatsTD[3], 1);
    TextDrawSetProportional(StatsTD[3], 1);
    TextDrawSetSelectable(StatsTD[3], 0);

    StatsTD[4] = TextDrawCreate(549.000000, 368.000000, "_");
    TextDrawFont(StatsTD[4], 1);
    TextDrawLetterSize(StatsTD[4], 0.600000, 1.600005);
    TextDrawTextSize(StatsTD[4], 298.500000, 94.000000);
    TextDrawSetOutline(StatsTD[4], 1);
    TextDrawSetShadow(StatsTD[4], 0);
    TextDrawAlignment(StatsTD[4], 2);
    TextDrawColor(StatsTD[4], -1);
    TextDrawBackgroundColor(StatsTD[4], 255);
    TextDrawBoxColor(StatsTD[4], 135);
    TextDrawUseBox(StatsTD[4], 1);
    TextDrawSetProportional(StatsTD[4], 1);
    TextDrawSetSelectable(StatsTD[4], 0);

    StatsTD[5] = TextDrawCreate(508.000000, 421.000000, "HUD:radar_diner");
    TextDrawFont(StatsTD[5], 4);
    TextDrawLetterSize(StatsTD[5], 0.600000, 2.000000);
    TextDrawTextSize(StatsTD[5], 13.500000, 15.000000);
    TextDrawSetOutline(StatsTD[5], 1);
    TextDrawSetShadow(StatsTD[5], 0);
    TextDrawAlignment(StatsTD[5], 1);
    TextDrawColor(StatsTD[5], -1);
    TextDrawBackgroundColor(StatsTD[5], 0);
    TextDrawBoxColor(StatsTD[5], 0);
    TextDrawUseBox(StatsTD[5], 1);
    TextDrawSetProportional(StatsTD[5], 1);
    TextDrawSetSelectable(StatsTD[5], 0);

    StatsTD[6] = TextDrawCreate(508.000000, 398.000000, "HUD:radar_datefood");
    TextDrawFont(StatsTD[6], 4);
    TextDrawLetterSize(StatsTD[6], 0.600000, 2.000000);
    TextDrawTextSize(StatsTD[6], 13.500000, 14.000000);
    TextDrawSetOutline(StatsTD[6], 1);
    TextDrawSetShadow(StatsTD[6], 0);
    TextDrawAlignment(StatsTD[6], 1);
    TextDrawColor(StatsTD[6], -1);
    TextDrawBackgroundColor(StatsTD[6], 255);
    TextDrawBoxColor(StatsTD[6], 50);
    TextDrawUseBox(StatsTD[6], 1);
    TextDrawSetProportional(StatsTD[6], 1);
    TextDrawSetSelectable(StatsTD[6], 0);

    //Vehicle textdraw
    VehicleTD[0] = TextDrawCreate(427.000000, 364.000000, "_");
    TextDrawFont(VehicleTD[0], 1);
    TextDrawLetterSize(VehicleTD[0], 0.600000, 9.550004);
    TextDrawTextSize(VehicleTD[0], 296.000000, 132.000000);
    TextDrawSetOutline(VehicleTD[0], 1);
    TextDrawSetShadow(VehicleTD[0], 0);
    TextDrawAlignment(VehicleTD[0], 2);
    TextDrawColor(VehicleTD[0], -1);
    TextDrawBackgroundColor(VehicleTD[0], 255);
    TextDrawBoxColor(VehicleTD[0], 125);
    TextDrawUseBox(VehicleTD[0], 1);
    TextDrawSetProportional(VehicleTD[0], 1);
    TextDrawSetSelectable(VehicleTD[0], 0);

    VehicleTD[1] = TextDrawCreate(427.000000, 366.000000, "_");
    TextDrawFont(VehicleTD[1], 1);
    TextDrawLetterSize(VehicleTD[1], 0.600000, 9.550004);
    TextDrawTextSize(VehicleTD[1], 296.000000, 127.500000);
    TextDrawSetOutline(VehicleTD[1], 1);
    TextDrawSetShadow(VehicleTD[1], 0);
    TextDrawAlignment(VehicleTD[1], 2);
    TextDrawColor(VehicleTD[1], -1);
    TextDrawBackgroundColor(VehicleTD[1], 255);
    TextDrawBoxColor(VehicleTD[1], -1);
    TextDrawUseBox(VehicleTD[1], 1);
    TextDrawSetProportional(VehicleTD[1], 1);
    TextDrawSetSelectable(VehicleTD[1], 0);

    VehicleTD[2] = TextDrawCreate(460.000000, 388.000000, "_");
    TextDrawFont(VehicleTD[2], 1);
    TextDrawLetterSize(VehicleTD[2], 0.600000, 9.199997);
    TextDrawTextSize(VehicleTD[2], 298.500000, 59.000000);
    TextDrawSetOutline(VehicleTD[2], 1);
    TextDrawSetShadow(VehicleTD[2], 0);
    TextDrawAlignment(VehicleTD[2], 2);
    TextDrawColor(VehicleTD[2], -1);
    TextDrawBackgroundColor(VehicleTD[2], 255);
    TextDrawBoxColor(VehicleTD[2], 135);
    TextDrawUseBox(VehicleTD[2], 1);
    TextDrawSetProportional(VehicleTD[2], 1);
    TextDrawSetSelectable(VehicleTD[2], 0);

    VehicleTD[3] = TextDrawCreate(427.000000, 368.000000, "_");
    TextDrawFont(VehicleTD[3], 1);
    TextDrawLetterSize(VehicleTD[3], 0.600000, 1.600005);
    TextDrawTextSize(VehicleTD[3], 298.500000, 124.500000);
    TextDrawSetOutline(VehicleTD[3], 1);
    TextDrawSetShadow(VehicleTD[3], 0);
    TextDrawAlignment(VehicleTD[3], 2);
    TextDrawColor(VehicleTD[3], -1);
    TextDrawBackgroundColor(VehicleTD[3], 255);
    TextDrawBoxColor(VehicleTD[3], 135);
    TextDrawUseBox(VehicleTD[3], 1);
    TextDrawSetProportional(VehicleTD[3], 1);
    TextDrawSetSelectable(VehicleTD[3], 0);

    VehicleTD[4] = TextDrawCreate(362.000000, 429.000000, "Preview_Model");
    TextDrawFont(VehicleTD[4], 5);
    TextDrawLetterSize(VehicleTD[4], 0.600000, 2.000000);
    TextDrawTextSize(VehicleTD[4], 18.000000, 18.000000);
    TextDrawSetOutline(VehicleTD[4], 0);
    TextDrawSetShadow(VehicleTD[4], 0);
    TextDrawAlignment(VehicleTD[4], 1);
    TextDrawColor(VehicleTD[4], -1);
    TextDrawBackgroundColor(VehicleTD[4], 0);
    TextDrawBoxColor(VehicleTD[4], 255);
    TextDrawUseBox(VehicleTD[4], 0);
    TextDrawSetProportional(VehicleTD[4], 1);
    TextDrawSetSelectable(VehicleTD[4], 0);
    TextDrawSetPreviewModel(VehicleTD[4], 1650);
    TextDrawSetPreviewRot(VehicleTD[4], -1.000000, 0.000000, 170.000000, 1.000000);
    TextDrawSetPreviewVehCol(VehicleTD[4], 1, 1);

    VehicleTD[5] = TextDrawCreate(395.000000, 388.000000, "_");
    TextDrawFont(VehicleTD[5], 1);
    TextDrawLetterSize(VehicleTD[5], 0.600000, 9.199997);
    TextDrawTextSize(VehicleTD[5], 299.500000, 60.500000);
    TextDrawSetOutline(VehicleTD[5], 1);
    TextDrawSetShadow(VehicleTD[5], 0);
    TextDrawAlignment(VehicleTD[5], 2);
    TextDrawColor(VehicleTD[5], -1);
    TextDrawBackgroundColor(VehicleTD[5], 255);
    TextDrawBoxColor(VehicleTD[5], 135);
    TextDrawUseBox(VehicleTD[5], 1);
    TextDrawSetProportional(VehicleTD[5], 1);
    TextDrawSetSelectable(VehicleTD[5], 0);

    VehicleTD[6] = TextDrawCreate(362.000000, 413.000000, "Preview_Model");
    TextDrawFont(VehicleTD[6], 5);
    TextDrawLetterSize(VehicleTD[6], 0.600000, 2.000000);
    TextDrawTextSize(VehicleTD[6], 18.000000, 18.000000);
    TextDrawSetOutline(VehicleTD[6], 0);
    TextDrawSetShadow(VehicleTD[6], 0);
    TextDrawAlignment(VehicleTD[6], 1);
    TextDrawColor(VehicleTD[6], -1);
    TextDrawBackgroundColor(VehicleTD[6], 0);
    TextDrawBoxColor(VehicleTD[6], 255);
    TextDrawUseBox(VehicleTD[6], 0);
    TextDrawSetProportional(VehicleTD[6], 1);
    TextDrawSetSelectable(VehicleTD[6], 0);
    TextDrawSetPreviewModel(VehicleTD[6], 1240);
    TextDrawSetPreviewRot(VehicleTD[6], -1.000000, 0.000000, 170.000000, 1.000000);
    TextDrawSetPreviewVehCol(VehicleTD[6], 1, 1);

    //------------[ Phone Textdraws Vexcity ]
    PhoneTD[0] = TextDrawCreate(512.000000, 111.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[0], 4);
    TextDrawLetterSize(PhoneTD[0], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[0], 25.000000, 25.000000);
    TextDrawSetOutline(PhoneTD[0], 1);
    TextDrawSetShadow(PhoneTD[0], 0);
    TextDrawAlignment(PhoneTD[0], 1);
    TextDrawColor(PhoneTD[0], 255);
    TextDrawBackgroundColor(PhoneTD[0], 255);
    TextDrawBoxColor(PhoneTD[0], 50);
    TextDrawUseBox(PhoneTD[0], 1);
    TextDrawSetProportional(PhoneTD[0], 1);
    TextDrawSetSelectable(PhoneTD[0], 0);

    PhoneTD[1] = TextDrawCreate(410.000000, 111.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[1], 4);
    TextDrawLetterSize(PhoneTD[1], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[1], 25.000000, 25.000000);
    TextDrawSetOutline(PhoneTD[1], 1);
    TextDrawSetShadow(PhoneTD[1], 0);
    TextDrawAlignment(PhoneTD[1], 1);
    TextDrawColor(PhoneTD[1], 255);
    TextDrawBackgroundColor(PhoneTD[1], 255);
    TextDrawBoxColor(PhoneTD[1], 50);
    TextDrawUseBox(PhoneTD[1], 1);
    TextDrawSetProportional(PhoneTD[1], 1);
    TextDrawSetSelectable(PhoneTD[1], 0);

    PhoneTD[2] = TextDrawCreate(410.000000, 321.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[2], 4);
    TextDrawLetterSize(PhoneTD[2], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[2], 25.000000, 25.000000);
    TextDrawSetOutline(PhoneTD[2], 1);
    TextDrawSetShadow(PhoneTD[2], 0);
    TextDrawAlignment(PhoneTD[2], 1);
    TextDrawColor(PhoneTD[2], 255);
    TextDrawBackgroundColor(PhoneTD[2], 255);
    TextDrawBoxColor(PhoneTD[2], 50);
    TextDrawUseBox(PhoneTD[2], 1);
    TextDrawSetProportional(PhoneTD[2], 1);
    TextDrawSetSelectable(PhoneTD[2], 0);

    PhoneTD[3] = TextDrawCreate(512.000000, 321.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[3], 4);
    TextDrawLetterSize(PhoneTD[3], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[3], 25.000000, 25.000000);
    TextDrawSetOutline(PhoneTD[3], 1);
    TextDrawSetShadow(PhoneTD[3], 0);
    TextDrawAlignment(PhoneTD[3], 1);
    TextDrawColor(PhoneTD[3], 255);
    TextDrawBackgroundColor(PhoneTD[3], 255);
    TextDrawBoxColor(PhoneTD[3], 50);
    TextDrawUseBox(PhoneTD[3], 1);
    TextDrawSetProportional(PhoneTD[3], 1);
    TextDrawSetSelectable(PhoneTD[3], 0);

    PhoneTD[4] = TextDrawCreate(473.000000, 117.500000, "_");
    TextDrawFont(PhoneTD[4], 1);
    TextDrawLetterSize(PhoneTD[4], 0.554166, 24.650011);
    TextDrawTextSize(PhoneTD[4], 261.000000, 101.500000);
    TextDrawSetOutline(PhoneTD[4], 1);
    TextDrawSetShadow(PhoneTD[4], 0);
    TextDrawAlignment(PhoneTD[4], 2);
    TextDrawColor(PhoneTD[4], -1);
    TextDrawBackgroundColor(PhoneTD[4], 255);
    TextDrawBoxColor(PhoneTD[4], 255);
    TextDrawUseBox(PhoneTD[4], 1);
    TextDrawSetProportional(PhoneTD[4], 1);
    TextDrawSetSelectable(PhoneTD[4], 0);

    PhoneTD[5] = TextDrawCreate(473.500000, 123.500000, "_");
    TextDrawFont(PhoneTD[5], 1);
    TextDrawLetterSize(PhoneTD[5], 0.554166, 23.050035);
    TextDrawTextSize(PhoneTD[5], 252.500000, 114.500000);
    TextDrawSetOutline(PhoneTD[5], 1);
    TextDrawSetShadow(PhoneTD[5], 0);
    TextDrawAlignment(PhoneTD[5], 2);
    TextDrawColor(PhoneTD[5], -1);
    TextDrawBackgroundColor(PhoneTD[5], 255);
    TextDrawBoxColor(PhoneTD[5], 255);
    TextDrawUseBox(PhoneTD[5], 1);
    TextDrawSetProportional(PhoneTD[5], 1);
    TextDrawSetSelectable(PhoneTD[5], 0);

    PhoneTD[6] = TextDrawCreate(419.000000, 318.000000, "ld_dual:backgnd");
    TextDrawFont(PhoneTD[6], 4);
    TextDrawLetterSize(PhoneTD[6], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[6], 109.500000, -198.000000);
    TextDrawSetOutline(PhoneTD[6], 1);
    TextDrawSetShadow(PhoneTD[6], 0);
    TextDrawAlignment(PhoneTD[6], 1);
    TextDrawColor(PhoneTD[6], -1);
    TextDrawBackgroundColor(PhoneTD[6], 255);
    TextDrawBoxColor(PhoneTD[6], 50);
    TextDrawUseBox(PhoneTD[6], 1);
    TextDrawSetProportional(PhoneTD[6], 1);
    TextDrawSetSelectable(PhoneTD[6], 0);

    PhoneTD[7] = TextDrawCreate(473.500000, 120.500000, "_");
    TextDrawFont(PhoneTD[7], 1);
    TextDrawLetterSize(PhoneTD[7], 0.554166, 1.700037);
    TextDrawTextSize(PhoneTD[7], 252.500000, 105.000000);
    TextDrawSetOutline(PhoneTD[7], 1);
    TextDrawSetShadow(PhoneTD[7], 0);
    TextDrawAlignment(PhoneTD[7], 2);
    TextDrawColor(PhoneTD[7], -1);
    TextDrawBackgroundColor(PhoneTD[7], 255);
    TextDrawBoxColor(PhoneTD[7], 255);
    TextDrawUseBox(PhoneTD[7], 1);
    TextDrawSetProportional(PhoneTD[7], 1);
    TextDrawSetSelectable(PhoneTD[7], 0);

    PhoneTD[8] = TextDrawCreate(474.000000, 123.000000, "_");
    TextDrawFont(PhoneTD[8], 1);
    TextDrawLetterSize(PhoneTD[8], 0.600000, -0.199993);
    TextDrawTextSize(PhoneTD[8], 326.000000, 21.000000);
    TextDrawSetOutline(PhoneTD[8], 1);
    TextDrawSetShadow(PhoneTD[8], 0);
    TextDrawAlignment(PhoneTD[8], 2);
    TextDrawColor(PhoneTD[8], -1);
    TextDrawBackgroundColor(PhoneTD[8], 255);
    TextDrawBoxColor(PhoneTD[8], -1);
    TextDrawUseBox(PhoneTD[8], 1);
    TextDrawSetProportional(PhoneTD[8], 1);
    TextDrawSetSelectable(PhoneTD[8], 0);

    PhoneTD[9] = TextDrawCreate(512.000000, 321.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[9], 4);
    TextDrawLetterSize(PhoneTD[9], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[9], 25.000000, 25.000000);
    TextDrawSetOutline(PhoneTD[9], 1);
    TextDrawSetShadow(PhoneTD[9], 0);
    TextDrawAlignment(PhoneTD[9], 1);
    TextDrawColor(PhoneTD[9], 255);
    TextDrawBackgroundColor(PhoneTD[9], 255);
    TextDrawBoxColor(PhoneTD[9], 50);
    TextDrawUseBox(PhoneTD[9], 1);
    TextDrawSetProportional(PhoneTD[9], 1);
    TextDrawSetSelectable(PhoneTD[9], 0);

    PhoneTD[10] = TextDrawCreate(480.000000, 119.500000, "ld_beat:chit");
    TextDrawFont(PhoneTD[10], 4);
    TextDrawLetterSize(PhoneTD[10], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[10], 10.000000, 5.000000);
    TextDrawSetOutline(PhoneTD[10], 1);
    TextDrawSetShadow(PhoneTD[10], 0);
    TextDrawAlignment(PhoneTD[10], 1);
    TextDrawColor(PhoneTD[10], -1);
    TextDrawBackgroundColor(PhoneTD[10], 255);
    TextDrawBoxColor(PhoneTD[10], 50);
    TextDrawUseBox(PhoneTD[10], 1);
    TextDrawSetProportional(PhoneTD[10], 1);
    TextDrawSetSelectable(PhoneTD[10], 0);

    PhoneTD[11] = TextDrawCreate(457.000000, 119.500000, "ld_beat:chit");
    TextDrawFont(PhoneTD[11], 4);
    TextDrawLetterSize(PhoneTD[11], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[11], 10.000000, 5.000000);
    TextDrawSetOutline(PhoneTD[11], 1);
    TextDrawSetShadow(PhoneTD[11], 0);
    TextDrawAlignment(PhoneTD[11], 1);
    TextDrawColor(PhoneTD[11], -1);
    TextDrawBackgroundColor(PhoneTD[11], 255);
    TextDrawBoxColor(PhoneTD[11], 50);
    TextDrawUseBox(PhoneTD[11], 1);
    TextDrawSetProportional(PhoneTD[11], 1);
    TextDrawSetSelectable(PhoneTD[11], 0);

    PhoneTD[12] = TextDrawCreate(452.000000, 119.500000, "ld_beat:chit");
    TextDrawFont(PhoneTD[12], 4);
    TextDrawLetterSize(PhoneTD[12], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[12], 5.000000, 5.000000);
    TextDrawSetOutline(PhoneTD[12], 1);
    TextDrawSetShadow(PhoneTD[12], 0);
    TextDrawAlignment(PhoneTD[12], 1);
    TextDrawColor(PhoneTD[12], -1);
    TextDrawBackgroundColor(PhoneTD[12], 255);
    TextDrawBoxColor(PhoneTD[12], 50);
    TextDrawUseBox(PhoneTD[12], 1);
    TextDrawSetProportional(PhoneTD[12], 1);
    TextDrawSetSelectable(PhoneTD[12], 0);

    PhoneTD[13] = TextDrawCreate(422.000000, 138.000000, "00:00");
    TextDrawFont(PhoneTD[13], 3);
    TextDrawLetterSize(PhoneTD[13], 0.220833, 1.100000);
    TextDrawTextSize(PhoneTD[13], 550.000000, 17.000000);
    TextDrawSetOutline(PhoneTD[13], 1);
    TextDrawSetShadow(PhoneTD[13], 0);
    TextDrawAlignment(PhoneTD[13], 1);
    TextDrawColor(PhoneTD[13], -1);
    TextDrawBackgroundColor(PhoneTD[13], 255);
    TextDrawBoxColor(PhoneTD[13], 50);
    TextDrawUseBox(PhoneTD[13], 0);
    TextDrawSetProportional(PhoneTD[13], 1);
    TextDrawSetSelectable(PhoneTD[13], 0);

    PhoneTD[14] = TextDrawCreate(416.000000, 151.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[14], 4);
    TextDrawLetterSize(PhoneTD[14], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[14], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[14], 1);
    TextDrawSetShadow(PhoneTD[14], 0);
    TextDrawAlignment(PhoneTD[14], 1);
    TextDrawColor(PhoneTD[14], 1687547391);
    TextDrawBackgroundColor(PhoneTD[14], 1097458175);
    TextDrawBoxColor(PhoneTD[14], 1687547186);
    TextDrawUseBox(PhoneTD[14], 1);
    TextDrawSetProportional(PhoneTD[14], 1);
    TextDrawSetSelectable(PhoneTD[14], 0);

    PhoneTD[15] = TextDrawCreate(454.000000, 151.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[15], 4);
    TextDrawLetterSize(PhoneTD[15], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[15], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[15], 1);
    TextDrawSetShadow(PhoneTD[15], 0);
    TextDrawAlignment(PhoneTD[15], 1);
    TextDrawColor(PhoneTD[15], -65281);
    TextDrawBackgroundColor(PhoneTD[15], 255);
    TextDrawBoxColor(PhoneTD[15], 50);
    TextDrawUseBox(PhoneTD[15], 1);
    TextDrawSetProportional(PhoneTD[15], 1);
    TextDrawSetSelectable(PhoneTD[15], 0);

    PhoneTD[16] = TextDrawCreate(491.000000, 151.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[16], 4);
    TextDrawLetterSize(PhoneTD[16], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[16], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[16], 1);
    TextDrawSetShadow(PhoneTD[16], 0);
    TextDrawAlignment(PhoneTD[16], 1);
    TextDrawColor(PhoneTD[16], 1296911871);
    TextDrawBackgroundColor(PhoneTD[16], 255);
    TextDrawBoxColor(PhoneTD[16], -16777166);
    TextDrawUseBox(PhoneTD[16], 1);
    TextDrawSetProportional(PhoneTD[16], 1);
    TextDrawSetSelectable(PhoneTD[16], 0);

    PhoneTD[17] = TextDrawCreate(491.000000, 193.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[17], 4);
    TextDrawLetterSize(PhoneTD[17], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[17], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[17], 1);
    TextDrawSetShadow(PhoneTD[17], 0);
    TextDrawAlignment(PhoneTD[17], 1);
    TextDrawColor(PhoneTD[17], -16776961);
    TextDrawBackgroundColor(PhoneTD[17], 255);
    TextDrawBoxColor(PhoneTD[17], -16777166);
    TextDrawUseBox(PhoneTD[17], 1);
    TextDrawSetProportional(PhoneTD[17], 1);
    TextDrawSetSelectable(PhoneTD[17], 0);

    PhoneTD[18] = TextDrawCreate(491.000000, 238.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[18], 4);
    TextDrawLetterSize(PhoneTD[18], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[18], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[18], 1);
    TextDrawSetShadow(PhoneTD[18], 0);
    TextDrawAlignment(PhoneTD[18], 1);
    TextDrawColor(PhoneTD[18], 9145343);
    TextDrawBackgroundColor(PhoneTD[18], 255);
    TextDrawBoxColor(PhoneTD[18], -16777166);
    TextDrawUseBox(PhoneTD[18], 1);
    TextDrawSetProportional(PhoneTD[18], 1);
    TextDrawSetSelectable(PhoneTD[18], 0);

    PhoneTD[19] = TextDrawCreate(416.000000, 193.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[19], 4);
    TextDrawLetterSize(PhoneTD[19], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[19], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[19], 1);
    TextDrawSetShadow(PhoneTD[19], 0);
    TextDrawAlignment(PhoneTD[19], 1);
    TextDrawColor(PhoneTD[19], -1);
    TextDrawBackgroundColor(PhoneTD[19], 1097458175);
    TextDrawBoxColor(PhoneTD[19], 1687547186);
    TextDrawUseBox(PhoneTD[19], 1);
    TextDrawSetProportional(PhoneTD[19], 1);
    TextDrawSetSelectable(PhoneTD[19], 0);

    PhoneTD[20] = TextDrawCreate(416.000000, 238.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[20], 4);
    TextDrawLetterSize(PhoneTD[20], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[20], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[20], 1);
    TextDrawSetShadow(PhoneTD[20], 0);
    TextDrawAlignment(PhoneTD[20], 1);
    TextDrawColor(PhoneTD[20], 65535);
    TextDrawBackgroundColor(PhoneTD[20], 1097458175);
    TextDrawBoxColor(PhoneTD[20], 1687547186);
    TextDrawUseBox(PhoneTD[20], 1);
    TextDrawSetProportional(PhoneTD[20], 1);
    TextDrawSetSelectable(PhoneTD[20], 0);

    PhoneTD[21] = TextDrawCreate(454.000000, 193.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[21], 4);
    TextDrawLetterSize(PhoneTD[21], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[21], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[21], 1);
    TextDrawSetShadow(PhoneTD[21], 0);
    TextDrawAlignment(PhoneTD[21], 1);
    TextDrawColor(PhoneTD[21], 1433087999);
    TextDrawBackgroundColor(PhoneTD[21], 255);
    TextDrawBoxColor(PhoneTD[21], 50);
    TextDrawUseBox(PhoneTD[21], 1);
    TextDrawSetProportional(PhoneTD[21], 1);
    TextDrawSetSelectable(PhoneTD[21], 0);

    PhoneTD[22] = TextDrawCreate(454.000000, 238.000000, "ld_beat:chit");
    TextDrawFont(PhoneTD[22], 4);
    TextDrawLetterSize(PhoneTD[22], 0.600000, 2.000000);
    TextDrawTextSize(PhoneTD[22], 40.000000, 40.000000);
    TextDrawSetOutline(PhoneTD[22], 1);
    TextDrawSetShadow(PhoneTD[22], 0);
    TextDrawAlignment(PhoneTD[22], 1);
    TextDrawColor(PhoneTD[22], -1962934017);
    TextDrawBackgroundColor(PhoneTD[22], 255);
    TextDrawBoxColor(PhoneTD[22], 50);
    TextDrawUseBox(PhoneTD[22], 1);
    TextDrawSetProportional(PhoneTD[22], 1);
    TextDrawSetSelectable(PhoneTD[22], 0);

    PhoneTD[23] = TextDrawCreate(428.000000, 186.000000, "SMS");
    TextDrawFont(PhoneTD[23], 1);
    TextDrawLetterSize(PhoneTD[23], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[23], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[23], 1);
    TextDrawSetShadow(PhoneTD[23], 0);
    TextDrawAlignment(PhoneTD[23], 1);
    TextDrawColor(PhoneTD[23], -1);
    TextDrawBackgroundColor(PhoneTD[23], 255);
    TextDrawBoxColor(PhoneTD[23], 50);
    TextDrawUseBox(PhoneTD[23], 0);
    TextDrawSetProportional(PhoneTD[23], 1);
    TextDrawSetSelectable(PhoneTD[23], 0);

    PhoneTD[24] = TextDrawCreate(458.000000, 186.000000, "CONTACT");
    TextDrawFont(PhoneTD[24], 1);
    TextDrawLetterSize(PhoneTD[24], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[24], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[24], 1);
    TextDrawSetShadow(PhoneTD[24], 0);
    TextDrawAlignment(PhoneTD[24], 1);
    TextDrawColor(PhoneTD[24], -1);
    TextDrawBackgroundColor(PhoneTD[24], 255);
    TextDrawBoxColor(PhoneTD[24], 50);
    TextDrawUseBox(PhoneTD[24], 0);
    TextDrawSetProportional(PhoneTD[24], 1);
    TextDrawSetSelectable(PhoneTD[24], 0);

    PhoneTD[25] = TextDrawCreate(502.000000, 186.000000, "CALL");
    TextDrawFont(PhoneTD[25], 1);
    TextDrawLetterSize(PhoneTD[25], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[25], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[25], 1);
    TextDrawSetShadow(PhoneTD[25], 0);
    TextDrawAlignment(PhoneTD[25], 1);
    TextDrawColor(PhoneTD[25], -1);
    TextDrawBackgroundColor(PhoneTD[25], 255);
    TextDrawBoxColor(PhoneTD[25], 50);
    TextDrawUseBox(PhoneTD[25], 0);
    TextDrawSetProportional(PhoneTD[25], 1);
    TextDrawSetSelectable(PhoneTD[25], 0);

    PhoneTD[26] = TextDrawCreate(497.000000, 227.000000, "SETTING");
    TextDrawFont(PhoneTD[26], 1);
    TextDrawLetterSize(PhoneTD[26], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[26], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[26], 1);
    TextDrawSetShadow(PhoneTD[26], 0);
    TextDrawAlignment(PhoneTD[26], 1);
    TextDrawColor(PhoneTD[26], -1);
    TextDrawBackgroundColor(PhoneTD[26], 255);
    TextDrawBoxColor(PhoneTD[26], 50);
    TextDrawUseBox(PhoneTD[26], 0);
    TextDrawSetProportional(PhoneTD[26], 1);
    TextDrawSetSelectable(PhoneTD[26], 0);

    PhoneTD[27] = TextDrawCreate(497.000000, 272.000000, "CAMERA");
    TextDrawFont(PhoneTD[27], 1);
    TextDrawLetterSize(PhoneTD[27], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[27], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[27], 1);
    TextDrawSetShadow(PhoneTD[27], 0);
    TextDrawAlignment(PhoneTD[27], 1);
    TextDrawColor(PhoneTD[27], -1);
    TextDrawBackgroundColor(PhoneTD[27], 255);
    TextDrawBoxColor(PhoneTD[27], 50);
    TextDrawUseBox(PhoneTD[27], 0);
    TextDrawSetProportional(PhoneTD[27], 1);
    TextDrawSetSelectable(PhoneTD[27], 0);

    PhoneTD[28] = TextDrawCreate(423.000000, 227.000000, "I-BANK");
    TextDrawFont(PhoneTD[28], 1);
    TextDrawLetterSize(PhoneTD[28], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[28], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[28], 1);
    TextDrawSetShadow(PhoneTD[28], 0);
    TextDrawAlignment(PhoneTD[28], 1);
    TextDrawColor(PhoneTD[28], -1);
    TextDrawBackgroundColor(PhoneTD[28], 255);
    TextDrawBoxColor(PhoneTD[28], 50);
    TextDrawUseBox(PhoneTD[28], 0);
    TextDrawSetProportional(PhoneTD[28], 1);
    TextDrawSetSelectable(PhoneTD[28], 0);

    PhoneTD[29] = TextDrawCreate(421.000000, 272.000000, "TWITTER");
    TextDrawFont(PhoneTD[29], 1);
    TextDrawLetterSize(PhoneTD[29], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[29], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[29], 1);
    TextDrawSetShadow(PhoneTD[29], 0);
    TextDrawAlignment(PhoneTD[29], 1);
    TextDrawColor(PhoneTD[29], -1);
    TextDrawBackgroundColor(PhoneTD[29], 255);
    TextDrawBoxColor(PhoneTD[29], 50);
    TextDrawUseBox(PhoneTD[29], 0);
    TextDrawSetProportional(PhoneTD[29], 1);
    TextDrawSetSelectable(PhoneTD[29], 0);

    PhoneTD[30] = TextDrawCreate(467.000000, 227.000000, "GPS");
    TextDrawFont(PhoneTD[30], 1);
    TextDrawLetterSize(PhoneTD[30], 0.224998, 1.000000);
    TextDrawTextSize(PhoneTD[30], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[30], 1);
    TextDrawSetShadow(PhoneTD[30], 0);
    TextDrawAlignment(PhoneTD[30], 1);
    TextDrawColor(PhoneTD[30], -1);
    TextDrawBackgroundColor(PhoneTD[30], 255);
    TextDrawBoxColor(PhoneTD[30], 50);
    TextDrawUseBox(PhoneTD[30], 0);
    TextDrawSetProportional(PhoneTD[30], 1);
    TextDrawSetSelectable(PhoneTD[30], 0);

    PhoneTD[31] = TextDrawCreate(462.000000, 272.000000, "APP");
    TextDrawFont(PhoneTD[31], 1);
    TextDrawLetterSize(PhoneTD[31], 0.224997, 1.000000);
    TextDrawTextSize(PhoneTD[31], 555.500000, 17.000000);
    TextDrawSetOutline(PhoneTD[31], 1);
    TextDrawSetShadow(PhoneTD[31], 0);
    TextDrawAlignment(PhoneTD[31], 1);
    TextDrawColor(PhoneTD[31], -1);
    TextDrawBackgroundColor(PhoneTD[31], 255);
    TextDrawBoxColor(PhoneTD[31], 50);
    TextDrawUseBox(PhoneTD[31], 0);
    TextDrawSetProportional(PhoneTD[31], 1);
    TextDrawSetSelectable(PhoneTD[31], 0);


    phoneclosetd = TextDrawCreate(459.000000, 316.500000, "ld_beat:chit"); //close
    TextDrawFont(phoneclosetd, 4);
    TextDrawLetterSize(phoneclosetd, 0.600000, 2.000000);
    TextDrawTextSize(phoneclosetd, 27.000000, 27.000000);
    TextDrawSetOutline(phoneclosetd, 1);
    TextDrawSetShadow(phoneclosetd, 0);
    TextDrawAlignment(phoneclosetd, 1);
    TextDrawColor(phoneclosetd, -1);
    TextDrawBackgroundColor(phoneclosetd, 255);
    TextDrawBoxColor(phoneclosetd, 50);
    TextDrawUseBox(phoneclosetd, 1);
    TextDrawSetProportional(phoneclosetd, 1);
    TextDrawSetSelectable(phoneclosetd, 1);

    mesaagetd = TextDrawCreate(429.000000, 163.000000, "ld_chat:goodcha");
    TextDrawFont(mesaagetd, 4);
    TextDrawLetterSize(mesaagetd, 0.600000, 2.000000);
    TextDrawTextSize(mesaagetd, 14.000000, 14.000000);
    TextDrawSetOutline(mesaagetd, 1);
    TextDrawSetShadow(mesaagetd, 0);
    TextDrawAlignment(mesaagetd, 1);
    TextDrawColor(mesaagetd, -1);
    TextDrawBackgroundColor(mesaagetd, 255);
    TextDrawBoxColor(mesaagetd, 50);
    TextDrawUseBox(mesaagetd, 1);
    TextDrawSetProportional(mesaagetd, 1);
    TextDrawSetSelectable(mesaagetd, 1);

    contactstd = TextDrawCreate(467.000000, 163.000000, "ld_chat:badchat");
    TextDrawFont(contactstd, 4);
    TextDrawLetterSize(contactstd, 0.600000, 2.000000);
    TextDrawTextSize(contactstd, 14.000000, 14.000000);
    TextDrawSetOutline(contactstd, 1);
    TextDrawSetShadow(contactstd, 0);
    TextDrawAlignment(contactstd, 1);
    TextDrawColor(contactstd, -1);
    TextDrawBackgroundColor(contactstd, 255);
    TextDrawBoxColor(contactstd, 50);
    TextDrawUseBox(contactstd, 1);
    TextDrawSetProportional(contactstd, 1);
    TextDrawSetSelectable(contactstd, 1);

    cameratd = TextDrawCreate(504.000000, 251.000000, "ld_grav:flwr");
    TextDrawFont(cameratd, 4);
    TextDrawLetterSize(cameratd, 0.600000, 2.000000);
    TextDrawTextSize(cameratd, 14.000000, 14.000000);
    TextDrawSetOutline(cameratd, 1);
    TextDrawSetShadow(cameratd, 0);
    TextDrawAlignment(cameratd, 1);
    TextDrawColor(cameratd, -1);
    TextDrawBackgroundColor(cameratd, 255);
    TextDrawBoxColor(cameratd, 50);
    TextDrawUseBox(cameratd, 1);
    TextDrawSetProportional(cameratd, 1);
    TextDrawSetSelectable(cameratd, 1);

    banktd = TextDrawCreate(429.000000, 205.000000, "HUD:radar_cash");
    TextDrawFont(banktd, 4);
    TextDrawLetterSize(banktd, 0.600000, 2.000000);
    TextDrawTextSize(banktd, 14.000000, 14.000000);
    TextDrawSetOutline(banktd, 1);
    TextDrawSetShadow(banktd, 0);
    TextDrawAlignment(banktd, 1);
    TextDrawColor(banktd, -1);
    TextDrawBackgroundColor(banktd, 255);
    TextDrawBoxColor(banktd, 50);
    TextDrawUseBox(banktd, 1);
    TextDrawSetProportional(banktd, 1);
    TextDrawSetSelectable(banktd, 1);

    settingtd = TextDrawCreate(504.000000, 205.000000, "HUD:radar_waypoint");
    TextDrawFont(settingtd, 4);
    TextDrawLetterSize(settingtd, 0.600000, 2.000000);
    TextDrawTextSize(settingtd, 14.000000, 14.000000);
    TextDrawSetOutline(settingtd, 1);
    TextDrawSetShadow(settingtd, 0);
    TextDrawAlignment(settingtd, 1);
    TextDrawColor(settingtd, -1);
    TextDrawBackgroundColor(settingtd, 255);
    TextDrawBoxColor(settingtd, 50);
    TextDrawUseBox(settingtd, 1);
    TextDrawSetProportional(settingtd, 1);
    TextDrawSetSelectable(settingtd, 1);

    twittertd = TextDrawCreate(431.000000, 249.000000, "T");
    TextDrawFont(twittertd, 1);
    TextDrawLetterSize(twittertd, 0.562500, 1.799998);
    TextDrawTextSize(twittertd, 441.000000, 49.000000);
    TextDrawSetOutline(twittertd, 1);
    TextDrawSetShadow(twittertd, 0);
    TextDrawAlignment(twittertd, 1);
    TextDrawColor(twittertd, -1);
    TextDrawBackgroundColor(twittertd, 255);
    TextDrawBoxColor(twittertd, 50);
    TextDrawUseBox(twittertd, 0);
    TextDrawSetProportional(twittertd, 1);
    TextDrawSetSelectable(twittertd, 1);

    gpstd = TextDrawCreate(467.000000, 203.000000, "G");
    TextDrawFont(gpstd, 1);
    TextDrawLetterSize(gpstd, 0.495833, 1.799998);
    TextDrawTextSize(gpstd, 480.500000, 52.500000);
    TextDrawSetOutline(gpstd, 1);
    TextDrawSetShadow(gpstd, 0);
    TextDrawAlignment(gpstd, 1);
    TextDrawColor(gpstd, -1);
    TextDrawBackgroundColor(gpstd, 255);
    TextDrawBoxColor(gpstd, 50);
    TextDrawUseBox(gpstd, 0);
    TextDrawSetProportional(gpstd, 1);
    TextDrawSetSelectable(gpstd, 1);

    calltd = TextDrawCreate(505.000000, 161.000000, "C");
    TextDrawFont(calltd, 1);
    TextDrawLetterSize(calltd, 0.495833, 1.799998);
    TextDrawTextSize(calltd, 516.000000, 17.000000);
    TextDrawSetOutline(calltd, 1);
    TextDrawSetShadow(calltd, 0);
    TextDrawAlignment(calltd, 1);
    TextDrawColor(calltd, -1);
    TextDrawBackgroundColor(calltd, 255);
    TextDrawBoxColor(calltd, 50);
    TextDrawUseBox(calltd, 0);
    TextDrawSetProportional(calltd, 1);
    TextDrawSetSelectable(calltd, 1);

    apptd = TextDrawCreate(467.000000, 249.000000, "HUD:radar_datedisco");
    TextDrawFont(apptd, 4);
    TextDrawLetterSize(apptd, 0.495833, 1.799998);
    TextDrawTextSize(apptd, 15.000000, 16.500000);
    TextDrawSetOutline(apptd, 1);
    TextDrawSetShadow(apptd, 0);
    TextDrawAlignment(apptd, 1);
    TextDrawColor(apptd, -1);
    TextDrawBackgroundColor(apptd, 255);
    TextDrawBoxColor(apptd, 50);
    TextDrawUseBox(apptd, 0);
    TextDrawSetProportional(apptd, 1);
    TextDrawSetSelectable(apptd, 1);
}