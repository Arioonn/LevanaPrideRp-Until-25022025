#define MAX_PRIVATE_GARAGE 10000
enum privategarage {
    ID,
    GaragePrice,
    Owner[52],
    Float:GaragePos[6],
    Float:TextPos[6],
    Float:GatePos[6],
    Vehicle[6],
    VehModel[6],
    DoorsStatus,
    ObjectGarage,
    ObjectText,
    ObjectButton,
    ObjectDoors
}
new PrivateGarage[MAX_PRIVATE_GARAGE][privategarage],
    Iterator: PrivateGarage<MAX_PRIVATE_GARAGE>;

PropertiesCommercial_GetCount(playerid) {
    new count = 0, string[32], maxProperties;

	foreach(new i : PrivateGarage) if(OwnerPvGarage(playerid, i)) {
        count++;
    }
    if (pData[playerid][pVip] == 2) maxProperties = MAX_OWN_COMMERCIAL+3;
    else if (pData[playerid][pVip] == 3) maxProperties = MAX_OWN_COMMERCIAL+4;
    else if (pData[playerid][pVip] == 4) maxProperties = MAX_OWN_COMMERCIAL+4;
    else maxProperties = MAX_OWN_COMMERCIAL;

    format(string, sizeof(string), "%d/%d", count, maxProperties);

    return string;
}

#pragma unused PropertiesCommercial_GetCount
native PropertiesCommercial_GetCount();

PropertiCommercial_CountMax(playerid) {
    new count = 0;

	foreach (new i : PrivateGarage) if(OwnerPvGarage(playerid, i)) {
        count++;
    }
    return count;
}

ReturnName2(playerid)
{
    static
        name[MAX_PLAYER_NAME + 1];

    GetPlayerName(playerid, name, sizeof(name));
	for (new i = 0, len = strlen(name); i < len; i ++) {
			if(name[i] == '_') name[i] = ' ';
	}
    return name;
}


PropertiesCommercial_Max(playerid) {
    new maxProperties;

    if (pData[playerid][pVip] == 2) maxProperties = MAX_OWN_COMMERCIAL+3;
    else if (pData[playerid][pVip] == 3) maxProperties = MAX_OWN_COMMERCIAL+4;
    else if (pData[playerid][pVip] == 4) maxProperties = MAX_OWN_COMMERCIAL+4;
    else maxProperties = MAX_OWN_COMMERCIAL;

    return maxProperties;
}