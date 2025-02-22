
CMD:createprivategarage(playerid, params[])
{
    static type[24], string[128];
    if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);
    if(sscanf(params, "s[24]S()[128]", type, string)) return Usage(playerid, "/pvgarage [create/garagepos/textpos/gatepos/owner/delete]");
    if(!strcmp(type, "create", true))
    {
        new pvid = Iter_Free(PrivateGarage);
	    if(pvid == -1) return Error(playerid, "You cant create more private garage!");
        PrivateGarage[pvid][GaragePrice] = 3500000;
        if(IsValidDynamicObject(PrivateGarage[pvid][ObjectGarage])) DestroyDynamicObject(PrivateGarage[pvid][ObjectGarage]);
        GetPlayerPos(playerid, PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2]);
		PrivateGarage[pvid][GaragePos][3] = PrivateGarage[pvid][GaragePos][4] = PrivateGarage[pvid][GaragePos][5] = 0;
        PrivateGarage[pvid][TextPos][0] = PrivateGarage[pvid][TextPos][1] = PrivateGarage[pvid][TextPos][2] = 0;
        PrivateGarage[pvid][TextPos][3] = PrivateGarage[pvid][TextPos][4] = PrivateGarage[pvid][TextPos][5] = 0;
        PrivateGarage[pvid][GatePos][0] = PrivateGarage[pvid][GatePos][1] = PrivateGarage[pvid][GatePos][2] = PrivateGarage[pvid][DoorsStatus] = 0;
        PrivateGarage[pvid][GatePos][3] = PrivateGarage[pvid][GatePos][4] = PrivateGarage[pvid][GatePos][5] = 0;
        PrivateGarage[pvid][ObjectGarage] = CreateDynamicObject(17950, PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2], PrivateGarage[pvid][GaragePos][3], PrivateGarage[pvid][GaragePos][4], PrivateGarage[pvid][GaragePos][5], -1, -1, -1, 300.00, 300.00); 
        GetDynamicObjectPos(PrivateGarage[pvid][ObjectGarage], PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2]);
        GetDynamicObjectRot(PrivateGarage[pvid][ObjectGarage], PrivateGarage[pvid][GaragePos][3], PrivateGarage[pvid][GaragePos][4], PrivateGarage[pvid][GaragePos][5]);
        EditDynamicObject(playerid, PrivateGarage[pvid][ObjectGarage]);
        PvGarageEdit[playerid][0] = 1;
        PvGarageEdit[playerid][1] = 1;
        PvGarageEdit[playerid][2] = pvid;
        format(PrivateGarage[pvid][Owner], 52, "-");
        Iter_Add(PrivateGarage, pvid);
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO privategarage SET ID=%d, Owner='%s', Price='%d'", pvid, PrivateGarage[pvid][Owner], PrivateGarage[pvid][GaragePrice]);
        mysql_tquery(g_SQL, query, "PvGarageCreate", "i", pvid);
    }
    else if(!strcmp(type, "garagepos", true))
    {
        new slot;
        if(sscanf(string, "d", slot)) return Usage(playerid, "/pvgarage [garagepos] [id]");
		if(!Iter_Contains(PrivateGarage, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectGarage])) {
            GetDynamicObjectPos(PrivateGarage[slot][ObjectGarage], PrivateGarage[slot][GaragePos][0], PrivateGarage[slot][GaragePos][1], PrivateGarage[slot][GaragePos][2]);
            GetDynamicObjectRot(PrivateGarage[slot][ObjectGarage], PrivateGarage[slot][GaragePos][3], PrivateGarage[slot][GaragePos][4], PrivateGarage[slot][GaragePos][5]);
            EditDynamicObject(playerid, PrivateGarage[slot][ObjectGarage]);
            PvGarageEdit[playerid][0] = 1;
            PvGarageEdit[playerid][1] = 1;
            PvGarageEdit[playerid][2] = slot;
        } 
    }
    else if(!strcmp(type, "textpos", true))
    {
        new slot;
        if(sscanf(string, "d", slot)) return Usage(playerid, "/pvgarage [textpos] [id]");
		if(!Iter_Contains(PrivateGarage, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectText])) {
            GetDynamicObjectPos(PrivateGarage[slot][ObjectText], PrivateGarage[slot][TextPos][0], PrivateGarage[slot][TextPos][1], PrivateGarage[slot][TextPos][2]);
            GetDynamicObjectRot(PrivateGarage[slot][ObjectText], PrivateGarage[slot][TextPos][3], PrivateGarage[slot][TextPos][4], PrivateGarage[slot][TextPos][5]);
            EditDynamicObject(playerid, PrivateGarage[slot][ObjectText]);
            PvGarageEdit[playerid][0] = 1;
            PvGarageEdit[playerid][1] = 2;
            PvGarageEdit[playerid][2] = slot;
        } 
        else {
            GetPlayerPos(playerid, PrivateGarage[slot][TextPos][0], PrivateGarage[slot][TextPos][1], PrivateGarage[slot][TextPos][2]);
            PrivateGarage[slot][TextPos][3] = PrivateGarage[slot][TextPos][4] = PrivateGarage[slot][TextPos][5] = 0;
            PrivateGarage[slot][ObjectText] = CreateDynamicObject(1233, PrivateGarage[slot][TextPos][0], PrivateGarage[slot][TextPos][1], PrivateGarage[slot][TextPos][2], PrivateGarage[slot][TextPos][3], PrivateGarage[slot][TextPos][4], PrivateGarage[slot][TextPos][5], -1, -1, -1, 300.00, 300.00); 
            GetDynamicObjectPos(PrivateGarage[slot][ObjectText], PrivateGarage[slot][TextPos][0], PrivateGarage[slot][TextPos][1], PrivateGarage[slot][TextPos][2]);
            GetDynamicObjectRot(PrivateGarage[slot][ObjectText], PrivateGarage[slot][TextPos][3], PrivateGarage[slot][TextPos][4], PrivateGarage[slot][TextPos][5]);
            EditDynamicObject(playerid, PrivateGarage[slot][ObjectText]);
            PvGarageEdit[playerid][0] = 1;
            PvGarageEdit[playerid][1] = 2;
            PvGarageEdit[playerid][2] = slot;
        }
    }
    else if(!strcmp(type, "gatepos", true))
    {
        new slot;
        if(sscanf(string, "d", slot)) return Usage(playerid, "/pvgarage [gatepos] [id]");
		if(!Iter_Contains(PrivateGarage, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectDoors])) {
            GetDynamicObjectPos(PrivateGarage[slot][ObjectDoors], PrivateGarage[slot][GatePos][0], PrivateGarage[slot][GatePos][1], PrivateGarage[slot][GatePos][2]);
            GetDynamicObjectRot(PrivateGarage[slot][ObjectDoors], PrivateGarage[slot][GatePos][3], PrivateGarage[slot][GatePos][4], PrivateGarage[slot][GatePos][5]);
            EditDynamicObject(playerid, PrivateGarage[slot][ObjectDoors]);
            PvGarageEdit[playerid][0] = 1;
            PvGarageEdit[playerid][1] = 3;
            PvGarageEdit[playerid][2] = slot;
        } 
        else {
            GetPlayerPos(playerid, PrivateGarage[slot][GatePos][0], PrivateGarage[slot][GatePos][1], PrivateGarage[slot][GatePos][2]);
            PrivateGarage[slot][GatePos][3] = PrivateGarage[slot][GatePos][4] = PrivateGarage[slot][GatePos][5] = 0;
            PrivateGarage[slot][ObjectDoors] = CreateDynamicObject(17951,  PrivateGarage[slot][GatePos][0], PrivateGarage[slot][GatePos][1], PrivateGarage[slot][GatePos][2], PrivateGarage[slot][GatePos][3], PrivateGarage[slot][GatePos][4], PrivateGarage[slot][GatePos][5], -1, -1, -1, 300.00, 300.00); 
            GetDynamicObjectPos(PrivateGarage[slot][ObjectDoors], PrivateGarage[slot][GatePos][0], PrivateGarage[slot][GatePos][1], PrivateGarage[slot][GatePos][2]);
            GetDynamicObjectRot(PrivateGarage[slot][ObjectDoors], PrivateGarage[slot][GatePos][3], PrivateGarage[slot][GatePos][4], PrivateGarage[slot][GatePos][5]);
            EditDynamicObject(playerid, PrivateGarage[slot][ObjectDoors]);
            PvGarageEdit[playerid][0] = 1;
            PvGarageEdit[playerid][1] = 3;
            PvGarageEdit[playerid][2] = slot;
        }
    }
    else if(!strcmp(type, "owner", true))
    {
        new slot, owner[MAX_PLAYER_NAME];
        if(sscanf(string, "ds[32]", slot, owner)) return Usage(playerid, "/pvgarage [owner] [id] [name]");
		if(!Iter_Contains(PrivateGarage, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        format(PrivateGarage[slot][Owner], MAX_PLAYER_NAME, owner);
        PvGarageSave(slot);
        PvGarageRefresh(slot);
        SendCustomMessage(playerid, "GARAGE", ""GREEN_E"You successfully turn the owner of the private garage into a player "AQUA_E"%s", PrivateGarage[slot][Owner]);
    }
    else if(!strcmp(type, "delete", true))
    {
        new slot;
        if(sscanf(string, "d", slot)) return Usage(playerid, "/pvgarage [delete] [id]");
		if(!Iter_Contains(PrivateGarage, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        PrivateGarage[slot][GaragePos][0] = PrivateGarage[slot][GaragePos][1] = PrivateGarage[slot][GaragePos][2] = PrivateGarage[slot][GaragePos][3] = PrivateGarage[slot][GaragePos][4] = PrivateGarage[slot][GaragePos][5] = 0;
        PrivateGarage[slot][Vehicle][0] = PrivateGarage[slot][Vehicle][1] = PrivateGarage[slot][Vehicle][2] = PrivateGarage[slot][Vehicle][3] = PrivateGarage[slot][Vehicle][4] = -1;
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectGarage])) DestroyDynamicObject(PrivateGarage[slot][ObjectGarage]);
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectText])) DestroyDynamicObject(PrivateGarage[slot][ObjectText]);
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectButton])) DestroyDynamicObject(PrivateGarage[slot][ObjectButton]);
        if(IsValidDynamicObject(PrivateGarage[slot][ObjectDoors])) DestroyDynamicObject(PrivateGarage[slot][ObjectDoors]);
        SendCustomMessage(playerid, "GARAGE", ""GREEN_E"You successfully deleted private garage "AQUA_E"[ID: %d]", slot);
        Iter_Remove(PrivateGarage, slot);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM privategarage WHERE ID=%d", slot);
		mysql_tquery(g_SQL, query);
    }
    return 1;
}

CMD:givegarage(playerid, params[])
{
	new pvid, otherid;
	if(pData[playerid][pLevel] < 3) return Error(playerid, "Anda harus level 3 untuk bisa melalukan akses ini");
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, -1873.1708,2670.5906,3.5904)) return Error(playerid, "You must be in City Hall to use this command");
	if(sscanf(params, "ud", otherid, pvid)) return Usage(playerid, "/givegarage [playerid/name] [id] | /mp - for show info");
	if(pvid == -1) return Error(playerid, "Invalid id");
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0)) return Error(playerid, "The specified player is disconnected or not near you.");
	if(!OwnerPvGarage(playerid, pvid)) return Error(playerid, "You dont own this id privategarage.");
	if(PropertiCommercial_CountMax(playerid) >= PropertiesCommercial_Max(playerid)) return Error(playerid, "property slots are full");
	GetPlayerName(otherid, PrivateGarage[pvid][Owner], MAX_PLAYER_NAME);
	SendCustomMessage(otherid, "PROPERTY", ""AQUA_E"%s "WHITE_E"has given you the garage property", ReturnName2(playerid));
	SendCustomMessage(playerid, "PROPERTY", "You successfully gave the garage property to player "AQUA_E"%s", ReturnName2(otherid));
	return 1;
}
