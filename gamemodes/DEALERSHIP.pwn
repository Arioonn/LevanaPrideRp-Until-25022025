#include <YSI_Coding\y_hooks>

#define MAX_DEALERSHIP 100

enum DealerVariabel
{
	dealerOwner[MAX_PLAYER_NAME],
	dealerOwnerId,
	dealerName[128],
	dealerPrice,
	dealerType,
	dealerLocked,
	dealerMoney,
	Float:dealerPosX,
	Float:dealerPosY,
	Float:dealerPosZ,
	Float:dealerPosA,
	Float:dealerPointX,
	Float:dealerPointY,
	Float:dealerPointZ,
	Float:dealerPointA,
	dealerStock,
	dealerRestock,

	// Hooked by DealerRefresh
	dealerPickup,
	dealerPickupPoint,
	dealerMap,
	Text3D:dealerLabel,
	Text3D:dealerPointLabel,
};

new DealerData[MAX_DEALERSHIP][DealerVariabel];
new Iterator:Dealer<MAX_DEALERSHIP>;

CMD:editdealer(playerid, params[])
{
    static
        did,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", did, type, string))
    {
        Usage(playerid, "/editdealer [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, point, price, type, stock, restock, reset, owner");
        return 1;
    }
    if((did < 0 || did > MAX_DEALERSHIP))
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, did)) return Error(playerid, "The dealership you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, DealerData[did][dealerPosX], DealerData[did][dealerPosY], DealerData[did][dealerPosZ]);
		GetPlayerFacingAngle(playerid, DealerData[did][dealerPosA]);
        DealerSave(did);
		DealerRefresh(did);

        SendAdminMessage(COLOR_RED, "%s Changes Location Dealer ID: %d.", pData[playerid][pAdminname], did);
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/editdealer [id] [Price] [Amount]");

        DealerData[did][dealerPrice] = price;

        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Changes Price Of The Dealer ID: %d to %d.", pData[playerid][pAdminname], did, price);
    }
	else if(!strcmp(type, "type", true))
    {
        new dtype;

        if(sscanf(string, "d", dtype))
            return Usage(playerid, "/editbisnis [id] [Type] [1.Motorcycle 2.Cars 3.Unique Cars 4.Job Cars 5.Truck]");

        DealerData[did][dealerType] = dtype;
        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Changes Type Of The Dealer ID: %d to %d.", pData[playerid][pAdminname], did, dtype);
    }
    else if(!strcmp(type, "stock", true))
    {
        new dStock;
        if(sscanf(string, "d", dStock))
            return Usage(playerid, "/editdealer [id] [stock]");

        DealerData[did][dealerStock] = dStock;
        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Set Stock Of The Dealer ID: %d with stock %d.", pData[playerid][pAdminname], did, dStock);
    }
    else if(!strcmp(type, "reset", true))
    {
        DealerReset(did);
		DealerSave(did);
        SendAdminMessage(COLOR_RED, "%s has reset dealer ID: %d.", pData[playerid][pAdminname], did);
    }
	else if(!strcmp(type, "point", true))
    {
		new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, Float:a);
		DealerData[did][dealerPointX] = x;
		DealerData[did][dealerPointY] = y;
		DealerData[did][dealerPointZ] = z;
		DealerSave(did);
		DealerPointRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Change Point Of The Dealer ID: %d.", pData[playerid][pAdminname], did);
    }
	else if (!strcmp(type, "owner", true))
	{
		new othername[MAX_PLAYER_NAME], otherid;

		if (sscanf(string, "s[24]", othername))
		{
			return Usage(playerid, "/editdealer [id] [owner] [player-name] (use '-' to no owner/reset)");
		}

		otherid = GetPlayerIDByName(othername);

		if (strcmp(othername, "-") == 0 || otherid == INVALID_PLAYER_ID)
		{
			format(DealerData[did][dealerOwner], MAX_PLAYER_NAME, "-");
			DealerData[did][dealerOwnerId] = -1; // Reset owner ID
		}
		else
		{
			format(DealerData[did][dealerOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
			DealerData[did][dealerOwnerId] = pData[otherid][pID];
		}

		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE dealership SET owner='%s', ownerid='%d' WHERE ID='%d'", DealerData[did][dealerOwner], DealerData[did][dealerOwnerId], did);
		mysql_tquery(g_SQL, query);

		DealerRefresh(did);
		SendAdminMessage(COLOR_RED, "%s has adjusted the owner of dealership ID: %d to %s", pData[playerid][pAdminname], did, DealerData[did][dealerOwner]);
	}
	return 1;
}

CMD:buydealer(playerid, params[])
{
	foreach(new bid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerData[bid][dealerPosX], DealerData[bid][dealerPosY], DealerData[bid][dealerPosZ]))
		{
			if(DealerData[bid][dealerPrice] > GetPlayerMoney(playerid))
				return Error(playerid, "Not enough money, you can't afford this dealership.");

			if(strcmp(DealerData[bid][dealerOwner], "-"))
				return Error(playerid, "Someone already owns this dealership.");

			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_DealerCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more dealership.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_DealerCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more dealership.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_DealerCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more dealership.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_DealerCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more dealership.");
				#endif
			}

			GivePlayerMoneyEx(playerid, -DealerData[bid][dealerPrice]);
			Server_AddMoney(DealerData[bid][dealerPrice]);
			GetPlayerName(playerid, DealerData[bid][dealerOwner], MAX_PLAYER_NAME);

			DealerRefresh(bid);
			DealerSave(bid);
		}
	}
	return 1;
}

CMD:createdealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new query[512];
	new dealerid = Iter_Free(Dealer), address[128];

	new price, type;
	if(sscanf(params, "dd", price, type))
		return Usage(playerid, "/createdealer [price] [type 1.Motorcycle 2.Cars 3.Unique Cars 4. Jobs Vehicle 5. Boat]");

	if(dealerid == -1)
		return Error(playerid, "You cant create more dealership");

	if((dealerid < 0 || dealerid >= MAX_DEALERSHIP))
        return Error(playerid, "You have already input 15 dealership in this server.");

	if(type > 5 || type < 0)
		return Error(playerid, "Invalid dealership Type");

	format(DealerData[dealerid][dealerOwner], 128, "-");
	GetPlayerPos(playerid, DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]);
	GetPlayerFacingAngle(playerid, DealerData[dealerid][dealerPosA]);

	DealerData[dealerid][dealerPrice] = price;
	DealerData[dealerid][dealerType] = type;

	address = GetLocation(DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]);
	format(DealerData[dealerid][dealerName], 128, address);

	DealerData[dealerid][dealerOwnerId] = 0;
	DealerData[dealerid][dealerLocked] = 1;
	DealerData[dealerid][dealerMoney] = 0;
	DealerData[dealerid][dealerStock] = 0;
	DealerData[dealerid][dealerRestock] = 0;

	Iter_Add(Dealer, dealerid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO dealership SET ID='%d', owner='%s', ownerid='%s', price='%d', type='%d', posx='%f', posy='%f', posz='%f', posa='%f', name='%s'", dealerid, DealerData[dealerid][dealerOwner], DealerData[dealerid][dealerOwnerId], DealerData[dealerid][dealerPrice], DealerData[dealerid][dealerType], DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ], DealerData[dealerid][dealerPosA], DealerData[dealerid][dealerName]);
	mysql_tquery(g_SQL, query, "OnDealerCreated", "i", dealerid);
	return 1;
}

CMD:deletedealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/deletedealer [id]");

	if(bid < 0 || bid >= MAX_DEALERSHIP)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	DealerReset(bid);

	DestroyDynamic3DTextLabel(DealerData[bid][dealerLabel]);
	DestroyDynamic3DTextLabel(DealerData[bid][dealerPointLabel]);

    DestroyDynamicPickup(DealerData[bid][dealerPickup]);
    DestroyDynamicPickup(DealerData[bid][dealerPickupPoint]);

	DealerData[bid][dealerPosX] = 0;
	DealerData[bid][dealerPosY] = 0;
	DealerData[bid][dealerPosZ] = 0;
	DealerData[bid][dealerPosA] = 0;
	DealerData[bid][dealerPointX] = 0;
	DealerData[bid][dealerPointY] = 0;
	DealerData[bid][dealerPointZ] = 0;
	DealerData[bid][dealerPrice] = 0;
	DealerData[bid][dealerLabel] = Text3D:INVALID_3DTEXT_ID;
	DealerData[bid][dealerPointLabel] = Text3D:INVALID_3DTEXT_ID;
	DealerData[bid][dealerPickup] = -1;
	DealerData[bid][dealerPickupPoint] = -1;

	Iter_Remove(Dealer, bid);
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM dealership WHERE ID=%d", bid);
	mysql_tquery(g_SQL, query);
    SendAdminMessage(COLOR_RED, "%s has delete dealership ID: %d.", pData[playerid][pAdminname], bid);
    return 1;
}

CMD:gotodealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/gotodealer [id]");

	if(bid < 0 || bid >= MAX_DEALERSHIP)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	SetPlayerPos(playerid, DealerData[bid][dealerPosX], DealerData[bid][dealerPosY], DealerData[bid][dealerPosZ]);
	SetPlayerFacingAngle(playerid, DealerData[bid][dealerPosA]);

    SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to dealership id %d", bid);
    return 1;
}

CMD:gotodealerpoint(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/gotodealerpoint [id]");

	if(bid < 0 || bid >= MAX_DEALERSHIP)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	if(DealerData[bid][dealerPointX] == 0.0 && DealerData[bid][dealerPointY] == 0.0 && DealerData[bid][dealerPointZ] == 0.0)
		return Error(playerid, "That point is exists but doesnt have any position");

	SetPlayerPos(playerid, DealerData[bid][dealerPointX], DealerData[bid][dealerPointY], DealerData[bid][dealerPointZ]);

    SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to dealership id %d", bid);
    return 1;
}

CMD:buypv(playerid, params[])
{
	foreach(new dealerid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]) && strcmp(DealerData[dealerid][dealerOwner], "-") && DealerData[dealerid][dealerPointX] != 0.0 && DealerData[dealerid][dealerPointY] != 0.0 && DealerData[dealerid][dealerPointZ] != 0.0)
		{
			DealerBuyVehicle(playerid, dealerid);
		}
	}
	return 1;
}

CMD:dealermanage(playerid, params[])
{
	foreach(new dealerid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]))
		{
			if(!PlayerOwnsDealership(playerid, dealerid)) return Error(playerid, "Dealership ini bukan milik anda!");
			ShowPlayerDialog(playerid, DIALOG_DEALER_MANAGE, DIALOG_STYLE_LIST, "Dealer Manage", "Dealer Information\nDealer Change Name\nDealer Vault\nDealer RequestStock", "Select", "Cancel");
		}
	}
	return 1;
}

CMD:gpsdealer(playerid)
{
	new
 	han2[MAX_DEALERSHIP * 32];

	han2 = "ID\tName\tType\tLocation\n";

    new type[128];
   	foreach(new bid : Dealer)
	{
		if(DealerData[bid][dealerType] == 1)
		{
			type = "Motorcycle";
		}
		else if(DealerData[bid][dealerType] == 2)
		{
			type = "Cars";
		}
		else if(DealerData[bid][dealerType] == 3)
		{
			type = "Unique Cars";
		}
		else if(DealerData[bid][dealerType] == 4)
		{
			type = "Job Cars";
		}
		else if(DealerData[bid][dealerType] == 5)
		{
			type = "Truck";
		}
		else
		{
			type = "Unknow";
		}

	    format(han2, sizeof(han2), "%s%d\t%s\t%s\t"WHITE_E"%.1f m\n", han2,
	    bid, DealerData[bid][dealerName], type, GetPlayerDistanceFromPoint(playerid, DealerData[bid][dealerPosX], DealerData[bid][dealerPosY], DealerData[bid][dealerPosZ]));
	}
	ShowPlayerDialog(playerid, DIALOG_FIND_DEALER, DIALOG_STYLE_TABLIST_HEADERS, "Dealership Location", han2, "Select", "Close");
	return 1;
}

CMD:dealermission(playerid)
{
    if(pData[playerid][pLevel] < 5)
			return Error(playerid, "You must level 5 to use this!");
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
	    if(pData[playerid][pJobTime] > 0)
		{
	    	Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik lagi.", pData[playerid][pJobTime]);
	    	return 1;
		}
		if(GetRestockDealer() <= 0) return Error(playerid, "Dealership Mission sedang kosong.");
		new id, count = GetRestockDealer(), dealermission[128], type[32], lstr[512];

		strcat(dealermission,"No\tDealerID\tDealerType\tDealerName\n",sizeof(dealermission));
		Loop(itt, (count + 1), 1)
		{
			id = ReturnRestockDealerID(itt);
			if(DealerData[id][dealerType] == 1)
			{
				type= "Motorcycle";
			}
			else if(DealerData[id][dealerType] == 2)
			{
				type= "Cars";
			}
			else if(DealerData[id][dealerType] == 3)
			{
				type= "Unique Cars";
			}
			else if(DealerData[id][dealerType] == 4)
			{
				type= "Job Cars";
			}
			else if(DealerData[id][dealerType] == 5)
			{
				type= "Truck";
			}
			else
			{
				type= "Unknow";
			}
			if(itt == count)
			{
				format(lstr,sizeof(lstr), "%d\t%d\t%s\t%s\n", itt, id, type, DealerData[id][dealerName]);
			}
			else format(lstr,sizeof(lstr), "%d\t%d\t%s\t%s\n", itt, id, type, DealerData[id][dealerName]);
			strcat(dealermission,lstr,sizeof(dealermission));
		}
		ShowPlayerDialog(playerid, DIALOG_DEALER_RESTOCK, DIALOG_STYLE_TABLIST_HEADERS,"Dealer Mission",dealermission,"Start","Cancel");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storeveh(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new bid = pData[playerid][pDealerMission], vehicleid = GetPlayerVehicleID(playerid);
		if(bid == -1) return Error(playerid, "You dont have dealermission.");
		if(IsPlayerInRangeOfPoint(playerid, 4.8, DealerData[bid][dealerPointX], DealerData[bid][dealerPointY], DealerData[bid][dealerPointZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(!IsTrailerAttachedToVehicle(vehicleid)) return Error(playerid, "Your Vehicle Trailer is not even attached");
			DealerData[bid][dealerMoney] -= 500000;
			Info(playerid, "Anda merestock dealerhsip "WHITE_E"dan diberi imbalan uang "GREEN_E"$250.00");
			AddPlayerSalary(playerid, "Trucker(Restock Dealer)", 25000);
			Server_AddMoney(25000);
			pData[playerid][pDealerMission] = -1;
			DealerData[bid][dealerStock] += 5;
			pData[playerid][pJobTime] += 3600;
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
		}
		else return Error(playerid, "Anda harus berada didekat dengan point dealership.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:givedealer(playerid, params[])
{
	new bid, otherid;
	if(sscanf(params, "ud", otherid, bid)) return Usage(playerid, "/givedealer [playerid/name] [id]");
	if(bid == -1) return Error(playerid, "Invalid id");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "Player tersebut telah disconnect/tidak berada didekat dirimu.");
	
	if(!PlayerOwnsDealership(playerid, bid)) return Error(playerid, "Kamu tidak memiliki Dealership");
	if(pData[otherid][pVip] == 1)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_DealerCount(otherid) + 1 > 2) return Error(playerid, "Target Player tidak dapat memiliki bisnis lebih.");
		#endif
	}
	else if(pData[otherid][pVip] == 2)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_DealerCount(otherid) + 1 > 3) return Error(playerid, "Target Player tidak dapat memiliki bisnis lebih.");
		#endif
	}
	else if(pData[otherid][pVip] == 3)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_DealerCount(otherid) + 1 > 4) return Error(playerid, "Target Player tidak dapat memiliki bisnis lebih.");
		#endif
	}
	else
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_DealerCount(otherid) + 1 > 1) return Error(playerid, "Target Player tidak dapat memiliki bisnis lebih.");
		#endif
	}
	GetPlayerName(otherid, DealerData[bid][dealerOwner], MAX_PLAYER_NAME);
	DealerData[bid][dealerOwnerId] = pData[otherid][pID];
	
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE dealership SET owner='%s', ownerid='%d', WHERE ID='%d'", DealerData[bid][dealerOwner], DealerData[bid][dealerOwnerId], bid);
	mysql_tquery(g_SQL, query);

	DealerRefresh(bid);
	Info(playerid, "Anda memberikan bisnis id: %d kepada %s", bid, ReturnName(otherid));
	Info(otherid, "%s memberikan bisnis id: %d kepada anda", bid, ReturnName(playerid));
	new str[150];
	format(str,sizeof(str),"[BIZ]: %s memberikan business id %d ke %s!", GetRPName(playerid), bid, GetRPName(otherid));
	LogServer("Property", str);
	return 1;
}


/* ============ [ Stock goes here ] ============ */
DealerSave(id)
{
	new cQuery[2248];
	format(cQuery, sizeof(cQuery), "UPDATE dealership SET owner='%s', ownerid='%s', name='%s', price='%d', type='%d', locked='%d', money='%d', stock='%d', posx='%f', posy='%f', posz='%f', posa='%f', pointx='%f', pointy='%f', pointz='%f', restock='%d' WHERE ID='%d'",
	DealerData[id][dealerOwner],
	DealerData[id][dealerOwnerId],
	DealerData[id][dealerName],
	DealerData[id][dealerPrice],
	DealerData[id][dealerType],
	DealerData[id][dealerLocked],
	DealerData[id][dealerMoney],
	DealerData[id][dealerStock],
	DealerData[id][dealerPosX],
	DealerData[id][dealerPosY],
	DealerData[id][dealerPosZ],
	DealerData[id][dealerPosA],
	DealerData[id][dealerPointX],
	DealerData[id][dealerPointY],
	DealerData[id][dealerPointZ],
	DealerData[id][dealerRestock],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}

DealerPointRefresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamic3DTextLabel(DealerData[id][dealerPointLabel]))
        DestroyDynamic3DTextLabel(DealerData[id][dealerPointLabel]);

    	if(IsValidDynamicPickup(DealerData[id][dealerPickupPoint]))
        	DestroyDynamicPickup(DealerData[id][dealerPickupPoint]);

		new tstr[218];
		if(DealerData[id][dealerPointX] != 0 && DealerData[id][dealerPointY] != 0 && DealerData[id][dealerPointZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"%s Dealership Vehicle Spawn Point", id, DealerData[id][dealerName]);
			DealerData[id][dealerPointLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ], 5.0);
        	DealerData[id][dealerPickupPoint] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ]);
		}
		else if(DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"%s Dealership Vehicle Spawn Point", id, DealerData[id][dealerName]);
			DealerData[id][dealerPointLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ], 5.0);
        	DealerData[id][dealerPickupPoint] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ]);
    	}
	}
}

DealerRefresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamic3DTextLabel(DealerData[id][dealerLabel]))
            DestroyDynamic3DTextLabel(DealerData[id][dealerLabel]);

        if(IsValidDynamicPickup(DealerData[id][dealerPickup]))
            DestroyDynamicPickup(DealerData[id][dealerPickup]);

        DestroyDynamicMapIcon(bData[id][bMap]);

        new type[128];
		if(DealerData[id][dealerType] == 1)
		{
			type= "Motorcycle";
		}
		else if(DealerData[id][dealerType] == 2)
		{
			type= "Cars";
		}
		else if(DealerData[id][dealerType] == 3)
		{
			type= "Unique Cars";
		}
		else if(DealerData[id][dealerType] == 4)
		{
			type= "Jobs Cars";
		}
		else if(DealerData[id][dealerType] == 5)
		{
			type= "Boat";
		}
		else
		{
			type= "Unknown";
		}

		new tstr[218];
		if(DealerData[id][dealerPosX] != 0 && DealerData[id][dealerPosY] != 0 && DealerData[id][dealerPosZ] != 0 && strcmp(DealerData[id][dealerOwner], "-") || DealerData[id][dealerOwnerId] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"Name: {FFFF00}%s\n"WHITE_E"Owned by %s\nType: "YELLOW_E"%s\n"WHITE_E"Stock: "GREY_E"%d\n"WHITE_E"Use "RED_E"/buypv "WHITE_E"to buy vehicle in this dealership", id, DealerData[id][dealerName], DealerData[id][dealerOwner], type, DealerData[id][dealerStock]);
			DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(tstr, COLOR_LBLUE, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 5.0);
            DealerData[id][dealerPickup] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]);
		}
		else if(DealerData[id][dealerPosX] != 0 && DealerData[id][dealerPosY] != 0 && DealerData[id][dealerPosZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"This dealership for sell\nLocation: %s\nPrice: "GREEN_E"%s\n"WHITE_E"Type: "YELLOW_E"%s", id, GetLocation(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]), FormatMoney(DealerData[id][dealerPrice]), type);
			DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(tstr, COLOR_LBLUE, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 5.0);
            DealerData[id][dealerPickup] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]);
   		}

        if(DealerData[id][dealerType] == 1)
		{
			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
		}
		else if(DealerData[id][dealerType] == 2)
		{
			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
		}
		else if(DealerData[id][dealerType] == 3)
		{
			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
		}
		else if(DealerData[id][dealerType] == 4)
		{
			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosX], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
		}
		else if(DealerData[id][dealerType] == 5)
		{
			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosX], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
		}
		else
		{
			DestroyDynamicMapIcon(DealerData[id][dealerMap]);
		}
	}
}

DealerReset(id)
{
	format(DealerData[id][dealerOwner], MAX_PLAYER_NAME, "-");
	DestroyDynamicPickup(DealerData[id][dealerPickup]);
	DestroyDynamicPickup(DealerData[id][dealerPickupPoint]);
	DealerData[id][dealerOwnerId] = 0;
	DealerData[id][dealerLocked] = 1;
    DealerData[id][dealerMoney] = 0;
	DealerData[id][dealerStock] = 0;
	DealerData[id][dealerRestock] = 0;
	DealerRefresh(id);
}

PlayerOwnsDealership(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(id == -1) return 0;
	if(!strcmp(DealerData[id][dealerOwner], pData[playerid][pName], true)) return 1;
	return 0;
}

Player_DealerCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new i : Dealer)
	{
		if(PlayerOwnsDealership(playerid, i)) count++;
	}
	return count;
	#else
		return 0;
	#endif
}

DealerBuyVehicle(playerid, dealerid)
{
	if(dealerid <= -1 )
        return 0;

    switch(DealerData[dealerid][dealerType])
    {
        case 1:
        {
            new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"%s\n%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n",
			GetVehicleModelName(481), FormatMoney(GetDealerVehicleCost(481)),
			GetVehicleModelName(509), FormatMoney(GetDealerVehicleCost(509)),
			GetVehicleModelName(510), FormatMoney(GetDealerVehicleCost(510)),
			GetVehicleModelName(462), FormatMoney(GetDealerVehicleCost(462)),
			GetVehicleModelName(586), FormatMoney(GetDealerVehicleCost(586)),
			GetVehicleModelName(581), FormatMoney(GetDealerVehicleCost(581)),
			GetVehicleModelName(461), FormatMoney(GetDealerVehicleCost(461)),
			GetVehicleModelName(521), FormatMoney(GetDealerVehicleCost(521)),
			GetVehicleModelName(463), FormatMoney(GetDealerVehicleCost(463)),
			GetVehicleModelName(468), FormatMoney(GetDealerVehicleCost(468))
			);

			ShowPlayerDialog(playerid, DIALOG_BUYMOTORCYCLEVEHICLE, DIALOG_STYLE_LIST, "Motorcyle Dealership", str, "Buy", "Close");
		}
        case 2:
        {
            new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n",
			GetVehicleModelName(400), FormatMoney(GetDealerVehicleCost(400)),
			GetVehicleModelName(412), FormatMoney(GetDealerVehicleCost(412)),
			GetVehicleModelName(419), FormatMoney(GetDealerVehicleCost(419)),
			GetVehicleModelName(426), FormatMoney(GetDealerVehicleCost(426)),
			GetVehicleModelName(436), FormatMoney(GetDealerVehicleCost(436)),
			GetVehicleModelName(466), FormatMoney(GetDealerVehicleCost(466)),
			GetVehicleModelName(467), FormatMoney(GetDealerVehicleCost(467)),
			GetVehicleModelName(474), FormatMoney(GetDealerVehicleCost(474)),
			GetVehicleModelName(475), FormatMoney(GetDealerVehicleCost(475)),
			GetVehicleModelName(480), FormatMoney(GetDealerVehicleCost(480)),
			GetVehicleModelName(603), FormatMoney(GetDealerVehicleCost(603)),
			GetVehicleModelName(421), FormatMoney(GetDealerVehicleCost(421)),
			GetVehicleModelName(602), FormatMoney(GetDealerVehicleCost(602)),
			GetVehicleModelName(492), FormatMoney(GetDealerVehicleCost(492)),
			GetVehicleModelName(545), FormatMoney(GetDealerVehicleCost(545)),
			GetVehicleModelName(489), FormatMoney(GetDealerVehicleCost(489)),
			GetVehicleModelName(405), FormatMoney(GetDealerVehicleCost(405)),
			GetVehicleModelName(445), FormatMoney(GetDealerVehicleCost(445)),
			GetVehicleModelName(579), FormatMoney(GetDealerVehicleCost(579)),
			GetVehicleModelName(507), FormatMoney(GetDealerVehicleCost(507))
			);

			ShowPlayerDialog(playerid, DIALOG_BUYCARSVEHICLE, DIALOG_STYLE_LIST, "Cars Dealership", str, "Buy", "Close");
		}
        case 3:
        {
            new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n",
			GetVehicleModelName(483), FormatMoney(GetDealerVehicleCost(483)),
			GetVehicleModelName(534), FormatMoney(GetDealerVehicleCost(534)),
			GetVehicleModelName(535), FormatMoney(GetDealerVehicleCost(535)),
			GetVehicleModelName(536), FormatMoney(GetDealerVehicleCost(536)),
			GetVehicleModelName(558), FormatMoney(GetDealerVehicleCost(558)),
			GetVehicleModelName(559), FormatMoney(GetDealerVehicleCost(559)),
			GetVehicleModelName(560), FormatMoney(GetDealerVehicleCost(560)),
			GetVehicleModelName(561), FormatMoney(GetDealerVehicleCost(561)),
			GetVehicleModelName(562), FormatMoney(GetDealerVehicleCost(562)),
			GetVehicleModelName(565), FormatMoney(GetDealerVehicleCost(565)),
			GetVehicleModelName(567), FormatMoney(GetDealerVehicleCost(567)),
			GetVehicleModelName(575), FormatMoney(GetDealerVehicleCost(575)),
			GetVehicleModelName(576), FormatMoney(GetDealerVehicleCost(576))
			);

			ShowPlayerDialog(playerid, DIALOG_BUYUCARSVEHICLE, DIALOG_STYLE_LIST, "Unique Cars Dealership", str, "Buy", "Close");
		}
        case 4:
		{
			//Job Cars
			new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n",
			GetVehicleModelName(420), FormatMoney(GetDealerVehicleCost(420)),
			GetVehicleModelName(438), FormatMoney(GetDealerVehicleCost(438)),
			GetVehicleModelName(403), FormatMoney(GetDealerVehicleCost(403)),
			GetVehicleModelName(413), FormatMoney(GetDealerVehicleCost(413)),
			GetVehicleModelName(414), FormatMoney(GetDealerVehicleCost(414)),
			GetVehicleModelName(422), FormatMoney(GetDealerVehicleCost(422)),
			GetVehicleModelName(440), FormatMoney(GetDealerVehicleCost(440)),
			GetVehicleModelName(455), FormatMoney(GetDealerVehicleCost(455)),
			GetVehicleModelName(456), FormatMoney(GetDealerVehicleCost(456)),
			GetVehicleModelName(478), FormatMoney(GetDealerVehicleCost(478)),
			GetVehicleModelName(482), FormatMoney(GetDealerVehicleCost(482)),
			GetVehicleModelName(498), FormatMoney(GetDealerVehicleCost(498)),
			GetVehicleModelName(499), FormatMoney(GetDealerVehicleCost(499)),
			GetVehicleModelName(423), FormatMoney(GetDealerVehicleCost(423)),
			GetVehicleModelName(588), FormatMoney(GetDealerVehicleCost(588)),
			GetVehicleModelName(524), FormatMoney(GetDealerVehicleCost(524)),
			GetVehicleModelName(525), FormatMoney(GetDealerVehicleCost(525)),
			GetVehicleModelName(543), FormatMoney(GetDealerVehicleCost(543)),
			GetVehicleModelName(552), FormatMoney(GetDealerVehicleCost(552)),
			GetVehicleModelName(554), FormatMoney(GetDealerVehicleCost(554)),
			GetVehicleModelName(578), FormatMoney(GetDealerVehicleCost(578)),
			GetVehicleModelName(609), FormatMoney(GetDealerVehicleCost(609))
			//GetVehicleModelName(530), FormatMoney(GetDealerVehicleCost(530)) //fortklift
			);

			ShowPlayerDialog(playerid, DIALOG_BUYJOBCARSVEHICLE, DIALOG_STYLE_LIST, "Job Cars", str, "Buy", "Close");
		}
        case 5:
        {
            new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t"LG_E"%s\n%s\t\n",
			GetVehicleModelName(473), FormatMoney(GetDealerVehicleCost(473)),
			GetVehicleModelName(453), FormatMoney(GetDealerVehicleCost(453)),
			GetVehicleModelName(446), FormatMoney(GetDealerVehicleCost(446)),
			GetVehicleModelName(452), FormatMoney(GetDealerVehicleCost(452)),
			GetVehicleModelName(493), FormatMoney(GetDealerVehicleCost(493))
			);

			ShowPlayerDialog(playerid, DIALOG_BUYBOAT, DIALOG_STYLE_LIST, "Boat Dealership", str, "Buy", "Close");
		}
    }
    return 1;
}

GetDealerVehicleCost(carid)
{
	//Ini Kendaraan saat beli pakai uang IC
	//boat
	if(carid == 473) return 130000;
	if(carid == 453) return 100000;
	if(carid == 446) return 300000;
	if(carid == 452) return 400000;
	if(carid == 493) return 600000;

	//Category Kendaraan Bike
	if(carid == 481) return 20000;  //Bmx
	if(carid == 509) return 30000; //Bike
	if(carid == 510) return 50000; //Mt bike
	if(carid == 463) return 350000; //Freeway harley
	if(carid == 521) return 620000; //Fcr 900
	if(carid == 461) return 420000; //Pcj 600
	if(carid == 581) return 230000; //Bf
	if(carid == 468) return 240000; //Sancehz
	if(carid == 586) return 150000; //Wayfare
	if(carid == 462) return 100000; //Faggio

	//Category Kendaraan Cars
	if(carid == 445) return 400000; //Admiral
	if(carid == 496) return 420000; //Blista Compact
	if(carid == 401) return 320000; //Bravura
	if(carid == 518) return 210000; //Buccaneer
	if(carid == 527) return 310000; //Cadrona
	if(carid == 483) return 300000; //Camper
	if(carid == 542) return 350000; //Clover
	if(carid == 589) return 500000; //Club
	if(carid == 507) return 480000; //Elegant
	if(carid == 540) return 520000; //Vincent
	if(carid == 585) return 320000; //Emperor
	if(carid == 419) return 440000; //Esperanto
	if(carid == 526) return 520000; //Fortune
	if(carid == 466) return 450000; //Glendale
	if(carid == 492) return 450000; //Greenwood
	if(carid == 474) return 575000; //Hermes
	if(carid == 546) return 220000; //Intruder
	if(carid == 517) return 320000; //Majestic
	if(carid == 410) return 210000; //Manana
	if(carid == 551) return 450000; //Merit
	if(carid == 516) return 320000; //Nebula
	if(carid == 467) return 240000; //Oceanic
	if(carid == 404) return 500000; //Perenniel
	if(carid == 600) return 200000; //Picador
	if(carid == 426) return 600000; //Premier
	if(carid == 436) return 230000; //Previon
	if(carid == 547) return 450000; //Primo
	if(carid == 405) return 550000; //Sentinel
	if(carid == 458) return 600000; //Solair
	if(carid == 439) return 300000; //Stallion
	if(carid == 550) return 500000; //Sunrise
	if(carid == 566) return 650000; //Tahoma
	if(carid == 549) return 340000; //Tampa
	if(carid == 491) return 230000; //Virgo
	if(carid == 412) return 250000; //Voodoo
	if(carid == 421) return 280000; //Washington
	if(carid == 529) return 230000; //Willard
	if(carid == 555) return 220000; //Windsor
	if(carid == 580) return 500000; //Stafford
	if(carid == 475) return 525000; //Sabre
	if(carid == 545) return 750000; //Hustler

	//Category Kendaraan Lowriders
	if(carid == 536) return 750000; //Blade
	if(carid == 575) return 650000; //Broadway
	if(carid == 533) return 420000; //Feltzer
	if(carid == 534) return 400000; //Remington
	if(carid == 567) return 850000; //Savanna
	if(carid == 535) return 600000; //Slamvan
	if(carid == 576) return 500000; //Tornado
	if(carid == 566) return 650000; //Tahoma
	if(carid == 412) return 250000; //Voodoo

	//Category Kendaraan SUVS Cars
	if(carid == 579) return 850000; //Huntley
	if(carid == 400) return 450000; //Landstalker
	if(carid == 500) return 800000; //Mesa
	if(carid == 489) return 400000; //Rancher
	if(carid == 479) return 300000; //Regina
	if(carid == 482) return 400000; //Burrito
	if(carid == 418) return 500000; //Moonbeam
	if(carid == 413) return 350000; //Pony
	//if(carid == 554) return 18000; //Yosemite

	//Category Kendaraan Sports
	if(carid == 602) return 1000000; //Alpha
	if(carid == 429) return 1500000; //Banshee
	if(carid == 562) return 1750000; //Elegy
	if(carid == 587) return 1200000; //Euros
	if(carid == 565) return 1350000; //Flash
	if(carid == 559) return 1500000; //Jester
	if(carid == 561) return 1250000; //Stratum
	if(carid == 560) return 1700000; //Sultan
	if(carid == 506) return 2500000; //Super GT
	if(carid == 558) return 1450000; //Uranus
	if(carid == 477) return 3000000; //Zr-350
	if(carid == 480) return 1500000; //Comet

	//Category Kendaraan Non Dealer
	if(carid == 434) return 2000000; //Hotknife
	if(carid == 502) return 2200000; //Hotring Racer
	if(carid == 495) return 2300000; //Sandking
	if(carid == 451) return 2300000; //Turismo
	if(carid == 470) return 5000000; //Patriot
	if(carid == 424) return 1000000; //BF Injection
	if(carid == 522) return 1000000; //Nrg
	if(carid == 411) return 3500000; //Infernus
	if(carid == 541) return 2750000; //Bullet
	if(carid == 504) return 1000000; //Bloodring Banger
	if(carid == 603) return 1000000; //Phoenix
	if(carid == 415) return 2300000; //Cheetah
	if(carid == 402) return 1500000; //Buffalo
	if(carid == 508) return 1000000; //Journey
	if(carid == 457) return 800000; //Caddy
	if(carid == 471) return 500000; //Quad

	//Category Kendaraan Job
	if(carid == 420) return 150000; //Taxi
	if(carid == 438) return 170000; //Cabbie
	if(carid == 403) return 350000; //Linerunner
	if(carid == 414) return 220000; //Mule
	if(carid == 422) return 200000; //Bobcat
	if(carid == 440) return 170000; //Rumpo
	if(carid == 455) return 250000; //Flatbead
	if(carid == 456) return 190000; //Yankee
	if(carid == 478) return 170000; //Walton
	if(carid == 498) return 220000; //Boxville
	if(carid == 499) return 250000; //Benson
	if(carid == 514) return 450000; //Tanker
	if(carid == 515) return 650000; //Roadtrain
	if(carid == 524) return 220000; //Cement Truck
	if(carid == 525) return 250000; //Towtruck
	if(carid == 543) return 275000; //Sadler
	if(carid == 552) return 180000; //Utility Van
	if(carid == 554) return 300000; //Yosemite
	if(carid == 578) return 350000; //DFT-30
	if(carid == 609) return 220000; //Boxville
	if(carid == 423) return 250000; //Mr Whoopee/Ice cream
	if(carid == 588) return 280000; //Hotdog
 	return -1;
}

/* ============ [ Hook, Function goes here ] ============ */

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_BUYMOTORCYCLEVEHICLE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 481;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 509;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 510;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 462;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 586;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 581;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 461;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 521;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 463;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 468;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
    if(dialogid == DIALOG_BUYCARSVEHICLE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 400;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 412;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 419;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 426;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 436;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 466;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 467;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 474;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 475;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 480;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 603;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 421;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 602;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 13:
				{
					new modelid = 492;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 14:
				{
					new modelid = 545;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 15:
				{
					new modelid = 489;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 16:
				{
					new modelid = 405;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 17:
				{
					new modelid = 445;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 18:
				{
					new modelid = 579;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 19:
				{
					new modelid = 507;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYUCARSVEHICLE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 483;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 534;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 535;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 536;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 558;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 559;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 560;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 561;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 562;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 565;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 567;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 575;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 576;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYJOBCARSVEHICLE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 420;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 438;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 403;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 3:
				{
					new modelid = 413;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 414;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 5:
				{
					new modelid = 422;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 6:
				{
					new modelid = 440;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 7:
				{
					new modelid = 455;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 8:
				{
					new modelid = 456;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 9:
				{
					new modelid = 478;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 10:
				{
					new modelid = 482;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 11:
				{
					new modelid = 498;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 12:
				{
					new modelid = 499;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 13:
				{
					new modelid = 423;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 14:
				{
					new modelid = 588;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 15:
				{
					new modelid = 524;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 16:
				{
					new modelid = 525;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 17:
				{
					new modelid = 543;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 18:
				{
					new modelid = 552;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 19:
				{
					new modelid = 554;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 20:
				{
					new modelid = 578;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
				case 21:
				{
					new modelid = 609;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
				}
			}
		}
	}
    if(dialogid == DIALOG_BUYBOAT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 473;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Boat", tstr, "Buy", "Batal");
				}
				case 1:
				{
					new modelid = 453;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Boat", tstr, "Buy", "Batal");
				}
				case 2:
				{
					new modelid = 446;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Boat", tstr, "Buy", "Batal");
				}
                case 3:
				{
					new modelid = 452;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Boat", tstr, "Buy", "Batal");
				}
				case 4:
				{
					new modelid = 493;
					new tstr[128], price = GetDealerVehicleCost(modelid);
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
					ShowPlayerDialog(playerid, DIALOG_BUYDEALERCARS_CONFIRM, DIALOG_STYLE_MSGBOX, "Private Boat", tstr, "Buy", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYDEALERCARS_CONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel];
		foreach(new bid : Dealer)
		if(response)
		{
			if(modelid <= 0) return Error(playerid, "Invalid model id.");
			new cost = GetDealerVehicleCost(modelid);
			if(pData[playerid][pMoney] < cost)
			{
				Error(playerid, "Uang anda tidak mencukupi.!");
				return 1;
			}
			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID])
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			new dealerid = pData[playerid][pInDealer];
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new model, color1, color2;
			DealerData[dealerid][dealerMoney] += cost;
			DealerData[dealerid][dealerStock]--;
			if(DealerData[dealerid][dealerStock] < 0)
				return Error(playerid, "This dealer is out of stock product.");
			GivePlayerMoneyEx(playerid, -cost);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
			color1 = 1;
			color2 = 1;
			model = modelid;
			x = DealerData[dealerid][dealerPointX];
			y = DealerData[dealerid][dealerPointY];
			z = DealerData[dealerid][dealerPointZ];
			DealerSave(bid);
			DealerRefresh(bid);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}
    if(dialogid == DIALOG_DEALER_MANAGE)
	{
		new dealerid = pData[playerid][pInDealer];
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new string[258];
					format(string, sizeof(string), "Dealer ID: %d\nDealer Name : %s\nDealer Location: %s\nDealership Vault: %s\nDealership Stock: %d",
					dealerid, DealerData[dealerid][dealerName], GetLocation(DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]), FormatMoney(DealerData[dealerid][dealerMoney]), DealerData[dealerid][dealerStock]);

					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Dealerhip Information", string, "Cancel", "");
				}
				case 1:
				{
					new string[218];
					format(string, sizeof(string), "Tulis Nama Dealer baru yang anda inginkan : ( Nama Dealer Lama %s )", DealerData[dealerid][dealerName]);
					ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT, "Dealership Change Name", string, "Select", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, DIALOG_DEALER_VAULT, DIALOG_STYLE_LIST,"Dealership Vault","Dealership Deposit\nDealership Withdraw","Select","Cancel");
				}
				case 3:
				{
					if(DealerData[dealerid][dealerStock] > 100)
						return Error(playerid, "Dealership ini masih memiliki cukup produck.");
					if(DealerData[dealerid][dealerMoney] < 5000)
						return Error(playerid, "Setidaknya anda mempunyai uang dalam dealer anda senilai $5,000 untuk merestock product.");
					DealerData[dealerid][dealerRestock] = 1;
					Info(playerid, "Anda berhasil request untuk mengisi stock kendaraan kepada trucker, harap tunggu sampai pekerja trucker melayani.");
				}
			}
		}
		return 1;
	}
    if(dialogid == DIALOG_DEALER_NAME)
	{
		if(response)
		{
			new bid = pData[playerid][pInDealer];

			if(!PlayerOwnsDealership(playerid, pData[playerid][pInDealer])) return Error(playerid, "You don't own this Dealership.");

			if (isnull(inputtext))
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Dealership tidak di perbolehkan kosong!\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerData[bid][dealerName]);
				ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			if(strlen(inputtext) > 32 || strlen(inputtext) < 5)
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Dealership harus 5 sampai 32 kata.\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerData[bid][dealerName]);
				ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			format(DealerData[bid][dealerName], 32, ColouredText(inputtext));

			DealerRefresh(bid);
			DealerSave(bid);

			SendClientMessageEx(playerid, COLOR_LBLUE,"Dealer name set to: \"%s\".", DealerData[bid][dealerName]);
		}
		else return callcmd::dealermanage(playerid, "\0");
		return 1;
	}
    if(dialogid == DIALOG_DEALER_VAULT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Uang kamu: %s.\n\nMasukkan berapa banyak uang yang akan kamu simpan di dalam Dealership ini", FormatMoney(GetPlayerMoney(playerid)));
					ShowPlayerDialog(playerid, DIALOG_DEALER_DEPOSIT, DIALOG_STYLE_INPUT, "Dealer Deposit Input", mstr, "Deposit", "Cancel");
				}
				case 1:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Dealer Vault: %s\n\nMasukkan berapa banyak uang yang akan kamu ambil di dalam Dealer ini", FormatMoney(DealerData[pData[playerid][pInDealer]][dealerMoney]));
					ShowPlayerDialog(playerid, DIALOG_DEALER_WITHDRAW, DIALOG_STYLE_INPUT,"Dealer Withdraw Input", mstr, "Withdraw","Cancel");
				}
			}
		}
	}
    if(dialogid == DIALOG_DEALER_WITHDRAW)
	{
		if(response)
		{
			new bid = pData[playerid][pInDealer];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > DealerData[bid][dealerMoney])
				return Error(playerid, "Invalid amount specified!");

			DealerData[bid][dealerMoney] -= amount;
			DealerSave(bid);

			GivePlayerMoneyEx(playerid, amount);

			Info(playerid, "You have withdrawn %s from the Dealership vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, DIALOG_DEALER_VAULT, DIALOG_STYLE_LIST,"Dealer Vault","Dealership Deposit\nDealership Withdraw","Next","Back");
		return 1;
	}
    if(dialogid == DIALOG_DEALER_DEPOSIT)
	{
		if(response)
		{
			new bid = pData[playerid][pInDealer];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > GetPlayerMoney(playerid))
				return Error(playerid, "Invalid amount specified!");

			DealerData[bid][dealerMoney] += amount;
			DealerSave(bid);

			GivePlayerMoneyEx(playerid, -amount);

			Info(playerid, "You have deposit %s into the Dealership vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, DIALOG_DEALER_VAULT, DIALOG_STYLE_LIST,"Dealership Vault","Dealership Deposit\nDealership Withdraw","Next","Back");
		return 1;
	}
	if(dialogid == DIALOG_FIND_DEALER)
	{
	    if(response)
	    {

            SetPlayerRaceCheckpoint(playerid,1, DealerData[listitem][dealerPosX], DealerData[listitem][dealerPosY], DealerData[listitem][dealerPosZ], 0.0, 0.0, 0.0, 3.5);


			SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}The Dealership You Selected Is Marked On You Map");
		}
	}
	if(dialogid == DIALOG_DEALER_RESTOCK)
	{
		if(response)
		{
			new id = ReturnRestockDealerID((listitem + 1)), vehicleid = GetPlayerVehicleID(playerid);
			if(DealerData[id][dealerMoney] < 1000)
				return Error(playerid, "Maaf, Dealership ini kehabisan uang untuk Restock.");

			if(pData[playerid][pMission] > -1 || pData[playerid][pHauling] > -1 || pData[playerid][pDealerMission] > -1)
				return Error(playerid, "Anda sudah sedang melakukan mission/hauling/dealermission!");

			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");

			pData[playerid][pDealerMission] = id;
			DealerData[id][dealerRestock] = 0;

			new line9[900];
			new type[128];
			if(DealerData[id][dealerType] == 1)
			{
				type= "Motorcycle";
			}
			else if(DealerData[id][dealerType] == 2)
			{
				type= "Cars";
			}
			else if(DealerData[id][dealerType] == 3)
			{
				type= "Unique Cars";
			}
			else if(DealerData[id][dealerType] == 4)
			{
				type= "Job Cars";
			}
			else if(DealerData[id][dealerType] == 5)
			{
				type= "Truck";
			}
			else
			{
				type= "Unknow";
			}
			format(line9, sizeof(line9), "Silahkan anda Kaitkan Trailer Hauling lalu antarkan ke dealership tujuan\n\nDealer ID: %d\nDealership Owner: %s\nDealership Name: %s\nDealership Type: %s\n\nSetelah itu ikuti checkpoint dan antarkan ke dealership mission anda!",
			id, DealerData[id][dealerOwner], DealerData[id][dealerName], type);
			SendClientMessage(playerid, COLOR_JOB,"TRUCKING: {FFFFFF}Silahkan Menuju Checkpoint dan Kaitkan Trailer ke truck anda lalu antarkan ke dealership!");
			SetPlayerRaceCheckpoint(playerid,1, -477.9302,-484.1866,25.5178, 0.0, 0.0, 0.0, 3.5);
			//SetPlayerCheckpoint(playerid, -279.67, -2148.42, 28.54, 3.5);
			TrailerHauling[playerid] = CreateVehicle(435, -477.9302,-484.1866,25.5178,166.3754, 1, 1, -1);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Hauling Info", line9, "Close","");
		}
	}
	if(dialogid == DIALOG_MY_DEALERSHIP)
	{
		if(!response) return true;
		SetPVarInt(playerid, "ClickedBisnis", ReturnPlayerBisnisID(playerid, (listitem + 1)));
		ShowPlayerDialog(playerid, DEALERSHIP_INFO, DIALOG_STYLE_LIST, "{0000FF}My Dealership", "Show Information\nTrack Bisnis", "Select", "Cancel");
		return 1;
	}
	if(dialogid == DEALERSHIP_INFO)
	{
		if(!response) return true;
		new id = GetPVarInt(playerid, "ClickedBisnis");
		switch(listitem)
		{
			case 0:
			{
				new line9[900];
				new type[128];
				if(DealerData[id][dealerType] == 1)
				{
					type = "Motorcycle";
			
				}
				else if(DealerData[id][dealerType] == 2)
				{
					type = "Cars";
				}
				else if(DealerData[id][dealerType] == 3)
				{
					type = "Unique Cars";
				}
				else if(DealerData[id][dealerType] == 4)
				{
					type = "Job Cars";
				}
				else if(DealerData[id][dealerType] == 5)
				{
					type = "Electronic";
				}
				else if(DealerData[id][dealerType] == 6)
				{
					type = "Truck";
				}
				else
				{
					type = "Unknow";
				}
				format(line9, sizeof(line9), "Dealership ID: %d\nDealership Owner: %s\nDealership Name: %s\nDealership Type: %s", id, DealerData[id][dealerOwner], DealerData[id][dealerName], type);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Dealership Info", line9, "Close","");
			}
			case 1:
			{
				pData[playerid][pTrackDealership] = 1;
				SetPlayerRaceCheckpoint(playerid,1, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 0.0, 0.0, 0.0, 3.5);
				Info(playerid, "Ikuti checkpoint untuk menemukan dealership anda!");
			}
		}
		return 1;
	}
	return 1;
}

function OnVehDealer(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 1000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "NoHave");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	Iter_Add(PVehicles, i);
	OnVehicleDealerRespawn(i);
	Servers(playerid, "Anda telah membeli kendaraan %s dengan harga %s", GetVehicleModelName(model), FormatMoney(GetDealerVehicleCost(model)));
	pData[playerid][pBuyPvModel] = 0;
	SetPlayerVirtualWorld(playerid, 0);
	return 1;
}

function OnVehicleDealerRespawn(i)
{
	pvData[i][cVeh] = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], 60000);
	SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
	SetVehicleVirtualWorld(pvData[i][cVeh], pvData[i][cVw]);
	LinkVehicleToInterior(pvData[i][cVeh], pvData[i][cInt]);
	SetVehicleFuel(pvData[i][cVeh], pvData[i][cFuel]);
	if(pvData[i][cHealth] < 350.0)
	{
		SetValidVehicleHealth(pvData[i][cVeh], 350.0);
	}
	else
	{
		SetValidVehicleHealth(pvData[i][cVeh], pvData[i][cHealth]);
	}
	UpdateVehicleDamageStatus(pvData[i][cVeh], pvData[i][cDamage0], pvData[i][cDamage1], pvData[i][cDamage2], pvData[i][cDamage3]);
	if(pvData[i][cVeh] != INVALID_VEHICLE_ID)
    {
        if(pvData[i][cPaintJob] != -1)
        {
            ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
        }
		for(new z = 0; z < 17; z++)
		{
			if(pvData[i][cMod][z]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][z]);
		}
		if(pvData[i][cLocked] == 1)
		{
			SwitchVehicleDoors(pvData[i][cVeh], true);
		}
		else
		{
			SwitchVehicleDoors(pvData[i][cVeh], false);
		}
	}
	return 1;
}

function OnDealerCreated(dealerid)
{
	DealerRefresh(dealerid);
	DealerSave(dealerid);
	return 1;
}

function LoadDealership()
{
    static bid;

	new rows = cache_num_rows(), owner[128], name[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", bid);
			cache_get_value_name(i, "owner", owner);
			format(DealerData[bid][dealerOwner], 128, owner);
			cache_get_value_name_int(i, "type", DealerData[bid][dealerOwnerId]);
			cache_get_value_name(i, "name", name);
			format(DealerData[bid][dealerName], 128, name);
			cache_get_value_name_int(i, "type", DealerData[bid][dealerType]);
			cache_get_value_name_int(i, "price", DealerData[bid][dealerPrice]);
			cache_get_value_name_float(i, "posx", DealerData[bid][dealerPosX]);
			cache_get_value_name_float(i, "posy", DealerData[bid][dealerPosY]);
			cache_get_value_name_float(i, "posz", DealerData[bid][dealerPosZ]);
			cache_get_value_name_float(i, "posa", DealerData[bid][dealerPosA]);
			cache_get_value_name_int(i, "money", DealerData[bid][dealerMoney]);
			cache_get_value_name_int(i, "locked", DealerData[bid][dealerLocked]);
			cache_get_value_name_int(i, "stock", DealerData[bid][dealerStock]);
			cache_get_value_name_float(i, "pointx", DealerData[bid][dealerPointX]);
			cache_get_value_name_float(i, "pointy", DealerData[bid][dealerPointY]);
			cache_get_value_name_float(i, "pointz", DealerData[bid][dealerPointZ]);
			cache_get_value_name_int(i, "restock", DealerData[bid][dealerRestock]);
			DealerRefresh(bid);
			DealerPointRefresh(bid);
			Iter_Add(Dealer, bid);
		}
		printf("[Dynamic Dealership] Number of Loaded: %d.", rows);
	}
}


ptask PlayerDealerUpdate[1000](playerid)
{
	foreach(new vid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerData[vid][dealerPosX], DealerData[vid][dealerPosY], DealerData[vid][dealerPosZ]))
		{
			pData[playerid][pInDealer] = vid;
			/*Info(playerid, "DEBUG MESSAGE: Kamu berada di dekat Dealer ID %d", vid);*/
		}
	}
	return 1;
}

GetRestockDealer()
{
	new tmpcount;
	foreach(new id : Dealer)
	{
	    if(DealerData[id][dealerRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockDealerID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_DEALERSHIP) return -1;
	foreach(new id : Dealer)
	{
	    if(DealerData[id][dealerRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return tmpcount;
}

stock GetPlayerIDByName(const name[])
{
    new playerid;
    for (playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        if (IsPlayerConnected(playerid))
        {
            new pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, sizeof(pname));
            if (!strcmp(pname, name, true))
            {
                return playerid;
            }
        }
    }
    return INVALID_PLAYER_ID;
}