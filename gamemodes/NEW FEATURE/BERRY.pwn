#define MAX_BERRY 100
#define BERRY_RESPAWN 1800

enum    E_BERRY
{
	// loaded from db
	Float: berryX,
	Float: berryY,
	Float: berryZ,
	Float: berryRX,
	Float: berryRY,
	Float: berryRZ,
	// temp
	berryActivity,
	berrySeconds,
	bool: berryGettingHarvest,
	berryObjID,
	Text3D: berryLabel,
	berryTimer
}

new BerryData[MAX_BERRY][E_BERRY],
	Iterator:Berrys<MAX_BERRY>;
	
GetClosestBerry(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Berrys)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, BerryData[i][berryX], BerryData[i][berryY], BerryData[i][berryZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

function RespawnBerry(id)
{
	new label[96];
	if(BerryData[id][berrySeconds] > 1)
	{
	    BerryData[id][berrySeconds]--;

	    format(label, sizeof(label), "Berry (%d)\n{FFFFFF}%s", id, ConvertToMinutes(BerryData[id][berrySeconds]));
		UpdateDynamic3DTextLabelText(BerryData[id][berryLabel], COLOR_GREEN, label);
	}
	else if(BerryData[id][berrySeconds] == 1)
	{
	    KillTimer(BerryData[id][berryTimer]);

	    BerryData[id][berryActivity] = 0;
	    BerryData[id][berrySeconds] = 0;
	    BerryData[id][berryTimer] = -1;

	    SetDynamicObjectPos(BerryData[id][berryObjID], BerryData[id][berryX], BerryData[id][berryY], BerryData[id][berryZ]);
     	SetDynamicObjectRot(BerryData[id][berryObjID], BerryData[id][berryRX], BerryData[id][berryRY], BerryData[id][berryRZ]);

     	format(label, sizeof(label), "Berry (%d)\n", id);
     	UpdateDynamic3DTextLabelText(BerryData[id][berryLabel], COLOR_GREEN, label);
	}
	return 1;
}

function LoadBerry()
{
    new tid;

	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", tid);
			cache_get_value_name_float(i, "posx", BerryData[tid][berryX]);
			cache_get_value_name_float(i, "posy", BerryData[tid][berryY]);
			cache_get_value_name_float(i, "posz", BerryData[tid][berryZ]);
			cache_get_value_name_float(i, "posrx", BerryData[tid][berryRX]);
			cache_get_value_name_float(i, "posry", BerryData[tid][berryRY]);
			cache_get_value_name_float(i, "posrz", BerryData[tid][berryRZ]);

			new label[64];
			format(label, sizeof(label), "Berry (%d)\n", tid);
			BerryData[tid][berryLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ] + 1.5, 5.0);
			BerryData[tid][berryObjID] = CreateDynamicObject(14400, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ], BerryData[tid][berryRX], BerryData[tid][berryRY], BerryData[tid][berryRZ]);
			Iter_Add(Berrys, tid);

			BerryData[tid][berryGettingHarvest] = false;
			BerryData[tid][berrySeconds] = 0;
		}
		printf("[Berry] Loaded: %d.", rows);
	}
}

Berry_Save(tid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE berrys SET posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f' WHERE id='%d'",
	BerryData[tid][berryX],
	BerryData[tid][berryY],
	BerryData[tid][berryZ],
	BerryData[tid][berryRX],
	BerryData[tid][berryRY],
	BerryData[tid][berryRZ],
	tid
	);
	return mysql_tquery(g_SQL, cQuery);
}

Berry_Refresh(tid)
{
    if(!Iter_Contains(Berrys, tid)) return 0;
    new label[96];

    if(BerryData[tid][berryActivity] > 0) {
	    format(label, sizeof(label), "Berry (%d)\n"WHITE_E"Berry: "GREEN_E"%d\n"WHITE_E"Use /berry take.", tid, BerryData[tid][berryActivity]);
		UpdateDynamic3DTextLabelText(BerryData[tid][berryLabel], COLOR_GREEN, label);
	}else{
	    BerryData[tid][berryTimer] = SetTimerEx("RespawnBerry", 1000, true, "i", tid);

	    format(label, sizeof(label), "Berry (%d)\n"WHITE_E"%s", tid, ConvertToMinutes(BerryData[tid][berrySeconds]));
		UpdateDynamic3DTextLabelText(BerryData[tid][berryLabel], COLOR_GREEN, label);
	}

	return 1;
}

Berry_BeingEdited(tid)
{
	if(!Iter_Contains(Berrys, tid)) return 0;
	foreach(new i : Player) if(pData[i][EditingBerryID] == tid) return 1;
	return 0;
}

//=====[ Command ]=====
CMD:createberry(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	new tid = Iter_Free(Berrys), query[512];
	if(tid == -1) return Error(playerid, "Can't add any more Berrys.");
 	new Float: x, Float: y, Float: z, Float: a;
 	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, a);
 	x += (3.0 * floatsin(-a, degrees));
	y += (3.0 * floatcos(-a, degrees));
	z -= 1.0;

	BerryData[tid][berryX] = x;
	BerryData[tid][berryY] = y;
	BerryData[tid][berryZ] = z;
	BerryData[tid][berryRX] = BerryData[tid][berryRY] = BerryData[tid][berryRZ] = 0.0;

	new label[96];
	format(label, sizeof(label), "berry (%d)\n", tid);
	BerryData[tid][berryLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ] + 1.5, 5.0);
	BerryData[tid][berryObjID] = CreateDynamicObject(14400, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ], BerryData[tid][berryRX], BerryData[tid][berryRY], BerryData[tid][berryRZ]);
	Iter_Add(Berrys, tid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO berry SET id='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f'", tid, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ], BerryData[tid][berryRX], BerryData[tid][berryRY], BerryData[tid][berryRZ]);
	mysql_tquery(g_SQL, query, "OnBerryCreated", "di", playerid, tid);
	return 1;
}

function OnBerryCreated(playerid, tid)
{
	Berry_Save(tid);

	pData[playerid][EditingBerryID] = tid;
	EditDynamicObject(playerid, BerryData[tid][berryObjID]);
	Servers(playerid, "Berry created.");
	Servers(playerid, "You can edit it right now, or cancel editing and edit it some other time.");
	return 1;
}

CMD:editberry(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
    if(pData[playerid][EditingBerryID] != -1) return Error(playerid, "You're already editing a berry.");
	new tid;
	if(sscanf(params, "i", tid)) return Usage(playerid, "/editberry [berry id]");
	if(!Iter_Contains(Berrys, tid)) return Error(playerid, "Invalid ID.");
	if(BerryData[tid][berryGettingHarvest]) return Error(playerid, "Can't edit specified berry because its getting cut down.");
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ])) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the berry you want to edit.");
	pData[playerid][EditingBerryID] = tid;
	EditDynamicObject(playerid, BerryData[tid][berryObjID]);
	return 1;
}

CMD:removeberry(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new tid, query[512];
	if(sscanf(params, "i", tid)) return Usage(playerid, "/removeberry [berry id]");
	if(!Iter_Contains(Berrys, tid)) return Error(playerid, "Invalid ID.");
	if(BerryData[tid][berryGettingHarvest]) return Error(playerid, "Can't remove specified berry because its getting harvest down.");
	if(Berry_BeingEdited(tid)) return Error(playerid, "Can't remove specified berry because its being edited.");
	DestroyDynamicObject(BerryData[tid][berryObjID]);
	DestroyDynamic3DTextLabel(BerryData[tid][berryLabel]);
	if(BerryData[tid][berryTimer] != -1) KillTimer(BerryData[tid][berryTimer]);

	BerryData[tid][berryActivity] = BerryData[tid][berrySeconds] = 0;
	BerryData[tid][berryObjID] = BerryData[tid][berryTimer] = -1;
	BerryData[tid][berryLabel] = Text3D: -1;
	Iter_Remove(Berrys, tid);

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM berry WHERE id=%d", tid);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "Berry removed.");
	return 1;
}

CMD:gotoberry(playerid, params[])
{
	new tid;
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

	if(sscanf(params, "d", tid))
		return Usage(playerid, "/gotoberry [id]");
	if(!Iter_Contains(Berrys, tid)) return Error(playerid, "The berry you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, BerryData[tid][berryX], BerryData[tid][berryY], BerryData[tid][berryZ], 2.0);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInDoor] = -1;
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	Servers(playerid, "You has teleport to berry id %d", tid);
	return 1;
}

CMD:berry(playerid, params[])
{
    if(pData[playerid][pJob] == 7 || pData[playerid][pJob2] == 7)
	{
		if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
		if(isnull(params)) return Usage(playerid, "/berry [pickup/take/sell]");

		if(!strcmp(params, "pickup", true))
		{
		    new tid = GetClosestBerry(playerid);
			if(tid != -1)
			{
				// Pastikan pemain tidak sedang memanen berry lain
				if(pData[playerid][HarvestBerryID] != -1)
					return Error(playerid, "Anda sedang memanen berry lain.");

				// Pastikan berry siap dipanen (tidak sedang diambil orang lain dan timer respawn telah habis)
				if(!Berry_BeingEdited(tid) && !BerryData[tid][berryGettingHarvest] && BerryData[tid][berrySeconds] < 1)
				{
					SetPlayerLookAt(playerid, BerryData[tid][berryX], BerryData[tid][berryY]);
					if(GetPlayerWeapon(playerid) != WEAPON_KNIFE) return Error(playerid, "Anda harus memegang pisau!");

					Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[tid][berryLabel], E_STREAMER_COLOR, 0xE74C3CFF);
					pData[playerid][pActivity] = SetTimerEx("HarvestBerry", 1000, true, "i", playerid);
					pData[playerid][HarvestBerryID] = tid;
					PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Panen...");
					PlayerTextDrawShow(playerid, ActiveTD[playerid]);
					ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					TogglePlayerControllable(playerid, 1);
					SetPlayerArmedWeapon(playerid, WEAPON_KNIFE);
					ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop", 4.1, 1, 0, 0, 1, 0, 1);

					BerryData[tid][berryGettingHarvest] = true;
				}
				else
				{
					return Error(playerid, "Berry ini belum siap untuk dipanen.");
				}
			}
			else
			{
				return Error(playerid, "ID berry tidak valid");
			}
		}
		else if(!strcmp(params, "take", true))
		{
			// Ambil ID berry terdekat
			new tid = GetClosestBerry(playerid);
			if(tid == -1)
				return Error(playerid, "Anda tidak berada di dekat berry.");

			// Pastikan berry sudah siap untuk diambil
			if(BerryData[tid][berrySeconds] < 1)
				return Error(playerid, "Berry ini belum siap untuk diambil.");
			if(BerryData[tid][berryActivity] < 1)
				return Error(playerid, "Berry ini tidak memiliki buah.");

			// Simpan ID berry yang diambil agar bisa diakses di animasi
			pData[playerid][HarvestBerryID] = tid;

			// Kurangi jumlah berry di pohon dan refresh data berry
			BerryData[tid][berryActivity]--;
			Berry_Refresh(tid);

			// Tambahkan satu buah berry ke inventory pemain dan beri informasi
			pData[playerid][pBerry] += 1;
			Info(playerid, "Anda mengambil satu buah berry dari panen.");

			// Setelah take, reset HarvestBerryID agar bisa melakukan pickup di berry lainnya
			pData[playerid][HarvestBerryID] = -1;
		}
		else if(!strcmp(params, "sell"))
		{
			// Pastikan pemain berada dalam jarak yang tepat dari gudang farmers
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, -381.44, -1426.13, 25.93))
				return Error(playerid, "Anda tidak berada di dekat gudang farmers.");

			// Pastikan pemain memiliki setidaknya satu berry di inventory
			if(pData[playerid][pBerry] < 1)
				return Error(playerid, "Anda tidak memiliki berry di inventory Anda.");

			// Kurangi satu buah berry dari inventory dan beri uang kepada pemain
			pData[playerid][pBerry] -= 1;
			GivePlayerMoneyEx(playerid, 20);
			Server_MinMoney(500);
			Info(playerid, "Anda menjual satu buah berry seharga $20.");
		}
	}
    else
    {
        return Error(playerid, "Anda bukan pekerja farmers!");
    }
	return 1;
}

function HarvestBerry(playerid)
{
    if(pData[playerid][HarvestBerryID] != -1)
	{
		new tid = pData[playerid][HarvestBerryID];

		if(pData[playerid][pActivityTime] >= 100)
		{
			BerryData[tid][berryActivity] = 5;
			BerryData[tid][berrySeconds] = BERRY_RESPAWN;
			Player_ResetCutting(playerid);
			Berry_Refresh(tid);

			InfoTD_MSG(playerid, 8000, "Harvest berry done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 5;
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, 0);
			//TogglePlayerControllable(playerid, 1);
			Streamer_Update(playerid);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}

	return 1;
}
