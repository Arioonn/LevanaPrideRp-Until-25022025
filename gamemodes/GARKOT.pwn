
#define MAX_PARKPOINT 300

enum    E_PARK
{
	// loaded from db
	Float: parkX,
	Float: parkY,
	Float: parkZ,
	parkInt,
	parkWorld,
	// temp
	parkPickup,
	Text3D: parkLabel,
	parkMap
}

new ppData[MAX_PARKPOINT][E_PARK],
	Iterator:Parks<MAX_PARKPOINT>;

ReturnAnyPark(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_PARKPOINT) return -1;
	foreach(new id : Parks)
	{
		tmpcount++;
		if(tmpcount == slot)
		{
			return id;
		}
	}
	return -1;
}

GetAnyPark()
{
	new tmpcount;
	foreach(new id : Parks)
	{
		tmpcount++;
	}
	return tmpcount;
}

function LoadPark()
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
  	{
 		new id, i = 0, str[1000];
		while(i < rows)
		{
			format(str, sizeof(str), "[ID: %d]\n{ffffff}Location: %s"YELLOW_E"'ALT' "WHITE_E"untuk menyimpan/menggambil kendaraan", id, GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name_float(i, "posx", ppData[id][parkX]);
			cache_get_value_name_float(i, "posy", ppData[id][parkY]);
			cache_get_value_name_float(i, "posz", ppData[id][parkZ]);
			cache_get_value_name_int(i, "interior", ppData[id][parkInt]);
			cache_get_value_name_int(i, "world", ppData[id][parkWorld]);
			ppData[id][parkPickup] = CreateDynamicPickup(19134, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt], -1, 50);
			ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
			ppData[id][parkMap] = CreateDynamicMapIcon(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 55, -1, -1, -1, -1, 100.0);
			Iter_Add(Parks, id);
	    	i++;
		}
		printf("[Garkot]: %d Loaded.", i);
	}
}

Park_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE parks SET posx='%f', posy='%f', posz='%f', interior=%d, world=%d WHERE id=%d",
	ppData[id][parkX],
	ppData[id][parkY],
	ppData[id][parkZ],
	ppData[id][parkInt],
	ppData[id][parkWorld],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}


/* GetNearbyGarkot(playerid)
{
	for(new i = 0; i < MAX_PARKPOINT; i ++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
	    {
	        return i;
	    }
	}
	return -1;
} */

CMD:createpark(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	new id = Iter_Free(Parks), query[512];
	if(id == -1) return Error(playerid, "Can't add any more Park Point.");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
	
	ppData[id][parkX] = x;
	ppData[id][parkY] = y;
	ppData[id][parkZ] = z;
	ppData[id][parkInt] = GetPlayerInterior(playerid);
	ppData[id][parkWorld] = GetPlayerVirtualWorld(playerid);
	
	new str[1000];
	format(str, sizeof(str), "[ID: %d]\n{ffffff}Location: %s"GREY_E"\n"YELLOW_E"'ALT' "WHITE_E"untuk menyimpan/menggambil kendaraan", id, GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
	ppData[id][parkPickup] = CreateDynamicPickup(19134, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt], -1, 50);
	ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
	ppData[id][parkMap] = CreateDynamicMapIcon(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 55, -1, -1, -1, -1, 100.0);
	Iter_Add(Parks, id);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO parks SET id=%d, posx='%f', posy='%f', posz='%f', interior=%d, world=%d", id, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query, "OnParkCreated", "ii", playerid, id);
	return 1;
}

function OnParkCreated(playerid, id)
{
	Park_Save(id);
	Servers(playerid, "You has created Park Point id: %d.", id);
	new str[150];
	format(str,sizeof(str),"[Garkot]: %s membuat garkot id %d!", GetRPName(playerid), id);
	LogServer("Admin", str);	
	return 1;
}

CMD:setparkpos(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);

	new id;
	if(sscanf(params, "i", id)) return Usage(playerid, "/setparkpos [id]");
	if(!Iter_Contains(Parks, id)) return Error(playerid, "Invalid ID.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	ppData[id][parkX] = x;
	ppData[id][parkY] = y;
	ppData[id][parkZ] = z;
	ppData[id][parkInt] = GetPlayerInterior(playerid);
	ppData[id][parkWorld] = GetPlayerVirtualWorld(playerid);

	if(IsValidDynamicPickup(ppData[id][parkPickup]))
		DestroyDynamicPickup(ppData[id][parkPickup]), ppData[id][parkPickup] = -1;

	if(IsValidDynamic3DTextLabel(ppData[id][parkLabel]))
		DestroyDynamic3DTextLabel(ppData[id][parkLabel]), ppData[id][parkLabel] = Text3D: INVALID_3DTEXT_ID;

	if(IsValidDynamicMapIcon(ppData[id][parkMap]))	
		DestroyDynamicMapIcon(ppData[id][parkMap]);

	
	new str[128];
	format(str, sizeof(str), "[ID: %d]\n{ffffff}Location: %s"GREY_E"\n"YELLOW_E"'ALT' "WHITE_E"untuk menyimpan/menggambil kendaraan", id, GetLocation(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ]));
	ppData[id][parkPickup] = CreateDynamicPickup(19134, 23, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], ppData[id][parkWorld],  ppData[id][parkInt], -1, 50);
	ppData[id][parkLabel] = CreateDynamic3DTextLabel(str, ARWIN, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ppData[id][parkWorld], ppData[id][parkInt], -1, 10.0);
	ppData[id][parkMap] = CreateDynamicMapIcon(ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 55, -1, -1, -1, -1, 100.0);
	Park_Save(id);
	return 1;
}

CMD:removepark(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return Usage(playerid, "/removepark [id]");
	if(!Iter_Contains(Parks, id)) return Error(playerid, "Invalid ID.");
	
	DestroyDynamic3DTextLabel(ppData[id][parkLabel]);
	DestroyDynamicPickup(ppData[id][parkPickup]);
	DestroyDynamicMapIcon(ppData[id][parkMap]);
	
	ppData[id][parkX] = ppData[id][parkY] = ppData[id][parkZ] = 0.0;
	ppData[id][parkInt] = ppData[id][parkWorld] = 0;
	ppData[id][parkPickup] = -1;
	ppData[id][parkLabel] = Text3D: -1;
	Iter_Remove(Parks, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM parks WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "Menghapus ID Park Point %d.", id);
	new str[150];
	format(str,sizeof(str),"[Garkot]: %s menghapus garkot id %d!", GetRPName(playerid), id);
	LogServer("Admin", str);	
	return 1;
}

CMD:gotopark(playerid, params[])
{
	new id;
	if(pData[playerid][pAdmin] < 6)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	if(sscanf(params, "d", id))
		return Usage(playerid, "/gotopark [id]");
	if(!Iter_Contains(Parks, id)) return Error(playerid, "Park Point ID tidak ada.");
	
	SetPlayerPosition(playerid, ppData[id][parkX], ppData[id][parkY], ppData[id][parkZ], 2.0);
    SetPlayerInterior(playerid, ppData[id][parkInt]);
    SetPlayerVirtualWorld(playerid, ppData[id][parkWorld]);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInFamily] = -1;	
	Servers(playerid, "Teleport ke ID Park Point %d", id);
	return 1;
}

/*CMD:parkveh(playerid)
{
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
	if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
	if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be in Vehicle");
    
	foreach(new id : Parks)
	if(CountParkedVeh(id) >= 40)
	return Error(playerid, "Garasi Kota sudah memenuhi Kapasitas!");

	new carid = -1,
		found = 0;

	if((carid = Vehicle_Nearest2(playerid)) != -1)
	{
		GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
		GetVehicleZAngle(pvData[carid][cVeh], pvData[carid][cPosA]);
		GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
		PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		InfoTD_MSG(playerid, 4000, "Vehicle ~r~Despawned");
		RemovePlayerFromVehicle(playerid);
		pvData[carid][cPark] = id;					
		SetPlayerArmedWeapon(playerid, 0);
		found++;
		if(IsValidVehicle(pvData[carid][cVeh]))
		{
			DestroyVehicle(pvData[carid][cVeh]);
			pvData[carid][cVeh] = INVALID_VEHICLE_ID;
		}
	}
	if(!found)
		return Error(playerid, "Kendaraan ini tidak dapat di Park!");
	return 1;
}*/

CMD:parkveh(playerid)
{
	new vehid = GetPlayerVehicleID(playerid), count = 0;

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "Kamu harus mengendarai kendaraan");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
	if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");

	foreach(new gkid : Parks)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[gkid][parkX], ppData[gkid][parkY], ppData[gkid][parkZ]))
		{
			count++;
			foreach(new ii : PVehicles)
			{
				if(vehid == pvData[ii][cVeh])
				{
					if(pvData[ii][cOwner] == pData[playerid][pID])
					{
						if(!IsValidVehicle(pvData[ii][cVeh]))
							return Error(playerid, "Your vehicle not Spawned");
						
						RemovePlayerFromVehicle(playerid);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, 0, "i", playerid);
						GetVehiclePos(pvData[ii][cVeh], pvData[ii][cPosX], pvData[ii][cPosY], pvData[ii][cPosZ]);
		                GetVehicleZAngle(pvData[ii][cVeh], pvData[ii][cPosA]);
		                GetVehicleHealth(pvData[ii][cVeh], pvData[ii][cHealth]);
						SetVehicleFuel(pvData[ii][cVeh], pvData[ii][cFuel]);
						//GetVehicleFuel(pvData[ii][cVeh], pvData[ii][cFuel]);
		                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						SetPlayerArmedWeapon(playerid, 0);
						if(IsValidVehicle(vehid))
						{
							if(pvData[ii][cPark] == -1) 
							{
								DestroyVehicle(pvData[ii][cVeh]);
								pvData[ii][cPark] = gkid; 
								pvData[ii][cVeh] = INVALID_VEHICLE_ID;
							}
						}
						InfoTD_MSG(playerid, 4000, "Vehicle ~r~Despawned");
					}
					else return Error(playerid, "Kendaraan ini bukan milikmu");
				}
			}
		}
	}
	if(count < 1)
		return Error(playerid, "Kamu tidak berada Di Dekat Garasi Kota");

	return 1;
}

CMD:pickupveh(playerid)
{
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
	if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be not in Vehicle");
	foreach(new i : Parks)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
		{
			pData[playerid][pPark] = i;
			if(GetAnyVehiclePark(i) <= 0) return Error(playerid, "Tidak ada Kendaraan yang diparkirkan disini.");
			new id, count = GetAnyVehiclePark(i), location[4080], lstr[596];

			strcat(location,"No\tVehicle\tPlate\tOwner\n",sizeof(location));
			Loop(itt, (count + 1), 1)
			{
				id = ReturnAnyVehiclePark(itt, i);
				if(itt == count)
				{
					format(lstr,sizeof(lstr), "%d\t%s\t%s\t%s\n", itt, GetVehicleModelName(pvData[id][cModel]), pvData[id][cPlate], GetVehicleOwnerName(id));
				}
				else format(lstr,sizeof(lstr), "%d\t%s\t%s\t%s\n", itt, GetVehicleModelName(pvData[id][cModel]), pvData[id][cPlate], GetVehicleOwnerName(id));
				strcat(location,lstr,sizeof(location));
			}
			ShowPlayerDialog(playerid, DIALOG_PICKUPVEH, DIALOG_STYLE_TABLIST_HEADERS,"Parked Vehicle",location,"Pickup","Cancel");
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_WALK) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		foreach(new i : Parks)
		{
			if(IsPlayerInRangeOfPoint(playerid, 4.0, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
			{
				return callcmd::pickupveh(playerid);
			}	
		}
	}
	if(PRESSED(KEY_WALK) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		foreach(new i : Parks)
		{
			if(IsPlayerInRangeOfPoint(playerid, 4.0, ppData[i][parkX], ppData[i][parkY], ppData[i][parkZ]))
			{
				return callcmd::parkveh(playerid);
			}	
		}
	}
	return 1;
}