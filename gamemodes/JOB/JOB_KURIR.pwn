//#define BOX_INDEX 0
new CourierVehicle[4];
new TimerCourier[MAX_PLAYERS], CourierCrate[MAX_PLAYERS], bool:CourierJob[MAX_PLAYERS], CourierCount[MAX_PLAYERS], CourierID[MAX_PLAYERS][11];

new Float: CourierPlayerX[MAX_PLAYERS][100];
new Float: CourierPlayerY[MAX_PLAYERS][100];
new Float: CourierPlayerZ[MAX_PLAYERS][100];
new bool:CourierStatus[MAX_PLAYERS][11];


ptask CourierTimer[1000](playerid) 
{
    if(CourierJob[playerid] && !IsPlayerInAnyVehicle(playerid) && CourierCrate[playerid])
    {
        TimerCourier[playerid]--;
        new str[256];
        format(str, sizeof(str), "~w~Return To Vehicle ~n~in ~y~%d seconds", TimerCourier[playerid]);
        GameTextForPlayer(playerid, str, 1000, 6);
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        if(TimerCourier[playerid] == 0)
        {
            new gaji;
            gaji = CourierCount[playerid]*250;
            TimerCourier[playerid] = 0;
            CourierJob[playerid] = false;
            SetVehicleToRespawn(GetPVarInt(playerid, "LastVehicleID"));
            format(str, sizeof(str), "Delivered %d packages");
            AddPlayerSalary(playerid, "Sidejob Courier", gaji);	
            SendClientMessageEx(playerid, COLOR_ARWIN, "COURIER: {ffffff}Courier sidejob failed, {3BBD44}%s {ffffff}has been issued for your next paycheck", FormatMoney(gaji));
            SendClientMessageEx(playerid, COLOR_ARWIN, "SALARY: {ffffff}Your salary statement has been updated, please check command {ffff00}'/mysalary'");
            CourierCount[playerid] = 0;
            CourierCrate[playerid] = 0;
            RemovePlayerAttachedObject(playerid, 9);
            pData[playerid][pDelayCourier] = 1600;
            for(new i = 0; i < 2; i++) 
            {
                TextDrawHideForPlayer(playerid, PlayerCrateTD);
                PlayerTextDrawHide(playerid, PlayerCrate[playerid][i]);
            }
            for(new id; id < 10; id++)
            {
                CourierStatus[playerid][id] = false;
            }
        }
    }
    return 1;
}

CMD:taruhbox(playerid, params[])
{
    if(!CourierJob[playerid] && CourierCrate[playerid] != 2)
        return Error(playerid, "Kamu tidak Mempunyai Kurir Box");

    foreach(new houseid : Houses)
	{
		new rada = 50;
		if(IsPlayerInRangeOfPoint(playerid, 3.0, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]))
		{
			//GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
			if(CourierJob[playerid] == true && CourierCrate[playerid] == 2) {
				for(new id = 0; id < 10; id++){
					if(CourierID[playerid][id] == houseid) {
						RemovePlayerAttachedObject(playerid, 9);
						CourierStatus[playerid][id] = true;
						CourierID[playerid][id] = -1;
						ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0 ,0,0,0,0,1);
						CourierCount[playerid]++;
						SendClientMessageEx(playerid, COLOR_ARWIN, "COURIER: {ffffff}Delivered {3BBD44}%d {ffffff}out of {ffff00}10", CourierCount[playerid]);
						RemovePlayerMapIcon(playerid, rada+id);
						SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
						if(CourierCount[playerid] == 10)
						{
							SendClientMessageEx(playerid, COLOR_ARWIN, "COURIER: {3BBD44}Delivered all crates, {ffffff}Please return the delivery vehicle back to the warehouse!");
							SendClientMessageEx(playerid, COLOR_ARWIN, "COURIER: {ffffff}You've delivered 10 packages, please return the delivery vehicle now!");
							SetPlayerRaceCheckpoint(playerid, 1, 1778.1998,-1693.6936,13.4569, 0.0, 0.0, 0.0, 5.0);
							for(new i; i < 10; i++)
							{
								RemovePlayerMapIcon(playerid, rada+i);
							}
						}
					}
				}
			}
		}
	}
    return 1;
}


Dialog:CourierSidejob(playerid, response, listitem, inputtext[]) {
    if(response)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(pData[playerid][pDelayCourier] > 0)
        {
            Error(playerid, "Kamu harus menunggu %d Menit untuk menjadi pengantar paket", pData[playerid][pDelayCourier]/60);
            RemovePlayerFromVehicle(playerid);
            SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
            return 1;
        }
        SendCustomMessage(playerid, "SIDEJOB", "Icon merah {FFFFFF}di radar map adalah lokasi pengiriman paket ke rumah");
        SendCustomMessage(playerid, "SIDEJOB", "Setelah sampai rumah, keluar dari kendaraan lalu untuk antar paket ke pintu rumah lalu {FFFF00}/taruhbox");
        SendCustomMessage(playerid, "SIDEJOB", "Jika sudah mengantar 10 paket, mohon kembalikan kendaraan ke tempat awal");
        SendCustomMessage(playerid, "SIDEJOB", "Meninggalkan mobil Boxville selama 60 detik artinya berhenti bekerja");
        new String2[212];
        format(String2,sizeof(String2),"Deliveries~n~%d/10", CourierCount[playerid]);
        PlayerTextDrawSetString(playerid, PlayerCrate[playerid][1], String2);

        TextDrawShowForPlayer(playerid, PlayerCrateTD);
        PlayerTextDrawShow(playerid, PlayerCrate[playerid][0]);
        PlayerTextDrawShow(playerid, PlayerCrate[playerid][1]);
        
        CourierJob[playerid] = true;
        CourierCount[playerid] = 0;
        new rand[10], rada = 50, count = 0;
        foreach(new hid : Houses) {
            count++;
        }
        for(new id = 0; id < 10; id++){
            rand[id] = random(count - 1);
            if(++rand[id] >= count) {
                rand[id] = 0;
            }
            if(rand[id] == rand[id]) rand[id] = random(count - 1);
            CourierStatus[playerid][id] = false;
            CourierID[playerid][id] = rand[id];
            
            CourierPlayerX[playerid][id] = hData[rand[id]][hExtposX];
            CourierPlayerY[playerid][id] = hData[rand[id]][hExtposY];
            CourierPlayerZ[playerid][id] = hData[rand[id]][hExtposZ];
            //SetPlayerCheckpoint(playerid, CourierPlayerX[playerid][id], CourierPlayerY[playerid][id], CourierPlayerZ[playerid][id], 5.0);
            //SetPlayerCheckpoint(playerid, 1, CourierPlayerX[playerid][id], CourierPlayerY[playerid][id], CourierPlayerZ[playerid][id], 1);
            SetPlayerMapIcon(playerid, rada+id, CourierPlayerX[playerid][id], CourierPlayerY[playerid][id], CourierPlayerZ[playerid][id], 0, COLOR_RED, MAPICON_GLOBAL);
        }
    }
    else
    {
        RemovePlayerFromVehicle(playerid);
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
    }
    return 1;
}

#include <YSI\y_hooks>
hook OnGameModeInit()
{
    new objectcourier;
    CourierVehicle[0] = AddStaticVehicle(498,1772.3386,-1702.9760,13.5782,11.1372,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);

    CourierVehicle[1] = AddStaticVehicle(498,1776.0262,-1702.9165,13.5767,9.1052,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);


    CourierVehicle[2] = AddStaticVehicle(498,1780.6472,-1702.3958,13.5761,10.6289,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);

    CourierVehicle[3] = AddStaticVehicle(498,1784.5532,-1702.2916,13.5749,10.9174,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);

}

IsACourierVeh(carid)
{
    for(new v = 0; v < sizeof(CourierVehicle); v++) {
        if(carid == CourierVehicle[v]) return 1;
    }
    return 0;
}


