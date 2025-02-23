CreateJoinTruckPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -77.38, -1136.52, 1.07, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[TRUCKER JOBS]\n{ffffff}Jadilah Pekerja Trucker disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -77.38, -1136.52, 1.07, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // truck
}

//Mission
GetRestockBisnis()
{
	new tmpcount;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockBisnisID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_BISNIS) return -1;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

//Hauling
GetRestockGStation()
{
	new tmpcount;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockGStationID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_GSTATION) return -1;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

//Vending Restock
GetRestockVending()
{
	new tmpcount;
	foreach(new id : Vendings)
	{
	    if(VendingData[id][vendingRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockVendingID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_VENDING) return -1;
	foreach(new id : Bisnis)
	{
	    if(VendingData[id][vendingRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}
CMD:mission(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new string[400];
	    string =  "List Delivery\tVehicle Used\n";
	    format(string, sizeof(string), "%sRestock Business\tMule, Yankee, Benson, Boxville\n", string);
	    format(string, sizeof(string), "%sRestock Gas Station\tRoadtrain, Linerunner, Petrol\n", string);
		format(string, sizeof(string), "%sRestock Vending Machine\tMule, Yankee, Benson, Boxville\n", string);
		format(string, sizeof(string), "%sRestock Dealership\tRoadtrain, Linerunner, Petrol\n", string);
		ShowPlayerDialog(playerid, DIALOG_MENU_TRUCKER, DIALOG_STYLE_TABLIST_HEADERS, "Menu Trucker", string, "Select","Cancel");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storeproduct(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new bid = pData[playerid][pMission], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(bid == -1) return Error(playerid, "You dont have mission.");
		if(IsPlayerInRangeOfPoint(playerid, 4.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(VehProduct[vehicleid] < 1) return Error(playerid, "Product is empty in this vehicle.");
			total = VehProduct[vehicleid] * ProductPrice;
			percent = (total / 100) * 80;
			convert = floatround(percent, floatround_floor);
			pay = total + convert;
			bData[bid][bProd] += VehProduct[vehicleid];
			bData[bid][bMoney] -= pay;
			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"product dengan seharga "GREEN_E"%s", VehProduct[vehicleid], FormatMoney(pay));
			AddPlayerSalary(playerid, "Trucker (Product)", pay);
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				pvData[carid][cProduct] = 0;
				Info(playerid, "Anda mendapatkan uang 80 percent dari hasil stock product anda.");
			}
			VehProduct[vehicleid] = 0;
			pData[playerid][pMission] = -1;
		}
		else return Error(playerid, "Anda harus berada didekat dengan bisnis mission anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storegas(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new id = pData[playerid][pHauling], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(id == -1) return Error(playerid, "You dont have hauling.");
		if(IsPlayerInRangeOfPoint(playerid, 5.5, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAHaulTruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(!IsTrailerAttachedToVehicle(vehicleid)) return Error(playerid, "Your Vehicle Trailer is not even attached");
			DetachTrailerFromVehicle(vehicleid);

			if(IsValidVehicle(GetVehicleTrailer(vehicleid)))
				DestroyVehicle(GetVehicleTrailer(vehicleid));
				
			pData[playerid][pTrailer] = INVALID_VEHICLE_ID;

			if(VehGasOil[vehicleid] < 1) return Error(playerid, "GasOil is empty in this vehicle.");
			total = VehGasOil[vehicleid] * GasOilPrice;
			percent = (total / 100) * 75;
			convert = floatround(percent, floatround_ceil);
			pay = total + convert;
			gsData[id][gsStock] += VehGasOil[vehicleid];
			Server_MinMoney(pay);
			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"liters gas oil dengan seharga "GREEN_E"%s", VehGasOil[vehicleid], FormatMoney(pay));
			AddPlayerSalary(playerid, "Trucker (Hauling)", pay);
			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{
				pvData[carid][cGasOil] = 0;
				Info(playerid, "Anda mendapatkan uang 75 percent dari hasil stock liters gas oil anda.");
			}
			VehGasOil[vehicleid] = 0;
			pData[playerid][pHauling] = -1;
			pData[playerid][pJobTime] = 1200;
			GStation_Refresh(id);
			GStation_Save(id);
		}
		else return Error(playerid, "Anda harus berada didekat dengan gas oil hauling anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:boxcomp(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
		if(isnull(params)) return Usage(playerid, "/boxcomp [buy/store/load/unload/pickup]");
		
		if(!strcmp(params, "buy", true))
		{
			new rego = 10;
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, 659.86, 1267.55, 12.89))
				return Error(playerid, "Kamu tidak berada di pembelian box");
			if(pData[playerid][CarryingBox] == true)
				return Error(playerid, "Kamu masih membawa creat component!");
			if(GetPlayerMoney(playerid) < rego)
				return Error(playerid, "Uangmu tidak cukup untuk membeli box seharga %s", FormatMoney(rego));

			GivePlayerMoneyEx(playerid, -rego);
			Player_GiveBox(playerid);
			Product -= 10;
			Server_AddMoney(rego);
            Servers(playerid,"Kamu berhasil membeli creat {ffff00}Component {ffffff}seharga %s", FormatMoney(rego));
        	
		}
		else if (!strcmp(params, "store", true))
		{
			new pay, wid, id;
			if(IsPlayerInRangeOfPoint(playerid, 5.0, 1339.68, 324.57, 20.27))
			{
				if (pData[playerid][CarryingBox] == false)
				{
					return Error(playerid, "Kamu tidak membawa box product!");
				}

				if (pData[playerid][pJobTime] > 0)
				{
					return Error(playerid, "Anda masih harus menunggu sebelum bisa menjual box lagi.");
				}

				// Logika penjualan
				pay = 500;

				// Mengambil nilai 'component' dari cache dan memasukkannya ke variabel
				Component += 80;

				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
				Player_RemoveBox(playerid);
				GivePlayerMoneyEx(playerid, pay);
				Info(playerid, "Anda telah store create component dan mendapatkan money {7fff00}%s", FormatMoney(pay));

				// Menambah jumlah kotak yang telah dijual pemain
				pData[playerid][pCreateSell]++;

				// Mengecek apakah kotak yang dijual sudah mencapai batas
				if (pData[playerid][pCreateSell] >= BOX_LIMIT)
				{
					pData[playerid][pJobTime] += 3000; // Menambahkan delay 1 jam
					pData[playerid][pCreateSell] = 0; // Reset jumlah kotak yang telah dijual
					return Info(playerid, "Anda telah mencapai batas penjualan kotak dan dapat menjual lagi setelah waktu tunggu selesai.");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid, 5.0,  wsData[wid][wX], wsData[wid][wY],  wsData[wid][wZ]))
			{
				if(!strcmp(wsData[wid][wOwner], "-") || wsData[wid][wOwnerID] == 0) 
					return Error(playerid, "Workshop ini masih belum mempunyai pemilik");
				if(wsData[id][wComp] > 75) 
					return Error(playerid, "Workshop ini masih punya cukup stock");
				if(pData[playerid][CarryingBox] == false)
					return Error(playerid, "Kamu tidak membawa box product!");

				wsData[id][wComp] += 80;
				
				Workshop_Save(wid);
				Workshop_Refresh(wid);
				ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0 ,0,0,0,0,1);
				Player_RemoveBox(playerid);
				Info(playerid, "Anda berhasil menaruh create component kedalam gudang workshop");
			}	
			else
			{
				return Error(playerid, "Anda harus di dekat tempat menaruh creat");
			}
		}
		else if(!strcmp(params, "load", true))
		{
			new carid = -1;
			if(!pData[playerid][CarryingBox]) return Error(playerid, "You're not carrying a Box.");
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 4.5, false);
			if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "You not in near any vehicles.");
			if(!IsATruck(vehicleid)) return Error(playerid, "You're not near a trucker car.");
			if(GetTrunkStatus(vehicleid))
			{
				if(Vehicle_BoxCount(vehicleid) >= BOX_LIMIT) return Error(playerid, "You can't load any more logs to this vehicle.");
				if((carid = Vehicle_Nearest(playerid)) != -1)
				{
					if(IsValidVehicle(pvData[carid][cVeh]))
					{
						pvData[carid][cBox]++;
					}
					BoxStorage[vehicleid][ pData[playerid][CarryingBox] ]++;
				}
				Player_RemoveBox(playerid);
				Info(playerid, "Loaded a box.");
			} 
			else Error(playerid, "Kamu belum membuka trunk kendaraan");	
		}
		else if(!strcmp(params, "unload", true))
		{
			new carid = -1;
			if(pData[playerid][CarryingBox]) return Error(playerid, "You're already carrying a box.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 4.5, false);		
			if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "You not in near any vehicles.");
			if(!IsATruck(vehicleid)) return Error(playerid, "You're not near a trucker car.");
			if(GetTrunkStatus(vehicleid))
			{
				if(Vehicle_BoxCount(vehicleid) < 1) return Error(playerid, "This vehicle doesn't have any Boxs.");
				if((carid = Vehicle_Nearest(playerid)) != -1)
				{
					if(IsValidVehicle(pvData[carid][cVeh]))
					{
						pvData[carid][cBox]--;
					}
					BoxStorage[vehicleid][ pData[playerid][CarryingBox] ]--;
				}
				Player_GiveBox(playerid);
				Info(playerid, "You've taken a box from the car.");
			}	
			else Error(playerid, "Kamu belum membuka trunk kendaraan");
		}
		else if(!strcmp(params, "pickup", true))
		{
			if(pData[playerid][CarryingBox]) return Error(playerid, "You're already carrying a Box.");
			new tid = GetClosestBox(playerid);
			if(tid == -1) return Error(playerid, "You're not near a Box.");
			BoxData[tid][boxSeconds] = 1;
			RemoveBox(tid);
			
			Player_GiveBox(playerid);
			Info(playerid, "You've taken a Box from ground.");
		}
	}	
	else return Error(playerid, "Kamu bukan Trucker!");
	return 1;
}

Player_GiveBox(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	pData[playerid][CarryingBox] = true;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, 9, 1271, 1, 0.002953, 0.469660, -0.009797, 269.851104, 34.443557, 0.000000, 0.804894, 1.000000, 0.822361 );
	Info(playerid, "You can press "GREEN_E"N "WHITE_E"to drop your box.");
	return 1;
}

Player_RemoveBox(playerid)
{
	if(!IsPlayerConnected(playerid) || !pData[playerid][CarryingBox]) return 0;
	ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
	RemovePlayerAttachedObject(playerid, 9);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	pData[playerid][CarryingBox] = false;
	return 1;
}

Player_DropBox(playerid, death_drop = 0)
{
    if(!IsPlayerConnected(playerid) || !pData[playerid][CarryingBox]) return 0;
    new id = Iter_Free(Boxs);
    if(id != -1)
    {
        new Float: x, Float: y, Float: z, Float: a, label[128];
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        GetPlayerName(playerid, BoxData[id][boxDroppedBy], MAX_PLAYER_NAME);

		if(!death_drop)
		{
		    x += (1.0 * floatsin(-a, degrees));
			y += (1.0 * floatcos(-a, degrees));
			
			ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		}

		BoxData[id][boxSeconds] = BOX_LIFETIME;
		BoxData[id][boxObjID] = CreateDynamicObject(1271, x, y, z - 0.4, 0.0, 0.0, a);
		
		format(label, sizeof(label), "Box (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /cargo pickup.", id, BoxData[id][boxDroppedBy], ConvertToMinutes(BOX_LIFETIME));
		BoxData[id][boxLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, x, y, z - 0.2, 5.0, .testlos = 1);
		
		BoxData[id][boxTimer] = SetTimerEx("RemoveBox", 1000, true, "i", id);
		Iter_Add(Boxs, id);
    }
    
    Player_RemoveBox(playerid);
	return 1;
}

Vehicle_BoxCount(vehicleid)
{
	//if(!IsValidVehicle(vehicleid)) return -1;
	new count = 0;
	for(new i; i < 2; i++) count += BoxStorage[vehicleid][i];
	return count;
}

GetClosestBox(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist, Float: pos[3];
	foreach(new i : Boxs)
	{
	    GetDynamicObjectPos(BoxData[i][boxObjID], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

function RemoveBox(tid)
{
	if(!Iter_Count(Boxs, tid)) return 1;
	
	if(BoxData[tid][boxSeconds] > 1) 
	{
	    BoxData[tid][boxSeconds]--;

        new label[128];
	    format(label, sizeof(label), "Box (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /cargo pickup.", tid, BoxData[tid][boxDroppedBy], ConvertToMinutes(BoxData[tid][boxSeconds]));
		UpdateDynamic3DTextLabelText(BoxData[tid][boxLabel], COLOR_GREEN, label);
	}
	else if(BoxData[tid][boxSeconds] == 1) 
	{
	    KillTimer(BoxData[tid][boxTimer]);
	    DestroyDynamicObject(BoxData[tid][boxObjID]);
		DestroyDynamic3DTextLabel(BoxData[tid][boxLabel]);
		
	    BoxData[tid][boxTimer] = -1;
        BoxData[tid][boxObjID] = -1;
        BoxData[tid][boxLabel] = Text3D: -1;

		Iter_Remove(Boxs, tid);
	}
	
	return 1;
}

CMD:shipments(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);
		if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus didalam kendaraan.");
		if(!IsATruck(vehicleid)) return Error(playerid, "You're not near a trucker car.");
		ShowPlayerDialog(playerid, DIALOG_SHIPMENTS, DIALOG_STYLE_LIST, "Shipments Menu", "Shipments Business\nShipments Vending", "Select", "Close");
		return 1;
	}
	else return Error(playerid, "Kamu bukan Trucker!");
}	
