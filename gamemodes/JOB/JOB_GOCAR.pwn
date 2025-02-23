CreateJoinGocarPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 345.63, -1835.22, 4.01, -1);
	format(strings, sizeof(strings), "DAPUR PEDAGANG\nUse: /lockerbahan Ambil sesuai pesanan pelanggan");
	CreateDynamic3DTextLabel(strings, COLOR_WHITE, 345.63, -1835.22, 4.01, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Taxi

	//pedagang//gocar
	Create3DTextLabel("{ffff00}[PEDAGANG VEH]\n{FFFFFF}Use: {ffff00}/takevehgocar {ffffff}Untuk Mengambil kendaraan\nUse: {ffff00}/inputgocar {ffffff}Untuk Mengembalikan", -1, 340.9970,-1808.8685,4.5301, 10.0, 0, 0);
	CreatePickup(1239, 23, 340.9970,-1808.8685,4.5301, 0);

	CreateDynamicPickup(1239, 23, 341.73, -1842.80, 4.01, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Information]\n{FFFF00}/menu {FFFFFF}- untuk melihat list menu\n{FFFF00}/jualsusu {FFFFFF}-Menjual susu sapi $40/items");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW,341.73, -1842.80, 4.01, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore
}

CMD:menu(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid,10.0,333.9329,-1837.6069,4.2963))
    {
        ShowPlayerDialog(playerid, DIALOG_MENU, DIALOG_STYLE_LIST, "MENU PEDAGANG (beta)","Burger\nMilk","Select","Close");
	}
	return 1;
}

CMD:lockerbahan(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 345.63, -1835.22, 4.01))
	{
		if(pData[playerid][pFaction] == 5)
		{
			ShowPlayerDialog(playerid, DIALOG_TAKEFOOD, DIALOG_STYLE_LIST, "GO FOOD", "Sanck\nSprunk\nNasi Goreng\nMilk", "Take", "Close");
		}
		else
		{
			Error(playerid, "Anda bukan anggota go car");
		}
	}
	else
	{
		Error(playerid, "Anda tidak berada di checkpoint");
	}
}

CMD:takevehgocar(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 340.9970,-1808.8685,4.5301))
	{
		if(pData[playerid][pFaction] == 5)
		{
			ShowPlayerDialog(playerid, DIALOG_LISTVEHGO, DIALOG_STYLE_LIST, "Go Car Vehicles", "Motorcycle\nCar", "Enter", "Close");
		}
		else
		{
			Error(playerid, "Anda bukan anggota go car");
		}
	}
	else
	{
		Error(playerid, "Anda tidak berada di checkpoint");
	}
}
CMD:inputgocar(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 340.9970,-1808.8685,4.5301))
	{
		if(pData[playerid][pFaction] != 5)
	        return Error(playerid, "You must be at GoCar officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(pData[playerid][pSpawnGo]);
		pData[playerid][pSpawnGo] = INVALID_VEHICLE_ID;
		pData[playerid][pSpawnGo] = 0;
    	GameTextForPlayer(playerid, "~w~Gocar Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}

CMD:gofare(playerid, params[])
{
	if(pData[playerid][pFaction] != 5)
        return Error(playerid, "Kamu bukan anggota San Andreas Go Car.");

	if(pData[playerid][pOnDuty] <= 0)
		return Error(playerid, "Kamu harus On duty untuk menjalankan pekerjaan");
		
	new vehicleid = GetPlayerVehicleID(playerid);
	//new modelid = GetVehicleModel(vehicleid);
		
	/*if(modelid != 438 && modelid != 420)
		return Error(playerid, "Anda harus mengendarai transportasi go car");*/
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "Anda bukan driver.");
	
	
	if(pData[playerid][pFare] == 0)
	{
		if(CheckPassengers(vehicleid) != 1) return Error(playerid,"Tidak ada penumpang!");
		GetPlayerPos(playerid, Float:pData[playerid][pFareOldX], Float:pData[playerid][pFareOldY], Float:pData[playerid][pFareOldZ]);
		pData[playerid][pFareTimer] = SetTimerEx("FareUpdate", 1000, true, "ii", playerid, GetVehiclePassenger(vehicleid));
		pData[playerid][pFare] = 1;
		pData[playerid][pTotalFare] = 5;
		new formatted[128];
		format(formatted,128,"%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		Info(playerid, "Anda telah mengaktifkan go car fare, silahkan menuju ke tempat tujuan!");
		//passanger
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		TextDrawSetString(DPvehfare[GetVehiclePassenger(vehicleid)], formatted);
		Info(GetVehiclePassenger(vehicleid), "Go Car fare telah aktif!");
	}
	else
	{
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
		KillTimer(pData[playerid][pFareTimer]);
		Info(playerid, "Anda telah menonaktifkan fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
		//passanger
		Info(GetVehiclePassenger(vehicleid), "fare telah di non aktifkan pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		pData[playerid][pFare] = 0;
		pData[playerid][pTotalFare] = 0;
	}
	return 1;
}


CMD:gocarlist(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 5)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""GREEN_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Member Go Car", lstr, "Close", "");
	return 1;
}

