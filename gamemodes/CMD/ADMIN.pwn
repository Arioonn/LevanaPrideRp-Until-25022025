CMD:setbooster(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new dayz, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, dayz))
	{
	    Usage(playerid, "/setbooster <ID/Name> <time (in days) 0 for permanent>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(dayz < 0)
		return Error(playerid, "Time can't be lower than 0!");

	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}

	if(pData[playerid][pAdmin] < 5 && dayz > 7)
		return Error(playerid, "Anda hanya bisa menset 1 - 7 hari!");

	pData[otherid][pBooster] = 1;
	if(dayz == 0)
	{
		pData[otherid][pBoostTime] = 0;
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%d) telah menset Roleplay Booster kepada %s(%d) ke level permanent time!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid);
	}
	else
	{
		pData[otherid][pBoostTime] = gettime() + (dayz * 86400);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%d) telah menset Roleplay Booster kepada %s(%d) selama %d hari!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, dayz);
	}

	format(tmp, sizeof(tmp), "(%d days)", dayz);
	StaffCommandLog("SETBOOSTER", playerid, otherid, tmp);
	return 1;
}

CMD:gotost(playerid,params[])
{
	if(pData[playerid][pAdmin] < 2)
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), 1771.0677,-1851.0072,13.4140);
	}
    SetPlayerPos(playerid, 1771.0677,-1851.0072,13.4140);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotols(playerid,params[])
{
	if(pData[playerid][pAdmin] < 2)
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),1529.6,-1691.2,13.3);
	}
    SetPlayerPos(playerid,1529.6,-1691.2,13.3);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotosf(playerid,params[])
{
	if(pData[playerid][pAdmin] < 2)
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), -2015.261108, 154.379516, 27.687500);
	}
    SetPlayerPos(playerid, -2015.261108, 154.379516, 27.687500);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotolv(playerid,params[])
{
	if(pData[playerid][pAdmin] < 2)
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), 1699.2,1435.1, 10.7);
	}
    SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotobank(playerid,params[])
{
	if(pData[playerid][pAdmin] < 2)
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), 1457.5571, -1040.2914, 23.8281);
	}
	SetPlayerPos(playerid, 1457.5571, -1040.2914, 23.8281);
	SendClientMessage(playerid, COLOR_LIGHTRED, "TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotoasgh(playerid,params[])
{
	if(pData[playerid][pAdmin] < 2)
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), 2039.9360,-1415.0548,17.1708);
	}
	SetPlayerPos(playerid, 2039.9360,-1415.0548,17.1708);
	SendClientMessage(playerid, COLOR_LIGHTRED, "TELEPORT: You have been teleported!");
	return 1;
}
CMD:p2p(playerid, params[])
{
    new otherid;

	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "ud", playerid, otherid))
        return Usage(playerid, "/playertoplayer [playerid/PartOfName] ke [playerid]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");

	if(pData[playerid][pSpawned] == 0 || pData[otherid][pSpawned] == 0)
		return Error(playerid, "Player/Target sedang tidak spawn!");

	if(pData[playerid][pJail] > 0 || pData[otherid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");

	if(pData[playerid][pArrest] > 0 || pData[otherid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");

    SendPlayerToPlayer(playerid, otherid);

    Servers(otherid, "Admin {ff0000}%s {ffffff}telah mengirim player %s ke anda.", pData[otherid][pAdminname], pData[playerid][pName]);
    return 1;
}

CMD:removebooster(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/removecs [playerid/PartOfName]");

	pData[otherid][pBooster] = 0;
	pData[otherid][pBoostTime] = 0;
	Servers(playerid, "Kamu telah menghapus Roleplay Booster milik %s's", ReturnName(otherid));
	Servers(otherid, "Admin {FF0000}%s{FFFFFF} Telah menghapus Roleplay Booster milik Anda", pData[playerid][pAdminname]);
	SendStaffMessage(COLOR_LIGHTRED, "%s(%d) Telah menghapus Roleplay Boostermilik %s's", pData[playerid][pAdminname], playerid, pData[otherid][pName]);
	return 1;
}

CMD:setcs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 1)
			return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/setcs [playerid/PartOfName]");

	pData[otherid][pCS] = 1;
	Servers(playerid, "Kamu telah memberikan Character Story kepada %s's", ReturnName(otherid));
	Servers(otherid, "Admin {FF0000]%s{FFFFFF} Telah memberikan Character Story kepada kamu", pData[playerid][pAdminname]);
	SendStaffMessage(COLOR_LIGHTRED, "%s(%d) Telah memberikan Character Story kepada %s's", pData[playerid][pAdminname], playerid, pData[otherid][pName]);
	return 1;
}

CMD:removecs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 1)
			return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/removecs [playerid/PartOfName]");

	pData[otherid][pCS] = 0;
	Servers(playerid, "Kamu telah menghapus Character Story milik %s's", ReturnName(otherid));
	Servers(otherid, "Admin {FF0000}%s{FFFFFF} Telah menghapus Character Story milik Anda", pData[playerid][pAdminname]);
	SendStaffMessage(COLOR_LIGHTRED, "%s(%d) Telah menghapus Character Story milik %s's", pData[playerid][pAdminname], playerid, pData[otherid][pName]);
	return 1;
}

CMD:acmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new line3[2480];
	if(pData[playerid][pAdmin] >= 1)
	{
		strcat(line3, "{a0522d}[Server Probationary]: {ffffff}/reports, /ar, /dr, /asks, /ans, /nonrpname, /goto, /jetpack, /gethere, /camerafly, /cameracmds\n");
		strcat(line3, "{a0522d}[Server Probationary]: {ffffff}/a, /aod, /asay, /arevive, /sendto, /spec, /getip, /aka, /akaip, /vmodels, /vehname\n");
		strcat(line3, "{a0522d}[Server Probationary]: {ffffff}/respawnsapd, /respawnsags, /respawnsamd, /respawnsana, /respawndmv, /respawnjobs, /setcs, /asalary\n\n");
	}
	if(pData[playerid][pAdmin] >= 2)
	{
		strcat(line3, "{3BBD44}[Junior Helper]: {ffffff}/makequiz, /adminjail, /togooc /goto(ls, sf, lv, asgh, bank), /freeze, /unfreeze, /slap, /caps, /aitems, /astats, /adelays, /resetdelays\n");
		strcat(line3, "{3BBD44}[Junior Helper]: {ffffff}/ostats, /jetpack, /owarn, /ojail, /jail, /unjail, /kick, /ban, /unban, /warn, /respawnrad, /sethp, /setbone\n");
		strcat(line3, "{3BBD44}[Junior Helper]: {ffffff} /destroyveh, /checkucp\n\n");
		
	}
	if(pData[playerid][pAdmin] >= 3)
	{
		strcat(line3, "{3BBD44}[Senior Helper]: {ffffff}/gethere, /peject, /acuff, /auncuff, /banucp, /setam, /afuel, /afix, /setskin\n");
		strcat(line3, "{3BBD44}[Senior Helper]: {ffffff}/ann, /cd, /oban, /banip, /unbanip, /reloadweap, /resetweap, /setvw, /setint, /setstock\n\n");
	}
	if(pData[playerid][pAdmin] >= 4)
	{
		strcat(line3, "{ff0000}[Junior Admin]: {ffffff}/arelease, /settime, /setweather, /gotoco, /setname, /setbooster, /removebooster\n");
		strcat(line3, "{ff0000}[Junior Admin]: {ffffff} /takemoney, /takegold, /setpassword, /clearallchat\n\n");
	
	}
	if(pData[playerid][pAdmin] >= 5)
	{
		strcat(line3, "{ff0000}[Senior Admin]: {ffffff}/sethbe, /setstres, /setbankmoney, /givebankmoney, /explode, /takegold, /sethelperlevel, /givemoneyall, /setadminname\n");
		strcat(line3, "{ff0000}[Senior Admin]: {ffffff}/setprice, /setstat, /setlevel, /createberry, /editberry /gotoactor\n\n");
	}
	if(pData[playerid][pAdmin] >= 6)
	{
		strcat(line3, "{ff0000}[Head Admin]: {ffffff}/kickall, /servermt, /createbiz, /editbiz, /gotobiz, /createstorage, /editstorage, /gotostorage, /createprivategarage\n");
		strcat(line3, "{ff0000}[Head Admin]: {ffffff}/createdealer, /editdealer, /gotodealer, /createactor, /editactor, /deleteactor, /gotoactor, /giveweap\n");
		strcat(line3, "{ff0000}[Head Admin]: {ffffff}/createpark, /setparkpos, /removepark, /gotopark, /editrent, /createrent, /gotorent\n\n");
	}
	if(pData[playerid][pAdmin] >= 7)
	{
		strcat(line3, "{ff0000}[Director Of Server]: {ffffff}/kickall, /anticheat, /servermt, /setstat, /setprice, /givemoney, /setmoney\n");
		strcat(line3, "{ff0000}[Director Of Server]: {ffffff}/createworkshop, /editworkshop, /gotoworkshop\n\n");
	}

	strcat(line3, "{00FF00}WARNING: Kepada staff Levana Pride, Saya ingatkan bahwasannya kalian dilarang mempergunakan commands admin untuk kepentigan di sendiri");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""WHITEP_E"Commands Staff", line3, "OK","");
	return true;
}

CMD:arelease(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
        return Error(playerid, "Kamu harus menjadi Admin level 5.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/arelease <ID/Name>");
	    return true;
	}

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

	if(pData[otherid][pArrest] == 0)
	    return Error(playerid, "The player isn't in arrest!");

	pData[otherid][pArrest] = 0;
	pData[otherid][pArrestTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPositionEx(otherid, 1526.69, -1678.05, 5.89, 267.76, 2000);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	new str[150];
	format(str,sizeof(str),"Admin: %s mengeluarkan %s dari penjara!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	return true;
}

CMD:amapper(playerid)
{
    // Cek apakah pemain adalah admin dengan level minimal 5
    if(pData[playerid][pAdmin] < 5)
    {
        return PermissionError(playerid); // Jika tidak, kembalikan pesan kesalahan izin
    }

    new str[512];
    // Format string yang berisi daftar perintah
    format(str, sizeof(str), "/createobject\n/deleteobject\n/editobject\n/setmaterialobject\n/onear");
    // Tampilkan dialog dengan daftar perintah
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Commands Mapper", str, "Select", "Close");

    return 1;
}

CMD:admins(playerid, params[])
{
	new count = 0, line3[512];
	if(pData[playerid][pAdmin] > 0)
	{
		format(line3, sizeof(line3), "ID\tName\tRank Name\tDuty Time\n");
		foreach(new i:Player) if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0) {
			format(line3, sizeof(line3), "%s\n%d\t%s (%s)\t%s\t%d minute", line3, i, pData[i][pName], pData[i][pAdminname], GetStaffRank(i), pData[i][pAdminTime]/60);
			count++;
		}
		if(count > 0) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Admin List", line3, "Close", "");
		else return Error(playerid, "Tidak ada ada admin yang online");
	}
	else
	{
		foreach(new i:Player) if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0) {
			if(pData[i][pAdminDuty] == 1)
			{
				format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s (ID: %i)", line3, GetStaffRank(i), pData[i][pAdminname], i);
				count++;
			}
		}
		if(count > 0) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
		else return Error(playerid, "Tidak ada admin yang duty!");
	}
	return 1;
}

//---------------------------[ Admin Level 1 ]--------------------
CMD:aod(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	if(!strcmp(pData[playerid][pAdminname], "None"))
		return Error(playerid, "Kamu harus setting Nama Admin mu!");
	
	if(!pData[playerid][pAdminDuty])
    {
		if(pData[playerid][pAdmin] > 0)
		{
			SetPlayerColor(playerid, 	COLOR_RED);
			pData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, pData[playerid][pAdminname]);
			SendStaffMessage(COLOR_LIGHTRED, "* %s telah on duty admin.", pData[playerid][pName]);
		}
		else
		{
			SetPlayerColor(playerid, COLOR_GREEN);
			pData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, pData[playerid][pAdminname]);
			SendStaffMessage(COLOR_LIGHTRED, "* %s telah on helper duty.", pData[playerid][pName]);
		}
    }
    else
    {
        if(pData[playerid][pFaction] != -1 && pData[playerid][pOnDuty]) 
            SetFactionColor(playerid);
        else 
            SetPlayerColor(playerid, COLOR_WHITE);
                
        SetPlayerName(playerid, pData[playerid][pName]);
        pData[playerid][pAdminDuty] = 0;
        SendStaffMessage(COLOR_LIGHTRED, "* %s telah off admin duty.", pData[playerid][pName]);
    }
	return 1;
}

CMD:asay(playerid, params[]) 
{
    new text[225];

    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

    if(sscanf(params,"s[225]",text))
        return Usage(playerid, "/asay [text]");
        
    SendClientMessageToAllEx(COLOR_LIGHTRED,"{ff0000}[STAFF] (%s{ff0000}) "YELLOW_E"%s: "LG_E"%s", GetStaffRank(playerid), pData[playerid][pAdminname], ColouredText(text));
    return 1;
}

CMD:h(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/h <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "{1e90ff}[Helper Chat] (%s{1e90ff}) "WHITEP_E"%s(%i): {ffffff}%s", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return 1;
}

CMD:a(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/a <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "[A] {007FFF}%s {00FF00}%s(%i): {ffffff}%s", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(pData[ii][pAdmin] > 0)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return true;
}

CMD:togooc(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(TogOOC == 0)
    {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s has disabled global OOC chat.", pData[playerid][pAdminname]);
        TogOOC = 1;
    }
    else
    {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s has enabled global OOC chat (DON'T SPAM).", pData[playerid][pAdminname]);
        TogOOC = 0;
    }
    return 1;
}

CMD:o(playerid, params[])
{
    if(TogOOC == 1 && pData[playerid][pAdmin] < 1 && pData[playerid][pHelper] < 1) 
            return Error(playerid, "An administrator has disabled global OOC chat.");

    if(isnull(params))
        return Usage(playerid, "/o [global OOC]");

    new VipColor[30];
	if(pData[playerid][pVip] == 1)
	{
		VipColor = "{33ee33}";
	}
	else if(pData[playerid][pVip] == 2)
	{
		VipColor = "{ffff00}";
	}
	else if(pData[playerid][pVip] == 3)
	{
		VipColor = "{ff00ff}";
	}
	else
	{
		VipColor = "{00ffff}";
	}
    if(strlen(params) < 90)
    {
        foreach (new i : Player) if(pData[i][IsLoggedIn] == true && pData[i][pSpawned] == 1)
        {
			if (pData[playerid][pAdminDuty] == 1) 
			{
				new staffRank[32];
				format(staffRank, sizeof(staffRank), "%s", GetStaffRank(playerid));

				SendClientMessageEx(i, COLOR_WHITE, "(( %s %s{FFFFFF}: %s {FFFFFF}))", staffRank, pData[playerid][pAdminname], ColouredText(params));
			}
            else
            {
                SendClientMessageEx(i, COLOR_WHITE, "(( %s %s{FFFFFF} (%d): %s ))", VipColor, pData[playerid][pName], playerid, params);
            }
        }
    }
    else
        return Error(playerid, "The text to long, maximum character is 90");

    return 1;
}

CMD:id(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/id [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	new packetLoss = 0;
    if (PacketSent[otherid] > 0)
    {
        packetLoss = 100 - (PacketReceived[otherid] * 100 / PacketSent[otherid]);
    }

	Servers(playerid, "%s(ID: %d) (%s) - Ping: (%d) - Level: (%d) - Packet Loss: (%d%%)", pData[otherid][pName], otherid, pData[otherid][pUCP], GetPlayerPing(otherid), pData[otherid][pLevel], packetLoss);
	return 1;
}

CMD:goto(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/goto [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SendPlayerToPlayer(playerid, otherid);
	Servers(otherid, "%s has been teleported to you.", pData[playerid][pName]);
	Servers(playerid, "You has teleport to %s position.", pData[otherid][pName]);
	return 1;
}

CMD:sendto(playerid, params[])
{
    static
        type[24],
		otherid;

    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "us[32]", otherid, type))
    {
        Usage(playerid, "/send [player] [name]");
        Info(playerid, "[NAMES]:{FFFFFF} ls, lv, sf, ooczone");
        return 1;
    }
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!strcmp(type,"ls")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1482.0356,-1724.5726,13.5469);
        }
        else 
		{
            SetPlayerPosition(otherid,1482.0356,-1724.5726,13.5469,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    else if(!strcmp(type,"sf")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),-1425.8307,-292.4445,14.1484);
        }
        else 
		{
            SetPlayerPosition(otherid,-1425.8307,-292.4445,14.1484,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    else if(!strcmp(type,"lv")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1686.0118,1448.9471,10.7695);
        }
        else 
		{
            SetPlayerPosition(otherid,1686.0118,1448.9471,10.7695,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    else if(!strcmp(type,"ooczone")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		        return Error(playerid, "Pemain tersebut sedang menggunakan kendaraan");

		SetPlayerPosition(otherid,2183.71, -1017.67, 1020.63,750);
		SetPlayerFacingAngle(otherid,179.4088);
		SetPlayerInterior(otherid, 1);
		SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
	    Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = 1;
	    pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    return 1;
}

CMD:gethere(playerid, params[])
{
    new otherid;

	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/gethere [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");
	
	if(pData[playerid][pSpawned] == 0 || pData[otherid][pSpawned] == 0)
		return Error(playerid, "Player/Target sedang tidak spawn!");
		
	if(pData[playerid][pJail] > 0 || pData[otherid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");
		
	if(pData[playerid][pArrest] > 0 || pData[otherid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");

	if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
		return Error(playerid, "Anda tidak dapat menarik Admin dengan level paling tinggi");

    SendPlayerToPlayer(otherid, playerid);

    Servers(playerid, "Anda menarik %s.", pData[otherid][pName]);
    Servers(otherid, "%s telah menarik mu.", pData[playerid][pName]);
    return 1;
}

CMD:freeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/freeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[playerid][pFreeze] = 1;

    TogglePlayerControllable(otherid, 0);
    Servers(playerid, "You have frozen %s's movements.", ReturnName(otherid));
	Servers(otherid, "You have been frozen movements by admin %s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unfreeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[playerid][pFreeze] = 0;

    TogglePlayerControllable(otherid, 1);
    Servers(playerid, "You have unfrozen %s's movements.", ReturnName(otherid));
	Servers(otherid, "You have been unfrozen movements by admin %s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:arevive(playerid, params[])
{

    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/arevive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(!pData[otherid][pInjured])
        return Error(playerid, "Tidak bisa revive karena tidak injured.");

    SetPlayerHealthEx(otherid, 100.0);
    pData[otherid][pInjured] = 0;
	pData[otherid][pHospital] = 0;
	pData[otherid][pSick] = 0;
	UpdateDynamic3DTextLabelText(pData[otherid][pInjuredLabel], COLOR_ORANGE, "");

    ClearAnimations(otherid);
	ApplyAnimation(otherid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);

    SendStaffMessage(COLOR_LIGHTRED, "Staff %s have revived player %s.", pData[playerid][pAdminname], ReturnName(otherid));
    Info(otherid, "Staff %s has revived your character.", pData[playerid][pAdminname]);
    return 1;
}

CMD:spec(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

    if(!isnull(params) && !strcmp(params, "off", true))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            return Error(playerid, "You are not spectating any player.");

		pData[pData[playerid][pSpec]][playerSpectated]--;
        PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
        PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

        SetSpawnInfo(playerid, 0, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
        TogglePlayerSpectating(playerid, false);
		pData[playerid][pSpec] = -1;
		TextDrawHideForPlayer(playerid, SpecBox);
		PlayerTextDrawHide(playerid, SpecName[playerid]);
		PlayerTextDrawHide(playerid, SpecCash[playerid]);
		PlayerTextDrawHide(playerid, SpecHP[playerid]);
		PlayerTextDrawHide(playerid, SpecAP[playerid]);
		PlayerTextDrawHide(playerid, SpecInt[playerid]);
		PlayerTextDrawHide(playerid, SpecWorld[playerid]);

        return Servers(playerid, "You are no longer in spectator mode.");
    }
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/spectate [playerid/PartOfName] - Type '/spec off' to stop spectating.");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(otherid == playerid)
		return Error(playerid, "You can't spectate yourself bro..");

    if(pData[playerid][pAdmin] < pData[otherid][pAdmin])
        return Error(playerid, "You can't spectate admin higher than you.");
		
	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}

    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
        GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);

        pData[playerid][pInt] = GetPlayerInterior(playerid);
        pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }
    SetPlayerInterior(playerid, GetPlayerInterior(otherid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(otherid));

    TogglePlayerSpectating(playerid, 1);

    if(IsPlayerInAnyVehicle(otherid))
	{
		new vID = GetPlayerVehicleID(otherid);
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(otherid));
		if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
	    {
	    	Servers(playerid, "You are now spectating %s(%i) who is driving a %s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
			new string[212];
			format(string, 212, "~g~%s (%d)", ReturnName2(otherid), otherid);
			PlayerTextDrawSetString(playerid, SpecName[playerid], string);
			format(string, 212, "~w~Cash: ~y~%s", FormatMoney(pData[otherid][pMoney]));
			PlayerTextDrawSetString(playerid, SpecCash[playerid], string);
			format(string, 212, "~w~HP: ~y~%.1f", pData[otherid][pHealth]);
			PlayerTextDrawSetString(playerid, SpecHP[playerid], string);
			format(string, 212, "~w~AP: ~y~%.1f", pData[otherid][pArmour]);
			PlayerTextDrawSetString(playerid, SpecAP[playerid], string);
			format(string, 212, "~w~Int: ~y~%d", GetPlayerInterior(otherid));
			PlayerTextDrawSetString(playerid, SpecInt[playerid], string);
			format(string, 212, "~w~World: ~y~%d", GetPlayerVirtualWorld(otherid));
			PlayerTextDrawSetString(playerid, SpecWorld[playerid], string);
			
			TextDrawShowForPlayer(playerid, SpecBox);
			PlayerTextDrawShow(playerid, SpecName[playerid]);
			PlayerTextDrawShow(playerid, SpecCash[playerid]);
			PlayerTextDrawShow(playerid, SpecHP[playerid]);
			PlayerTextDrawShow(playerid, SpecAP[playerid]);
			PlayerTextDrawShow(playerid, SpecInt[playerid]);
			PlayerTextDrawShow(playerid, SpecWorld[playerid]);	
		}
		else
		{
		    Servers(playerid, "You are now spectating %s(%i) who is a passenger in %s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
			new string[212];
			format(string, 212, "~g~%s (%d)", ReturnName2(otherid), otherid);
			PlayerTextDrawSetString(playerid, SpecName[playerid], string);
			format(string, 212, "~w~Cash: ~y~%s", FormatMoney(pData[otherid][pMoney]));
			PlayerTextDrawSetString(playerid, SpecCash[playerid], string);
			format(string, 212, "~w~HP: ~y~%.1f", pData[otherid][pHealth]);
			PlayerTextDrawSetString(playerid, SpecHP[playerid], string);
			format(string, 212, "~w~AP: ~y~%.1f", pData[otherid][pArmour]);
			PlayerTextDrawSetString(playerid, SpecAP[playerid], string);
			format(string, 212, "~w~Int: ~y~%d", GetPlayerInterior(otherid));
			PlayerTextDrawSetString(playerid, SpecInt[playerid], string);
			format(string, 212, "~w~World: ~y~%d", GetPlayerVirtualWorld(otherid));
			PlayerTextDrawSetString(playerid, SpecWorld[playerid], string);
			
			TextDrawShowForPlayer(playerid, SpecBox);
			PlayerTextDrawShow(playerid, SpecName[playerid]);
			PlayerTextDrawShow(playerid, SpecCash[playerid]);
			PlayerTextDrawShow(playerid, SpecHP[playerid]);
			PlayerTextDrawShow(playerid, SpecAP[playerid]);
			PlayerTextDrawShow(playerid, SpecInt[playerid]);
			PlayerTextDrawShow(playerid, SpecWorld[playerid]);
		}
	}
    else
	{
        PlayerSpectatePlayer(playerid, otherid);
		new string[212];
		format(string, 212, "~g~%s (%d)", ReturnName2(otherid), otherid);
		PlayerTextDrawSetString(playerid, SpecName[playerid], string);
		format(string, 212, "~w~Cash: ~y~%s", FormatMoney(pData[otherid][pMoney]));
		PlayerTextDrawSetString(playerid, SpecCash[playerid], string);
		format(string, 212, "~w~HP: ~y~%.1f", pData[otherid][pHealth]);
		PlayerTextDrawSetString(playerid, SpecHP[playerid], string);
		format(string, 212, "~w~AP: ~y~%.1f", pData[otherid][pArmour]);
		PlayerTextDrawSetString(playerid, SpecAP[playerid], string);
		format(string, 212, "~w~Int: ~y~%d", GetPlayerInterior(otherid));
		PlayerTextDrawSetString(playerid, SpecInt[playerid], string);
		format(string, 212, "~w~World: ~y~%d", GetPlayerVirtualWorld(otherid));
		PlayerTextDrawSetString(playerid, SpecWorld[playerid], string);
		
		TextDrawShowForPlayer(playerid, SpecBox);
		PlayerTextDrawShow(playerid, SpecName[playerid]);
		PlayerTextDrawShow(playerid, SpecCash[playerid]);
		PlayerTextDrawShow(playerid, SpecHP[playerid]);
		PlayerTextDrawShow(playerid, SpecAP[playerid]);
		PlayerTextDrawShow(playerid, SpecInt[playerid]);
		PlayerTextDrawShow(playerid, SpecWorld[playerid]);

	}
	pData[otherid][playerSpectated]++;
    SendStaffMessage(COLOR_LIGHTRED, "%s now spectating %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
    Servers(playerid, "You are now spectating %s (ID: %d).", pData[otherid][pName], otherid);
    pData[playerid][pSpec] = otherid;
    return 1;
}

CMD:slap(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new Float:POS[3], otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/slap <ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 9.0);
	if(IsPlayerInAnyVehicle(otherid)) 
	{
		RemovePlayerFromVehicle(otherid);
		//OnPlayerExitVehicle(otherid, GetPlayerVehicleID(otherid));
	}
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah men-slap player %s", pData[playerid][pAdminname], pData[otherid][pName]);

	PlayerPlaySound(otherid, 1130, 0.0, 0.0, 0.0);
	return 1;
}

CMD:caps(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
 	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/caps <ID>");
	    Info(playerid, "Function: Will disable caps for the player, type again to enable caps.");
	    return 1;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!GetPVarType(otherid, "Caps"))
	{
	    // Disable Caps
	    SetPVarInt(otherid, "Caps", 1);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah menon-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	else
	{
	    // Enable Caps
		DeletePVar(otherid, "Caps");
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah meng-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	return 1;
}

CMD:peject(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/peject <ID>");
	    return 1;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!IsPlayerInAnyVehicle(otherid))
	{
		Error(playerid, "Player tersebut tidak berada dalam kendaraan!");
		return 1;
	}

	new vv = GetVehicleModel(GetPlayerVehicleID(otherid));
	Servers(playerid, "You have successfully ejected %s(%i) from their %s.", pData[otherid][pName], otherid, GetVehicleModelName(vv - 400));
	Servers(otherid, "%s(%i) has ejected you from your %s.", pData[playerid][pName], playerid, GetVehicleModelName(vv));
	RemovePlayerFromVehicle(otherid);
	return 1;
}

CMD:aitems(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aitems [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");
		
	DisplayItems(playerid, otherid);
	return 1;
}

CMD:astats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/check [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DisplayStats(playerid, otherid);
	return 1;
}

CMD:adelays(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/check [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DelaysPlayer(playerid, otherid);
	return 1;
}

CMD:ostats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new name[24], PlayerName[24];
	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/ostats <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /stats on them.");
	  		return 1;
	  	}
	}

	// Load User Data
    new cVar[500];
    new cQuery[600];

	strcat(cVar, "email,admin,helper,level,levelup,vip,vip_time,gold,reg_date,last_login,money,bmoney,brek,hours,minutes,seconds,");
	strcat(cVar, "gender,age,faction,family,warn,job,job2,interior,world,ucp,reg_id,phone,phonestatus, twittername");

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT %s FROM players WHERE username='%e' LIMIT 1", cVar, name);
	mysql_tquery(g_SQL, cQuery, "LoadStats", "is", playerid, name);
	return true;
}

CMD:acuff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid, mstr[128];		
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/acuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot handcuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
        return Error(playerid, "The player must be onfoot before you can cuff them.");

    if(pData[otherid][pCuffed])
        return Error(playerid, "The player is already cuffed at the moment.");

    pData[otherid][pCuffed] = 1;
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);

    format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, mstr);

    Servers(playerid, "Player %s telah berhasil di cuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin %s telah mengcuffed anda.", pData[playerid][pName]);
    return 1;
}

CMD:auncuff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/auncuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot uncuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(!pData[otherid][pCuffed])
        return Error(playerid, "The player is not cuffed at the moment.");

    static
        string[64];

    pData[otherid][pCuffed] = 0;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, string);
	Servers(playerid, "Player %s telah berhasil uncuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin %s telah uncuffed tangan anda.", pData[playerid][pName]);
    return 1;
}

CMD:jetpack(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 1)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
    {
        pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(otherid, SPECIAL_ACTION_USEJETPACK);
        Servers(playerid, "You have spawned a jetpack for %s.", pData[otherid][pName]);
    }
    return 1;
}

CMD:getip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
		
	new otherid, PlayerIP[16], giveplayer[24];
	if(sscanf(params, "u", otherid))
 	{
  		Usage(playerid, "/getip <ID>");
		return 1;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(pData[otherid][pAdmin] == 5)
 	{
  		Error(playerid, "You can't get the server owners ip!");
  		Servers(otherid, "%s(%i) tried to get your IP!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	Servers(playerid, "%s(%i)'s IP: %s", giveplayer, otherid, PlayerIP);
	return 1;
}

CMD:aka(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new otherid, PlayerIP[16], query[128];
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/aka <ID/Name>");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(pData[otherid][pAdmin] == 5)
 	{
  		Error(playerid, "You can't AKA the server owner!");
  		Servers(otherid, "%s(%i) tried to AKA you!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", PlayerIP);
	mysql_tquery(g_SQL, query, "CheckPlayerIP", "is", playerid, PlayerIP);
	return true;
}

CMD:akaip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new query[128];
	if(isnull(params))
	{
	    Usage(playerid, "/akaip <IP>");
		return true;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", params);
	mysql_tquery(g_SQL, query, "CheckPlayerIP2", "is", playerid, params);
	return true;
}

CMD:vmodels(playerid, params[])
{
    new string[3500];

    if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
    {
        format(string,sizeof(string), "%s%d - %s\n", string, i+400, g_arrVehicleNames[i]);
    }
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Vehicle Models", string, "Close", "");
    return 1;
}

CMD:vehname(playerid, params[]) {

	if(pData[playerid][pAdmin] >= 1) 
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle Search:");

		new
			string[128];

		if(isnull(params)) return Error(playerid, "No keyword specified.");
		if(!params[2]) return Error(playerid, "Search keyword too short.");

		for(new v; v < sizeof(g_arrVehicleNames); v++) 
		{
			if(strfind(g_arrVehicleNames[v], params, true) != -1) {

				if(isnull(string)) format(string, sizeof(string), "%s (ID %d)", g_arrVehicleNames[v], v+400);
				else format(string, sizeof(string), "%s | %s (ID %d)", string, g_arrVehicleNames[v], v+400);
			}
		}

		if(!string[0]) Error(playerid, "No results found.");
		else if(string[127]) Error(playerid, "Too many results found.");
		else SendClientMessageEx(playerid, COLOR_WHITE, string);

		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
	}
	else
	{
		PermissionError(playerid);
	}
	return 1;
}

CMD:owarn(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);
	
	new player[24], tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]s[50]", player, tmp))
		return Usage(playerid, "/owarn <name> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /warn on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id,warn FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OWarnPlayer", "iss", playerid, player, tmp);
	return 1;
}

function OWarnPlayer(adminid, NameToWarn[], warnReason[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToWarn);
	}
	else
	{
	    new RegID, warn;
		cache_get_value_index_int(0, 0, RegID);
		cache_get_value_index_int(0, 1, warn);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah memberi warning(offline) player %s. [Reason: %s]", pData[adminid][pAdminname], NameToWarn, warnReason);
		new str[150];
		format(str,sizeof(str),"Admin: %s memberi %s warn(offline). Alasan: %s!", GetRPName(adminid), NameToWarn, warnReason);
		LogServer("Admin", str);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET warn=%d WHERE reg_id=%d", warn+1, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

CMD:ojail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
		return Usage(playerid, "/ojail <name> <time in minutes)> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");
	if(datez < 1 || datez > 60)
	{
 		if(pData[playerid][pAdmin] < 5)
   		{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
  			return 1;
   		}
	}
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /jail on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, player, tmp, datez);
	return 1;
}

function OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToJail);
	}
	else
	{
	    new RegID, JailMinutes = jailTime * 60;
		cache_get_value_index_int(0, 0, RegID);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah menjail(offline) player %s selama %d menit. [Reason: %s]", pData[adminid][pAdminname], NameToJail, jailTime, jailReason);
		new str[150];
		format(str,sizeof(str),"Admin: %s memberi %s jail(offline) selama %d menit. Alasan: %s!", GetRPName(adminid), NameToJail, jailTime, jailReason);
		LogServer("Admin", str);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail=%d WHERE reg_id=%d", JailMinutes, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

CMD:jail(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new reason[60], timeSec, otherid;
	if(sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
	{
	    Usage(playerid, "/jail <ID/Name> <time in minutes> <reason>)");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][pJail] > 0)
	{
	    Servers(playerid, "%s(%i) is already jailed (gets out in %d minutes)", pData[otherid][pName], otherid, pData[otherid][pJailTime]);
	    Info(playerid, "/unjail <ID/Name> to unjail.");
	    return true;
	}
	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}
	if(reason[0] != '*' && strlen(reason) > 60)
	{
	 	Error(playerid, "Reason too long! Must be smaller than 60 characters!");
	   	return true;
	}
	if(timeSec < 1 || timeSec > 60)
	{
	    if(pData[playerid][pAdmin] < 5)
	 	{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
	    	return 1;
	  	}
	}
	pData[otherid][pJail] = 1;
	pData[otherid][pJailTime] = timeSec * 60;
	JailPlayer(otherid);
	if(reason[0] == '*')
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: {ffff00}Admin %s telah menjail player %s selama %d menit.", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
		new str[150];
		format(str,sizeof(str),"Admin: %s memberi %s jail selama %d menit!", GetRPName(playerid), GetRPName(otherid), timeSec);
		LogServer("Admin", str);
	}
	else
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah menjail player %s selama %d menit", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", reason);
		//SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah menjail player %s selama %d menit. {ffff00}[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], timeSec, reason);
		new str[150];
		format(str,sizeof(str),"Admin: %s memberi %s jail selama %d menit. Alasan: %s!", GetRPName(playerid), GetRPName(otherid), timeSec, reason);
		LogServer("Admin", str);
	}
	return 1;
}


CMD:unjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/unjail <ID/Name>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][pJail] == 0)
	    return Error(playerid, "The player isn't in jail!");

	pData[otherid][pJail] = 0;
	pData[otherid][pJailTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPos(otherid, 1529.6,-1691.2,13.3);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah unjailed %s", pData[playerid][pAdminname], pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s merilis %s dari penjara", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	return true;
}

CMD:kick(playerid, params[])
{
    static
        reason[128];

	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "us[128]", otherid, reason))
        return Usage(playerid, "/kick [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

    SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was kicked by admin %s", pData[otherid][pName], pData[playerid][pAdminname], reason);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", reason);
  	new str[150];
	format(str,sizeof(str),"Admin: %s kicked %s Alasan: %s!", GetRPName(playerid), GetRPName(otherid), reason);
	LogServer("Admin", str);
    KickEx(otherid);
    return 1;
}

CMD:ban(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
			return PermissionError(playerid);

	new ban_time, datez, tmp[60], otherid;
	if(sscanf(params, "uds[60]", otherid, datez, tmp))
	{
	    Usage(playerid, "/tempban <ID/Name> <time (in days) 0 for permanent> <reason> ");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
 	if(datez < 0) Error(playerid, "Please input a valid ban time.");
	if(pData[playerid][pAdmin] < 2)
	{
		if(datez > 10 || datez <= 0) return Error(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
	}
	/*if(otherid == playerid)
	    return Error(playerid, "You are not able to ban yourself!");*/
	if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
	{
		Servers(otherid, "** %s(%i) has just tried to ban you!", pData[playerid][pName], playerid);
 		Error(playerid, "You are not able to ban a admin with a higher level than you!");
 		return true;
   	}
	new PlayerIP[16], giveplayer[24];
	
   	//SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	if(datez != 0)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah membanned player %s selama %dhari", pData[playerid][pAdminname], giveplayer, datez);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", tmp);
		new str[150];
		format(str,sizeof(str),"Admin: %s banned %s selama %d hari Alasan: %s!", GetRPName(playerid), GetRPName(otherid), datez, tmp);
		LogServer("Admin", str);
	}
	else
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned permanent player %s. {ffff00}[Reason: %s]", pData[playerid][pAdminname], giveplayer, tmp);
		new str[150];
		format(str,sizeof(str),"Admin: %s banned permanen %s Alasan: %s!", GetRPName(playerid), GetRPName(otherid), tmp);
		LogServer("Admin", str);
	}
	//SetPlayerPosition(otherid, 227.46, 110.0, 999.02, 360.0000, 10);
	BanPlayerMSG(otherid, playerid, tmp);
 	if(datez != 0)
    {
		Servers(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		Servers(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contack admin for unbanned!.", datez);
		ban_time = datez;
	}
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", giveplayer, PlayerIP, pData[playerid][pAdminname], tmp, gettime(), ban_time);
	mysql_tquery(g_SQL, query);
	KickEx(otherid);
	return true;
}

CMD:banucp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
			return PermissionError(playerid);

	new ban_time, datez, tmp[60], otherid;
	if(sscanf(params, "uds[60]", otherid, datez, tmp))
	{
	    Usage(playerid, "/banucp <ID/UCPName> <time (in days) 0 for permanent> <reason> ");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
 	if(datez < 0) Error(playerid, "Please input a valid ban time.");
	if(pData[playerid][pAdmin] < 2)
	{
		if(datez > 10 || datez <= 0) return Error(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
	}
	/*if(otherid == playerid)
	    return Error(playerid, "You are not able to ban yourself!");*/
	if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
	{
		Servers(otherid, "** %s(%i) has just tried to ban you!", pData[playerid][pName], playerid);
 		Error(playerid, "You are not able to ban a admin with a higher level than you!");
 		return true;
   	}
	new PlayerIP[16];
	
   	//SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	if(datez != 0)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned player %s selama %d hari. {ffff00}[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pUCP], datez, tmp);
		new str[150];
		format(str,sizeof(str),"Admin: %s banned ucp %s selama %d hari Alasan: %s!", GetRPName(playerid), pData[otherid][pUCP], datez, tmp);
		LogServer("Admin", str);
	}
	else
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned permanent player %s. {ffff00}[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pUCP], tmp);
		new str[150];
		format(str,sizeof(str),"Admin: %s banned ucp permanen %s Alasan: %s!", GetRPName(playerid), pData[otherid][pUCP], tmp);
		LogServer("Admin", str);
	}
	//SetPlayerPosition(otherid, 227.46, 110.0, 999.02, 360.0000, 10);
	BanPlayerMSG(otherid, playerid, tmp);
 	if(datez != 0)
    {
		Servers(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		Servers(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contack admin for unbanned!.", datez);
		ban_time = datez;
	}
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", pData[otherid][pUCP], PlayerIP, pData[playerid][pAdminname], tmp, gettime(), ban_time);
	mysql_tquery(g_SQL, query);
	KickEx(otherid);
	return true;
}

CMD:unban(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 2)
			return PermissionError(playerid);
	
	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/unban <ban name>");
	    return true;
	}
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT name,ip FROM banneds WHERE name = '%e'", tmp);
	mysql_tquery(g_SQL, query, "OnUnbanQueryData", "is", playerid, tmp);
	return 1;
}

function OnUnbanQueryData(adminid, BannedName[])
{
	if(cache_num_rows() > 0)
	{
		new banIP[16], query[128];
		cache_get_value_name(0, "ip", banIP);
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE ip = '%s'", banIP);
		mysql_tquery(g_SQL, query);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: %s(%i) has unbanned %s from the server.", pData[adminid][pAdminname], adminid, BannedName);
		new str[150];
		format(str,sizeof(str),"Admin: %s unban %s dari server!", GetRPName(adminid), BannedName);
		LogServer("Admin", str);
	}
	else
	{
		Error(adminid, "No player named '%s' found on the ban list.", BannedName);
	}
	return 1;
}

CMD:unbanucp(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 2)
			return PermissionError(playerid);
	
	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/unbanucp <ucp name>");
	    return true;
	}
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT name FROM banneds WHERE name = '%e'", tmp);
	mysql_tquery(g_SQL, query, "UnbanUCP", "is", playerid, tmp);
	return 1;
}

function UnbanUCP(adminid, BannedName[])
{
	if(cache_num_rows() > 0)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE name = '%s'", BannedName);
		mysql_tquery(g_SQL, query);

		SendStaffMessage(COLOR_LIGHTRED, "Server: %s(%i) has unbanned %s from the server.", pData[adminid][pAdminname], adminid, BannedName);
		new str[150];
		format(str,sizeof(str),"Admin: %s unban ucp %s dari server!", GetRPName(adminid), BannedName);
		LogServer("Admin", str);
	}
	else
	{
		Error(adminid, "No player named '%s' found on the ban list.", BannedName);
	}
	return 1;
}

CMD:warn(playerid, params[])
{
    static
        reason[32];

    if(pData[playerid][pAdmin] < 2)
        if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "us[32]", otherid, reason))
        return Usage(playerid, "/warn [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

	pData[otherid][pWarn]++;
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s telah memberikan warning kepada player %s. [Reason: %s] [Total Warning: %d/20]", pData[playerid][pAdminname], pData[otherid][pName], reason, pData[otherid][pWarn]);
    return 1;
}

CMD:unwarn(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unwarn [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[otherid][pWarn] -= 1;
    Servers(playerid, "You have unwarned 1 point %s's warnings.", pData[otherid][pName]);
	Servers(otherid, "%s has unwarned 1 point your warnings.", pData[playerid][pAdminname]);
    SendStaffMessage(COLOR_LIGHTRED, "Admin %s has unwarned 1 point to %s's warnings.", pData[playerid][pAdminname], pData[otherid][pName]);
    new str[150];
	format(str,sizeof(str),"Admin: %s unwarn %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	return 1;
}

CMD:facdespawn(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	new vehicleid = GetPlayerVehicleID(playerid);
	if(GovVeh{vehicleid})
	{
		DestroyVehicle(vehicleid);
		return GovVeh{vehicleid} = false;
	}

	if(PolisiVeh{vehicleid})
	{
		DestroyVehicle(vehicleid);
		return PolisiVeh{vehicleid} = false;
	}

	if(SamdVeh{vehicleid})
	{
		DestroyVehicle(vehicleid);
		return SamdVeh{vehicleid} = false;
	}

	for(new x;x<sizeof(SANAVehicles);x++)
	{
		if(IsVehicleEmpty(SANAVehicles[x]))
		{
			SetVehicleToRespawn(SANAVehicles[x]);
			SetValidVehicleHealth(SANAVehicles[x], 2000);
			SetVehicleFuel(SANAVehicles[x], 1000);
			SwitchVehicleDoors(SANAVehicles[x], false);
		}
	}

	foreach(new i : Player)
	{
	    if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
	    {
	        return 1;
		}
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned All Faction vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsapd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	foreach(new i : Player)
	{
		pData[i][pSpawnPD] = 0;
		DestroyVehicle(pData[i][pSpawnPD]);
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned SAPD vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsags(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SAGSVehicles);x++)
	{
		if(IsVehicleEmpty(SAGSVehicles[x]))
		{
			SetVehicleToRespawn(SAGSVehicles[x]);
			SetValidVehicleHealth(SAGSVehicles[x], 2000);
			SetVehicleFuel(SAGSVehicles[x], 1000);
			SwitchVehicleDoors(SAGSVehicles[x], false);
		}
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned SAGS vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsamd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	foreach(new i : Player)
	{
		pData[i][pSpawnMD] = 0;
		DestroyVehicle(pData[i][pSpawnMD]);
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned SAMD vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsana(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SANAVehicles);x++)
	{
		if(IsVehicleEmpty(SANAVehicles[x]))
		{
			SetVehicleToRespawn(SANAVehicles[x]);
			SetValidVehicleHealth(SANAVehicles[x], 2000);
			SetVehicleFuel(SANAVehicles[x], 1000);
			SwitchVehicleDoors(SANAVehicles[x], false);
		}
	}
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s has respawned SANA vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawndmv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(DmvVeh);x++)
	{
		if(IsVehicleEmpty(DmvVeh[x]))
		{
			SetVehicleToRespawn(DmvVeh[x]);
			SetValidVehicleHealth(DmvVeh[x], 2000);
			SetVehicleFuel(DmvVeh[x], 1000);
			SwitchVehicleDoors(DmvVeh[x], false);
		}
	}
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s has respawned DMV vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnjobs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SweepVeh);x++)
	{
		if(IsVehicleEmpty(SweepVeh[x]))
		{
			SetVehicleToRespawn(SweepVeh[x]);
			SetValidVehicleHealth(SweepVeh[x], 2000);
			SetVehicleFuel(SweepVeh[x], 1000);
			SwitchVehicleDoors(SweepVeh[x], false);
		}
	}
	for(new xx;xx<sizeof(BusVeh);xx++)
	{
		if(IsVehicleEmpty(BusVeh[xx]))
		{
			SetVehicleToRespawn(BusVeh[xx]);
			SetValidVehicleHealth(BusVeh[xx], 2000);
			SetVehicleFuel(BusVeh[xx], 1000);
			SwitchVehicleDoors(BusVeh[xx], false);
		}
	}
	for(new xx;xx<sizeof(CourierVehicle);xx++)
	{
		if(IsVehicleEmpty(CourierVehicle[xx]))
		{
			SetVehicleToRespawn(CourierVehicle[xx]);
			SetValidVehicleHealth(CourierVehicle[xx], 2000);
			SetVehicleFuel(CourierVehicle[xx], 1000);
			SwitchVehicleDoors(CourierVehicle[xx], false);
		}
	}
	for(new xx;xx<sizeof(ForVeh);xx++)
	{
		if(IsVehicleEmpty(ForVeh[xx]))
		{
			SetVehicleToRespawn(ForVeh[xx]);
			SetValidVehicleHealth(ForVeh[xx], 2000);
			SetVehicleFuel(ForVeh[xx], 1000);
			SwitchVehicleDoors(ForVeh[xx], false);
		}
	}
	for(new xx;xx<sizeof(BaggageVeh);xx++)
	{
		if(IsVehicleEmpty(BaggageVeh[xx]))
		{
			SetVehicleToRespawn(BaggageVeh[xx]);
			SetValidVehicleHealth(BaggageVeh[xx], 2000);
			SetVehicleFuel(BaggageVeh[xx], 1000);
			SwitchVehicleDoors(BaggageVeh[xx], false);
		}
	}
	for(new xx;xx<sizeof(MowerVeh);xx++)
	{
		if(IsVehicleEmpty(MowerVeh[xx]))
		{
			SetVehicleToRespawn(MowerVeh[xx]);
			SetValidVehicleHealth(MowerVeh[xx], 2000);
			SetVehicleFuel(MowerVeh[xx], 1000);
			SwitchVehicleDoors(MowerVeh[xx], false);
		}
	}
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s has respawned Jobs vehicles.", pData[playerid][pAdminname]);
	return 1;
}

RespawnNearbyVehicles(playerid, Float:radi)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i=1; i<MAX_VEHICLES; i++)
    {
        if(GetVehicleModel(i))
        {
            new Float:posx, Float:posy, Float:posz;
            new Float:tempposx, Float:tempposy, Float:tempposz;
            GetVehiclePos(i, posx, posy, posz);
            tempposx = (posx - x);
            tempposy = (posy - y);
            tempposz = (posz - z);
            if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
            {
				if(IsVehicleEmpty(i))
				{
					//SetVehicleToRespawn(i);
					SetTimerEx("RespawnPV", 3000, false, "d", i);
					SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: {ffff00}Admin %s telah merespawn kendaraan disekitar dengan radius %d.", pData[playerid][pAdminname], radi);
					SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: {ffff00}Jika kendaraan lumber pribadi anda terkena respawn admin gunakan /v park untuk meload kembali lumber anda!");
				}
			}
        }
    }
}

CMD:respawnrad(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
		
	new rad;
	if(sscanf(params, "d", rad)) return Usage(playerid, "/respawnrad [radius] | respawn vehicle nearest");
	
	if(rad > 50) return Error(playerid, "Maximal 50 radius");
	RespawnNearbyVehicles(playerid, rad);
	return 1;
}

//----------------------------[ Admin Level 2 ]-----------------------
CMD:sethp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethp [playerid id/name] <jumlah>");
	if(jumlah > 100)
		return Error(playerid, "Max 100 Hp!");
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerHealthEx(otherid, jumlah);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah hp player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set hp anda", pData[playerid][pAdminname]);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel hp %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	return 1;
}

CMD:setbone(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setbone [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pHead] = jumlah;
	pData[otherid][pPerut] = jumlah;
	pData[otherid][pLFoot] = jumlah;
	pData[otherid][pRFoot] = jumlah;
	pData[otherid][pLHand] = jumlah;
	pData[otherid][pRHand] = jumlah;
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah Kondisi tulang player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set Kondisi tulang anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setam(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setam [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(jumlah > 95)
	{
		SetPlayerArmourEx(otherid, 98);
	}
	else
	{
		SetPlayerArmourEx(otherid, jumlah);
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah armor player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set armor anda", pData[playerid][pAdminname]);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel armor %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	return 1;
}

CMD:afuel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
     		return PermissionError(playerid);

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		SetVehicleFuel(GetPlayerVehicleID(playerid), 1000);
		Servers(playerid, "Vehicle Fueled!");
	}
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:afix(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
     		return PermissionError(playerid);
	
    if(IsPlayerInAnyVehicle(playerid)) 
	{
        SetValidVehicleHealth(GetPlayerVehicleID(playerid), 1000);
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        Servers(playerid, "Vehicle Fixed!");
    }
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:afixy(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
     		return PermissionError(playerid);
			
    new targetid;

    if (sscanf(params, "i", targetid))
    {
        SendClientMessage(playerid, -1, "{FFE4C4}USAGE: {FFFFFF}/afix [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Invalid player ID or player is not connected.");
        return 1;
    }

    if (pData[playerid][pAdmin] < 3)
    {
        return PermissionError(playerid);
    }

    if (IsPlayerInAnyVehicle(targetid))
    {
        new vehicleid = GetPlayerVehicleID(targetid);

        SetVehicleHealth(vehicleid, 1000.0);
        RepairVehicle(vehicleid);
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Vehicle Fixed!");
    }
    else
    {
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Target player is not in any vehicle!");
    }
    return 1;
}

CMD:setskin(playerid, params[])
{
    new
        skinid,
		otherid;

    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, skinid))
        return Usage(playerid, "/skin [playerid/PartOfName] [skin id]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(skinid < 0 || skinid > 310)
        return Error(playerid, "Invalid skin ID. Skins range from 0 to 310.");

    SetPlayerSkin(otherid, skinid);
	pData[otherid][pSkin] = skinid;

    Servers(playerid, "You have set %s's skin to ID: %d.", ReturnName(otherid), skinid);
    Servers(otherid, "%s has set your skin to ID: %d.", ReturnName(playerid), skinid);
    return 1;
}

CMD:setcustomskin(playerid, params[])
{
    new
        skinid,
		otherid;

    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, skinid))
        return Usage(playerid, "/setcustomskin [playerid/PartOfName] [skin id], Untuk setbisa sampai 20001 - 20020");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(skinid < 20001 || skinid > 20020)
        return Error(playerid, "Invalid skin ID. Skins range from 0 to 20020.");

    SetPlayerSkin(otherid, skinid);
	pData[otherid][pSkin] = skinid;

    Servers(playerid, "You have set %s's skin to ID: %d.", ReturnName(otherid), skinid);
    Servers(otherid, "%s has set your skin to ID: %d.", ReturnName(playerid), skinid);
    return 1;
}

CMD:akill(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new reason[60], otherid;
	if(sscanf(params, "uS(*)[60]", otherid, reason))
	{
	    Usage(playerid, "/akill <ID/Name> <optional: reason>");
	    return 1;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	SetPlayerHealth(otherid, 0.0);

	if(reason[0] != '*')
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s has killed %s. "GREY_E"[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], reason);
	}
	else
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s has killed %s.", pData[playerid][pAdminname], pData[otherid][pName]);
	}
	return 1;
}

CMD:ann(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

 	if(isnull(params))
    {
	    Usage(playerid, "/announce <msg>");
	    return 1;
	}
	// Check for special trouble-making input
   	if(strfind(params, "~x~", true) != -1)
		return Error(playerid, "~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1)
		return Error(playerid, "The constant key is not allowed in announce.");
	if(strfind(params, "/q", true) != -1)
		return Error(playerid, "You are not allowed to type /q in announcement!");

	// Count tildes (uneven number = faulty input)
	new iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1)
		return Error(playerid, "You either have an extra ~ or one is missing in the announcement!");
	
	new str[512];
	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);
	return true;
}

CMD:settime(playerid, params[])
{
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

	new time, mstr[128];
	if(sscanf(params, "d", time))
	{
		Usage(playerid, "/time <time ID>");
		return true;
	}

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%i) has changed the time to: "YELLOW_E"%d", pData[playerid][pAdminname], playerid, time);

	format(mstr, sizeof(mstr), "~r~Time changed: ~b~%d", time);
	GameTextForAll(mstr, 3000, 5);

	SetWorldTime(time);
	WorldTime = time;
	foreach(new ii : Player)
	{
		SetPlayerTime(ii, time, 0);
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
    new weatherid;

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "d", weatherid))
        return Usage(playerid, "/setweather [weather ID]");

    SetWeather(weatherid);
	WorldWeather = weatherid;
	foreach(new ii : Player)
	{
		SetPlayerWeather(ii, weatherid);
	}
    SetGVarInt("g_Weather", weatherid);
    SendClientMessageToAllEx(COLOR_LIGHTRED,"AdmCMD: %s have changed the weather ID", pData[playerid][pAdminname]);
    Servers(playerid, "You have changed the weather to ID: %d.", weatherid);
    return 1;
}

CMD:gotoco(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new Float: pos[3], int;
	if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return Usage(playerid, "/gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

	Servers(playerid, "Anda telah terteleportasi ke kordinat tersebut.");
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerInterior(playerid, int);
	return 1;
}

CMD:cd(playerid)
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
	if(Count != -1) return Error(playerid, "There is already a countdown in progress, wait for it to end!");

	Count = 6;
	countTimer = SetTimer("pCountDown", 1000, 1);

	foreach(new ii : Player)
	{
		showCD[ii] = 1;
	}
	SendClientMessageToAllEx(COLOR_LIGHTRED, "[SERVER] "LB_E"Admin %s has started a global countdown!", pData[playerid][pAdminname]);
	return 1;
}

//---------------[ Admin Level 3 ]------------
CMD:oban(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
	    return PermissionError(playerid);

	new player[24], datez, reason[50];
	if(sscanf(params, "s[24]D(0)s[50]", player, datez, reason))
	{
	    Usage(playerid, "/oban <ban name> <time in days (0 for permanent ban)> <reason>");
	    Info(playerid, "Will ban a player while he is offline. If time isn't specified it will be a perm ban.");
	    return true;
	}
	if(strlen(reason) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		new PlayerName[24];
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /ban on him.");
	  		return true;
	  	}
	}

	new query[128];

	mysql_format(g_SQL, query, sizeof(query), "SELECT ip FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OnOBanQueryData", "issi", playerid, player, reason, datez);
	return true;
}

CMD:banip(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/banip <IP Address>");
		return true;
	}
	if(strfind(params, "*", true) != -1 && pData[playerid][pAdmin] != 5)
	{
		Error(playerid, "You are not authorized to ban ranges.");
  		return true;
  	}

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%d) IP banned address %s.", pData[playerid][pAdminname], playerid, params);
	new str[150];
	format(str,sizeof(str),"Admin: %s banned IP %s!", GetRPName(playerid), params);
	LogServer("Admin", str);

	new tstr[128];
	format(tstr, sizeof(tstr), "banip %s", params);
	SendRconCommand(tstr);
	return 1;
}

CMD:unbanip(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/unbanip <IP Address>");
		return true;
	}
	new mstr[128];
	format(mstr, sizeof(mstr), "unbanip %s", params);
	SendRconCommand(mstr);
	format(mstr, sizeof(mstr), "reloadbans");
	SendRconCommand(mstr);
	Servers(playerid, "You have unbanned IP address %s.", params);
	new str[150];
	format(str,sizeof(str),"Admin: %s unbanned IP %s!", GetRPName(playerid), params);
	LogServer("Admin", str);
	return 1;
}

CMD:reloadweap(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/reloadweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    SetWeapons(otherid);
    Servers(playerid, "You have reload %s's weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin %s have reload your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:resetweap(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/resetweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    ResetPlayerWeaponsEx(otherid);
    Servers(playerid, "You have reset %s's weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin %s have reset your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:setlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setlevel [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pLevel] = jumlah;
	SetPlayerScore(otherid, jumlah);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah level player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set level anda", pData[playerid][pAdminname]);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level %s ke level %d!", GetRPName(playerid), GetRPName(otherid), jumlah);
	LogServer("Admin", str);
	return 1;
}

CMD:sethbe(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethbe [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pHunger] = jumlah;
	pData[otherid][pEnergy] = jumlah;
	pData[otherid][pSick] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah hbe player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set HBE anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setstres(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setstres [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pBladder] = jumlah;
	pData[otherid][pSick] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah stress player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set Stress anda", pData[playerid][pAdminname]);
	return 1;
}

//----------------------------[ Admin Level 4 ]---------------
CMD:setname(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	new otherid, tmp[20];
	if(sscanf(params, "is[20]", otherid, tmp))
	{
	   	Usage(playerid, "/setname <ID/Name> <newname>");
	    return 1;
	}
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player belum masuk!");
	if(pData[otherid][IsLoggedIn] == false)	return Error(playerid, "That player is not logged in.");
	
	if(strlen(tmp) < 4) return Error(playerid, "New name can't be shorter than 4 characters!");
	if(strlen(tmp) > 20) return Error(playerid, "New name can't be longer than 20 characters!");

	if(!IsValidName(tmp)) return Error(playerid, "Name contains invalid characters, please doublecheck!");
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", tmp);
	mysql_tquery(g_SQL, query, "SetName", "iis", otherid, playerid, tmp);
	return 1;
}


// SetName Callback
function SetName(otherplayer, playerid, nname[])
{
	if(!cache_num_rows())
	{
		new oldname[24], newname[24], query[248], id;
		GetPlayerName(otherplayer, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(otherplayer, "Admin %s telah mengganti nickname anda menjadi (%s)", pData[playerid][pAdminname], nname);
		Info(otherplayer, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah mengganti nickname player %s(%d) menjadi %s", pData[playerid][pAdminname], oldname, otherplayer, nname);
		new str[150];
		format(str,sizeof(str),"Admin: %s mengganti nama %s menjadi %s!", GetRPName(playerid), GetRPName(otherplayer), nname);
		LogServer("Admin", str);
		
		SetPlayerName(otherplayer, nname);
		GetPlayerName(otherplayer, newname, sizeof(newname));
		pData[otherplayer][pName] = newname;
		pData[otherplayer][pID] = id;
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
			}
		}
		foreach(new w : Workshop)
		{
			if(!strcmp(wsData[w][wOwner], oldname, true))
			{
				format(wsData[w][wOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE workshop SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, w);
				mysql_tquery(g_SQL, query);
				Workshop_Refresh(w);
			}
		}
		foreach(new v : Vendings)
		{
			if(!strcmp(VendingData[v][vendingOwner], oldname, true))
			{
				format(VendingData[v][vendingOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vending SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, v);
				mysql_tquery(g_SQL, query);
				Vending_RefreshObject(v);
				Vending_RefreshText(v);	
			}
		}	
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
	}
    return 1;
}

function ChangeName(playerid, nname[])
{
	if(!cache_num_rows())
	{
		if(pData[playerid][pGold] < 500) return Error(playerid, "Not enough gold!");
		pData[playerid][pGold] -= 500;
		
		new oldname[24], newname[24], query[248], id;
		GetPlayerName(playerid, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(playerid, "Anda telah mengganti nickname anda menjadi (%s)", nname);
		Info(playerid, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_LIGHTRED, "Player %s(%d) telah mengganti nickname menjadi %s(%d)", oldname, playerid, nname, playerid);
		
		SetPlayerName(playerid, nname);
		GetPlayerName(playerid, newname, sizeof(newname));
		pData[playerid][pName] = newname;
		pData[playerid][pID] = id;
		
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
			}
		}
		foreach(new w : Workshop)
		{
			if(!strcmp(wsData[w][wOwner], oldname, true))
			{
				format(wsData[w][wOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE workshop SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, w);
				mysql_tquery(g_SQL, query);
				Workshop_Refresh(w);
			}
		}
		foreach(new v : Vendings)
		{
			if(!strcmp(VendingData[v][vendingOwner], oldname, true))
			{
				format(VendingData[v][vendingOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vending SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, v);
				mysql_tquery(g_SQL, query);
				Vending_RefreshObject(v);
				Vending_RefreshText(v);	
			}
		}	
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

function NonRPName(playerid, nname[])
{
	if(!cache_num_rows())
	{		
		new oldname[24], newname[24], query[248], id;
		GetPlayerName(playerid, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(playerid, "Anda telah mengganti nickname anda menjadi (%s)", nname);
		SendStaffMessage(COLOR_LIGHTRED, "Player %s(%d) telah mengganti nickname menjadi %s(%d), Reason: Non RP Name", oldname, playerid, nname, playerid);
		
		SetPlayerName(playerid, nname);
		GetPlayerName(playerid, newname, sizeof(newname));
		pData[playerid][pName] = newname;
		pData[playerid][pID] = id;
		
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
			}
		}
		foreach(new w : Workshop)
		{
			if(!strcmp(wsData[w][wOwner], oldname, true))
			{
				format(wsData[w][wOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE workshop SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, w);
				mysql_tquery(g_SQL, query);
				Workshop_Refresh(w);
			}
		}
		foreach(new v : Vendings)
		{
			if(!strcmp(VendingData[v][vendingOwner], oldname, true))
			{
				format(VendingData[v][vendingOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vending SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, v);
				mysql_tquery(g_SQL, query);
				Vending_RefreshObject(v);
				Vending_RefreshText(v);	
			}
		}	
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

CMD:setvip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new alevel, dayz, otherid, tmp[64];
	if(sscanf(params, "udd", otherid, alevel, dayz))
	{
	    Usage(playerid, "/setvip <ID/Name> <level 0 - 3> <time (in days) 0 for permanent>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 3)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	if(dayz < 0)
		return Error(playerid, "Time can't be lower than 0!");
		
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	
	if(pData[playerid][pAdmin] < 5 && dayz > 7)
		return Error(playerid, "Anda hanya bisa menset 1 - 7 hari!");
	
	pData[otherid][pVip] = alevel;
	if(dayz == 0)
	{
		pData[otherid][pVipTime] = 0;
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%d) telah menset VIP kepada %s(%d) ke level %s permanent time!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, GetVipRank(otherid));
		new str[150];
		format(str,sizeof(str),"Admin: %s menyetel VIP ke %s, permanen jenis %s!", GetRPName(playerid), GetRPName(otherid), GetVipRank(otherid));
		LogServer("Admin", str);
	}
	else
	{
		pData[otherid][pVipTime] = gettime() + (dayz * 86400);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%d) telah menset VIP kepada %s(%d) selama %d hari ke level %s!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, dayz, GetVipRank(otherid));
		new str[150];
		format(str,sizeof(str),"Admin: %s menyetel VIP ke %s selama %d hari jenis %s!", GetRPName(playerid), GetRPName(otherid), dayz, GetVipRank(otherid));
		LogServer("Admin", str);
	}
	
	format(tmp, sizeof(tmp), "%d(%d days)", alevel, dayz);
	StaffCommandLog("SETVIP", playerid, otherid, tmp);
	return 1;
}

CMD:giveweap(playerid, params[])
{
    static
        weaponid,
        ammo;
		
	new otherid;
    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "udI(250)", otherid, weaponid, ammo))
        return Usage(playerid, "/givewep [playerid/PartOfName] [weaponid] [ammo]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "You cannot give weapons to disconnected players.");


    if(weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
        return Error(playerid, "You have specified an invalid weapon.");

    if(ammo < 1 || ammo > 500)
        return Error(playerid, "You have specified an invalid weapon ammo, 1 - 500");

    GivePlayerWeaponEx(otherid, weaponid, ammo);
    Servers(playerid, "You have give %s a %s with %d ammo.", pData[otherid][pName], ReturnWeaponName(weaponid), ammo);
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan senjata %s(%d) ke %s!", GetRPName(playerid), ReturnWeaponName(weaponid), ammo, GetRPName(otherid));
	LogServer("Admin", str);
    return 1;
}

CMD:setfaction(playerid, params[])
{
	new fid, rank, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
    	if(pData[playerid][pFactionModerator] < 1)	
        return PermissionError(playerid);

    if(sscanf(params, "udd", otherid, fid, rank))
        return Usage(playerid, "/setfaction [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW, 5.GOCAR] [rank 1-13]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 5)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");
		
	if(rank < 1 || rank > 13)
        return Error(playerid, "You have specified an invalid rank 1 - 12.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed %s's from faction.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your faction.", pData[playerid][pName]);
		new str[150];
		format(str,sizeof(str),"Admin: %s mengeluarkan %s dari fraksi!", GetRPName(playerid), GetRPName(otherid));
		LogServer("Admin", str);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionRank] = rank;
		Servers(playerid, "You have set %s's faction ID %d with rank %d.", pData[otherid][pName], fid, rank);
		Servers(otherid, "%s has set your faction ID to %d with rank %d.", pData[playerid][pName], fid, rank);
		new str[150];
		format(str,sizeof(str),"Admin: %s menyetel faction id %d & rank %d ke %s!", GetRPName(playerid), fid, rank, GetRPName(otherid));
		LogServer("Admin", str);
	}
	
	format(tmp, sizeof(tmp), "%d(%d rank)", fid, rank);
	StaffCommandLog("SETFACTION", playerid, otherid, tmp);
    return 1;
}

CMD:setleader(playerid, params[])
{
	new fid, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pFactionModerator] < 1)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, fid))
        return Usage(playerid, "/setleader [playerid/PartOfName] [0.None, 1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW, 5.GOCAR]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 5)
        return Error(playerid, "You have specified an invalid faction ID 0 - 5.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionLead] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed %s's from faction leader.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your faction leader.", pData[playerid][pName]);
		new str[150];
		format(str,sizeof(str),"Admin: %s mengeluarkan %s dari ketu fraksi!", GetRPName(playerid), GetRPName(otherid));
		LogServer("Admin", str);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionLead] = fid;
		pData[otherid][pFactionRank] = 13;
		Servers(playerid, "You have set %s's faction ID %d with leader.", pData[otherid][pName], fid);
		Servers(otherid, "%s has set your faction ID to %d with leader.", pData[playerid][pName], fid);
		new str[150];
		format(str,sizeof(str),"Admin: %s menyetel ketua faction id %d ke %s!", GetRPName(playerid), fid, GetRPName(otherid));
		LogServer("Admin", str);
	}
	
	format(tmp, sizeof(tmp), "%d", fid);
	StaffCommandLog("SETLEADER", playerid, otherid, tmp);
    return 1;
}

CMD:takemoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new money, otherid;
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/takemoney <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(money > pData[otherid][pMoney])
		return Error(playerid, "Player doesn't have enough money to deduct from!");

	GivePlayerMoneyEx(otherid, -money);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%i) has taken away money "RED_E"%s {ffff00}from %s", pData[playerid][pAdminname], FormatMoney(money), pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s mengambil %s dari %s !", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	return true;
}

CMD:takegold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new gold, otherid;
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/takegold <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(gold > pData[otherid][pGold])
		return Error(playerid, "Player doesn't have enough gold to deduct from!");

	pData[otherid][pGold] -= gold;
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCMD: Admin %s(%i) has taken away gold "RED_E"%d {ffff00}from %s", pData[playerid][pAdminname], gold, pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s mengambil %d Gold dari %s !", GetRPName(playerid), gold, GetRPName(otherid));
	LogServer("Admin", str);
	return 1;
}

CMD:veh(playerid, params[])
{
    static
        model[32],
        color1,
        color2;

    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

    if(sscanf(params, "s[32]I(0)I(0)", model, color1, color2))
        return Usage(playerid, "/veh [model id/name] <color 1> <color 2>");

    if((model[0] = GetVehicleModelByName(model)) == 0)
        return Error(playerid, "Invalid model ID.");

    static
        Float:x,
        Float:y,
        Float:z,
        Float:a,
        vehicleid;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    vehicleid = CreateVehicle(model[0], x, y, z, a, color1, color2, 600);
	AdminVehicle{vehicleid} = true;

    if(GetPlayerInterior(playerid) != 0)
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

    if(GetPlayerVirtualWorld(playerid) != 0)
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    if(IsABoat(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
        PutPlayerInVehicle(playerid, vehicleid, 0);

    SetVehicleNumberPlate(vehicleid, "STATIC");
    Servers(playerid, "Anda memunculkan %s (%d, %d).", GetVehicleModelName(model[0]), color1, color2);
    return 1;
}

CMD:destroyveh(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

    if(pData[playerid][pAdmin] < 2)
	{
	    return PermissionError(playerid);
	}
	if(AdminVehicle{vehicleid})
	{
	    DestroyVehicle(vehicleid);
	    AdminVehicle{vehicleid} = false;
	    return Servers(playerid, "Kendaraan admin dihancurkan.");
	}

	for(new i = 1; i < MAX_VEHICLES; i ++)
	{
	    if(AdminVehicle{i})
	    {
	        DestroyVehicle(i);
	        AdminVehicle{i} = false;
		}
	}

	SendStaffMessage(COLOR_LIGHTRED, "%s menghancurkan semua kendaraan yang dispawn admin.", pData[playerid][pAdminname]);
	return 1;
}

CMD:agl(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/agl [playerid id/name]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SendStaffMessage(COLOR_LIGHTRED, "%s telah memberi sim kepada player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah memberi sim anda", pData[playerid][pAdminname]);
	return 1;
}
//-----------------------------[ Admin Level 5 ]------------------
CMD:sethelperlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/sethelperlevel <ID/Name> <level 0 - 3>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 3)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pHelper] = alevel;
	Servers(playerid, "You has set helper level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your helper level to %d", pData[otherid][pName], playerid, alevel);
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah menset %s(%d) sebagai staff helper level %s(%d)",  pData[playerid][pAdminname], pData[otherid][pName], otherid, GetStaffRank(playerid), alevel);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level helper %d ke %s!", GetRPName(playerid), alevel, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETHELPERLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:settwittername(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128], string[63];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/settwittername <ID/Name> <Twitter name>");
	    return true;
	}
	
	format(string, sizeof(string), "%s", aname);
	pData[otherid][pRegTwitter] = 1;
	mysql_format(g_SQL, query, sizeof(query), "SELECT twittername FROM players WHERE twittername='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeTwitterName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setadminname(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/setadminname <ID/Name> <admin name>");
	    return true;
	}
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT adminname FROM players WHERE adminname='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeAdminName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");
	
	ResetPlayerMoneyEx(otherid);
	GivePlayerMoneyEx(otherid, money);
	
	Servers(playerid, "Kamu telah mengset uang %s(%d) menjadi %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah mengset uang anda menjadi %s!",pData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givemoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	GivePlayerMoneyEx(otherid, money);
	
	Servers(playerid, "Kamu telah memberikan uang %s(%d) dengan jumlah %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah memberikan uang kepada anda dengan jumlah %s!", pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan uang %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givemoneyall(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money;
	if(sscanf(params, "d", money))
	{
	    Usage(playerid, "/givemoneyall <money>");
	    return true;
	}

	foreach(new pid : Player)
	{
		GivePlayerMoneyEx(pid, money);
		Servers(pid, "Admin %s telah memberikan %s kepada semua player online", pData[playerid][pAdminname], FormatMoney(money));
		new str[150];
		format(str,sizeof(str),"Admin: %s memberikan uang kesemua player sejumlah %s", GetRPName(playerid), FormatMoney(money));
		LogServer("Admin", str);
	}
	
	return 1;
}

CMD:setbankmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setbankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[playerid][pBankMoney] = money;
	
	Servers(playerid, "Kamu telah mengset uang rekening banki %s(%d) menjadi %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah mengset uang rekening bank anda menjadi %s!",pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel uang bank %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givebankmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givebankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[playerid][pBankMoney] += money;
	
	Servers(playerid, "Kamu telah memberikan uang rekening bank %s(%d) dengan jumlah %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah memberikan uang rekening bank kepada anda dengan jumlah %s!", pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan uang bank %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setvw(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setvw [playerid id/name] <virtual world>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerVirtualWorld(otherid, jumlah);
	Servers(otherid, "Admin %s telah men set Virtual World anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setint(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setint [playerid id/name] <interior>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerInterior(otherid, jumlah);
	Servers(otherid, "Admin %s telah men set Interior anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:explode(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	new Float:POS[3], otherid, giveplayer[24];
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/explode <ID/Name>");
		return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	Servers(playerid, "You have exploded %s(%i).", giveplayer, otherid);
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
	return true;
}

//--------------------------[ Admin Level 6 ]-------------------
CMD:setadminlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/setadminlevel <ID/Name> <level 0 - 5>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 6)
		return Error(playerid, "Level can't be higher than 6!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pAdmin] = alevel;
	Servers(playerid, "You has set admin level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your admin level to %d", pData[otherid][pName], playerid, alevel);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level admin %d ke %s!", GetRPName(playerid), alevel, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setfounder(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new otherid, tmp[64];
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/setadminlevel <ID/Name>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pAdmin] = 7;
	Servers(playerid, "You has set admin level %s(%d) to Founder", pData[otherid][pName], otherid);
	Servers(otherid, "%s(%d) has set your admin to Founder", pData[otherid][pName], playerid);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level admin %d ke %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "7");
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setgold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/setgold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pGold] = gold;
	
	Servers(playerid, "Kamu telah menset gold %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin %s telah menset gold kepada anda dengan jumlah %d!", pData[playerid][pAdminname], gold);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel %d Gold ke %s!", GetRPName(playerid), gold, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("SETGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:givegold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/givegold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pGold] += gold;
	
	Servers(playerid, "Kamu telah memberikan gold %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin %s telah memberikan gold kepada anda dengan jumlah %d!", pData[playerid][pAdminname], gold);
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan %d Gold ke %s!", GetRPName(playerid), gold, GetRPName(otherid));
	LogServer("Admin", str);

	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("GIVEGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:resetdelays(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

	new otherid, namajob[24];
	if(sscanf(params, "us[24]", otherid, namajob))
        return Usage(playerid, "/check [playerid] [sweeper, courier, bus]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	if(strcmp(namajob,"courier",true) == 0) 
	{
		pData[otherid][pDelayCourier] = 0;
		Info(playerid, "Anda berhasil mereset delay courier %s", pData[otherid][pName]);
		Info(otherid, "Admin %s Telah mereset delays courier Anda", pData[playerid][pAdminname]);
	}
	if(strcmp(namajob,"sweeper",true) == 0) 
	{
		pData[otherid][pSweeperTime] = 0;
		Info(playerid, "Anda berhasil mereset delay sweeper %s", pData[otherid][pName]);
		Info(otherid, "Admin %s Telah mereset delays sweeper Anda", pData[playerid][pAdminname]);
	}
	if(strcmp(namajob,"bus",true) == 0) 
	{
		pData[otherid][pBusTime] = 0;
		Info(playerid, "Anda berhasil mereset delay bus %s", pData[otherid][pName]);
		Info(otherid, "Admin %s Telah mereset delays bus Anda", pData[playerid][pAdminname]);
	}

	
	return 1;
}

CMD:agive(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/agive [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, medicine, snack, sprunk, material, component, marijuana, obat, gps");
			return 1;
		}
			
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			pData[otherid][pBandage] += ammount;
			Info(playerid, "Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan perban kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			pData[otherid][pMedicine] += ammount;
			Info(playerid, "Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan medicine kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			pData[otherid][pSnack] += ammount;
			Info(playerid, "Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan snack kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			pData[otherid][pSprunk] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxmat = pData[otherid][pMaterial] + ammount;
			
			if(maxmat > 500)
				return Error(playerid, "That player already have maximum material!");
			
			pData[otherid][pMaterial] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Material kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = pData[otherid][pComponent] + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");
			
			pData[otherid][pComponent] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Component kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			pData[otherid][pMarijuana] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Marijuana kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Marijuana kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"obat",true) == 0) 
		{	
			pData[otherid][pObat] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Obat kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Obat kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"gps",true) == 0) 
		{
			pData[otherid][pGPS] += ammount;
			Info(playerid, "Anda telah berhasil memberikan GPS kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan GPS kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:setprice(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setprice [name] [price]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [MaterialPrice], [LumberPrice], [ComponentPrice], [MetalPrice], [GasOilPrice], [CoalPrice], [ProductPrice]");
		SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [FoodPrice], [FishPrice], [GsPrice] [ObatPrice] [MedicinePrice] [medkitprice]");
        return 1;
    }
	if(!strcmp(name, "materialprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [materialprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        MaterialPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set material price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "lumberprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [lumberprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        LumberPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set lumber price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "componentprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [componentprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        ComponentPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set component price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "metalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [metalprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        MetalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set metal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "gasoilprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [gasoilprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        GasOilPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set gasoil price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "coalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [coalprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        CoalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set coal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "productprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [productprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        ProductPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set product price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medicineprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [medicineprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        MedicinePrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set medicine price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medkitprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [medkitprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        MedkitPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set medkit price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "foodprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [foodprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        FoodPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set food price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "fishprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [fishprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        FishPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set fish price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "gsprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [gsprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        GStationPrice = price;
		foreach(new gsid : GStation)
		{
			if(Iter_Contains(GStation, gsid))
			{
				GStation_Save(gsid);
				GStation_Refresh(gsid);
			}
		}
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set gs price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
    else if(!strcmp(name, "obatprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [obatprice] [price]");

        if(price < 0 || price > 500)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 500.");

        ObatPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set obat price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	return 1;
}

CMD:setstock(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setstock [name] [stock]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [material] [cratecompo] [component] [product] [gasoil] [food] [obat] [marijuana] [pedagang]");
        return 1;
    }
	if(!strcmp(name, "material", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [material] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Material = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set material to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "cratecompo", true))
	{
		new stok;
		if(sscanf(string, "d", stok))
			return Usage(playerid, "/setstok [createcompo] [stock]");

		if(stok < 0 || stok > 5000) return Error(playerid, "Invalid Value!");

		Product = stok;
		Server_Save();
		SendAdminMessage(COLOR_LIGHTRED, "%s set createcompo to %d.", pData[playerid][pAdminname], stok);
	}
	else if(!strcmp(name, "pedagang", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [pedagang] [stok]");

        if(stok < 0 || stok > 50000)
            return Error(playerid, "You must specify at least 0 or 5000.");

        Pedagang = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set pedagang stok to %d.", pData[playerid][pAdminname], stok);
	}
	else if(!strcmp(name, "component", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [component] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Component = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set component to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "product", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [product] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Product = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set product to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "gasoil", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [gasoil] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GasOil = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set gasoil to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "apotek", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [apotek] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Apotek = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set apotek stok to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "food", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [food] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Food = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set food stok to %d.", pData[playerid][pAdminname], stok);
    }
    else if(!strcmp(name, "obat", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [obat] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ObatMyr = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set obat stok to %d.", pData[playerid][pAdminname], stok);
    }
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel %s jumlah %d!", GetRPName(playerid), name, string);
	LogServer("Admin", str);
	return 1;
}

CMD:setpassword(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new cname[21], query[128], pass[65], tmp[64];
	if(sscanf(params, "s[21]s[20]", cname, pass))
	{
	    Usage(playerid, "/setpassword <name> <new password>");
	    Info(playerid, "Make sure you enter the players name and not ID!");
	   	return 1;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT password FROM playerucp WHERE ucp='%s'", cname);
	mysql_tquery(g_SQL, query, "ChangePlayerPassword", "iss", playerid, cname, pass);
	
	format(tmp, sizeof(tmp), "%s", pass);
	StaffCommandLog("SETPASSWORD", playerid, INVALID_PLAYER_ID, tmp);
	return 1;
}

// SetPassword Callback
function ChangePlayerPassword(admin, cPlayer[], newpass[])
{
	if(cache_num_rows() > 0)
	{
		new query[512], pass[65], salt[16];
		Servers(admin, "Password for %s has been set to \"%s\"", cPlayer, newpass);
		
		for (new i = 0; i < 16; i++) salt[i] = random(94) + 33;
		SHA256_PassHash(newpass, salt, pass, 65);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE playerucp SET password='%s', salt='%e' WHERE ucp='%s'", pass, salt, cPlayer);
		mysql_tquery(g_SQL, query);
	}
	else
	{
	    // Name Exists
		Error(admin, "The name"DARK_E"'%s' "WHITE_E"doesn't exist in the database!", cPlayer);
	}
    return 1;
}


CMD:playsong(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp);
			Servers(ii, "/stopsong, /togsong");
		}
	}
	return 1;
}

CMD:playnearsong(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playnearsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp, x, y, z, 35.0, 1);
			Servers(ii, "/stopsong, /togsong");
		}
	}
	return 1;
}

CMD:stopsong(playerid)
{
	StopAudioStreamForPlayer(playerid);
	Servers(playerid, "Song stop!");
	return 1;
}

CMD:anticheat(playerid, params[])
{
	new status;

	if(pData[playerid][pAdmin] < 5)
	{
	    return Error(playerid, "Kamu tidak diizinkan untuk menggunakan command ini.");
	}
	if(sscanf(params, "i", status) || !(0 <= status <= 1))
	{
	    return Usage(playerid, "/anticheat [0/1]");
	}

	if(status) {
		SendAdminMessage(COLOR_LIGHTRED, "[ANTICHEAT]:"WHITE_E" %s telah mengaktifkan anticheat server .", ReturnName(playerid));
	} else {
		SendAdminMessage(COLOR_LIGHTRED, "[ANTICHEAT]:"WHITE_E" %s telah menonaktifkan anticheat server .", ReturnName(playerid));
	}

	AntiCheatKontol = status;
	return 1;
}

CMD:setstat(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], query[248], param[32], ammount, otherid;
        if(sscanf(params, "us[24]S()[32]", otherid, name, param))
		{
			Usage(playerid, "/setstat [playerid] [names]");
			Info(playerid, "Names: Level, LevelUp, Gold, Money, Bank, Health, Armour, Hunger, Energy");
			Info(playerid, "Names: PhoneCredit, Job1, Job2, Fish, Worm, Sprunk, Snack, Seed, Food, Potato");
			Info(playerid, "Names: Wheat, Orange, Bandage, Medkit, Medicine, Marijuana, Component, Material, Stress");
			return 1;
		}
			
		if(!strcmp(name, "level", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [level] [ammount]");
			}

			pData[otherid][pLevel] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Level {FFFF00}%s {ffffff}ke level %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Level{ffffff} kamu ke %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET level = %i WHERE reg_id = %i", pData[otherid][pLevel], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "levelup", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [levelup] [ammount]");
			}

			pData[otherid][pLevelUp] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Poin Level {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Poin Level{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET levelup = %i WHERE reg_id = %i", pData[otherid][pLevelUp], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "gold", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [gold] [ammount]");
			}

			pData[otherid][pGold] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Gold {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Gold{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET gold = %i WHERE reg_id = %i", pData[otherid][pGold], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "money", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [money] [ammount]");
			}

			pData[otherid][pMoney] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Money {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), FormatMoney(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Money{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET money = %i WHERE reg_id = %i", pData[otherid][pMoney], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "bank", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [bank] [ammount]");
			}

			pData[otherid][pBankMoney] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bank Money {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), FormatMoney(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bank Money{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney = %i WHERE reg_id = %i", pData[otherid][pBankMoney], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "phonecredit", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [phonecredit] [ammount]");
			}

			pData[otherid][pPhoneCredit] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Phone Credit {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Phone Credit{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET phonecredit = %i WHERE reg_id = %i", pData[otherid][pPhoneCredit], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "health", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [health] [ammount]");
			}

			pData[otherid][pHealth] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Health {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Health{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET health = %i WHERE reg_id = %i", pData[otherid][pHealth], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "armour", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [armour] [ammount]");
			}

			pData[otherid][pArmour] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Armour {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Armour{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET armour = %i WHERE reg_id = %i", pData[otherid][pArmour], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "hunger", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [hunger] [ammount]");
			}

			pData[otherid][pHunger] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Hunger {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Hunger{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET hunger = %i WHERE reg_id = %i", pData[otherid][pHunger], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "stress", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [stress] [ammount]");
			}

			pData[otherid][pBladder] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Stress {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Stress{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET hunger = %i WHERE reg_id = %i", pData[otherid][pHunger], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "energy", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [energy] [ammount]");
			}

			pData[otherid][pEnergy] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Energy {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Energy{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET energy = %i WHERE reg_id = %i", pData[otherid][pEnergy], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "job1", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				Usage(playerid, "/setstat [playerid] [job1] [ammount]");
				Info(playerid, "Names: <1> Taxi, <2> Mechanic, <3> LumberJack, <4> Trucker, <5> Miner");
				Info(playerid, "Names: <6> Production, <7> Farmer, <8> Kurir, <9> Smuggler, <10> Baggage");
				return 1;
			}
			if(!(0 <= ammount <= 10))
			{
				return Error(playerid, "Invalid job.");
			}

			pData[otherid][pJob] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Job {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), GetJobName(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Job{ffffff} kamu menjadi %s.", pData[playerid][pAdminname], GetJobName(ammount));

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET job = %i WHERE reg_id = %i", pData[otherid][pJob], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "job2", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				Usage(playerid, "/setstat [playerid] [job2] [ammount]");
				Info(playerid, "Names: <1> Taxi, <2> Mechanic, <3> LumberJack, <4> Trucker, <5> Miner");
				Info(playerid, "Names: <6> Production, <7> Farmer, <8> Kurir, <9> Smuggler, <10> Baggage");
				return 1;
			}
			if(!(0 <= ammount <= 10))
			{
				return Error(playerid, "Invalid job.");
			}

			pData[otherid][pJob2] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Second Job {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), GetJobName(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Second Job{ffffff} kamu menjadi %s.", pData[playerid][pAdminname], GetJobName(ammount));

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET job2 = %i WHERE reg_id = %i", pData[otherid][pJob2], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "medicine", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [medicine] [ammount]");
			}

			pData[otherid][pMedicine] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medicine {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medicine{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET medicine = %i WHERE reg_id = %i", pData[otherid][pMedicine], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "medkit", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [medkit] [ammount]");
			}

			pData[otherid][pMedkit] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medkit {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medicine{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET Medkit = %i WHERE reg_id = %i", pData[otherid][pMedkit], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "snack", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [snack] [ammount]");
			}

			pData[otherid][pSnack] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Snack {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Snack{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET snack = %i WHERE reg_id = %i", pData[otherid][pSnack], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "sprunk", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [sprunk] [ammount]");
			}

			pData[otherid][pSprunk] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Sprunk {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Sprunk{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET sprunk = %i WHERE reg_id = %i", pData[otherid][pSprunk], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "bandage", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [bandage] [ammount]");
			}

			pData[otherid][pBandage] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bandage {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bandage{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bandage = %i WHERE reg_id = %i", pData[otherid][pBandage], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "material", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [material] [ammount]");
			}

			pData[otherid][pMaterial] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Material {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Material{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET material = %i WHERE reg_id = %i", pData[otherid][pMaterial], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "component", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [component] [ammount]");
			}

			pData[otherid][pComponent] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Component {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Component{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET component = %i WHERE reg_id = %i", pData[otherid][pComponent], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "food", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [food] [ammount]");
			}

			pData[otherid][pFood] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Food {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Food{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET food = %i WHERE reg_id = %i", pData[otherid][pFood], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "seed", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [seed] [ammount]");
			}

			pData[otherid][pSeed] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Seed {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Seed{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET seed = %i WHERE reg_id = %i", pData[otherid][pSeed], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "potato", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [potato] [ammount]");
			}

			pData[otherid][pPotato] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Potato {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Potato{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET potato = %i WHERE reg_id = %i", pData[otherid][pPotato], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "orange", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [orange] [ammount]");
			}

			pData[otherid][pOrange] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Orange {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Orange{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET orange = %i WHERE reg_id = %i", pData[otherid][pOrange], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "wheat", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [wheat] [ammount]");
			}

			pData[otherid][pWheat] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Wheat {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Wheat{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET wheat = %i WHERE reg_id = %i", pData[otherid][pWheat], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "marijuana", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [marijuana] [ammount]");
			}

			pData[otherid][pMarijuana] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Marijuana {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Marijuana{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET marijuana = %i WHERE reg_id = %i", pData[otherid][pMarijuana], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "fish", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [fish] [ammount]");
			}

			pData[otherid][pFish] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Fish {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Fish{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET fish = %i WHERE reg_id = %i", pData[otherid][pFish], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "worm", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [worm] [ammount]");
			}

			pData[otherid][pWorm] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Worm {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Worm{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET worm = %i WHERE reg_id = %i", pData[otherid][pWorm], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "fam", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [fam] [ammount]");
			}

			pData[otherid][pFamily] = ammount;
			pData[otherid][pFamilyRank] = 1;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Family {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Family{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET family = %i, familyrank = %i WHERE reg_id = %i", pData[otherid][pFamily], pData[otherid][pFamilyRank], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else 
		{
			return 1;
		}
	}	
	return 1;
}

CMD:clearallchat(playerid)
{
    if(pData[playerid][pAdmin] < 4)
	    return PermissionError(playerid);

	foreach(new i : Player)
	{
	    ClearAllChat(i);
	}
	SendAdminMessage(COLOR_LIGHTRED, "%s {FFFFFF}telah membersihkan chat box.", pData[playerid][pAdminname]);
	return 1;
}

CMD:checkucp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
			
	new name[24];
	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/checkucp <ucpname>");
 		return 1;
 	}

    new cQuery[600];

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT username FROM players WHERE ucp='%e'", name);
	mysql_tquery(g_SQL, cQuery, "CheckUCP", "is", playerid, name);
	return true;
}

CMD:setadminmoderator(playerid, params[])
{
	new otherid, option[16], status;
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	if(sscanf(params, "us[16]i", otherid, option, status) || !(0 <= status <= 1))
	{
	    Usage(playerid, "/setadminmod [playerid] [type] [status (0/1)]");
		Info(playerid, "Type: [1]ServerMod, [2]EventMod, [3]FactionMod, [4]FamilyMod");
		return 1;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	if(pData[otherid][pAdmin] < 1)
		return Error(playerid, "Player tersebut bukan team pengurus, set terlebih dahulu!");

	if(!strcmp(option, "1", true))
	{
	    pData[otherid][pServerModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Server", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Server", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Server!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Server", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Server", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Server!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	else if(!strcmp(option, "2", true))
	{
	    pData[otherid][pEventModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Event", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Event", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Event!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Event", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Event", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Event!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	else if(!strcmp(option, "3", true))
	{
	    pData[otherid][pFactionModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Faction", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Faction", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Faction!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Faction", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Faction", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Faction!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	else if(!strcmp(option, "4", true))
	{
	    pData[otherid][pFamilyModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Family", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Family", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Family!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Family", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Family", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Family!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	return 1;
}		

CMD:moderatorhelp(playerid, params[])
{
    new string[2000];
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	if(pData[playerid][pServerModerator])
	{
	    strcat(string, "{ffffff}==========> {ff0000}Server Moderator.\n\n");
		strcat(string, "{87CEFA}[ACTOR]: {ffffff}/createactor, /editactor, /deleteactor, /gotoactor\n");
		strcat(string, "{87CEFA}[ATM]: {ffffff}/createatm, /editatm, /removeatm, /gotoatm\n");
		strcat(string, "{87CEFA}[BUSINESS]: {ffffff}/createbiz, /editbiz, /gotobiz\n");
		strcat(string, "{87CEFA}[DOOR]: {ffffff}/createdoor, /editdoor, /gotodoor\n");
		strcat(string, "{87CEFA}[GARKOT]: {ffffff}/createpark, /setparkpos, /removepark, /gotopark\n");
		strcat(string, "{87CEFA}[GAS STATION]: {ffffff}/creategs, /editgs, /gotogs\n");
		strcat(string, "{87CEFA}[GATE]: {ffffff}/creategate, /gedit, /gotogate\n");
		strcat(string, "{87CEFA}[HOUSE]: {ffffff}/createhouse, /edithouse, /gotohouse\n");
		strcat(string, "{87CEFA}[SPEEDCAM]: {ffffff}/createsc, deletesc, /gotosc, /editsc - Note: Jangan diset dulu\n");
		strcat(string, "{87CEFA}[WORKSHOP]: {ffffff}/createws, /editws, /gotows\n\n");
	}
	if(pData[playerid][pEventModerator])
	{
	    strcat(string, "{ffffff}==========> {ff0000}Event Moderator.\n\n");
	    strcat(string, "{87CEFA}[EVENT]: {ffffff}/tdmhelp, /createtdm, /settdminfo /tdmpos /endtdm /starttdm /locktdm /announceevent\n\n");
	}
	if(pData[playerid][pFactionModerator])
	{
	    strcat(string, "{ffffff}==========> {ff0000}Faction Moderator.\n\n");
	    strcat(string, "{87CEFA}[LOCKER]: {ffffff}/createlocker, /editlocker, /gotolocker, /setleader\n\n");
	}
	if(pData[playerid][pFamilyModerator])
	{	
		strcat(string, "{ffffff}==========> {ff0000}Family Moderator.\n\n");
	    strcat(string, "{87CEFA}[FAMILY]: {ffffff}/fcreate, /fedit, /fdelete, /flist, /famint\n\n");
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "{FF0000}Moderator Commands | Levana Pride Roleplay", string, "Close","");
	return 1;
}

CMD:aclaimpv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new found = 0, otherid;

	if(sscanf(params, "d", otherid)) 
		return Usage(playerid, "/aclaimpv [playerid]");
	if(otherid == INVALID_PLAYER_ID)
		return Error(playerid, "Invalid id");	

	foreach(new i : PVehicles)
	{
		if(pvData[i][cClaim] > 0 && pvData[i][cClaimTime] > 0)
		{
			if(pvData[i][cOwner] == pData[otherid][pID])
			{
				pvData[i][cClaim] = 0;
				pvData[i][cClaimTime] = 0;
				
				OnPlayerVehicleRespawn(i);
				pvData[i][cPosX] = 1290.7111;
				pvData[i][cPosY] = -1243.8767;
				pvData[i][cPosZ] = 13.3901;
				pvData[i][cPosA] = 2.5077;
				SetValidVehicleHealth(pvData[i][cVeh], 1500);
				SetVehiclePos(pvData[i][cVeh], 1290.7111, -1243.8767, 13.3901);
				SetVehicleZAngle(pvData[i][cVeh], 2.5077);
				SetVehicleFuel(pvData[i][cVeh], 1000);
				ValidRepairVehicle(pvData[i][cVeh]);
				found++;
				Info(playerid, "Kamu telah mengclaim kendaraan player %s dengan model %s", ReturnName(otherid), GetVehicleModelName(pvData[i][cModel]));
				Info(otherid, "Kamu telah mengclaim kendaraan dengan model %s di bantu oleh admin %s", GetVehicleModelName(pvData[i][cModel]), pData[playerid][pAdminname]);
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
		Info(playerid, "Kamu berhasil mengclaim %d kendaraan %s!", found, ReturnName(otherid));
		Info(otherid, "Kamu berhasil mengclaim %d kendaraan anda di bantu oleh admin %s!", found, pData[playerid][pAdminname]);
	}
	return 1;
}

CMD:cleardelays(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	pData[playerid][pJobTime] = 0;
	pData[playerid][pSideJobTime] = 0;
	return 1;
}

CMD:god(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

	SetPlayerHealthEx(playerid, 100);
	SetPlayerArmourEx(playerid, 99999999);
	return 1;
}
	
CMD:nonrpname(playerid, params[])
{
	new otherid, string[256];
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/nonrpname <ID/ Name>");
		return true;
	}
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	format(string, sizeof (string), "{ff0000}Nama kamu non rp name!\n{ffffff}Contoh Nama RP: {3BBD44}James_Petterson, Antonio_Whitford, Javier_Valdes.{ffffff}\n\n{ffff00}Silahkan isi nama kamu baru dibawah ini!");
	ShowPlayerDialog(otherid, DIALOG_NONRPNAME, DIALOG_STYLE_INPUT, "{ffff00}Non Roleplay Name", string, "Change", "Cancel");
	return 1; 
}
