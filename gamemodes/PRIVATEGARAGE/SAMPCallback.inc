#include <YSI\y_hooks>
hook OnPlayerEditDynamicObj(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response == EDIT_RESPONSE_FINAL)
	{ 
        if(PvGarageEdit[playerid][0] == 1)
		{
			new pvid = PvGarageEdit[playerid][2];
			switch(PvGarageEdit[playerid][1])
			{
				case 1: {
					PrivateGarage[pvid][GaragePos][0] = x;
					PrivateGarage[pvid][GaragePos][1] = y; 
					PrivateGarage[pvid][GaragePos][2] = z;
					PrivateGarage[pvid][GaragePos][3] = rx;
					PrivateGarage[pvid][GaragePos][4] = ry;
					PrivateGarage[pvid][GaragePos][5] = rz;
					SetDynamicObjectPos(objectid,  PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2]);
					SetDynamicObjectRot(objectid, PrivateGarage[pvid][GaragePos][3], PrivateGarage[pvid][GaragePos][4], PrivateGarage[pvid][GaragePos][5]);
					SendCustomMessage(playerid, "EDIT", ""AQUA_E"Successfully edit private garage ID %d", pvid);
					PvGarageSave(pvid);
					PvGarageRefresh(pvid);
					Streamer_UpdateEx(playerid, PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2]);
					PvGarageEdit[playerid][0] = -1;
					PvGarageEdit[playerid][1] = -1;
					PvGarageEdit[playerid][2] = -1;
				}
				case 2: {
					PrivateGarage[pvid][TextPos][0] = x;
					PrivateGarage[pvid][TextPos][1] = y; 
					PrivateGarage[pvid][TextPos][2] = z;
					PrivateGarage[pvid][TextPos][3] = rx;
					PrivateGarage[pvid][TextPos][4] = ry;
					PrivateGarage[pvid][TextPos][5] = rz;
					SetDynamicObjectPos(objectid,  PrivateGarage[pvid][TextPos][0], PrivateGarage[pvid][TextPos][1], PrivateGarage[pvid][TextPos][2]);
					SetDynamicObjectRot(objectid, PrivateGarage[pvid][TextPos][3], PrivateGarage[pvid][TextPos][4], PrivateGarage[pvid][TextPos][5]);
					SendCustomMessage(playerid, "EDIT", ""AQUA_E"Successfully edit private garage ID %d", pvid);
					PvGarageSave(pvid);
					PvGarageRefresh(pvid);
					Streamer_UpdateEx(playerid, PrivateGarage[pvid][TextPos][0], PrivateGarage[pvid][TextPos][1], PrivateGarage[pvid][TextPos][2]);
					PvGarageEdit[playerid][0] = -1;
					PvGarageEdit[playerid][1] = -1;
					PvGarageEdit[playerid][2] = -1;
				}
				case 3: {
					PrivateGarage[pvid][GatePos][0] = x;
					PrivateGarage[pvid][GatePos][1] = y; 
					PrivateGarage[pvid][GatePos][2] = z;
					PrivateGarage[pvid][GatePos][3] = rx;
					PrivateGarage[pvid][GatePos][4] = ry;
					PrivateGarage[pvid][GatePos][5] = rz;
					SetDynamicObjectPos(objectid,  PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2]);
					SetDynamicObjectRot(objectid, PrivateGarage[pvid][GatePos][3], PrivateGarage[pvid][GatePos][4], PrivateGarage[pvid][GatePos][5]);
					SendCustomMessage(playerid, "EDIT", ""AQUA_E"Successfully edit private garage ID %d", pvid);
					PvGarageSave(pvid);
					PvGarageRefresh(pvid);
					Streamer_UpdateEx(playerid, PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2]);
					PvGarageEdit[playerid][0] = -1;
					PvGarageEdit[playerid][1] = -1;
					PvGarageEdit[playerid][2] = -1;
				}
			}
			return 1;
		}
	}
    if(response == EDIT_RESPONSE_CANCEL) {
        if(PvGarageEdit[playerid][0] == 1)
	    {
			new pvid = PvGarageEdit[playerid][2];
			switch(PvGarageEdit[playerid][1])
			{
				case 1: {
					SetDynamicObjectPos(objectid, PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2]);
					SetDynamicObjectRot(objectid, PrivateGarage[pvid][GaragePos][0], PrivateGarage[pvid][GaragePos][1], PrivateGarage[pvid][GaragePos][2]);
					PvGarageEdit[playerid][0] = -1;
					PvGarageEdit[playerid][1] = -1;
					PvGarageEdit[playerid][2] = -1;
				}
			}
			return 1;
		}
    }
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) if((newkeys & KEY_SECONDARY_ATTACK))
    {
        foreach(new pvid : PrivateGarage) if(IsPlayerInRangeOfPoint(playerid, 2.8, PrivateGarage[pvid][TextPos][0], PrivateGarage[pvid][TextPos][1], PrivateGarage[pvid][TextPos][2])) {
            if(!OwnerPvGarage(playerid, pvid)) return Error(playerid, "You don't own this private garage.");
            switch(PrivateGarage[pvid][DoorsStatus]) {
                case 0: {
                    ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);
                    MoveDynamicObject(PrivateGarage[pvid][ObjectDoors], PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2]-4, 3.0, PrivateGarage[pvid][GatePos][3], PrivateGarage[pvid][GatePos][4], PrivateGarage[pvid][GatePos][5]);
                    PrivateGarage[pvid][DoorsStatus] = 1;
                    PvGarageSave(pvid);
                }
                case 1: {
                    ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);
                    MoveDynamicObject(PrivateGarage[pvid][ObjectDoors], PrivateGarage[pvid][GatePos][0], PrivateGarage[pvid][GatePos][1], PrivateGarage[pvid][GatePos][2], 3.0, PrivateGarage[pvid][GatePos][3], PrivateGarage[pvid][GatePos][4], PrivateGarage[pvid][GatePos][5]);
                    PrivateGarage[pvid][DoorsStatus] = 0;
                    PvGarageSave(pvid);
                }
            }
        }
    }
	return 1;
}
