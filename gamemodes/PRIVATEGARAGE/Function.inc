PvGarageRefresh(pvid) {
    new string[212];
    if(pvid != -1) {
        if(IsValidDynamicObject(PrivateGarage[pvid][ObjectGarage])) DestroyDynamicObject(PrivateGarage[pvid][ObjectGarage]);
        if(IsValidDynamicObject(PrivateGarage[pvid][ObjectText])) DestroyDynamicObject(PrivateGarage[pvid][ObjectText]);
        if(IsValidDynamicObject(PrivateGarage[pvid][ObjectButton])) DestroyDynamicObject(PrivateGarage[pvid][ObjectButton]);
        if(IsValidDynamicObject(PrivateGarage[pvid][ObjectDoors])) DestroyDynamicObject(PrivateGarage[pvid][ObjectDoors]);
        if(strcmp(PrivateGarage[pvid][Owner], "-")) format(string, sizeof(string), ""DARK_E"G:%d\n"AQUA_E"%s", pvid, PrivateGarage[pvid][Owner]);
        else format(string, sizeof(string), ""DARK_E"G:%d\n"AQUA_E"Price: "GREEN_E"%s", pvid, FormatMoney(PrivateGarage[pvid][GaragePrice]));

        PrivateGarage[pvid][ObjectGarage] = CreateDynamicObject(17950, PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2], PrivateGarage[pvid][GaragePos][3], PrivateGarage[pvid][GaragePos][4], PrivateGarage[pvid][GaragePos][5], -1, -1, -1, 300.00, 300.00); 

		if(PrivateGarage[pvid][TextPos][0] != 0) {
			PrivateGarage[pvid][ObjectButton] = CreateDynamicObject(19273, PrivateGarage[pvid][TextPos][0], PrivateGarage[pvid][TextPos][1], PrivateGarage[pvid][TextPos][2]+0.2, PrivateGarage[pvid][TextPos][3], PrivateGarage[pvid][TextPos][4], PrivateGarage[pvid][TextPos][5], -1, -1, -1, 300.00, 300.00); 
			PrivateGarage[pvid][ObjectText] = CreateDynamicObject(1233, PrivateGarage[pvid][TextPos][0], PrivateGarage[pvid][TextPos][1], PrivateGarage[pvid][TextPos][2], PrivateGarage[pvid][TextPos][3], PrivateGarage[pvid][TextPos][4], PrivateGarage[pvid][TextPos][5], -1, -1, -1, 300.00, 300.00); 
			SetDynamicObjectMaterial(PrivateGarage[pvid][ObjectText], 0, 10765, "airportgnd_sfse", "white", 0x00000000);
			SetDynamicObjectMaterial(PrivateGarage[pvid][ObjectText], 2, 10765, "airportgnd_sfse", "white", 0x00000000);
			SetDynamicObjectMaterialText(PrivateGarage[pvid][ObjectText], 2, string, 100, "Arial", 30, 1, 0xFFFF0000, 0xFFFFFFFF, 1); 
		}
		if(PrivateGarage[pvid][GatePos][0] != 0) {
			switch(PrivateGarage[pvid][DoorsStatus])
			{
				case 0: {
					PrivateGarage[pvid][ObjectDoors] = CreateDynamicObject(17951,  PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2], PrivateGarage[pvid][GatePos][3], PrivateGarage[pvid][GatePos][4], PrivateGarage[pvid][GatePos][5], -1, -1, -1, 300.00, 300.00); 
				}
				case 1: {
					PrivateGarage[pvid][ObjectDoors] = CreateDynamicObject(17951,  PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2], PrivateGarage[pvid][GatePos][3], PrivateGarage[pvid][GatePos][4], PrivateGarage[pvid][GatePos][5], -1, -1, -1, 300.00, 300.00); 
				}
			}
		}
    }
    return 1;
}

function PvGarageCreate(id)
{
	PvGarageSave(id);
	return 1;
}

OwnerPvGarage(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(id == -1) return 0;
	if(!strcmp(PrivateGarage[id][Owner], pData[playerid][pName], true)) return 1;
	return 0;
}

PvGarageSave(id)
{
	new dquery[2048];
	mysql_format(g_SQL, dquery, sizeof(dquery), "UPDATE privategarage SET `owner` = '%s', `price` = '%d', `status` = '%d'",
	PrivateGarage[id][Owner],
	PrivateGarage[id][GaragePrice],
	PrivateGarage[id][DoorsStatus]);

	mysql_format(g_SQL, dquery, sizeof(dquery), "%s, `garagepos` = '%.2f|%.2f|%.2f|%.2f|%.2f|%.2f', `textpos` = '%.2f|%.2f|%.2f|%.2f|%.2f|%.2f', `gatepos` = '%.2f|%.2f|%.2f|%.2f|%.2f|%.2f' WHERE ID='%d'", 
	dquery,
	PrivateGarage[id][GaragePos][0],
	PrivateGarage[id][GaragePos][1],
	PrivateGarage[id][GaragePos][2],
	PrivateGarage[id][GaragePos][3],
	PrivateGarage[id][GaragePos][4],
	PrivateGarage[id][GaragePos][5],
	PrivateGarage[id][TextPos][0],
	PrivateGarage[id][TextPos][1],
	PrivateGarage[id][TextPos][2],
	PrivateGarage[id][TextPos][3],
	PrivateGarage[id][TextPos][4],
	PrivateGarage[id][TextPos][5],
	PrivateGarage[id][GatePos][0],
	PrivateGarage[id][GatePos][1],
	PrivateGarage[id][GatePos][2],
	PrivateGarage[id][GatePos][3],
	PrivateGarage[id][GatePos][4],
	PrivateGarage[id][GatePos][5],
    id);
	return mysql_tquery(g_SQL, dquery);
}

function PvGarageLoad()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new pvid, string[521];
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", pvid);
		    cache_get_value_name(i, "owner", PrivateGarage[pvid][Owner], MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "price", PrivateGarage[pvid][GaragePrice]);
            cache_get_value_name_int(i, "status", PrivateGarage[pvid][DoorsStatus]);
			cache_get_value(i, "garagepos", string);
      		sscanf(string, "p<|>ffffff", PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2], PrivateGarage[pvid][GaragePos][3], PrivateGarage[pvid][GaragePos][4], PrivateGarage[pvid][GaragePos][5]);
			cache_get_value(i, "textpos", string);
      		sscanf(string, "p<|>ffffff", PrivateGarage[pvid][TextPos][0], PrivateGarage[pvid][TextPos][1], PrivateGarage[pvid][TextPos][2], PrivateGarage[pvid][TextPos][3], PrivateGarage[pvid][TextPos][4], PrivateGarage[pvid][TextPos][5]);
            cache_get_value(i, "gatepos", string);
      		sscanf(string, "p<|>ffffff", PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2], PrivateGarage[pvid][GatePos][3], PrivateGarage[pvid][GatePos][4], PrivateGarage[pvid][GatePos][5]);
            
			PrivateGarage[pvid][ID] = pvid;
			Iter_Add(PrivateGarage, pvid);
			PvGarageRefresh(pvid);
	    }
	    printf("[Private Garage]: %d Loaded.", rows);
	}
}

hook GetOwnedPrivateGarage(playerid)
{
	new tmpcount;
	foreach(new pvid : PrivateGarage)
	{
	    if(!strcmp(PrivateGarage[pvid][Owner], ReturnName(playerid), true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}
