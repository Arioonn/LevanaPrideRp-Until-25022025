#include "COLOR.pwn"
// Boombox command - Usage: /boombox [URL]
CMD:boombox(playerid, params[])
{
    new string[128];
    if(!GetPVarType(playerid, "BoomboxObject"))
    {
        if(sscanf(params, "s[256]", params)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /boombox [music url]");

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if(GetPVarType(i, "BoomboxObject"))
            {
                if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "bposX"), GetPVarFloat(i, "bposY"), GetPVarFloat(i, "bposZ")))
                {
                    SendClientMessage(playerid, COLOR_GREY, " There is another boombox nearby, place yours somewhere else.");
                    return 1;
                }
            }
        }

        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z); GetPlayerFacingAngle(playerid, a);
        SetPVarInt(playerid, "BoomboxObject", CreateDynamicObject(2103, x, y, z, 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
        SetPVarFloat(playerid, "bposX", x); SetPVarFloat(playerid, "bposY", y); SetPVarFloat(playerid, "bposZ", z);
        SetPVarInt(playerid, "bboxareaid", CreateDynamicSphere(x, y, z, 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
        format(string, sizeof(string), " You have placed your boombox at your location.");
        SendClientMessage(playerid, COLOR_ARWIN, string);

        for (new j = 0; j < MAX_PLAYERS; j++)
        {
            if(IsPlayerConnected(j) && IsPlayerInDynamicArea(j, GetPVarInt(playerid, "bboxareaid")))
            {
                PlayAudioStreamForPlayer(j, params, x, y, z, 30.0, 1);
            }
        }

        SetPVarString(playerid, "BoomboxURL", params);
    }
    else
    {
        DestroyDynamicObject(GetPVarInt(playerid, "BoomboxObject"));
        DeletePVar(playerid, "BoomboxObject");
        DeletePVar(playerid, "BoomboxURL");
        DeletePVar(playerid, "bposX");
        DeletePVar(playerid, "bposY");
        DeletePVar(playerid, "bposZ");

        if (GetPVarType(playerid, "bboxareaid"))
        {
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (IsPlayerConnected(i) && IsPlayerInDynamicArea(i, GetPVarInt(playerid, "bboxareaid")))
                {
                    StopAudioStreamForPlayer(i);
                    SendClientMessage(i, COLOR_GREY, "The boombox creator has removed his boombox.");
                }
            }
            DeletePVar(playerid, "bboxareaid");
        }
        SendClientMessage(playerid, COLOR_ARWIN, "You have removed your boombox.");
    }
    return 1;
}

// Boombox editing - Usage: /boomboxnext [url]
CMD:boomboxnext(playerid, params[])
{
    if (sscanf(params, "s[256]", params)) 
        return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /boomboxnext [music url]");
    
    SendClientMessage(playerid, COLOR_GREY, " You have changed the music your boombox is playing.");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && IsPlayerInDynamicArea(i, GetPVarInt(playerid, "bboxareaid")))
        {
            PlayAudioStreamForPlayer(i, params, GetPVarFloat(playerid, "bposX"), GetPVarFloat(playerid, "bposY"), GetPVarFloat(playerid, "bposZ"), 30.0, 1);
        }
    }

    SetPVarString(playerid, "BoomboxURL", params);
    return 1;
}