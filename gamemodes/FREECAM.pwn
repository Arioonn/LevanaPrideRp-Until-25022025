#include <a_samp> //INFO SEDIKIT KALO KEBELET EEK NGISING

#define FREECAM_MOVE_SPEED 0.5

new bool:IsPlayerInFreecam[MAX_PLAYERS];
new Float:FreecamOriginalPos[MAX_PLAYERS][3];
new Float:FreecamOriginalAngle[MAX_PLAYERS];
new Float:FreecamCurrentCamPos[MAX_PLAYERS][3];
new Float:FreecamCurrentCamAngle[MAX_PLAYERS];

CMD:freecam(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;

    if (IsPlayerInFreecam[playerid])
    {
        IsPlayerInFreecam[playerid] = false;
        SendClientMessage(playerid, 0xFFE4C4FF, "INFO: {FFFFFF}You have exited freecam mode.");

        SetCameraBehindPlayer(playerid);
    }
    else
    {
        IsPlayerInFreecam[playerid] = true;
        SendClientMessage(playerid, 0xFFE4C4FF, "INFO: {FFFFFF}You have entered freecam mode.");
        GetPlayerPos(playerid, FreecamOriginalPos[playerid][0], FreecamOriginalPos[playerid][1], FreecamOriginalPos[playerid][2]);
        GetPlayerFacingAngle(playerid, FreecamOriginalAngle[playerid]);
        GetPlayerCameraPos(playerid, FreecamCurrentCamPos[playerid][0], FreecamCurrentCamPos[playerid][1], FreecamCurrentCamPos[playerid][2]);
        FreecamCurrentCamAngle[playerid] = FreecamOriginalAngle[playerid];
    }
    return 1;
}

hook OnPlayerUpdate(playerid)
{
    if (IsPlayerInFreecam[playerid])
    {
        new Float:x, Float:y, Float:z, Float:angle;

        x = FreecamCurrentCamPos[playerid][0];
        y = FreecamCurrentCamPos[playerid][1];
        z = FreecamCurrentCamPos[playerid][2];
        angle = FreecamCurrentCamAngle[playerid];

        new keys, ud, lr;
        GetPlayerKeys(playerid, keys, ud, lr);

        if (ud > 0)
        {
            x += FREECAM_MOVE_SPEED * floatsin(-angle, degrees);
            y += FREECAM_MOVE_SPEED * floatcos(-angle, degrees);
        }
        else if (ud < 0)
        {
            x -= FREECAM_MOVE_SPEED * floatsin(-angle, degrees);
            y -= FREECAM_MOVE_SPEED * floatcos(-angle, degrees);
        }

        if (lr > 0)
        {
            x += FREECAM_MOVE_SPEED * floatsin(-angle + 90.0, degrees);
            y += FREECAM_MOVE_SPEED * floatcos(-angle + 90.0, degrees);
        }
        else if (lr < 0)
        {
            x -= FREECAM_MOVE_SPEED * floatsin(-angle + 90.0, degrees);
            y -= FREECAM_MOVE_SPEED * floatcos(-angle + 90.0, degrees);
        }

        FreecamCurrentCamPos[playerid][0] = x;
        FreecamCurrentCamPos[playerid][1] = y;
        FreecamCurrentCamPos[playerid][2] = z;

        SetPlayerCameraPos(playerid, x, y, z);
        SetPlayerCameraLookAt(playerid, FreecamOriginalPos[playerid][0], FreecamOriginalPos[playerid][1], FreecamOriginalPos[playerid][2]); // Lihat posisi asli pemain

        return 0;
    }

    return 1;
}