//-------------[ Player Commands ]-------------//
CMD:togglesettings(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	new str[1024], togpm[64], toglog[64], togads[64], togwt[64];

	if(pData[playerid][pTogPM] == 0)
	{
		togpm = ""RED_E"Disable";
	}
	else
	{
		togpm = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogLog] == 0)
	{
		toglog = ""RED_E"Disable";
	}
	else
	{
		toglog = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogAds] == 0)
	{
		togads = ""RED_E"Disable";
	}
	else
	{
		togads = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogWT] == 0)
	{
		togwt = ""RED_E"Disable";
	}
	else
	{
		togwt = ""LG_E"Enable";
	}

	format(str, sizeof(str), "Toggle Settings\tStatus\n"WHITEP_E"Toggle PM:\t%s\n"WHITEP_E"Toggle Logs:\t%s\n"WHITEP_E"Toggle Ads:\t%s\n"WHITEP_E"Toggle WT:\t%s", togpm, toglog, togads, togwt);
	ShowPlayerDialog(playerid, DIALOG_TOGGLE, DIALOG_STYLE_TABLIST_HEADERS, "Toggle Settings", str, "Set", "Close");
	return 1;

}

CMD:skateon(playerid)
{
	if(pData[playerid][pModeSkate] == 1)
		return Error(playerid, "Mode skateboard kamu telah on Dan Tidak bisa di gunakan berulang kali");
	if(pData[playerid][pSkate] == 0)
		return Error(playerid, "Anda tidak memiliki Skateboard");

	pData[playerid][pModeSkate] = 1;
	//layerAttachedObject(playerid, index, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0)
	if(pData[playerid][pModeSkate] == 1)
	{
		SetPlayerAttachedObject(playerid, 9, 19878, 6, -0.069, 0.077, 0.027, 97.500, 0.000, -68.400, 0.815, 0.886, 1.000);
		Info(playerid, "Mode skateboard telah {FFFF00}ON");
		Info(playerid, "Gunakan {FFFF00}/skateboard {FFFFFF}Untuk menggunakan Skateboard");
	}
	return 1;
}

CMD:skateboard(playerid)
{
	if(pData[playerid][pModeSkate] != 1)
		return Error(playerid, "Kamu harus /skateon Terlebih dahulu");
	if(pData[playerid][pSkate] == 0)
		return Error(playerid, "Anda tidak memiliki Skateboard");
	
	ApplyAnimation(playerid,"SKATE","skate_run",4.1,1,1,1,1,1,1);
	RemovePlayerAttachedObject(playerid, 9);
	SetPlayerAttachedObject(playerid, 9, 19878, 10, 0.127, 0.077, 0.020, -98.900, -89.600, 178.600, 0.865, 1.001, 1.000);
	Info(playerid, "Gunakan {ffff00}/skateoff {FFFFFF}Untuk menyimpan Skateboard");
	return 1;
}
CMD:skateoff(playerid)
{
	if(pData[playerid][pModeSkate] == 0)
		return Error(playerid, "Mode skateboard kamu telah off Dan Tidak bisa di gunakan berulang kali");
	if(pData[playerid][pSkate] == 0)
		return Error(playerid, "Anda tidak memiliki Skateboard");
	pData[playerid][pModeSkate] = 0;
	ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	RemovePlayerAttachedObject(playerid, 8);
	RemovePlayerAttachedObject(playerid, 9);
	Info(playerid, "Jika animasi Masih berjalan gunakan {FFFF00}/stopanim atau {FFFF00}H");
	return 1;
}

CMD:hudmode(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	new str[1024], hbemode[64], timeandate[64], nameserver[64], moneydot[64];

	if(pData[playerid][pHBEMode] == 1)
	{
		hbemode = ""GREEN_E"Modern";
	}
	else if(pData[playerid][pHBEMode] == 2)
	{
		hbemode = ""ORANGE_E"Simple";
	}
	else
	{
		hbemode = ""RED_E"Disable";
	}

	if(pData[playerid][pTimeAndDate] == 1)
	{
		timeandate = ""LG_E"Show";
	}
	else
	{
		timeandate = ""RED_E"Hide";
	}
	if(pData[playerid][pMoneyDot])
	{
		 moneydot= ""LG_E"Show";
	}
	else
	{
		moneydot = ""RED_E"Hide";
	}
	
	format(str, sizeof(str), "HUD Settings\tStatus\n"WHITEP_E"HBE Mode:\t%s\n"WHITEP_E"Text/Time:\t%s\n"WHITEP_E"Money Dot:\t%s", hbemode, timeandate, nameserver, moneydot);
	
	ShowPlayerDialog(playerid, DIALOG_HUDMODE, DIALOG_STYLE_TABLIST_HEADERS, "HUD Settings", str, "Set", "Close");
	return 1;
}

CMD:eprop(playerid, params[])
{
	new eprop[512];
    format(eprop, 512, "Stopanim\nBox\nTv\nBasket\nKursi\nPayung\nBendera\nBunga\nOmek\nBox Mini\nPizza");
    ShowPlayerDialog(playerid, DIALOG_EMOTEPROPERTY, DIALOG_STYLE_LIST, "{FF0000}Levana Pride {FFFFFF}- Emote Property", eprop, "Select", "Close");
	return 1;
}

CMD:kalkulator(playerid,params[])
{
	TogglePlayerControllable(playerid, 0);
	CancelSelectTextDraw(playerid);
	SelectTextDraw(playerid,0x8C8C8CFF);
	TextDrawShowForPlayer(playerid, boxlator[0]);
	TextDrawShowForPlayer(playerid, Line1);
	TextDrawShowForPlayer(playerid, Line2);
	TextDrawShowForPlayer(playerid, Line3);
	TextDrawShowForPlayer(playerid, Line4);
	TextDrawShowForPlayer(playerid, zahl1);
	TextDrawShowForPlayer(playerid, zahl2);
	TextDrawShowForPlayer(playerid, zahl3);
	TextDrawShowForPlayer(playerid, zahl4);
	TextDrawShowForPlayer(playerid, zahl5);
	TextDrawShowForPlayer(playerid, zahl6);
	TextDrawShowForPlayer(playerid, zahl7);
	TextDrawShowForPlayer(playerid, zahl8);
	TextDrawShowForPlayer(playerid, zahl9);
	TextDrawShowForPlayer(playerid, plus);
	TextDrawShowForPlayer(playerid, minus);
	TextDrawShowForPlayer(playerid, mal);
	TextDrawShowForPlayer(playerid, geteilt);
	TextDrawShowForPlayer(playerid, gleich);
	TextDrawShowForPlayer(playerid, exxit);
	PlayerTextDrawShow(playerid, neu[playerid][0]);
	TextDrawShowForPlayer(playerid, Logo);
	for(new i = 0; i< sizeof(tdbox);i++)
	{
		TextDrawShowForPlayer(playerid, tdbox[i]);
	}
	return 1;
}

CMD:race(playerid, params[]) {
	new type[24], string[128], Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(sscanf(params, "s[24]S()[128]", type, string)) {
		Usage(playerid, "/race [names]");
		SendClientMessage(playerid, COLOR_YELLOW, "NAMES: "WHITE_E"save (1-9), finish, invite, joinme, start");
		return 1;
	}
	if(!strcmp(type, "save", true)) {
		new ind;
		if(sscanf(string, "d", ind)) 
			return Usage(playerid, "/race save [index 1 - 9]");

		if(ind < 1 || ind > 9)
			return Usage(playerid,"Invalid route index!");

		new dex = ind - 1;
		RacePos[playerid][dex][0] = pos[0];
		RacePos[playerid][dex][1] = pos[1];
		RacePos[playerid][dex][2] = pos[2];
		SendCustomMessage(playerid, "RACE", "Checkpoint %d recorded and saved!", ind);
	}
	else if(!strcmp(type, "finish", true)) {
		RacePos[playerid][9][0] = pos[0];
		RacePos[playerid][9][1] = pos[1];
		RacePos[playerid][9][2] = pos[2];
		SendCustomMessage(playerid, "RACE", "Finish checkpoint recorded!");
	}
	else if(!strcmp(type, "joinme", true)) {
		RaceWith[playerid] = playerid;
		SendCustomMessage(playerid, "RACE", "Kamu mengikuti balapan milikmu sendiri!");
	}
	else if(!strcmp(type, "invite", true)) {
		new pid;
		if(sscanf(string, "u", pid))
			return Usage(playerid, "/race invite [playerid]");

		if(!IsPlayerNearPlayer(playerid, pid, 5.0) || pid == INVALID_PLAYER_ID)
			return Error(playerid, "Player tersebut tidak didekatmu!");

		if(RaceWith[pid] != INVALID_PLAYER_ID)
			return Error(playerid, "Player tersebut sudah ada di balapan lain!");

		if(pid == playerid)
			return Error(playerid, "Gunakan /race joinme");

		RaceWith[pid] = playerid;
		RaceWith[playerid] = playerid;
		SendCustomMessage(playerid, "RACE", "Kamu telah mengundang "YELLOW_E"%s "WHITE_E"untuk ikut balapan mu!", ReturnName(pid));
		SendCustomMessage(pid, "RACE", "Kamu telah diundang oleh "YELLOW_E"%s "WHITE_E"untuk mengikuti balapan!", ReturnName(playerid));
	}
	else if(!strcmp(type, "start", true)) {
		for(new i = 0; i < MAX_ROUTE - 1; i++) {
			if(RacePos[playerid][i][0] == 0 && RacePos[playerid][i][1] == 0 && RacePos[playerid][i][2] == 0) {
				SendCustomMessage(playerid, "RACE", "Route %d masih belum di record!", i + 1);
				return 1;
			}
		}
		if(RacePos[playerid][9][0] == 0 && RacePos[playerid][9][1] == 0 && RacePos[playerid][9][2] == 0)
			return Error(playerid, "Finish Route belum di record!");

		foreach (new player : Player) if(IsPlayerConnected(player) && RaceWith[player] == playerid) 
		{
			InRace[playerid] = true;
			RaceIndex[playerid] = 0;
			InRace[player] = true;
			RaceIndex[player] = 0;
			GameTextForPlayer(player, "Balapan dimulai!", 3000, 5);
			DisablePlayerRaceCheckpoint(player);
			SetPlayerRaceCheckpoint(player, 0, RacePos[RaceWith[player]][RaceIndex[player]][0], RacePos[RaceWith[player]][RaceIndex[player]][1], RacePos[RaceWith[player]][RaceIndex[player]][2], RacePos[RaceWith[player]][RaceIndex[player]+1][0], RacePos[RaceWith[player]][RaceIndex[player]+1][1], RacePos[RaceWith[player]][RaceIndex[player]+1][2], 5.0);
			GameTextForPlayer(playerid, "Balapan dimulai!", 3000, 5);
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, RacePos[playerid][RaceIndex[playerid]][0], RacePos[playerid][RaceIndex[playerid]][1], RacePos[playerid][RaceIndex[playerid]][2], RacePos[playerid][RaceIndex[playerid]+1][0], RacePos[playerid][RaceIndex[playerid]+1][1], RacePos[playerid][RaceIndex[playerid]+1][2], 5.0);
		}
	}
	return 1;
}

CMD:maxobject(playerid) {
    new str[155];
    strcat(str, "Setting\tObject Limit\tMultiplier\n");
    strcat(str, PINK_E"Potato\t100\t0.1\n");
    strcat(str, ORANGE_E"Low\t200\t0.2\n");
    strcat(str, WHITE_E"Normal\t300\t0.3\n");
    strcat(str, GREEN_E"High\t600\t0.8\n");
    strcat(str, YELLOW_E"Stonks High\t800\t1,0");
    ShowPlayerDialog(playerid, DIALOG_STREAMERSETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "Object Streamer Settings", str, "Set", "Cancel");
    return 1;
}

CMD:help(playerid, params[])
{
	new str[512], info[512];
	format(str, sizeof(str), "Account Commands\nGeneral Commands\nVehicle Commands\nJob Commands\nFaction Commands\nBusiness Commands\nHouse Commands\nWorkshop Commands\nDealership Commands \nVending Commands \nPrivate Garage Commands \nPrivate Storage Commands \n");
	strcat(info, str);
	if(pData[playerid][pRobLeader] > 1 || pData[playerid][pMemberRob] > 1)
	{
		format(str, sizeof(str), "Robbery Help");
		strcat(info, str);	
	}
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help Commands", info, "Select", "Close");
	return 1;
}

CMD:destroycp(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pSideJob] > 1 || pData[playerid][pCP] > 1)
		return Error(playerid, "Harap selesaikan Pekerjaan mu terlebih dahulu");

	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	Servers(playerid, "Menghapus Checkpoint Sukses");
	return 1;
}

CMD:credits(playerid)
{
	new line1[1200], line2[300], line3[500];
	strcat(line3, ""LB_E"Coder: "YELLOW_E"Dandy overall , Aril for Update\n");
	strcat(line3, ""LB_E"Support Mapper: "YELLOW_E"Dandy and his Friends, Adit\n");
	strcat(line3, ""LB_E"Support Website: "YELLOW_E"Manox\n");
	format(line2, sizeof(line2), ""LB_E"Server Support: "YELLOW_E"%s & All SA-MP Team\n\n\
	"GREEN_E"Terima kasih telah bergabung dengan kami! Copyright © 2024 | Levana Pride Roleplay.", pData[playerid][pName]);
	format(line1, sizeof(line1), "%s%s", line3, line2);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Levana Pride:RP: "WHITE_E"Server Credits", line1, "OK", "");
	return 1;
}

CMD:donate(playerid)
{
	new longstr2[3500];
	strcat(longstr2, ""WHITE_E"Looking for bonus features and commands? Get premium status today!");
	return 1;
}

/*CMD:donate(playerid)
{
    new line3[3500];
    strcat(line3, ""RED_E"...:::... "DOOM_"Donate List Levana Pride Roleplay "RED_E"...:::...\n");
    strcat(line3, ""RED_E"..:.. "DOOM_"GOLD(OOC) "RED_E"..:..\n\n");

    strcat(line3, ""DOOM_"1. 250 Gold >> "RED_E"Rp 15.000\n");
    strcat(line3, ""DOOM_"2. 525 Gold >> "RED_E"Rp 25.000\n");
	strcat(line3, ""DOOM_"3. 1125 Gold >> "RED_E"Rp 50.000\n");
    strcat(line3, ""DOOM_"4. 2150 Gold >> "RED_E"Rp 100.000\n");
	strcat(line3, ""DOOM_"5. 3125 Gold >> "RED_E"Rp 150.000\n");
    strcat(line3, ""DOOM_"6. 4200 Gold >> "RED_E"Rp 200.000\n\n");

	strcat(line3, ""RED_E"..::.. "DOOM_"VIP PLAYER "RED_E"..::..\n\n");
	
    strcat(line3, ""DOOM_"1. VIP Regular(1 Month) >> "RED_E"500 Gold\n");
    strcat(line3, ""DOOM_"2. VIP Premium(1 Month) >> "RED_E"900 Gold\n");
    strcat(line3, ""DOOM_"3. VIP Platinum(1 Month) >> "RED_E"1200 Gold\n\n");

	strcat(line3, ""RED_E"..:::.. "DOOM_"SERVER FEATURE "RED_E"..:::..\n\n");
    strcat(line3, ""DOOM_"1. Mapping(per object) >> "RED_E"60 Gold\n");
	strcat(line3, ""DOOM_"2. Private Door >> "RED_E"100 Gold\n");
	strcat(line3, ""DOOM_"3. Private Gate >> "RED_E"200 Gold\n");
	strcat(line3, ""DOOM_"4. Bisnis >> "RED_E"(Tergantung Lokasi)\n");
	strcat(line3, ""DOOM_"5. House >> "RED_E"(Tergantung Lokasi dan Type)\n");
	strcat(line3, ""DOOM_"6. Custom House Interior >> "RED_E"(Tergantung Interior)\n\n");
	
	strcat(line3, ""RED_E"..::::.. "DOOM_"SERVER VEHICLE "RED_E"..:::::..\n\n");
    strcat(line3, ""DOOM_"1. VEHICLE IN DEALER >> "RED_E"1200 Gold\n");
	strcat(line3, ""DOOM_"2. VEHICLE NON DEALER >> "RED_E"1800 Gold\n");
	strcat(line3, ""DOOM_"3. BOAT / HELI >> "RED_E"2300 Gold\n\n");

    strcat(line3, ""RED_E"..::.. "WHITE_E"CONTACT INFO "RED_E"..::..\n");
    strcat(line3, ""WHITE_E"1. NAMA : "RED_E"Adit (SugengGod)\n");
    strcat(line3, ""WHITE_E"-  WHATSAPP: "RED_E"+6281231845985\n\n");

    strcat(line3, ""RED_E"..::.. "WHITE_E"NOTE "RED_E"..::..\n");
    strcat(line3, ""WHITE_E"Note: "RED_E"Pembayaran Via PayPal, Gopay, Dana, OVO, Saweria, Pulsa Telkomsel!\n\n");

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Levana Pride: "WHITE_E"DONATE LIST", line3, "Okay", "");
	return 1;
}*/

CMD:email(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login!");

	ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, ""WHITE_E"Set Email", ""WHITE_E"Masukkan Email.\nIni akan digunakan sebagai ganti kata sandi.\n\n"RED_E"* "WHITE_E"Email mu tidak akan termunculkan untuk Publik\n"RED_E"* "WHITE_E"Email hanya berguna untuk verifikasi Password yang terlupakan dan berita lainnya\n\
	"RED_E"* "WHITE_E"Be sure to double-check and enter a valid email address!", "Enter", "Exit");
	return 1;
}

CMD:changepass(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login sebelum menggantinya!");

	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_INPUT, ""WHITE_E"Change your password", "Masukkan Password untuk menggantinya!", "Change", "Exit");
	InfoTD_MSG(playerid, 3000, "~g~~h~Masukkan password yang sebelum nya anda pakai!");
	return 1;
}

CMD:savestats(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu belum login!");
		
	UpdatePlayerData(playerid);
	Servers(playerid, "Statistik Anda sukses disimpan kedalam Database!");
	return 1;
}

CMD:gshop(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new Dstring[512];
	format(Dstring, sizeof(Dstring), "Gold Shop\tPrice\n\
	Instant Change Name\t500 Gold\n");
	format(Dstring, sizeof(Dstring), "%sClear Warning\t1000 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 1(7 Days)\t150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 2(7 Days)\t250 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 3(7 Days)\t500 Gold\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_GOLDSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Gold Shop", Dstring, "Buy", "Cancel");
	return 1;
}

CMD:mypos(playerid, params[])
{
	new int, Float:px,Float:py,Float:pz, Float:a;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, a);
	int = GetPlayerInterior(playerid);
	new zone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, zone, sizeof(zone));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lokasi Anda Saat Ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) Int = %d", zone, px, py, pz, a, int);
	return 1;
}

CMD:gps(playerid, params[])
{
	if(pData[playerid][pGPS] < 1) return Error(playerid, "Anda tidak memiliki GPS.");
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
	return 1;
}

CMD:death(playerid, params[])
{
    if(pData[playerid][pInjured] == 0)
        return Error(playerid, "Kamu belum injured.");
		
	if(pData[playerid][pJail] > 0)
		return Error(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");
		
	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

    if((gettime()-GetPVarInt(playerid, "GiveUptime")) < 100)
        return Error(playerid, "Kamu harus menunggu 3 menit untuk kembali kerumah sakit");
        
	/*if(pMatiPukul[playerid] == 1)
	{
	    SetPlayerHealthEx(playerid, 50.0);
	    ClearAnimations(playerid);
	    pData[playerid][pInjured] = 0;
	    pMatiPukul[playerid] = 0;
    	Servers(playerid, "You have wake up and accepted death in your position.");
    	return 1;
	}*/
    Servers(playerid, "Kamu telah terbangun dari pingsan.");
	pData[playerid][pHospitalTime] = 0;
	pData[playerid][pHospital] = 1;
    return 1;
}

/*CMD:piss(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
        
	new time = (100 - pData[playerid][pBladder]) * (300);
    SetTimerEx("UnfreezePee", time, 0, "i", playerid);
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}*/

CMD:health(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new hstring[512], info[512];
	pData[playerid][pHead] = 100;
	pData[playerid][pPerut] = 100;
	pData[playerid][pLHand] = 100;
	pData[playerid][pRHand] = 100;
	pData[playerid][pLFoot] = 100;
	pData[playerid][pRFoot] = 100;
	format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}100%\n{ffffff}Perut\t{7fffd4}100%\n{ffffff}Tangan Kanan\t{7fffd4}100%\n{ffffff}Tangan Kiri\t{7fffd4}100%\n");
	strcat(info, hstring);
    format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}100%\n{ffffff}Kaki Kiri\t{7fffd4}100%\n");
    strcat(info, hstring);
    ShowPlayerDialog(playerid, DIALOG_HEALTH, DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
	
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "Kamu tidak berada didalam rumah.");
	
	InfoTD_MSG(playerid, 10000, "Sleeping... Harap Tunggu");
	TogglePlayerControllable(playerid, 0);
	new time = (100 - pData[playerid][pEnergy]) * (400);
    SetTimerEx("UnfreezeSleep", time, 0, "i", playerid);
	switch(random(6))
	{
		case 0: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L",4.1,0,0,0,1,1);
		case 1: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R",4.1,0,0,0,1,1);
		case 2: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L",4.1,1,0,0,1,1);
		case 3: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R",4.1,1,0,0,1,1);
		case 4: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_L",4.1,0,1,1,0,0);
		case 5: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_R",4.1,0,1,1,0,0);
	}
	return 1;
}

/*CMD:salary(playerid, params[])
{
	new query[256], count;
	format(query, sizeof(query), "SELECT * FROM salary WHERE owner='%d'", pData[playerid][pID]);
	new Cache:result = mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new str[2048];
		for(new i; i < rows; i++)
		{
			new info[64];
			cache_get_value_int(i, "id", pSalary[playerid][i][salaryId]);
			cache_get_value_int(i, "money", pSalary[playerid][i][salaryMoney]);
			cache_get_value(i, "info", info);
			format(pSalary[playerid][i][salaryInfo], 64, "%s", info);
			cache_get_value_int(i, "date", pSalary[playerid][i][salaryDate]);
			
			format(str, sizeof(str), "%s%s\t%s\t%s\n", str, ReturnDate(pSalary[playerid][i][salaryDate]), pSalary[playerid][i][salaryInfo], FormatMoney(pSalary[playerid][i][salaryMoney]));
			count++;
			if(count >= 10) break;
		}
		format(str, sizeof(str), "Date\tInfo\tCash\n", str);
		if(count >= 10)
		{
			format(str, sizeof(str), "%s\nNext >>>", str);
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Salary Details", str, "Close", "");
	}
	else 
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Notice", "Kamu tidak memiliki salary saat ini!", "Ok", "");
	}
	cache_delete(result);
	return 1;
}*/

CMD:time(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login!");
		
	new line2[1200];
	new paycheck = 3600 - pData[playerid][pPaycheck];
	if(paycheck < 1)
	{
		paycheck = 0;
	}
	
	format(line2, sizeof(line2), ""WHITE_E"Paycheck Time: "YELLOW_E"%d remaining\n"WHITE_E"Delay Job: "RED_E"%d Detik\n"WHITE_E"Delay Side Job: "RED_E"%d Detik\n"WHITE_E"Plant Time(Farmer): "RED_E"%d Detik\n"WHITE_E"Arrest Time: "RED_E"%d Detik\n"WHITE_E"Jail Time: "RED_E"%d Detik\n", paycheck, pData[playerid][pJobTime], pData[playerid][pSideJobTime], pData[playerid][pPlantTime], pData[playerid][pArrestTime], pData[playerid][pJailTime]);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""WHITE_E"Time", line2, "Oke", "");
	return 1;
}

CMD:cekdamage(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/cekdamage [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");

	if(GetPlayerDamageLog(otherid) <= 0)
		return SendClientMessage(playerid, -1, "Tidak ada damage logs yang tersedia.");

	new id, count = GetPlayerDamageLog(otherid), strings[5024], lstr[5024], partname[128];

	strcat(strings,"Pelaku\tSenjata\tDamage\tBagian Tubuh\tWaktu\n", sizeof(strings));
	Looping(itt, (count +1))
	{
		id = ReturnPlayerDamageLogID(otherid, itt);
		if(DamageData[id][dlBody] == 3)
		{
			partname = "Perut";
		}
		else if(DamageData[id][dlBody] == 4)
		{
			partname = "Paha";
		}
		else if(DamageData[id][dlBody] == 5)
		{
			partname = "Tangan Kiri";
		}
		else if(DamageData[id][dlBody] == 6)
		{
			partname = "Tangan Kanan";
		}
		else if(DamageData[id][dlBody] == 7)
		{
			partname = "Kaki Kiri";
		}
		else if(DamageData[id][dlBody] == 8)
		{
			partname = "Kaki Kanan";
		}
		else if(DamageData[id][dlBody] == 9)
		{
			partname = "Kepala";
		}
		else
		{
			partname = "Tidak Di Ketahui";
		}
		if(itt == count)
		{
			format(lstr, sizeof(lstr), "%s\t%s\t%0.1f\n", DamageData[id][dlTarget], ReturnWeaponName(DamageData[id][dlWeapon]), DamageData[id][dlDamage], partname, ReturnTime());
		}
		else format(lstr ,sizeof(lstr), "%s\t%s\t%0.1f\t%s\n", DamageData[id][dlTarget], ReturnWeaponName(DamageData[id][dlWeapon]), DamageData[id][dlDamage], partname, ReturnTime());
		strcat(strings, lstr, sizeof(strings));
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Damage Logs", strings, "Close", "");
	return 1;
}

CMD:giveammo(playerid, params[])
{
    static
        ammo;
		
	new otherid;
    if(sscanf(params, "udI(250)", otherid, ammo))
        return Usage(playerid, "/giveammo [playerid/PartOfName] [ammo]");

	if(otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "You cannot give weapons to disconnected players.");


    if(GetPlayerWeapon(playerid) <= 0 || GetPlayerWeapon(playerid) > 46 || (GetPlayerWeapon(playerid) >= 19 && GetPlayerWeapon(playerid) <= 21))
        return Error(playerid, "You have specified an invalid weapon.");

    if(GetPlayerAmmo(playerid) < ammo)
        return Error(playerid, "Kamu tidak memiliki ammo yang cukup untuk diberikan");

    GivePlayerWeaponEx(otherid, GetPlayerWeapon(playerid), ammo);
	GivePlayerWeaponEx(playerid, GetPlayerWeapon(playerid), -ammo);
    Info(playerid, "Anda berhasil memberikan %d Ammo ke %s", ammo, pData[otherid][pName]);
    Info(otherid, "Anda menerima %d Ammo dari %s", ammo, pData[playerid][pName]);
    return 1;
}

alias:dweb("darkweb")
CMD:dweb(playerid, params[])
{
	new teks[120];

    if(pData[playerid][pFamily] != -1) 
    {
    	if(sscanf(params, "s[120]", teks))
			return Usage(playerid, "/darkweb [pesan]");	

		new lstr[1024];
		format(lstr, sizeof(lstr), "DARKWEB | MASKMAN :{FFFFFF} %s", params);
		SendClientMessageToAll(COLOR_GOLD, lstr);
		SendStaffMessage(COLOR_GOLD, "[LOGS DWEB] {FFFFFF}%s.", pData[playerid][pName]);
    }
	else
	{
		Error(playerid, "Anda bukan anggota family");
	}
	return 1;
}

CMD:idcard(playerid, params[])
{
	if(pData[playerid][pIDCard] == 0) return Error(playerid, "Anda tidak memiliki id card!");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[ID-Card] "GREY3_E"Name: %s | Gender: %s | Brithday: %s | Expire: %s.", pData[playerid][pName], sext, pData[playerid][pAge], ReturnTimelapse(gettime(), pData[playerid][pIDCardTime]));
	return 1;
}

CMD:drivelic(playerid, params[])
{
	if(pData[playerid][pDriveLic] == 0) return Error(playerid, "Anda tidak memiliki Driving License/SIM!");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[Drive-Lic] "GREY3_E"Name: %s | Gender: %s | Brithday: %s | Expire: %s.", pData[playerid][pName], sext, pData[playerid][pAge], ReturnTimelapse(gettime(), pData[playerid][pDriveLicTime]));
	return 1;
}

CMD:newidcard(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 361.83, 173.679, 1008.68)) return Error(playerid, "Anda harus berada di City Hall!");
	if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 300) return Error(playerid, "Anda butuh $300 untuk membuat ID Card");
	new sext[40], mstr[128];
	if(pData[playerid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nNegara: San Andreas\nTgl Lahir: %s\nJenis Kelamin: %s\nBerlaku hingga 14 hari!", pData[playerid][pName], pData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ID-Card", mstr, "Tutup", "");
	pData[playerid][pIDCard] = 1;
	pData[playerid][pIDCardTime] = gettime() + (30 * 86400);
	GivePlayerMoneyEx(playerid, -300);
	Server_AddMoney(25);
	return 1;
}

CMD:newage(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 361.83, 173.679, 1008.68)) return Error(playerid, "Anda harus berada di City Hall!");
	//if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 300) return Error(playerid, "Anda butuh $300 untuk mengganti tgl lahir anda!");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Anda harus login terlebih dahulu!");
	ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Change", "Cancel");
	return 1;
}

CMD:newdrivelic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1490.28, 1306.00, 1093.29)) return Error(playerid, "Anda harus berada di SAPD!");
	if(pData[playerid][pDriveLic] != 0) return Error(playerid, "Anda sudah memiliki Driving License!");
	if(GetPlayerMoney(playerid) < 300) return Error(playerid, "Anda butuh $300 untuk membuat Driving License.");
	Info(playerid, "Silahkan keluar ruangan ini dan masuki salah satu mobil untuk mengikuti tes mengemudi");
	GivePlayerMoneyEx(playerid, -300);
	pData[playerid][pDriveLicApp] = 1;
	pData[playerid][pCheckPoint] = CHECKPOINT_DRIVELIC;
	return 1;
}

/*CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 101.9294, 1064.6431, -48.9141)) return Error(playerid, "Anda harus berada di SAPD!");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tPlate\tPlate Time\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			if(strcmp(pvData[i][cPlate], "NoHave"))
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
				found = true;
			}
			else
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s\t%s\tNone\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate]);
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_BUYPLATE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicles Plate", msg2, "Buy", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles Plate", "Anda tidak memeliki kendaraan", "Close", "");
			
	return 1;
}*/

CMD:payticket(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1320.85, 739.36, 111.32) && !IsPlayerInRangeOfPoint(playerid, 3.0, -1469.6188, 2600.2039, 19.6310)) return Error(playerid, "Anda harus berada di kantor SAPD!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return Usage(playerid, "/payticket [vehid] | /mypv - for find vehid");
		
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
		
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new ticket = pvData[i][cTicket];
				
				if(ticket > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money! check your ticket in /v insu.");
					
				if(ticket > 0)
				{
					GivePlayerMoneyEx(playerid, -ticket);
					pvData[i][cTicket] = 0;
					Info(playerid, "Anda telah berhasil membayar ticket tilang kendaraan %s(id: %d) sebesar "RED_E"%s", GetVehicleName(vehid), vehid, FormatMoney(ticket));
					return 1;
				}
			}
			else return Error(playerid, "Kendaraan ini bukan milik anda! /mypv - for find vehid");
		}
	}
	return 1;
}

CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0,   1320.85, 739.36, 111.32) && !IsPlayerInRangeOfPoint(playerid, 3.0, -1466.4567, 2600.2031, 19.6310)) return Error(playerid, "Anda harus berada di SAPD!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/buyplate [vehid] | /mypv - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				if(GetPlayerMoney(playerid) < 500) return Error(playerid, "Anda butuh $500 untuk membeli Plate baru.");
				GivePlayerMoneyEx(playerid, -500);
				new rand = RandomEx(1111, 9999);
				format(pvData[i][cPlate], 32, "GI-%d", rand);
				SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
				pvData[i][cPlateTime] = gettime() + (15 * 86400);
				Info(playerid, "Model: %s || New plate: %s || Plate Time: %s || Plate Price: $500", GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mypv untuk mencari ID.");
		}
	}
	return 1;
}

CMD:buyinsu(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2792.800293, -1087.574097, 30.718750)) return Error(playerid, "Kamu harus berada di Kantor Insurance!");
	
		
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/buyinsu [vehid] | /mypv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cClaim] == 0)
			{
				if(GetPlayerMoney(playerid) < 500) return Error(playerid, "Anda butuh $500 untuk membeli Insurance.");
				GivePlayerMoneyEx(playerid, -500);
				pvData[i][cInsu]++;
				Info(playerid, "Model: %s || Total Insurance: %d || Insurance Price: $500", GetVehicleModelName(pvData[i][cModel]), pvData[i][cInsu]);
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mypv untuk mencari ID.");
		}
	}
	return 1;
}

CMD:claimpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2792.800293, -1087.574097, 30.718750)) return Error(playerid, "Kamu harus berada di Kantor Insurance!");
	new found = 0;
	foreach(new i : PVehicles)
	{
		if(pvData[i][cClaim] == 1 && pvData[i][cClaimTime] == 0)
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				pvData[i][cClaim] = 0;
				
				OnPlayerVehicleRespawn(i);
				pvData[i][cPosX] = 2818.711182;
				pvData[i][cPosY] = -1088.772949;
				pvData[i][cPosZ] = 30.727907;
				pvData[i][cPosA] = -1.664756;
				SetValidVehicleHealth(pvData[i][cVeh], 1500);
				SetVehiclePos(pvData[i][cVeh], 2818.711182, -1088.772949, 30.727907);
				SetVehicleZAngle(pvData[i][cVeh], 30.727907);
				SetVehicleFuel(pvData[i][cVeh], 1000);
				ValidRepairVehicle(pvData[i][cVeh]);
				found++;
				SetPlayerRaceCheckpoint(playerid, 1, 2818.711182, -1088.772949, 30.727907, 2818.711182, -1088.772949, 30.727907, 5.0);
				Info(playerid, "Anda telah mengclaim kendaraan %s anda.", GetVehicleModelName(pvData[i][cModel]));
				Info(playerid, "Ikuti checkpoint Map Untuk menemukan Kendaraan Yang Anda Claim!");
			}
			//else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mypv untuk mencari ID.");
		}
	}
	if(found == 0)
	{
		Info(playerid, "Sekarang belum saatnya anda mengclaim kendaraan anda!");
	}
	else
	{
		Info(playerid, "Anda berhasil mengclaim %d kendaraan anda!", found);
	}
	return 1;
}

CMD:sellpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2792.800293, -1087.574097, 30.718750)) return Error(playerid, "Kamu harus berada di Kantor Insurance!");
	
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/sellpv [vehid] | /mypv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				if(!IsValidVehicle(pvData[i][cVeh])) return Error(playerid, "Your vehicle is not spanwed!");
				if(pvData[i][cRent] != 0) return Error(playerid, "You can't sell rental vehicle!");
				new pay = 1000;
				GivePlayerMoneyEx(playerid, pay);
				
				Info(playerid, "Anda menjual kendaraan model %s(%d) dengan seharga "LG_E"%s", GetVehicleName(vehid), GetVehicleModel(vehid), FormatMoney(pay));
				new str[150];
				format(str,sizeof(str),"[VEH]: %s menjual kendaraan %s seharga %s!", GetRPName(playerid), GetVehicleName(vehid), FormatMoney(pay));
				LogServer("Property", str);
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
				mysql_tquery(g_SQL, query);
				if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
				pvData[i][cVeh] = INVALID_VEHICLE_ID;
				Iter_SafeRemove(PVehicles, i, i);
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mypv untuk mencari ID.");
		}
	}
	return 1;
}

CMD:newrek(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0,  2308.8, -13.2487, 27.0422)) return Error(playerid, "Anda harus berada di Bank!");
	if(GetPlayerMoney(playerid) < 50) return Error(playerid, "Not enough money!");
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	Info(playerid, "New rekening bank!");
	GivePlayerMoneyEx(playerid, -500);
	Server_AddMoney(50);
	return 1;
}

CMD:bank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2316.62, -7.25945, 27.0422)) return Error(playerid, "Anda harus berada di bank point!");
	new tstr[128];
	format(tstr, sizeof(tstr), ""LB_E"Number Card: "GREY_E"%d", pData[playerid][pBankRek]);
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s you try to ask the cashier and maybe he wants to take money from your account or your savings", ReturnName(playerid));
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, tstr, "Deposit Money\nWithdraw Money\nCheck Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	return 1;
}

CMD:pay(playerid, params[])
{
	if(pData[playerid][pLevel] < 2) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 2 ke atas");

	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new money, otherid, mstr[128];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/pay <ID/Name> <amount>");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

 	if(otherid == playerid)
		return Error(playerid, "You can't send yourself money!");
	if(pData[playerid][pMoney] < money)
		return Error(playerid, "You don't have enough money to send!");
	if(money > 10000 && pData[playerid][pAdmin] == 0)
		return Error(playerid, "You can't send more than $10,000 at once!");
	if(money < 1)
		return Error(playerid, "You can't send anyone less than $1!");
		
	GivePlayerMoneyEx(otherid, money);
	GivePlayerMoneyEx(playerid, -money);

	format(mstr, sizeof(mstr), "Pays: "LB_E"Kamu memberikan uang ke %s(%i) "GREEN_E"%s", pData[otherid][pName], otherid, FormatMoney(money));
	SendClientMessage(playerid, COLOR_GREY, mstr);
	format(mstr, sizeof(mstr), "Pays: "LB_E"%s(%i) Telah memberikan kamu uang sebesar "GREEN_E"%s", pData[playerid][pName], playerid, FormatMoney(money));
	SendClientMessage(otherid, COLOR_GREY, mstr);
	InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
	InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
	ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
	ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
	SendStaffMessage(COLOR_RED, "[PAYINFO] "WHITE_E"%s(%d)pay to %s(%d)ammount "GREEN_E"%s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, FormatMoney(money));
	return 1;
}

CMD:stats(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	DisplayStats(playerid, playerid);
	return 1;
}

CMD:settings(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	new str[1024], dynamic[64];
	
	format(str, sizeof(str), "Settings\tStatus\n"WHITEP_E"Email:\t"GREY3_E"%s\n"WHITEP_E"Change Password\n"WHITEP_E"HUD Settings\n"WHITEP_E"Toggle Settings\n"WHITEP_E"Max Objects", pData[playerid][pEmail], dynamic);
	
	ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "Settings", str, "Set", "Close");
	return 1;
}

CMD:items(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check items!");
	    return true;
	}
	DisplayItems(playerid, playerid);
	return 1;
}

CMD:getjob(playerid, params[])
{
	if(pData[playerid][pIDCard] <= 0)
		return Error(playerid, "Anda tidak memiliki ID-Card.");
		
	if(pData[playerid][pVip] > 0)
	{
		if(pData[playerid][pJob] == 0 || pData[playerid][pJob2] == 0)
		{
			if(pData[playerid][pJob] == 0)
			{
				if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0,  1685.35, -1464.57, 13.9719))
				{
					pData[playerid][pGetJob] = 1;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Taxi. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2281.08, -2365.03, 13.8469))
				{
					pData[playerid][pGetJob] = 2;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Mechanic. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
				{
					pData[playerid][pGetJob] = 3;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Lumber jack. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
				{
					pData[playerid][pGetJob] = 4;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Trucker. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
				{
					pData[playerid][pGetJob] = 5;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Miner. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
				{
					pData[playerid][pGetJob] = 6;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Production. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
				{
					pData[playerid][pGetJob] = 7;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Farmer. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
				{
					pData[playerid][pGetJob] = 8;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Kurir. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob] = 9;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Smuggler. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2060.2942, -2220.8250, 13.5469))
				{
					pData[playerid][pGetJob] = 10;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Baggage. /accept job untuk konfirmasi.");
				}
				else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
			}
			else if(pData[playerid][pJob2] == 0)
			{
				if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0,  1685.35, -1464.57, 13.9719))
				{
					pData[playerid][pGetJob2] = 1;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Taxi. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2281.08, -2365.03, 13.8469))
				{
					pData[playerid][pGetJob2] = 2;
					Info(playerid, "Anda telah berhasil mendaftarkan Job mechanic. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
				{
					pData[playerid][pGetJob2] = 3;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Lumber jack. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
				{
					pData[playerid][pGetJob2] = 4;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Trucker. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
				{
					pData[playerid][pGetJob2] = 5;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Miner. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
				{
					pData[playerid][pGetJob2] = 6;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Production. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
				{
					pData[playerid][pGetJob2] = 7;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Farmer. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
				{
					pData[playerid][pGetJob2] = 8;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Kurir. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob2] = 9;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Smuggler. /accept job untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2060.2942, -2220.8250, 13.5469))
				{
					pData[playerid][pGetJob] = 10;
					Info(playerid, "Anda telah berhasil mendaftarkan Job Baggage. /accept job untuk konfirmasi.");
				}
				else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
			}
			else return Error(playerid, "Anda sudah memiliki 2 pekerjaan!");
		}
		else return Error(playerid, "Anda sudah memiliki 2 pekerjaan!");
	}
	else
	{
		if(pData[playerid][pJob] > 0)
			return Error(playerid, "Anda hanya harus VIP untuk bisa mempunyai 2 pekerjaan");
			
		if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -2159.04, 640.36, 1052.38))
		{
			pData[playerid][pGetJob] = 1;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Taxi. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2281.08, -2365.03, 13.8469))
		{
			pData[playerid][pGetJob] = 2;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Mechanic. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
		{
			pData[playerid][pGetJob] = 3;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Lumber jack. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
		{
			pData[playerid][pGetJob] = 4;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Trucker. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
		{
			pData[playerid][pGetJob] = 5;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Miner. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
		{
			pData[playerid][pGetJob] = 6;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Production. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
		{
			pData[playerid][pGetJob] = 7;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Farmer. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
		{
			pData[playerid][pGetJob] = 8;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Kurir. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
		{
			if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
			pData[playerid][pGetJob] = 9;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Smuggler. /accept job untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2060.2942, -2220.8250, 13.5469))
		{
			pData[playerid][pGetJob] = 10;
			Info(playerid, "Anda telah berhasil mendaftarkan Job Baggage. /accept job untuk konfirmasi.");
		}
		else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
	}
	return 1;
}

CMD:frisk(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/frisk [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pFriskOffer] = playerid;

    Info(otherid, "%s has offered to frisk you (type \"/accept frisk or /deny frisk\").", ReturnName(playerid));
    Info(playerid, "You have offered to frisk %s.", ReturnName(otherid));
	return 1;
}

CMD:inspect(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/inspect [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pInsOffer] = playerid;

    Info(otherid, "%s has offered to inspect you (type \"/accept inspect or /deny inspect\").", ReturnName(playerid));
    Info(playerid, "You have offered to inspect %s.", ReturnName(otherid));
	return 1;
}

CMD:reqloc(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/reqloc [playerid/PartOfName]");

    if(pData[playerid][pPhone] < 1)
    	return Error(playerid, "Anda tidak memiliki Handphone");

    if(pData[playerid][pPhoneStatus] == 0)if(pData[playerid][pPhoneStatus] == 0)
    	return Error(playerid, "Ponsel anda masih offline");

    if(pData[otherid][pPhone] < 1)
    	return Error(playerid, "Tujuan tidak memiliki Handphone");

    if(pData[otherid][pPhoneStatus] == 0)
    	return Error(playerid, "Ponsel yang anda tuju masih offline");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa meminta lokasi kepada anda sendiri.");

    pData[otherid][pLocOffer] = playerid;

    Info(otherid, "%s has offered to request share his location (type \"/accept reqloc or /deny reqloc\").", ReturnName(playerid));
    Info(playerid, "You have offered to share your location %s.", ReturnName(otherid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /accept [name]");
            Info(playerid, "Names: faction, family, drag, frisk, inspect, job, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFacOffer])) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
                    pData[playerid][pFaction] = pData[playerid][pFacInvite];
					pData[playerid][pFactionRank] = 1;
					Info(playerid, "Anda telah menerima invite faction dari %s", pData[pData[playerid][pFacOffer]][pName]);
					Info(pData[playerid][pFacOffer], "%s telah menerima invite faction yang anda tawari", pData[playerid][pName]);
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		if(strcmp(params,"family",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFamOffer])) 
			{
                if(pData[playerid][pFamInvite] > -1) 
				{
                    pData[playerid][pFamily] = pData[playerid][pFamInvite];
					pData[playerid][pFamilyRank] = 1;
					Info(playerid, "Anda telah menerima invite family dari %s", pData[pData[playerid][pFamOffer]][pName]);
					Info(pData[playerid][pFamOffer], "%s telah menerima invite family yang anda tawari", pData[playerid][pName]);
					pData[playerid][pFamInvite] = 0;
					pData[playerid][pFamOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
        
			pData[playerid][pDragged] = 1;
			pData[playerid][pDraggedBy] = dragby;

			pData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/undrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, pData[playerid][pFriskOffer], 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
				
			DisplayItems(pData[playerid][pFriskOffer], playerid);
			Servers(playerid, "Anda telah berhasil menaccept tawaran frisk kepada %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, pData[playerid][pInsOffer], 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
				
			new hstring[512], info[512];
			new hh = pData[playerid][pHead];
			new hp = pData[playerid][pPerut];
			new htk = pData[playerid][pRHand];
			new htka = pData[playerid][pLHand];
			new hkk = pData[playerid][pRFoot];
			new hkka = pData[playerid][pLFoot];
			format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
			strcat(info, hstring);
			format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
			strcat(info, hstring);
			ShowPlayerDialog(pData[playerid][pInsOffer],DIALOG_HEALTH,DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
			Servers(playerid, "Anda telah berhasil menaccept tawaran Inspect kepada %s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"job",true) == 0) 
		{
			if(pData[playerid][pExitJob] > 0) return Error(playerid, "Kamu harus menunggu exitjobs delays untuk keluar dari job");
			if(pData[playerid][pGetJob] > 0)
			{
				pData[playerid][pJob] = pData[playerid][pGetJob];
				Info(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan /help untuk informasi.");
				pData[playerid][pGetJob] = 0;
				pData[playerid][pExitJob] = 1200;
			}
			else if(pData[playerid][pGetJob2] > 0)
			{
				pData[playerid][pJob2] = pData[playerid][pGetJob2];
				Info(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan /help untuk informasi.");
				pData[playerid][pGetJob2] = 0;
				pData[playerid][pExitJob] = 1200;
			}
		}
		else if(strcmp(params,"reqloc",true) == 0)
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
				
			new Float:sX, Float:sY, Float:sZ;
			GetPlayerPos(playerid, sX, sY, sZ);
			SetPlayerCheckpoint(pData[playerid][pLocOffer], sX, sY, sZ, 5.0);
			Servers(playerid, "Anda telah berhasil menaccept tawaran Share Lokasi kepada %s.", ReturnName(pData[playerid][pLocOffer]));
			Servers(pData[playerid][pLocOffer], "Lokasi %s telah tertandai.", ReturnName(playerid));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0)
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Servers(playerid, "Anda telah berhasil menaccept tawaran bergabung kedalam Robbery %s.", ReturnName(pData[playerid][pRobOffer]));
			Servers(pData[playerid][pRobOffer], "%s Menerima ajakan Robbing anda.", ReturnName(playerid));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
			pData[playerid][pMemberRob] = 1;
			pData[pData[playerid][pRobOffer]][pRobMember] += 1;
			RobMember += 1;
		}
		else if(strcmp(params,"marriage",true) == 0)
		{
			new String[500];
			if(pData[playerid][pMarriedAccept] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMarriedAccept]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pMarriedAccept], 5.0))
				return Error(playerid, "You must be near this player.");

			if(pData[playerid][pGender] == 1 && pData[pData[playerid][pMarriedAccept]][pGender] == 2)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Wife, you may kiss the bride.", ReturnName2(playerid), ReturnName2(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Wife, you may kiss the groom.", ReturnName2(pData[playerid][pMarriedAccept]), ReturnName2(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new lovely couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName2(playerid), ReturnName2(pData[playerid][pMarriedAccept]));
				OOCNews(COLOR_WHITE, String);
			}
			else if(pData[playerid][pGender] == 1 && pData[pData[playerid][pMarriedAccept]][pGender] == 1)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Husband, you may kiss the bride.", ReturnName2(playerid), ReturnName2(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Husband, you may kiss the groom.", ReturnName2(pData[playerid][pMarriedAccept]), ReturnName2(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new gay couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName2(playerid), ReturnName2(pData[playerid][pMarriedAccept]));
				OOCNews(COLOR_WHITE, String);
			}
			else if(pData[playerid][pGender] == 2 && pData[pData[playerid][pMarriedAccept]][pGender] == 2)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Wife & Wife, you may kiss the Bride.", ReturnName2(playerid), ReturnName2(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Wife & Wife, you may kiss the Groom.", ReturnName2(pData[playerid][pMarriedAccept]), ReturnName2(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new lesbian couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName2(playerid), ReturnName2(pData[playerid][pMarriedAccept]));
				OOCNews(COLOR_WHITE, String);
			}
			format(pData[pData[playerid][pMarriedAccept]][pMarriedTo], MAX_PLAYER_NAME, "%s", ReturnName(playerid));
			format(pData[playerid][pMarriedTo], MAX_PLAYER_NAME, "%s", ReturnName(pData[playerid][pMarriedAccept]));
			GivePlayerMoney(pData[playerid][pMarriedAccept], -10000);
			pData[playerid][pMarried] = 1;
			pData[pData[playerid][pMarriedAccept]][pMarried] = 1;
			pData[playerid][pMarriedAccept] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"divorce",true) == 0)
		{
			if(pData[playerid][pMarriedCancel] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMarriedCancel]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pMarriedCancel], 5.0))
				return Error(playerid, "You must be near this player.");

			if(pData[playerid][pGender] == 1)
			{
				format(pData[playerid][pMarriedTo], 50, "Duda");
			}
			else if(pData[playerid][pGender] == 2)
			{
				format(pData[playerid][pMarriedTo], 50, "Janda");
			}
			if(pData[pData[playerid][pMarriedCancel]][pGender] == 1)
			{
				format(pData[pData[playerid][pMarriedCancel]][pMarriedTo], 50, "Duda");
			}
			else if(pData[pData[playerid][pMarriedCancel]][pGender] == 2)
			{
				format(pData[pData[playerid][pMarriedCancel]][pMarriedTo], 50, "Janda");
			}
			pData[playerid][pMarried] = 0;
			pData[pData[playerid][pMarriedCancel]][pMarried] = 0;
			pData[playerid][pMarriedCancel] = INVALID_PLAYER_ID;
			SendClientMessageEx(playerid, COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah pisah/cerai dengan %s", ReturnName2(pData[playerid][pMarriedCancel]));
			SendClientMessageEx(pData[pData[playerid][pMarriedCancel]][pMarried], COLOR_ARWIN, "ACCEPT: "WHITE_E"Anda telah pisah/cerai dengan %s", ReturnName(playerid));
		}
	}
	return 1;
}

CMD:deny(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /deny [name]");
            Info(playerid, "Names: faction, drag, frisk, inspect, job1, job2, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(pData[playerid][pFacOffer] > -1) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
					Info(playerid, "Anda telah menolak faction dari %s", ReturnName(pData[playerid][pFacOffer]));
					Info(pData[playerid][pFacOffer], "%s telah menolak invite faction yang anda tawari", ReturnName(playerid));
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");

			Info(playerid, "Anda telah menolak drag.");
			Info(dragby, "Player telah menolak drag yang anda tawari.");
			
			DeletePVar(playerid, "DragBy");
			pData[playerid][pDragged] = 0;
			pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran frisk kepada %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pInsOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Inspect kepada %s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"job1",true) == 0) 
		{
			if(pData[playerid][pExitJob] > 0) return Error(playerid, "Kamu harus menunggu exitjobs delays untuk keluar dari job");
			if(pData[playerid][pJob] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			if(pData[playerid][pJob] != 0)
			{
				pData[playerid][pJob] = 0;
				Info(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"job2",true) == 0) 
		{
			if(pData[playerid][pExitJob] > 0) return Error(playerid, "Kamu harus menunggu exitjobs delays untuk keluar dari job");
			if(pData[playerid][pJob2] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			if(pData[playerid][pJob2] != 0)
			{
				pData[playerid][pJob2] = 0;
				Info(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"reqloc",true) == 0) 
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Share Lokasi kepada %s.", ReturnName(pData[playerid][pLocOffer]));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0) 
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Rob kepada %s.", ReturnName(pData[playerid][pRobOffer]));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}

CMD:give(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/give [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, redmoney, medicine, snack, sprunk, material, component, marijuana, obat, gps, berry, nasgor, milk");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");
			
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pBandage] -= ammount;
			pData[otherid][pBandage] += ammount;
			Info(playerid, "Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan perban kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"nasgor",true) == 0) 
		{
			if(pData[playerid][pNasgor] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pNasgor] -= ammount;
			pData[otherid][pNasgor] += ammount;
			Info(playerid, "Anda telah berhasil memberikan nasgor kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan nasgor kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"milk",true) == 0) 
		{
			if(pData[playerid][pSusu] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSusu] -= ammount;
			pData[otherid][pSusu] += ammount;
			Info(playerid, "Anda telah berhasil memberikan milk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan milk kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMedicine] -= ammount;
			pData[otherid][pMedicine] += ammount;
			Info(playerid, "Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan medicine kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSnack] -= ammount;
			pData[otherid][pSnack] += ammount;
			Info(playerid, "Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan snack kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"redmoney",true) == 0) 
		{
			if(pData[playerid][pRedMoney] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pRedMoney] -= ammount;
			pData[otherid][pRedMoney] += ammount;
			Info(playerid, "Anda telah berhasil memberikan redmoney kepada %s sejumlah %s.", ReturnName(otherid), FormatMoney(ammount));
			Info(otherid, "%s telah berhasil memberikan redmoney kepada anda sejumlah %s.", ReturnName(playerid), FormatMoney(ammount));
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSprunk] -= ammount;
			pData[otherid][pSprunk] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			if(pData[playerid][pMaterial] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxmat = pData[otherid][pMaterial] + ammount;
			
			if(maxmat > 500)
				return Error(playerid, "That player already have maximum material!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMaterial] -= ammount;
			pData[otherid][pMaterial] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Material kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			if(pData[playerid][pComponent] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = pData[otherid][pComponent] + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pComponent] -= ammount;
			pData[otherid][pComponent] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Component kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			if(pData[playerid][pMarijuana] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMarijuana] -= ammount;
			pData[otherid][pMarijuana] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Marijuana kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Marijuana kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pObat] -= ammount;
			pData[otherid][pObat] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Obat kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Obat kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"gps",true) == 0) 
		{
			if(pData[playerid][pGPS] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pGPS] -= ammount;
			pData[otherid][pGPS] += ammount;
			Info(playerid, "Anda telah berhasil memberikan GPS kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan GPS kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"berry",true) == 0)
		{
			if(pData[playerid][pBerry] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pBerry] -= ammount;
			pData[otherid][pBerry] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Berry kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Berry kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:faconline(playerid, params[])
{
    new string[658] = "No. Fraksi\tCnline\n", tmp_string[128];
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}1. "BLUE_E"SAPD\t(%d online)\n", GetFactionCount(1));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}2. "LB_E"SAGS\t(%d online)\n", GetFactionCount(2));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}3. "PINK_E"SAMD\t(%d online)\n", GetFactionCount(3));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}4. "ORANGE_E"SANEWS\t(%d online)\n", GetFactionCount(4));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}5. "YELLOW_E"PEDAGANG\t(%d online)\n", GetFactionCount(5));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}6. "GREEN_E"MECHANIC\t(%d online)", GetMechanicCount());
    strcat(string, tmp_string);
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Levana Pride - Faction Online", string, "Close", "");
}

GetFactionCount(FACTION_ID)
{
    new count;
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
        if (pData[i][pFaction] == FACTION_ID && pData[i][pOnDuty] == 1) count++;
    }
    return count;
}

GetMechanicCount()
{
    new count;
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
        if (pData[i][pMechDuty] == 1) count++;
    }
    return count;
}

CMD:use(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /use [name]");
            Info(playerid, "Names: bandage, snack, sprunk, gas, medicine, marijuana, obat, berry, nasgor, milk");
            return 1;
        }
		if(strcmp(params,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < 1)
				return Error(playerid, "Anda tidak memiliki perban.");

			if(pData[playerid][pHealth] >= 100) return Error(playerid, "your health is 100%!");
			
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			pData[playerid][pBandage]--;
			SetPlayerHealthEx(playerid, 100);
			Info(playerid, "You have successfully applied the bandage.");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu menggunakan perban ke area tubuh yang terluka", ReturnName(playerid));
			InfoTD_MSG(playerid, 3000, "Restore 100% Health");
		}
		else if(strcmp(params,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < 1)
				return Error(playerid, "Anda tidak memiliki snack.");
			
			pData[playerid][pSnack]--;
			pData[playerid][pHunger] += 15;
			Info(playerid, "You have successfully used the snack.");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba membukan snack dan memakannya", ReturnName(playerid));
			InfoTD_MSG(playerid, 3000, "+15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "Anda tidak memiliki sprunk.");
			
			pData[playerid][pSprunk]--;
			pData[playerid][pEnergy] += 15;
			Info(playerid, "You have successfully drunk sprunk.");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba meminum sprunk dengan mulut", ReturnName(playerid));
			InfoTD_MSG(playerid, 3000, "+15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"nasgor",true) == 0) 
		{
			if(pData[playerid][pNasgor] < 1)
				return Error(playerid, "Anda tidak memiliki nasgor.");
			
			pData[playerid][pNasgor]--;
			pData[playerid][pHunger] += 20;
			Info(playerid, "You have successfully used the nasgor.");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba membukan nasgor dan memakannya", ReturnName(playerid));
			InfoTD_MSG(playerid, 3000, "+20 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"milk",true) == 0) 
		{
			if(pData[playerid][pSusuGO] < 1)
				return Error(playerid, "Anda tidak memiliki Milk.");
			
			pData[playerid][pSusuGO]--;
			pData[playerid][pEnergy] += 15;
			Info(playerid, "You have successfully drunk Milk.");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba meminum Milk dengan mulut", ReturnName(playerid));
			InfoTD_MSG(playerid, 3000, "+15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		/*else if(strcmp(params,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "Anda tidak memiliki snack.");
			
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
			//SendNearbyMessage(playerid, 10.0, COLOR_PURPLE,"* %s opens a can of sprunk.", ReturnName(playerid));
			SetPVarInt(playerid, "UsingSprunk", 1);
			pData[playerid][pSprunk]--;
		}*/
		else if(strcmp(params,"gas",true) == 0) 
		{
			if(pData[playerid][pGas] < 1)
				return Error(playerid, "Anda tidak memiliki gas.");
				
			if(IsPlayerInAnyVehicle(playerid))
				return Error(playerid, "You must be outside the vehicle!");
			
			if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
			
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(IsValidVehicle(vehicleid))
			{
				new fuel = GetVehicleFuel(vehicleid);
			
				if(GetEngineStatus(vehicleid))
					return Error(playerid, "Turn off vehicle engine.");
			
				if(fuel >= 999.0)
					return Error(playerid, "This vehicle gas is full.");
			
				if(!IsEngineVehicle(vehicleid))
					return Error(playerid, "This vehicle can't be refull.");

				if(!GetHoodStatus(vehicleid))
					return Error(playerid, "The hood must be opened before refull the vehicle.");

				pData[playerid][pGas]--;
				Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mengisi bensin kendaraan mu menggunakan gas", ReturnName(playerid));
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pActivityStatus] = 1;
				pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				/*InfoTD_MSG(playerid, 10000, "Refulling...");
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s starts to refulling the vehicle.", ReturnName(playerid));*/
				return 1;
			}
		}
		else if(strcmp(params,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < 1)
				return Error(playerid, "Anda tidak memiliki medicine.");
			
			pData[playerid][pMedicine]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "Your Using Medicine");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mengunakan medicine ke luka yang ada di tubuh", ReturnName(playerid));
			
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < 1)
				return Error(playerid, "Anda tidak memiliki Obat Myricous.");
			
			pData[playerid][pObat]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			pData[playerid][pHead] = 100;
			pData[playerid][pPerut] = 100;
			pData[playerid][pRHand] = 100;
			pData[playerid][pLHand] = 100;
			pData[playerid][pRFoot] = 100;
			pData[playerid][pLFoot] = 100;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "You used Myricous Medicine.");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba meminum obat", ReturnName(playerid));
			
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"marijuana",true) == 0) 
		{
			if(pData[playerid][pMarijuana] < 1)
				return Error(playerid, "You dont have marijuana.");
			
			new Float:armor;
			GetPlayerArmour(playerid, armor);
			if(armor+10 > 90) return Error(playerid, "Over dosis!");
			
			pData[playerid][pMarijuana]--;
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba membakar marijuana dan menghirupnya", ReturnName(playerid));
			SetPlayerArmourEx(playerid, armor+10);
			SetPlayerDrunkLevel(playerid, 4000);
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"berry",true) == 0)
		{
			if(pData[playerid][pBerry] < 0)
				return Error(playerid, "You dont have berry.");

			pData[playerid][pHunger] += 8;
			pData[playerid][pBerry]--;
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kamu mencoba memakan buah berry milikmu", ReturnName(playerid));
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}

CMD:enter(playerid, params[])
{
	if(pData[playerid][pInjured] == 0)
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "Bangunan ini di Kunci untuk sementara.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk fraksi.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "Pintu ini hanya untuk Family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "VIP Level mu tidak cukup.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Admin level mu tidak cukup.");
						
					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Password Salah.");
						
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
				else
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "Pintu ini ditutup sementara");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "Pintu ini hanya untuk family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level not enough to enter this door.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this door.");

					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
				
					if(dData[did][dCustom])
					{
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					else
					{
						SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
				else
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
					
					if(dData[did][dCustom])
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);

					else
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
			}
        }
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "Rumah ini terkunci!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			pData[playerid][pInHouse] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "Bisnis ini Terkunci!");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			pData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				pData[playerid][pInFamily] = fid;		
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			new difamily = pData[playerid][pInFamily];
			if(pData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, fData[difamily][fIntposX], fData[difamily][fIntposY], fData[difamily][fIntposZ]))
			{
				pData[playerid][pInFamily] = -1;	
				SetPlayerPositionEx(playerid, fData[difamily][fExtposX], fData[difamily][fExtposY], fData[difamily][fExtposZ], fData[difamily][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
	}
	return 1;
}

CMD:drag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/drag [playerid/PartOfName] || /undrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player itu Disconnect.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa menarik diri mu sendiri.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Kamu harus didekat Player.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "kamu tidak bisa drag orang yang tidak mati.");

    SetPVarInt(otherid, "DragBy", playerid);
    Info(otherid, "%s Telah menawari drag kepada anda, /accept drag untuk menerimanya /deny drag untuk membatalkannya.", ReturnName(playerid));
	Info(playerid, "Anda berhasil menawari drag kepada player %s", ReturnName(otherid));
    return 1;
}

CMD:undrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return Usage(playerid, "/undrag [playerid]");
	if(pData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        pData[otherid][pDragged] = 0;
        pData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(pData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}

/*CMD:mask(playerid, params[])
{
	if(pData[playerid][pMask] <= 0)
		return Error(playerid, "Anda tidak memiliki topeng!");
		
	switch (pData[playerid][pMaskOn])
    {
        case 0:
        {
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a mask and puts it on.", ReturnName(playerid));
            pData[playerid][pMaskOn] = 1;
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            	UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_RED, (sprintf("Mask_#%d {ffffff}(%d)", pData[playerid][pMaskID], playerid)));
        }
        case 1:
        {
			if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            	UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, (sprintf("%s (%d)", GetRPName(playerid), playerid)));

            pData[playerid][pMaskOn] = 0;
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));
        }
    }
	return 1;
}*/

alias:togmask("mask")
CMD:togmask(playerid, params[])
{
	if(pData[playerid][pMask] <= 0)
		return Error(playerid, "You don't have a mask.");

	if(pData[playerid][pLevel] < 3)
		return Error(playerid, "Level kamu belum cukup, Untuk Menggunakan Mask");

	if(pData[playerid][pAdminDuty] == 1)
		return Error(playerid, "Kamu tidak bisa menggunakan mask pada saat Duty Admin");
		
	switch (pData[playerid][pMaskOn])
    {
        case 0:
        {
        	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* Mask_#%d takes out a mask and puts it on.", pData[playerid][pMaskID]);
		    pData[playerid][pMaskOn] = 1;
			new string[300], Float:healthh, Float:armourr;
			GetPlayerHealth(playerid, healthh), GetPlayerArmour(playerid, armourr);
			if(armourr == 0)
			{
				format(string, sizeof(string), "Mask_#%d\nH:["RED_E"%.1f"WHITE_E"]", pData[playerid][pMaskID], healthh);
				pData[playerid][pMaskLabel] = CreateDynamic3DTextLabel(string, -1, 0, 0, -10, 30.0, playerid);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, pData[playerid][pMaskLabel] , E_STREAMER_ATTACH_OFFSET_Z, 0.30);
				Attach3DTextLabelToPlayer(pData[playerid][pMaskLabel], playerid, 0, 0, 0.39);
				SetPlayerName(playerid, string);
				foreach(new i : Player)
				{
					ShowPlayerNameTagForPlayer(i, playerid, 0);
				}
				for(new i = GetPlayerPoolSize(); i != -1; --i)
				{
					ShowPlayerNameTagForPlayer(i, playerid, 0);
				}
			}
			else if(armourr > 0)
			{
				format(string, sizeof(string), "Mask_#%d\nH:["RED_E"%.1f"WHITE_E"] A:["RED_E"%.1f"WHITE_E"]", pData[playerid][pMaskID], healthh, armourr);
				pData[playerid][pMaskLabel] = CreateDynamic3DTextLabel(string, -1, 0, 0, -10, 30.0, playerid);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, pData[playerid][pMaskLabel] , E_STREAMER_ATTACH_OFFSET_Z, 0.30);
				Attach3DTextLabelToPlayer(pData[playerid][pMaskLabel], playerid, 0, 0, 0.39);
				SetPlayerName(playerid, string);
				foreach(new i : Player)
				{
					ShowPlayerNameTagForPlayer(i, playerid, 0);
				}
				for(new i = GetPlayerPoolSize(); i != -1; --i)
				{
					ShowPlayerNameTagForPlayer(i, playerid, 0);
				}
			}
			//SetPlayerAttachedObject(playerid, 9, 18911, 2,0.078534, 0.041857, -0.001727, 268.970458, 1.533374, 269.223754);
        }
        case 1:
        {
        	DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);
            pData[playerid][pMaskOn] = 0;
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));
            SetPlayerName(playerid, pData[playerid][pName]);
			for(new i = GetPlayerPoolSize(); i != -1; --i)
			{
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}
			//RemovePlayerAttachedObject(playerid, 9);
        }
    }
	return 1;
}

CMD:stuck(playerid)
{
	if(pData[playerid][pFreeze] == 1)
		return Error(playerid, "Anda sedang di Freeze oleh staff, tidak dapat menggunakan ini");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	ShowPlayerDialog(playerid, DIALOG_STUCK, DIALOG_STYLE_LIST,"Stuck Options","Tersangkut DiGedung\nTersangkut setelah masuk/keluar Interior\nTersangkut diKendaraan","Pilih","Batal");
	return 1;
}
//Text and Chat Commands
CMD:try(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/try [action]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s, %s", params[64], (random(2) == 0) ? ("and success") : ("but fail"));
    }
    else {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s, %s", ReturnName(playerid), params, (random(2) == 0) ? ("and success") : ("but fail"));
    }
	printf("[TRY] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ado(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ado [text]");
		Info(playerid, "Use /ado off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pAdoActive])
            return Error(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

        Servers(playerid, "You're removed your ado text.");
        pData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pAdoTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pAdoActive] = true;
        pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[ADO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1; 
}

CMD:ab(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ab [text]");
		Info(playerid, "Use /ab off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pBActive])
            return Error(playerid, "You're not actived your 'ab' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);

        Servers(playerid, "You're removed your ab text.");
        pData[playerid][pBActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( OOC : %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pBActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pBTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pBActive] = true;
        pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[AB] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ame(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164];

    if(isnull(params))
        return Usage(playerid, "/ame [action]");

    if(strlen(params) > 128)
        return Error(playerid, "Max action can only maximmum 128 characters.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    format(flyingtext, sizeof(flyingtext), "* %s %s*", ReturnName(playerid), params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_PURPLE, 10.0, 10000);
	printf("[AME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:me(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/me [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
    }
	printf("[ME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:do(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/do [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
    }
	printf("[DO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:toglog(playerid)
{
	if(!pData[playerid][pTogLog])
	{
		pData[playerid][pTogLog] = 1;
		Info(playerid, "Anda telah menonaktifkan log server.");
	}
	else
	{
		pData[playerid][pTogLog] = 0;
		Info(playerid, "Anda telah mengaktifkan log server.");
	}
	return 1;
}

CMD:togpm(playerid)
{
	if(!pData[playerid][pTogPM])
	{
		pData[playerid][pTogPM] = 1;
		Info(playerid, "Anda telah menonaktifkan PM");
	}
	else
	{
		pData[playerid][pTogPM] = 0;
		Info(playerid, "Anda telah mengaktifkan PM");
	}
	return 1;
}

CMD:togads(playerid)
{
	if(!pData[playerid][pTogAds])
	{
		pData[playerid][pTogAds] = 1;
		Info(playerid, "Anda telah menonaktifkan Ads/Iklan.");
	}
	else
	{
		pData[playerid][pTogAds] = 0;
		Info(playerid, "Anda telah mengaktifkan Ads/Iklan.");
	}
	return 1;
}

CMD:togwt(playerid)
{
	if(!pData[playerid][pTogWT])
	{
		pData[playerid][pTogWT] = 1;
		Info(playerid, "Anda telah menonaktifkan Walkie Talkie.");
	}
	else
	{
		pData[playerid][pTogWT] = 0;
		Info(playerid, "Anda telah mengaktifkan Walkie Talkie.");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
    static text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/pm [playerid/PartOfName] [message]");

    /*if(pData[playerid][pTogPM])
        return Error(playerid, "You must enable private messaging first.");*/

    /*if(pData[otherid][pAdminDuty])
        return Error(playerid, "You can't pm'ing admin duty now!");*/
		
	if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player yang anda tuju tidak valid.");

    if(otherid == playerid)
        return Error(playerid, "Tidak dapan PM diri sendiri.");

    if(pData[otherid][pTogPM] && pData[playerid][pAdmin] < 1)
        return Error(playerid, "Player tersebut menonaktifkan pm.");

    if(IsPlayerInRangeOfPoint(otherid, 50, 2184.32, -1023.32, 1018.68))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

    //GameTextForPlayer(otherid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~New message!", 3000, 3);
    PlayerPlaySound(otherid, 1085, 0.0, 0.0, 0.0);

    SendClientMessageEx(otherid, COLOR_YELLOW, "(( PM from %s (%d): %s ))", pData[playerid][pName], playerid, text);
    SendClientMessageEx(playerid, COLOR_YELLOW, "(( PM to %s (%d): %s ))", pData[otherid][pName], otherid, text);
	//Info(otherid, "/togpm for tog enable/disable PM");

    foreach(new i : Player) if((pData[i][pAdmin]) && pData[playerid][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_LIGHTGREEN, "[SPY PM] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:whisper(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/(w)hisper [playerid/PartOfName] [text]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player itu Disconnect or not near you.");

    if(otherid == playerid)
        return Error(playerid, "You can't whisper yourself.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(text) > 64) 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
        SendClientMessageEx(otherid, COLOR_YELLOW, "...%s **", text[64]);

        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %.64s", ReturnName(otherid), otherid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
    }
    else 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %s **", ReturnName(otherid), otherid, text);
    }
    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(otherid));
	
	foreach(new i : Player) if((pData[i][pAdmin]) && pData[i][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_YELLOW2, "[SPY Whisper] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:l(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64) 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessageEx(i, COLOR_WHITE, "...%s", params[64]);
				}
				else 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %s", ReturnName(playerid), params);
				}
				printf("[CAR] %s(%d) : %s", pData[playerid][pName], playerid, params);
			}
		}
	}
	else
	{
		if(strlen(params) > 64) 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
		}
		printf("[LOW] %s(%d) : %s", pData[playerid][pName], playerid, params);
	}
    return 1;
}

CMD:s(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(s)hout [shout text] /ds for in the door");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "%s shouts: %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "...%s!", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
    }
	new flyingtext[128];
	format(flyingtext, sizeof(flyingtext), "%s!", params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_WHITE, 10.0, 10000);
	printf("[SHOUTS] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:b(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "OOC Zone, Ketik biasa saja");

    if(isnull(params))
        return Usage(playerid, "/b [local OOC]");
		
	if(pData[playerid][pAdminDuty] == 1)
    {
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", GetRPName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", GetRPName(playerid), params);
            return 1;
        }
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", GetRPName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", GetRPName(playerid), params);
            return 1;
        }
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
	new str[150];
	format(str,sizeof(str),"[OOC] %s: %s", GetRPName(playerid), params);
	LogServer("Chat", str);
    return 1;
}

CMD:t(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(isnull(params))
		return Usage(playerid, "/t [typo text]");

	if(strlen(params) < 10)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s : %.10s*", ReturnName(playerid), params);
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:p(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
		return Error(playerid, "Anda sudah sedang menelpon seseorang!");
		
	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "You cant do that in this time.");
		
	foreach(new ii : Player)
	{
		if(playerid == pData[ii][pCall])
		{
			pData[ii][pPhoneCredit]--;
			
			pData[playerid][pCall] = ii;
			SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
			return 1;
		}
	}
	return 1;
}

CMD:hu(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new caller = pData[playerid][pCall];
	if(IsPlayerConnected(caller) && caller != INVALID_PLAYER_ID)
	{
		pData[caller][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
		SendNearbyMessage(caller, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(caller));
		
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
		pData[playerid][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return 1;
}

CMD:sms(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph, text[50];
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "Anda tidak memiliki Ponsel credits!");
	if(pData[playerid][pInjured] != 0) return Error(playerid, "You cant do at this time.");
	
	if(sscanf(params, "ds[50]", ph, text))
        return Usage(playerid, "/sms [phone number] [message max 50 text]");
	
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][pPhoneStatus] == 0) return Error(playerid, "Tidak dapat SMS, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", ph, text);
			SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], text);
			Info(ii, "Gunakan "LB_E"'@<text>' "WHITE_E"untuk membalas SMS!");
			PlayerPlaySound(ii, 6003, 0,0,0);
			pData[ii][pSMS] = pData[playerid][pPhone];
			
			pData[playerid][pPhoneCredit] -= 1;
			return 1;
		}
	}
	return 1;
}

CMD:number(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pPhoneBook] == 0)
		return Error(playerid, "You dont have a phone book.");
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/number [playerid]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "That player is not listed in phone book.");
		
	if(pData[otherid][pPhone] == 0)
		return Error(playerid, "That player is not listed in phone book.");
	
	SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] Name: %s | Ph: %d.", ReturnName(otherid), pData[otherid][pPhone]);
	return 1;
}


CMD:setfreq(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
	
	new channel;
	if(sscanf(params, "d", channel))
		return Usage(playerid, "/setfreq [channel 1 - 1000]");
	
	if(pData[playerid][pTogWT] == 1) return Error(playerid, "Your walkie talkie is turned off.");
	if(channel == pData[playerid][pWT]) return Error(playerid, "You are already in this channel.");
	
	if(channel > 0 && channel <= 1000)
	{
		foreach(new i : Player)
		{
		    if(pData[i][pWT] == channel)
		    {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s has joined in to this channel!", ReturnName(playerid));
		    }
		}
		Info(playerid, "You have set your walkie talkie channel to "LIME_E"%d", channel);
		pData[playerid][pWT] = channel;
	}
	else
	{
		Error(playerid, "Invalid channel id! 1 - 1000");
	}
	return 1;
}

CMD:wt(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
		
	if(pData[playerid][pTogWT] == 1)
		return Error(playerid, "Your walkie talkie is turned off!");
	
	new flyingtext[128];
	format(flyingtext, sizeof(flyingtext), "*[WT]: %s*", params); 
	SetPlayerChatBubble(playerid, flyingtext, COLOR_LIGHTGREEN, 10.0, 10000);
	new msg[128];
	if(sscanf(params, "s[128]", msg)) return Usage(playerid, "/wt [message]");
	foreach(new i : Player)
	{
	    if(pData[i][pTogWT] == 0)
	    {
	        if(pData[i][pWT] == pData[playerid][pWT])
	        {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s: %s", ReturnName(playerid), msg);

				SetPlayerChatBubble(i, flyingtext, COLOR_LIGHTGREEN, 10.0, 10000);
	        }
	    }
	}
	return 1;
}

/*CMD:savestats(playerid, params[])
{
	UpdateWeapons(playerid);
	UpdatePlayerData(playerid);
	Info(playerid, "Your data have been saved!");
	return 1;
}*/

/* CMD:ads(playerid, params[])
{
	if(pData[playerid][pVip] < 1)
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Tidak dapat iklan, Ponsel anda sedang Offline");
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2461.28, 2270.08, 91.9744)) return Error(playerid, "You must in SANA Station!");
	if(pData[playerid][pDelayIklan] > 0) return Error(playerid, "Kamu masih cooldown %d detik", pData[playerid][pDelayIklan]);
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	
	if(isnull(params))
	{
		Usage(playerid, "/ads kmau akan membayar $200,00");
		return 1;
	}
	if(strlen(params) >= 100 ) return Error(playerid, "Maximum character is 100 text." );
//	new payout = strlen(params) * 50;
	if(GetPlayerMoney(playerid) < 20000) return Error(playerid, "Not enough money.");
	
	GivePlayerMoneyEx(playerid, -20000);
	Server_AddMoney(20000);
	pData[playerid][pDelayIklan] = 600;
	foreach(new ii : Player)
	{
		if(pData[ii][pTogAds] == 0)
		{
			SendClientMessageEx(ii, COLOR_ORANGE2, "[IKLAN] "GREEN_E"%s.", params);
			SendClientMessageEx(ii, COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", pData[playerid][pName], pData[playerid][pPhone], pData[playerid][pBankRek]);
		}
	}
	//SendClientMessageToAllEx(COLOR_ORANGE2, "[ADS] "GREEN_E"%s.", params);
	//SendClientMessageToAllEx(COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", pData[playerid][pName], pData[playerid][pPhone], pData[playerid][pBankRek]);
	return 1;
} */

//------------------[ Bisnis and Buy Commands ]-------
CMD:buy(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	//trucker product
	if(IsPlayerInRangeOfPoint(playerid, 3.5, -279.67, -2148.42, 28.54))
	{
		if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah product:\nProduct Stock: "GREEN_E"%d\n"WHITE_E"Product Price"GREEN_E"%s / item", Product, FormatMoney(ProductPrice));
				ShowPlayerDialog(playerid, DIALOG_PRODUCT, DIALOG_STYLE_INPUT, "Buy Product", mstr, "Buy", "Cancel");
			}
			else return Error(playerid, "You are not in vehicle trucker.");
		}
		else return Error(playerid, "You are not trucker job.");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 336.70, 895.54, 20.40))
	{
		if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah liter gasoil:\nGasOil Stock: "GREEN_E"%d\n"WHITE_E"GasOil Price"GREEN_E"%s / liters", GasOil, FormatMoney(GasOilPrice));
				ShowPlayerDialog(playerid, DIALOG_GASOIL, DIALOG_STYLE_INPUT, "Buy GasOil", mstr, "Buy", "Cancel");
			}
			else return Error(playerid, "You are not in vehicle trucker.");
		}
		else return Error(playerid, "You are not trucker job.");
	}
	//Material
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -258.54, -2189.92, 28.97))
	{
		if(pData[playerid][pMaterial] >= 500) return Error(playerid, "Anda sudah membawa 500 Material!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah material:\nMaterial Stock: "GREEN_E"%d\n"WHITE_E"Material Price"GREEN_E"%s / item", Material, FormatMoney(MaterialPrice));
		ShowPlayerDialog(playerid, DIALOG_MATERIAL, DIALOG_STYLE_INPUT, "Buy Material", mstr, "Buy", "Cancel");
	}
	//Component
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 1339.68, 324.57, 20.27))
	{
		if(pData[playerid][pComponent] >= 500) return Error(playerid, "Anda sudah membawa 500 Component!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah component:\nComponent Stock: "GREEN_E"%d\n"WHITE_E"Component Price"GREEN_E"%s / item", Component, FormatMoney(ComponentPrice));
		ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
	}
	//Apotek
	// if(IsPlayerInRangeOfPoint(playerid, 2.5, 1842.52, -1077.10, 41.65))
	// {
			
	// 	new mstr[128];
	// 	format(mstr, sizeof(mstr), "Product\tPrice\n
	// 	Medicine\t"GREEN_E"%s\n
	// 	Medkit\t"GREEN_E"%s\n
	// 	Bandage\t"GREEN_E"$200\n
	// 	", FormatMoney(MedicinePrice), FormatMoney(MedkitPrice));
	// 	ShowPlayerDialog(playerid, DIALOG_APOTEK, DIALOG_STYLE_TABLIST_HEADERS, "Apotek", mstr, "Buy", "Cancel");
	// }
	//Food and Seed
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -381.44, -1426.13, 25.93))
	{
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Food\t"GREEN_E"%s\n\
		Seed\t"GREEN_E"%s\n\
		", FormatMoney(FoodPrice), FormatMoney(SeedPrice));
		ShowPlayerDialog(playerid, DIALOG_FOOD, DIALOG_STYLE_TABLIST_HEADERS, "Food", mstr, "Buy", "Cancel");
	}
	// Obat Myr
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -1772.3304, -2013.1531, 1500.7853))
	{
		if(pData[playerid][pObat] >= 5) return Error(playerid, "Anda sudah membawa 5 Obat Myr!");
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah Obat:\nObat Stock: "GREEN_E"%d\n"WHITE_E"Obat Price"GREEN_E"%s / item", ObatMyr, FormatMoney(ObatPrice));
		ShowPlayerDialog(playerid, DIALOG_OBAT, DIALOG_STYLE_INPUT, "Buy Obat", mstr, "Buy", "Cancel");
	}
	//Buy House
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return Error(playerid, "Someone already owns this house.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			Server_AddMoney(hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			hData[hid][hOwnerID] = pData[playerid][pID];
			hData[hid][hVisit] = gettime();
			new str[150];
			format(str,sizeof(str),"[HOUSE]: %s membeli rumah id %d seharga %s!", GetRPName(playerid), hid, FormatMoney(hData[hid][hPrice]));
			LogServer("Property", str);

			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", hData[hid][hOwner], hData[hid][hOwnerID], hData[hid][hVisit], hid);
			mysql_tquery(g_SQL, query);
			
			House_Refresh(hid);
		}
	}
	//Buy Bisnis
	foreach(new bid : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(bData[bid][bPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this bisnis.");
			if(strcmp(bData[bid][bOwner], "-") || bData[bid][bOwnerID] != 0) return Error(playerid, "Someone already owns this bisnis.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
			Server_AddMoney(-bData[bid][bPrice]);
			GetPlayerName(playerid, bData[bid][bOwner], MAX_PLAYER_NAME);
			bData[bid][bOwnerID] = pData[playerid][pID];
			bData[bid][bVisit] = gettime();
			new str[150];
			format(str,sizeof(str),"[BIZ]: %s membeli bisnis id %d seharga %s!", GetRPName(playerid), bid, FormatMoney(bData[bid][bPrice]));
			LogServer("Property", str);
			
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", bData[bid][bOwner], bData[bid][bOwnerID], bData[bid][bVisit], bid);
			mysql_tquery(g_SQL, query);

			Bisnis_Refresh(bid);
		}
	}
	//Buy Bisnis menu
	if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
	{
		Bisnis_BuyMenu(playerid, pData[playerid][pInBiz]);
	}
	//Buy Vending Machine
	foreach(new vid : Vendings)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]))
		{
			if(VendingData[vid][vendingPrice] > GetPlayerMoney(playerid)) 
				return Error(playerid, "Not enough money, you can't afford this Vending.");

			if(strcmp(VendingData[vid][vendingOwner], "-") || VendingData[vid][vendingOwnerID] != 0) 
				return Error(playerid, "Someone already owns this Vending.");

			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}

			SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to vending id %d", vid);
			GivePlayerMoneyEx(playerid, -VendingData[vid][vendingPrice]);
			Server_AddMoney(VendingData[vid][vendingPrice]);
			GetPlayerName(playerid, VendingData[vid][vendingOwner], MAX_PLAYER_NAME);
			VendingData[vid][vendingOwnerID] = pData[playerid][pID];
			new str[150];
			format(str,sizeof(str),"[VEND]: %s membeli vending id %d seharga %s!", GetRPName(playerid), vid, FormatMoney(VendingData[vid][vendingPrice]));
			LogServer("Property", str);
			
			Vending_RefreshText(vid);
			Vending_Save(vid);
		}
		//Buy Workshop
		foreach(new wid : Workshop)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]))
			{
				if(wsData[wid][wPrice] > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money, you can't afford this workshop.");
				if(wsData[wid][wOwnerID] != 0 || strcmp(wsData[wid][wOwner], "-")) 
					return Error(playerid, "Someone already owns this workshop.");

				#if LIMIT_PER_PLAYER > 0
				if(Player_WorkshopCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more workshop.");
				#endif

				GivePlayerMoneyEx(playerid, -wsData[wid][wPrice]);
				Server_AddMoney(wsData[wid][wPrice]);
				GetPlayerName(playerid, wsData[wid][wOwner], MAX_PLAYER_NAME);
				wsData[wid][wOwnerID] = pData[playerid][pID];
				new str[150];
				format(str,sizeof(str),"[WS]: %s membeli workshop id %d seharga %s!", GetRPName(playerid), wid, FormatMoney(wsData[wid][wPrice]));
				LogServer("Property", str);

				Workshop_Refresh(wid);
				Workshop_Save(wid);
			}
		}
	}
	
	return 1;
}

forward Revive(playerid);
public Revive(playerid)
{
	new otherid = GetPVarInt(playerid, "gcPlayer");
	TogglePlayerControllable(playerid,1);
	Servers(playerid, "Sukses revive");
	pData[playerid][pObat] -= 1;
    pData[otherid][pInjured] = 0;
    pData[otherid][pHospital] = 0;
    pData[otherid][pSick] = 0;
    pData[otherid][pHead] = 100;
    pData[otherid][pPerut] = 100;
    pData[otherid][pRHand] = 100;
    pData[otherid][pLHand] = 100;
    pData[otherid][pRFoot] = 100;
    pData[otherid][pLFoot] = 100;
}

forward DownloadTwitter(playerid);
public DownloadTwitter(playerid)
{
	pData[playerid][pTwitter] = 1;
	pData[playerid][pKuota] -= 38000;
	Servers(playerid, "Twitter berhasil di Download");
}

CMD:selfie(playerid,params[])
{
	if(takingselfie[playerid] == 0)
	{
	    GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
		static Float: n1X, Float: n1Y;
		if(Degree[playerid] >= 360) Degree[playerid] = 0;
		Degree[playerid] += Speed;
		n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		takingselfie[playerid] = 1;
		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 1, 1, 1, 1, 1, 1);
		return 1;
	}
    if(takingselfie[playerid] == 1)
	{
	    TogglePlayerControllable(playerid,1);
		SetCameraBehindPlayer(playerid);
	    takingselfie[playerid] = 0;
	    ApplyAnimation(playerid, "PED", "ATM", 4.1, 0, 1, 1, 0, 1, 1);
	    return 1;
	}
    return 1;
}
CMD:checkstarterpack(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	ShowPlayerDialog(playerid, DIALOG_CHECKSTARTERPACK, DIALOG_STYLE_INPUT, "Check Starterpack", "Enter player ID to check:", "Check", "Cancel");
    return 1;
}

CMD:claimsp(playerid, params)
{
	if(pData[playerid][pStarterpack] != 0)
	{
		return Error(playerid, "Kamu sudah mengambil Starterpack!");
	}
	else
	{
		SendClientMessage(playerid, COLOR_ARWIN, "SERVER: "WHITE_E"Anda berhasil menggambil starterpack");
		GivePlayerMoneyEx(playerid, 3000);
		pData[playerid][pMedicine] = 3;
		pData[playerid][pLevel] += 1;
		pData[playerid][pSnack] += 10;
		pData[playerid][pSprunk] += 10;
		pData[playerid][pStarterpack] = 1;
		new cQuery[1024];
		new Float:x,Float:y,Float:z, Float:a;
		GetPlayerPos(playerid, x ,y , z);
		GetPlayerFacingAngle(playerid, a);
		new model = 468, color1 = 1, color2 = 1;
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Benefit Starterpack", "Anda berhasil mengambil Starterpack\n\nHadiah yang anda Dapat berupa:\n+ Money: $3,000\n+ Snack: 10\n+ Sprunk: 10\n+ Level: 1\n\nTerimakasih telah Bermain di Levana Pride\nServer ini baru Berjalan Jangan lupa Ramaikan ya", "Close", "");
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, x, y, z, a);
		mysql_tquery(g_SQL, cQuery, "OnVehStarterpack", "dddddffff", playerid, pData[playerid][pID], model, color1, color2, x, y, z, a);
	}
	return 1;	
}

DelaysPlayer(playerid, p2)
{
	new str[(1024 * 2)], headers[500];
	strcat(headers, "Name\tTime\n");

	if(pData[p2][pExitJob] > 0)
    {
        format(str, sizeof(str), "%s{ff0000}Exit Jobs{ffffff}\t%i Second\n", str, ReturnTimelapse(gettime(), pData[p2][pExitJob]));
	}
	if(pData[p2][pJobTime] > 0)
    {
        format(str, sizeof(str), "%sJobs\t%i Second\n", str, pData[p2][pJobTime]);
	}
    if(pData[p2][pSweeperTime] > 0)
    {
        format(str, sizeof(str), "%sSweeper (Sidejob)\t%i Second\n", str, pData[p2][pSweeperTime]);
	}
	if(pData[p2][pForklifterTime] > 0)
    {
        format(str, sizeof(str), "%sForklifter (Sidejob)\t%i Second\n", str, pData[p2][pForklifterTime]);
	}
	if(pData[p2][pBusTime] > 0)
    {
        format(str, sizeof(str), "%sBus (Sidejob)\t%i Second\n", str, pData[p2][pBusTime]);
	}
	if(pData[p2][pMowerTime] > 0)
    {
        format(str, sizeof(str), "%sMower (Sidejob)\t%i Second\n", str, pData[p2][pMowerTime]);
	}
	if(pData[p2][pTagsTime] > 0)
    {
        format(str, sizeof(str), "%sGrafity/Tags\t%i Second\n", str, pData[p2][pTagsTime]);
	}
	if(pData[p2][pDelayCourier] > 0)
    {
        format(str, sizeof(str), "%sCourier (Sidejob)\t%i Second\n", str, pData[p2][pDelayCourier]);
	}
	
	strcat(headers, str);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Delays", headers, "Okay", "");
	return 1;
}

CMD:delays(playerid, params)
{
	new str[(1024 * 2)], headers[500];
	strcat(headers, "Name\tTime\n");
    format(str, sizeof(str), "%sJobs\t%i Second\n", str, pData[playerid][pJobTime]);
    format(str, sizeof(str), "%sSweeper (Sidejob)\t%i Second\n", str, pData[playerid][pSweeperTime]);
    format(str, sizeof(str), "%sForklifter (Sidejob)\t%i Second\n", str, pData[playerid][pForklifterTime]);
    format(str, sizeof(str), "%sBus (Sidejob)\t%i Second\n", str, pData[playerid][pBusTime]);
    format(str, sizeof(str), "%sMower (Sidejob)\t%i Second\n", str, pData[playerid][pMowerTime]);
	format(str, sizeof(str), "%sExit Jobs{ffffff}\t%i Second\n", str, pData[playerid][pExitJob]);
	format(str, sizeof(str), "%sGrafity/Tags\t%i Second\n", str, pData[playerid][pTagsTime]);
	format(str, sizeof(str), "%sAdvertisement\t%i Second\n", str, pData[playerid][pDelayIklan]);
	format(str, sizeof(str), "%sCourier (Sidejob)\t%i Second\n", str, pData[playerid][pDelayCourier]);
	strcat(headers, str);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Delays", headers, "Okay", "");
	return 1;
}

CMD:washmoney(playerid, params[])
{
	new merah = pData[playerid][pRedMoney];
	new rumus = (merah/200)*10; // 5 discount percent
 	new total = merah-rumus;
	if(pData[playerid][pRedMoney] < 0)
	{
		return Error(playerid, "Kamu tidak memiliki uang merah.");
	}
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -427.3773, -392.3799, 16.5802))
	{
		return Error(playerid, "Kamu harus berada di penukaran uang.");
	}
	Info(playerid, "Kamu mencuci uang dan menghasilkan %s.", FormatMoney(total));
	pData[playerid][pRedMoney] -= total;
	GivePlayerMoneyEx(playerid, total);
	return 1;
}

CMD:clearchat(playerid, params[])
{
	ClearChat(playerid);
	return 1;
}

CMD:taclight(playerid, params[])
{
	if(!pData[playerid][pFlashlight]) 
		return Error(playerid, "Kamu tidak mempunyai senter.");
	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 6, 0.25, -0.0175, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s attach the flashlight to the gun.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] = 1;
	}
	else
	{
		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
		pData[playerid][pUsedFlashlight] =0;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take the flashlight off the gun.", ReturnName(playerid));
	}
	return 1;
}
CMD:flashlight(playerid, params[])
{
	if(!pData[playerid][pFlashlight])
		return Error(playerid, "Kamu tidak mempunyai senter.");

	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take out the flashlight and turn on the flashlight.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] =1;
	}
	else
	{
 		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
		pData[playerid][pUsedFlashlight] =0;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s turn off the flashlight and put it in.", ReturnName(playerid));
	}
	return 1;
}

CMD:newweaponlic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2578.5625, -1383.2179, 1500.7570)) return Error(playerid, "Anda harus berada di Kantor SAPD!");
	if(pData[playerid][pDriveLic] != 0) return Error(playerid, "Anda sudah memiliki Weapon License!");
	if(GetPlayerMoney(playerid) < 4000) return Error(playerid, "Anda butuh $4,000 untuk membuat Weapon License.");
	pData[playerid][pWeaponLic] = 1;
	pData[playerid][pWeaponLicTime] = gettime() + (30 * 86400);
	GivePlayerMoneyEx(playerid, -4000);
	Server_AddMoney(4000);
	return 1;
}

/*CMD:blindfold(playerid,params[])
{
    new targetid;
	if(sscanf(params, "u", targetid))
	{
	    return Usage(playerid, "/blindfold [playerid]");
	}
	if(pData[playerid][pBlindfold] <= 0)
	{
	    return Error(playerid, "Kamu tidak memiliki blindfold");
	}
	if(!IsPlayerInVehicle(targetid, GetPlayerVehicleID(playerid)))
	{
	    return Error(playerid, "Orang yang ditentukan terputus.");
	}
	if(GetPlayerState(targetid) == PLAYER_STATE_DRIVER)
	{
	    return Error(playerid, "Kamu tidak bisa menutup mata pengemudi.");
	}
	if(targetid == playerid)
	{
	    return Error(playerid, "Kamu tidak bisa menutup matamu sendiri.");
	}
	if(pBlind[targetid])
	{
	    return Error(playerid, "Orang itu sudah ditutup matanya. '/unblindfold' untuk melepas.");
	}
	if(pData[targetid][pAdminDuty])
	{
	    return Error(playerid, "Kamu tidak dapat menutup mata Administrator");
	}

	pData[playerid][pBlindfold]--;

	GameTextForPlayer(targetid, "~r~Penutup Mata", 3000, 3);
	SendProximityMessage(playerid, 20.0, SERVER_COLOR, "{C2A2DA} %s menutup mata %s dengan bandana.", GetRPName(playerid), GetRPName(targetid));

	TogglePlayerControllable(targetid, 0);
	TextDrawShowForPlayer(targetid, Blind);
	pBlind[targetid] = 1;
    return 1;
}

CMD:unblindfold(playerid, params[])
{
	new targetid;

	if(sscanf(params, "u", targetid))
	{
	    return SCM(playerid, COLOR_SYNTAX, "Gunakan: /unblindfold [playerid]");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerInRangeOfPlayer(playerid, targetid, 5.0))
	{
	    return Error(playerid, "Orang yang ditentukan terputus atau jauh darimu.");
	}
	if(targetid == playerid)
	{
	    return Error(playerid, "Kamu tidak dapat membuka penutup mata dirimu sendiri.");
	}
	if(!pBlind[targetid])
	{
	    return Error(playerid, "Orang itu bukan penutup mata.");
	}
	if(IsPlayerInAnyVehicle(targetid) && !IsPlayerInVehicle(playerid, GetPlayerVehicleID(targetid)))
	{
	    return Error(playerid, "Kamu harus berada di dalam kendaraan pemain itu untuk membuka penutup matanya.");
	}

	GameTextForPlayer(targetid, "~g~Buka penutup mata", 3000, 3);
	SendProximityMessage(playerid, 20.0, SERVER_COLOR, "**{C2A2DA} %s membuka penutup mata bandana dari %s.", GetRPName(playerid), GetRPName(targetid));

    TextDrawHideForPlayer(targetid, Blind);
	pBlind[targetid] = 0;
	return 1;
}*/
