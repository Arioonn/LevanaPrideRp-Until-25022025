//291.35, -106.30, 1001.51

CreateArmsPoint()
{
	
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 291.35, -106.30, 1001.51, -1, -1, -1, 50);
	format(strings, sizeof(strings), "{FFFFFF}/creategun untuk membuat senjata\n/createammo untuk membuat peluru");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 291.35, -106.30, 1001.51, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
}

CMD:creategun(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 291.35, -106.30, 1001.51)) return Error(playerid, "Kamu harus diblackmarket!");
	if(pData[playerid][pCS] == 0) return Error(playerid, "Anda belum membuat {FFFF00}Character Story");
	//if(pData[playerid][pFamily] == -1) return Error(playerid, "Kamu bukan anggota Geng/ Family.");
	
	new Dstring[750];
	if(pData[playerid][pFamily] != -1)
	{
		format(Dstring, sizeof(Dstring), "\tAmmo\tMaterial\tMoney\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sSilenced Pistol\t250\t320\t{3BBD44}$2,500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sColt45 9MM\t300\t250\t{3BBD44}$3,500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sShotgun\t200\t300\t{3BBD44}$4,500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sDesert Eagle\t150\t350\t{3BBD44}$5,000\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sAK-47\t500\t500\t{3BBD44}$6,500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sGlock\t200\t500\t{3BBD44}$7,000\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sUZI\t400\t500\t{3BBD44}$6,000\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sMP5\t500\t500\t{3BBD44}$5,500\n", Dstring);

	}
	else if(pData[playerid][pFamily] == -1)
	{
		format(Dstring, sizeof(Dstring), "\tAmmo\tMaterial\tMoney\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sSilenced Pistol\t250\t320\t{3BBD44}$2,500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sColt45 9MM\t300\t250\t{3BBD44}$3,500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sShotgun\t200\t300\t{3BBD44}$4,500\n", Dstring);
	}
	ShowPlayerDialog(playerid, DIALOG_ARMS_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Create Gun", Dstring, "Create", "Cancel");
	return 1;
}

CMD:createammo(playerid, params[])
{
    new weaponid = GetPlayerWeapon(playerid);

    if(!IsPlayerInRangeOfPoint(playerid, 3.5, 291.35, -106.30, 1001.51)) 
        return Error(playerid, "Kamu harus di blackmarket!");
    
    if (weaponid == 0)
    {
        return SendClientMessage(playerid, COLOR_ARWIN, "INFO: {FFFFFF}You are not holding any weapon.");
    }
    
    if (pData[playerid][pMaterial] < 80)
    {
        return SendClientMessage(playerid, COLOR_ARWIN, "INFO: {FFFFFF}Kamu tidak memiliki Material, kamu harus Mempunyai 80 Material");
    }
    
    new ammo = randomex(5, 10);
	GivePlayerWeaponEx(playerid, weaponid, ammo);
    pData[playerid][pMaterial] -= 40;
    Info(playerid, "Kamu berhasil membuat {FFFF00}5 {FFFFFF}Ammo.");
    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

function CreateGun(playerid, gunid, ammo)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pArmsDealerStatus] != 1) return 0;
	if(gunid == 0 || ammo == 0) return 0;
	if(pData[playerid][pActivityTime] >= 100)
	{
		GivePlayerWeaponEx(playerid, gunid, ammo);
		
		Info(playerid, "Kamu telah berhasil membuat senjata ilegal.");
		TogglePlayerControllable(playerid, 1);
		InfoTD_MSG(playerid, 8000, "Weapon Created!");
		KillTimer(pData[playerid][pArmsDealer]);
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		pData[playerid][pEnergy] -= 3;
		return 1;
	}
	else if(pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}
