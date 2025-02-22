// Selected vehicle needs to be parked outside this building
CMD:basement(playerid, params[])
{
    static
        type[24],
        string[128];
    if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);
    if(sscanf(params, "s[24]S()[128]", type, string)) {
        Usage(playerid, "/basement [add/extin/extout/intin/intout/delete/goto]");
        SendCustomMessage(playerid, "GUIDE", ""YELLOW_E"'basement extin' pickup masuk ke basement dari luar");
        SendCustomMessage(playerid, "GUIDE", ""YELLOW_E"'basement extout' spawn diluar dari masuk basement");
        SendCustomMessage(playerid, "GUIDE", ""YELLOW_E"'basement intin' spawn didalam dari luar basement");
        SendCustomMessage(playerid, "GUIDE", ""YELLOW_E"'basement intout' pickup keluar dari basement dalam");
        return 1;
    }
    if(!strcmp(type, "add", true))
    {
        new name[52];

        if(sscanf(string, "s[52]", name)) {
            Usage(playerid, "/basement [add] [name]");
            return 1;
        }
        new id = Iter_Free(DoorBasement);
        if(id == -1) return Error(playerid, "You can't create a Basement anymore!");
        
        format(Basement[id][dbName], 52, name);
        GetPlayerPos(playerid, Basement[id][dbExtInPos][0], Basement[id][dbExtInPos][1], Basement[id][dbExtInPos][2]);
        GetPlayerFacingAngle(playerid, Basement[id][dbExtInPos][3]);
        Basement[id][dbExtint] = GetPlayerInterior(playerid);
        Basement[id][dbExtvw] = GetPlayerVirtualWorld(playerid);

        Basement[id][dbIntInPos][0] = 1304.7107;
        Basement[id][dbIntInPos][1] = 1458.5062;
        Basement[id][dbIntInPos][2] = 13.3396;
        Basement[id][dbIntInPos][3] = 270.5633;
        
        Basement[id][dbIntOutPos][0] = 1304.6908;
        Basement[id][dbIntOutPos][1] = 1463.1555;
        Basement[id][dbIntOutPos][2] = 13.5912;
        Basement[id][dbIntOutPos][3] = 90.4569;

        Basement[id][dbIntvw] = 12;
        Basement[id][dbIntint] = id;

        Iter_Add(DoorBasement, id);
        mysql_tquery(g_SQL, sprintf("INSERT INTO `basement` (`ID`) VALUES ('%d')",id), "OnBasementAdd", "d", id);
        SendCustomMessage(playerid, "BASEMENT", "You have created a "AQUA_E"Basement (%d)", id);
        SendCustomMessage(playerid, "NOTE", "Use '/basement' to edit basement");
    }
    else if(!strcmp(type, "extin", true))
    {
        new slot;

        if(sscanf(string, "d", slot)) {
            Usage(playerid, "/basement [extin] [ID]");
            return 1;
        }
        if(!Iter_Contains(DoorBasement, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        GetPlayerPos(playerid, Basement[slot][dbExtInPos][0], Basement[slot][dbExtInPos][1], Basement[slot][dbExtInPos][2]);
        GetPlayerFacingAngle(playerid, Basement[slot][dbExtInPos][3]);
        Basement[slot][dbExtint] = GetPlayerInterior(playerid);
        Basement[slot][dbExtvw] = GetPlayerVirtualWorld(playerid);
        Basement_Save(slot);
        Basement_Refresh(slot);
        SendCustomMessage(playerid, "BASEMENT", "You've have set cordinat ext in basement");
    }
    else if(!strcmp(type, "extout", true))
    {
        new slot;

        if(sscanf(string, "d", slot)) {
            Usage(playerid, "/basement [extout] [ID]");
            return 1;
        }
        if(!Iter_Contains(DoorBasement, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        GetPlayerPos(playerid, Basement[slot][dbExtOutPos][0], Basement[slot][dbExtOutPos][1], Basement[slot][dbExtOutPos][2]);
        GetPlayerFacingAngle(playerid, Basement[slot][dbExtOutPos][3]);
        Basement_Save(slot);
        Basement_Refresh(slot);
        SendCustomMessage(playerid, "BASEMENT", "You've have set cordinat ext out basement");
    }
    else if(!strcmp(type, "intin", true))
    {
        new slot;

        if(sscanf(string, "d", slot)) {
            Usage(playerid, "/basement [intin] [ID]");
            return 1;
        }
        if(!Iter_Contains(DoorBasement, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        GetPlayerPos(playerid, Basement[slot][dbIntInPos][0], Basement[slot][dbIntInPos][1], Basement[slot][dbIntInPos][2]);
        GetPlayerFacingAngle(playerid, Basement[slot][dbIntInPos][3]);
        Basement[slot][dbIntint] = GetPlayerInterior(playerid);
        Basement[slot][dbIntvw] = GetPlayerVirtualWorld(playerid);
        Basement_Save(slot);
        Basement_Refresh(slot);
        SendCustomMessage(playerid, "BASEMENT", "You've have set cordinat int in basement");
    }
    else if(!strcmp(type, "intout", true))
    {
        new slot;

        if(sscanf(string, "d", slot)) {
            Usage(playerid, "/basement [intout] [ID]");
            return 1;
        }
        if(!Iter_Contains(DoorBasement, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        GetPlayerPos(playerid, Basement[slot][dbIntOutPos][0], Basement[slot][dbIntOutPos][1], Basement[slot][dbIntOutPos][2]);
        GetPlayerFacingAngle(playerid, Basement[slot][dbIntOutPos][3]);
        Basement_Save(slot);
        Basement_Refresh(slot);
        SendCustomMessage(playerid, "BASEMENT", "You've have set cordinat int out basement");
    }
    else if(!strcmp(type, "goto", true))
    {
        new slot;

        if(sscanf(string, "d", slot)) {
            Usage(playerid, "/basement [goto] [ID]");
            return 1;
        }
        if(!Iter_Contains(DoorBasement, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        SendCustomMessage(playerid, "TELEPORT", "You successfully teleport to Basement "AQUA_E"id:%d", slot);
        SetPlayerPos(playerid, Basement[slot][dbExtInPos][0], Basement[slot][dbExtInPos][1], Basement[slot][dbExtInPos][2]);
        SetPlayerFacingAngle(playerid, Basement[slot][dbExtInPos][3]);
        SetPlayerVirtualWorld(playerid, Basement[slot][dbExtvw]);
        SetPlayerInterior(playerid, Basement[slot][dbExtint]);
    }
    else if(!strcmp(type, "delete", true))
    {
        new slot;

        if(sscanf(string, "d", slot)) {
            Usage(playerid, "/basement [delete] [ID]");
            return 1;
        }
        if(!Iter_Contains(DoorBasement, slot)) return Error(playerid, "The you specified ID of doesn't exist.");
        SendCustomMessage(playerid, "Basement", "You successfully removed Basement "AQUA_E"id:%d", slot);
        if(IsValidDynamic3DTextLabel(Basement[slot][dbLabelext])) DestroyDynamic3DTextLabel(Basement[slot][dbLabelext]);
        if(IsValidDynamicPickup(Basement[slot][dbPickupext])) DestroyDynamicPickup(Basement[slot][dbPickupext]);
        if(IsValidDynamicCP(Basement[slot][dbCP][0])) DestroyDynamicCP(Basement[slot][dbCP][0]);
        if(IsValidDynamicCP(Basement[slot][dbCP][1])) DestroyDynamicCP(Basement[slot][dbCP][1]);
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM basement WHERE ID=%d", Basement[slot][dbID]);
        mysql_tquery(g_SQL, query);
        new tmp_VehicleData[doorbasement];
        Basement[slot] = tmp_VehicleData;
        Iter_Remove(DoorBasement, slot);
    }
    return 1;
}
