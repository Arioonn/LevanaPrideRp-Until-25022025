#include <a_samp> //HOOHTENAN ENAK ENAK

new
	bool:SpawnedOnce[MAX_PLAYERS],
	bool:NoXmasHat[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	SpawnedOnce[playerid] = false;
	NoXmasHat[playerid] = false;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Snow_OnDisconnect(playerid);
	return 1;
}

#define MAX_SNOW_OBJECTS    3
#define SNOW_UPDATE_INTERVAL     1000

#define MAX_SLOTS MAX_PLAYERS

#define CB:%0(%1)           forward %0(%1); public %0(%1)

new
	bool:snowOn[MAX_SLOTS char],
	snowObject[MAX_SLOTS][MAX_SNOW_OBJECTS],
	updateTimer[MAX_SLOTS char];

Snow_OnDisconnect(playerid)
{
	if(snowOn{playerid})
	{
	    for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
			DestroyPlayerObject(playerid, snowObject[playerid][i]);
		snowOn{playerid} = false;
		KillTimer(updateTimer{playerid});
	}
	return 1;
}


CMD:UpdateSnow(playerid)
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	if(!snowOn{playerid}) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
		SetPlayerObjectPos(playerid, snowObject[playerid][i], pPos[0] + random(25), pPos[1] + random(25), pPos[2] - 5 + random(10));
	return 1;
}

CreateSnow(playerid)
{
	if(snowOn{playerid}) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
		snowObject[playerid][i] = CreatePlayerObject(playerid, 18864, pPos[0] + random(25), pPos[1] + random (25), pPos[2] - 5 + random(10), random(280), random(280), 0);
	snowOn{playerid} = true;
	updateTimer{playerid} = SetTimerEx("UpdateSnow", SNOW_UPDATE_INTERVAL, true, "i", playerid);
	return 1;
}

DeleteSnow(playerid)
{
	if(!snowOn{playerid}) return 0;
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++)
	DestroyPlayerObject(playerid, snowObject[playerid][i]);
	KillTimer(updateTimer{playerid});
	snowOn{playerid} = false;
	return 1;
}

CMD:snow(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	if(snowOn{playerid})
	{
	    DeleteSnow(playerid);
	    SendClientMessage(playerid, -1, "It's not snowing anymore now.");
	}
	else
	{
	    CreateSnow(playerid);
	    SendClientMessage(playerid, -1, "Let it snow, let it snow, let it snow!");
	}
	return 1;
}
