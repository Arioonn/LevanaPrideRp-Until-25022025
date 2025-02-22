#include <a_samp>
#include <sscanf2>
#include <a_players>
#include <a_objects>
#include <float>

//- FLYBREAK
#define MOVE_FORWARD_KEY          KEY_UP
#define MOVE_BACKWARD_KEY         KEY_DOWN
#define MOVE_LEFT_KEY             KEY_LEFT
#define MOVE_RIGHT_KEY            KEY_RIGHT
#define FLY_UP_KEY                KEY_JUMP
#define FLY_DOWN_KEY              KEY_SPRINT
new bool:gPlayerFlybreak[MAX_PLAYERS];
new Float:gFlySpeed = 5.0;

//- INVIS
new bool:gPlayerInvisible[MAX_PLAYERS];
new bool:gPlayerHighJump[MAX_PLAYERS];

//- JUMP HIGH
#define HIGH_JUMP_VELOCITY 0.5
#define FORWARD_JUMP_VELOCITY 1.0

CMD:atroll(playerid)
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
    new line3[2480];
	strcat(line3, "{ff0000}[Trolling -_-]: {ffffff} /flybreak, /highjump, /tirestroll, /invis \n");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""WHITEP_E"Commands Trolling", line3, "OK","");
	return true;
}

// = FLYBREAK
CMD:flybreak(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

    gPlayerFlybreak[playerid] = !gPlayerFlybreak[playerid];
    SendClientMessage(playerid, -1, gPlayerFlybreak[playerid] ? "{FFE4C4}INFO: {FFFFFF}Flybreak enabled." : "{FFE4C4}INFO: {FFFFFF}Flybreak disabled.");
    return 1;
}

ApplyFlybreak(playerid)
{
    new keys, updown, leftright;

    GetPlayerKeys(playerid, keys, updown, leftright);

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    if (keys & FLY_UP_KEY)
    {
        z += gFlySpeed;
    }
    if (keys & FLY_DOWN_KEY)
    {
        z -= gFlySpeed;
    }

    if (updown & MOVE_FORWARD_KEY)
    {
        new Float:angle;
        GetPlayerFacingAngle(playerid, angle);
        
        x += gFlySpeed * floatcos(angle, degrees);
        y += gFlySpeed * floatsin(angle, degrees);
    }
    else if (updown & MOVE_BACKWARD_KEY)
    {
        new Float:angle;
        GetPlayerFacingAngle(playerid, angle);
        
        x -= gFlySpeed * floatcos(angle, degrees);
        y -= gFlySpeed * floatsin(angle, degrees);
    }

    if (leftright & MOVE_LEFT_KEY)
    {
        new Float:angle;
        GetPlayerFacingAngle(playerid, angle);
        
        x -= gFlySpeed * floatsin(angle, degrees);
        y += gFlySpeed * floatcos(angle, degrees);
    }
    else if (leftright & MOVE_RIGHT_KEY)
    {
        new Float:angle;
        GetPlayerFacingAngle(playerid, angle);
        
        x += gFlySpeed * floatsin(angle, degrees);
        y -= gFlySpeed * floatcos(angle, degrees);
    }

    SetPlayerPos(playerid, x, y, z);
    return 1;
}

//= INVIS
CMD:invis(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

    gPlayerInvisible[playerid] = !gPlayerInvisible[playerid];

    if (gPlayerInvisible[playerid])
    {
        SetPlayerInvisibility(playerid, true);
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Invisibility enabled.");
    }
    else
    {
        SetPlayerInvisibility(playerid, false);
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Invisibility disabled.");
    }

    return 1;
}

SetPlayerInvisibility(playerid, bool:status)
{
    if (status)
    {
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (i != playerid && IsPlayerConnected(i))
            {
                SetPlayerMarkerForPlayer(i, playerid, -1);
            }
        }
        TextDrawDestroy(TextDrawCreate(320.0000, 320.0000, " "));
        SetPlayerColor(playerid, 0x00000000);
    }
    else
    {
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (i != playerid && IsPlayerConnected(i))
            {
                SetPlayerMarkerForPlayer(i, playerid, GetPlayerColor(playerid));
            }
        }
        SetPlayerColor(playerid, GetPlayerColor(playerid));
    }

    return 1;
}

hook OnPlayerSpawn(playerid)
{
    if (gPlayerInvisible[playerid])
    {
        SetPlayerInvisibility(playerid, true);
    }
    return 1;
}

//= HIGH JUMP
CMD:highjump(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
     	return PermissionError(playerid);

    gPlayerHighJump[playerid] = !gPlayerHighJump[playerid];
    SendClientMessage(playerid, -1, gPlayerHighJump[playerid] ? "{FFE4C4}INFO: {FFFFFF}High jump enabled." : "{FFE4C4}INFO: {FFFFFF}High jump disabled.");
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (gPlayerHighJump[playerid] && (newkeys & KEY_JUMP))
    {
        new Float:x, Float:y, Float:z;
        GetPlayerVelocity(playerid, x, y, z);

        new Float:angle;
        GetPlayerFacingAngle(playerid, angle);

        new Float:speedX = floatsin(-angle, degrees) * FORWARD_JUMP_VELOCITY;
        new Float:speedY = floatcos(-angle, degrees) * FORWARD_JUMP_VELOCITY;
        
        SetPlayerVelocity(playerid, speedX, speedY, HIGH_JUMP_VELOCITY);
    }
    return 1;
}

//= TROLLING TIRES
CMD:tirestroll(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
     		return PermissionError(playerid);
    new targetid;

    if (sscanf(params, "i", targetid))
    {
        SendClientMessage(playerid, -1, "{FFE4C4}USAGE: {FFFFFF}/destroytires [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Invalid player ID or player is not connected.");
        return 1;
    }

    DestroyVehicleTiresByPlayerID(targetid);
    SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Tires destroyed successfully.");
    return 1;
}

stock DestroyVehicleTiresByPlayerID(playerid);
stock DestroyVehicleTiresByPlayerID(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);

    if (vehicleid != INVALID_VEHICLE_ID)
    {
        new panels, doors, lights, tires;
        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

        tires |= (1 << 0);
        tires |= (1 << 1);
        tires |= (1 << 2);
        tires |= (1 << 3);

        UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}The tires of your vehicle have been destroyed.");
    }
    else
    {
        SendClientMessage(playerid, -1, "{FFE4C4}INFO: {FFFFFF}Player is not in any vehicle.");
    }
    return 1;
}

//getseat
CMD:getseat(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

    new targetid, seat;

    // Parse the target player ID and seat number from the command parameters
    if (sscanf(params, "ui", targetid, seat))
    {
        return Usage(playerid, "/getseat [playerid/PartOfName] [seat]");
    }

    // Check if the target player is connected
    if (!IsPlayerConnected(targetid))
    {
        return Error(playerid, "The specified player is not connected.");
    }

    // Check if the player issuing the command is in a vehicle
    new vehicleid = GetPlayerVehicleID(playerid);
    if (vehicleid == INVALID_VEHICLE_ID)
    {
        return Error(playerid, "You must be in a vehicle to pull another player.");
    }

    // Check if the specified seat is valid
    if (seat < 0 || seat > 3) // Adjust the max seat number based on your vehicle types (0-3 for most vehicles)
    {
        return Error(playerid, "Invalid seat number. It should be between 0 and 3.");
    }

    // Pull the target player into the vehicle of the player issuing the command
    PutPlayerInVehicle(targetid, vehicleid, seat);

    SendClientMessage(playerid, -1, "You have successfully pulled the player into your vehicle.");
    SendClientMessage(targetid, -1, "You have been pulled into a vehicle.");

    return 1;
}
