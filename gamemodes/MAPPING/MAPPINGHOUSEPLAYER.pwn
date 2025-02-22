CreateHousePlayer()
{
    new tmpobjid;
    //= RUMAH PEHTER
    CreateDynamicObject(3285, 2539.270019, -1066.310058, 70.500000, 0.000000, 0.000000, -87.907966, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "flatdoor01_law", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "flatdoor01_law", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 13628, "8stad", "stadroof", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 13628, "8stad", "stadroof", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 10765, "airportgnd_sfse", "white", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CreateDynamicObject(1280, 2530.599853, -1071.529174, 68.965660, 0.000000, 0.000000, -88.099967, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(18014, 2528.192138, -1064.334960, 68.987625, 0.000000, 0.000000, 1.499994, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(18014, 2528.321777, -1068.963623, 68.987625, 0.000000, 0.000000, 1.499994, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(2253, 2534.859619, -1062.059082, 68.848175, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(2253, 2538.012695, -1061.979003, 68.848175, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    CreateDynamicObject(3802, 2533.145507, -1064.887573, 71.181297, 0.000000, 2.899999, 177.700012, -1, -1, -1, 300.00, 300.00);
}

RemoveHSPlayer(playerid)
{
    //= RUMAH PEHTER
    RemoveBuildingForPlayer(playerid, 3285, 2539.270, -1066.310, 70.500, 0.250);
    RemoveBuildingForPlayer(playerid, 3300, 2539.270, -1066.310, 70.500, 0.250);

}