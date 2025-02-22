DynamicSusuSapi()
{
    new strings[555];
    //sapi
	format(strings, sizeof(strings), "/ambilsusu {FFFFFF}- Untuk memeras Susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -568.1038,-1490.6731,9.8217, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "/ambilsusu {FFFFFF}- Untuk memeras Susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -572.3114,-1491.6060,9.9639, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "/ambilsusu {FFFFFF}- Untuk memeras Susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -572.3418,-1494.3867,9.7904, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "/ambilsusu {FFFFFF}- Untuk memeras Susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -575.3952,-1494.4244,9.9338, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "/ambilsusu {FFFFFF}- Untuk memeras Susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -575.8989,-1491.1851,10.1618, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    format(strings, sizeof(strings), "/olahsusu {FFFFFF}- Untuk mengolah Susu sapi");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -585.4072,-1502.9233,10.0476, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    
}

CMD:olahsusu(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -585.4072,-1502.9233,10.0476))
        return Error(playerid, "Anda tidak berada di Tempat Pengolahan Susu Sapi");

    if(pData[playerid][pSusu] < 3)
        return Error(playerid, "Anda harus mempunyai 3 Susu sapi");

    if(pData[playerid][pProgress] == 1)
        return Error(playerid, "Anda tidak bisa Melakukan Ini");

	if(pData[playerid][pSusuolah] > 20)
		return Error(playerid, "Jumlah susu olah di Inventory kamu penuh Harap jual terlebih dahulu.");

    TogglePlayerControllable(playerid, 0);
    pData[playerid][pProgress] = 1;
	pData[playerid][pSapiTimer] = SetTimerEx("SelesaiOlahSusu", 1000, true, "i", playerid);
	PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengolah...");
	PlayerTextDrawShow(playerid, ActiveTD[playerid]);
	ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, true, 0, 0, 0, 0, 1);
    return 1;
}

CMD:ambilsusu(playerid, params[])
{
    if(pData[playerid][pProgress] == 1)
        return Error(playerid, "Anda tidak bisa Melakukan Ini");

	if(pData[playerid][pSusu] > 40)
		return Error(playerid, "Jumlah susu di inventory kamu Sudah penuh Harap olah terlebih dahalu.");

    if(IsPlayerInRangeOfPoint(playerid, 1.0, -568.1038,-1490.6731,9.8217) || IsPlayerInRangeOfPoint(playerid, 1.0, -572.3114,-1491.6060,9.9639) || IsPlayerInRangeOfPoint(playerid, 1.0, -572.3418,-1494.3867,9.7904) || IsPlayerInRangeOfPoint(playerid, 1.0, -575.3952,-1494.4244,9.9338) || IsPlayerInRangeOfPoint(playerid, 1.0, -575.8989,-1491.1851,10.1618))
    {
        TogglePlayerControllable(playerid, 0);
        pData[playerid][pProgress] = 1;
        pData[playerid][pSapiTimer] = SetTimerEx("SelesaiAmbilSusu", 1000, true, "i", playerid);
        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Memeras...");
        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0, true, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:jualsusu(playerid, params[])
{
	if(pData[playerid][pSusuolah] < 1) return Error(playerid, "Kamu tidak mempunyai Susu Olahan!");
	new pay = pData[playerid][pSusuolah] * 40;
	new total = pData[playerid][pSusuolah];
	GivePlayerMoneyEx(playerid, pay);
	Server_AddMoney(pay);

	Info(playerid, "Kamu menjual "YELLOW_E"%d "WHITE_E"Susu olahan Dan mendapat "GREEN_E"%s", total, FormatMoney(pay));
    InfoTD_MSG(playerid, 4000, "Terjual");
	pData[playerid][pSusuolah] = 0;
	return 1;
}
function SelesaiAmbilSusu(playerid)
{
    if(pData[playerid][pActivityTime] >= 100)
	{
        new rand = randomex(1, 3);
		TogglePlayerControllable(playerid, 1);
		InfoTD_MSG(playerid, 3000, "Berhasil!");
		KillTimer(pData[playerid][pSapiTimer]);
		pData[playerid][pActivityTime] = 0;
		Info(playerid, "Anda berhasil memeras susu Mendapat %d", rand);
        ClearAnimations(playerid);
        pData[playerid][pProgress] = 0;
        pData[playerid][pSusu] += rand;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	}
	else if(pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 15;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	}
}

function SelesaiOlahSusu(playerid)
{
    if(pData[playerid][pActivityTime] >= 100)
	{
		TogglePlayerControllable(playerid, 1);
		InfoTD_MSG(playerid, 3000, "Berhasil!");
		KillTimer(pData[playerid][pSapiTimer]);
		pData[playerid][pActivityTime] = 0;
		Info(playerid, "Anda berhasil mengolah Mendapat 1 Susu Olah");
        ClearAnimations(playerid);
        pData[playerid][pProgress] = 0;
		pData[playerid][pSusu] -= 3;
        pData[playerid][pSusuolah] += 1;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	}
	else if(pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 15;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	}
}