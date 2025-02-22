#include <YSI\y_hooks>
hook OnGameModeInit() {
    new basementmap;
    basementmap = CreateDynamicObject(19375, 1300.613525, 1461.034912, 13.882836, 0.000000, 0.000000, -0.699999, 12, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(basementmap, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    basementmap = CreateDynamicObject(7245, 1327.028564, 1457.601562, 13.337623, 0.000000, 0.000000, 0.000000, 12, -1, -1, 250.00, 250.00); 
    basementmap = CreateDynamicObject(10149, 1300.732055, 1463.205688, 15.045871, 0.000000, 0.000000, -90.699935, 12, -1, -1, 250.00, 250.00); 
    basementmap = CreateDynamicObject(10149, 1300.675781, 1458.596313, 15.045871, 0.000000, 0.000000, -90.699935, 12, -1, -1, 250.00, 250.00); 
    basementmap = CreateDynamicObject(984, 1307.274902, 1460.693481, 12.625809, 13.699992, 0.000000, 89.800125, 12, -1, -1, 250.00, 250.00); 
    basementmap = CreateDynamicObject(8843, 1307.364013, 1458.634155, 11.953393, -13.799997, 0.000000, -87.999984, 12, -1, -1, 250.00, 250.00); 
    basementmap = CreateDynamicObject(8843, 1307.171997, 1462.835449, 12.031107, 14.000000, 0.000000, 89.700050, 12, -1, -1, 250.00, 250.00); 
    return 1;
}

function OnBasementAdd(id) {
    if (!Iter_Contains(DoorBasement, id))
        return 0;

    Basement[id][dbID] = cache_insert_id();
    Basement_Save(id);
    Basement_Refresh(id);
    return 1;
}

function Basement_Load() {
    new rows = cache_num_rows(), str[65];
    for (new i = 0; i < rows; i ++) {
        Iter_Add(DoorBasement, i);

        cache_get_value_int(i, "ID", Basement[i][dbID]);
        cache_get_value(i, "Name", Basement[i][dbName]);
        cache_get_value(i, "PositionExterior", str);
        sscanf(str, "p<|>ffffffff", Basement[i][dbExtInPos][0], Basement[i][dbExtInPos][1], Basement[i][dbExtInPos][2], Basement[i][dbExtInPos][3]
        , Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2], Basement[i][dbExtOutPos][3]);
        cache_get_value(i, "PositionInterior", str);
        sscanf(str, "p<|>ffffffff", Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2], Basement[i][dbIntInPos][3]
        , Basement[i][dbIntOutPos][0], Basement[i][dbIntOutPos][1], Basement[i][dbIntOutPos][2], Basement[i][dbIntOutPos][3]);
        cache_get_value_int(i, "InteriorExt", Basement[i][dbExtint]);
        cache_get_value_int(i, "WorldExt", Basement[i][dbExtvw]);
        cache_get_value_int(i, "InteriorInt", Basement[i][dbIntint]);
        cache_get_value_int(i, "WorldInt", Basement[i][dbIntvw]);
        Basement_Refresh(i);
    }
    printf("[Basement]: %d Loaded", rows);
    return 1;
}

Basement_Refresh(i) {
    new strings[512];
    if (!Iter_Contains(DoorBasement, i)) return 0;
    if(IsValidDynamic3DTextLabel(Basement[i][dbLabelext])) DestroyDynamic3DTextLabel(Basement[i][dbLabelext]);
    if(IsValidDynamicPickup(Basement[i][dbPickupext])) DestroyDynamicPickup(Basement[i][dbPickupext]);
    if(IsValidDynamicCP(Basement[i][dbCP][0])) DestroyDynamicCP(Basement[i][dbCP][0]);
    if(IsValidDynamicCP(Basement[i][dbCP][1])) DestroyDynamicCP(Basement[i][dbCP][1]);
    format(strings, sizeof(strings), "{00FFFF}[DID: %d]\n{FFFF00}%s\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door", i, Basement[i][dbName]);
    
    Basement[i][dbCP][0] = CreateDynamicCP(Basement[i][dbExtInPos][0], Basement[i][dbExtInPos][1], Basement[i][dbExtInPos][2], 4, Basement[i][dbExtvw], Basement[i][dbExtint]);
    Basement[i][dbCP][1] = CreateDynamicCP(Basement[i][dbIntOutPos][0], Basement[i][dbIntOutPos][1], Basement[i][dbIntOutPos][2], 4, Basement[i][dbIntvw], Basement[i][dbIntint]);
    Basement[i][dbPickupext] = CreateDynamicPickup(1239, 23, Basement[i][dbExtInPos][0], Basement[i][dbExtInPos][1], Basement[i][dbExtInPos][2], Basement[i][dbExtvw], Basement[i][dbExtint]);
    Basement[i][dbLabelext] = CreateDynamic3DTextLabel(strings, -1, Basement[i][dbExtInPos][0], Basement[i][dbExtInPos][1], Basement[i][dbExtInPos][2], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, Basement[i][dbExtvw], Basement[i][dbExtint]);
    return 1;
}

Basement_Save(i) {
    if (!Iter_Contains(DoorBasement, i))
        return 0;
    
    new query[1250];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE `basement` SET `Name`='%s', `PositionExterior`='%.2f|%.2f|%.2f|%.2f|%.2f|%.2f|%.2f|%.2f', `InteriorExt`='%d', `WorldExt`='%d', `InteriorInt`='%d', `WorldInt`='%d', `PositionInterior`='%.2f|%.2f|%.2f|%.2f|%.2f|%.2f|%.2f|%.2f' WHERE `ID`='%d'",
    Basement[i][dbName],
    Basement[i][dbExtInPos][0], Basement[i][dbExtInPos][1], Basement[i][dbExtInPos][2], Basement[i][dbExtInPos][3], 
    Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2], Basement[i][dbExtOutPos][3],
    Basement[i][dbExtint],
    Basement[i][dbExtvw],
    Basement[i][dbIntint],
    Basement[i][dbIntvw],
    Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2], Basement[i][dbIntInPos][3], 
    Basement[i][dbIntOutPos][0], Basement[i][dbIntOutPos][1], Basement[i][dbIntOutPos][2], Basement[i][dbIntOutPos][3],
    Basement[i][dbID]);
    return mysql_tquery(g_SQL, query);
}
