new STREAMER_TAG_3D_TEXT_LABEL:PlayerLabel[MAX_PLAYERS];

LoadTagName(playerid)
{
    if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
        DestroyDynamic3DTextLabel(PlayerLabel[playerid]);

    PlayerLabel[playerid] = STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID;
    
    if(!IsValidDynamic3DTextLabel(PlayerLabel[playerid])) PlayerLabel[playerid] = CreateDynamic3DTextLabel((sprintf("%s (%d)", GetRPName(playerid), playerid)), COLOR_WHITE, 0.0, 0.0, 0.2, 20.0, playerid, INVALID_VEHICLE_ID, 1);
}

ResetTagLabel(playerid)
{
    if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
        DestroyDynamic3DTextLabel(PlayerLabel[playerid]);

    PlayerLabel[playerid] = STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID;
}

//Untuk mengatur ke semula
timer LabelAdmin[1000](playerid)
{
    if (IsPlayerConnected(playerid))
    {
        new nametag[128], playername[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playername, sizeof(playername));
        format(nametag, sizeof(nametag), ""SBLUE_E"On Duty\n"WHITE_E"%s (%d)\n"YELLOW_E"%s", pData[playerid][pAdminname], playerid, GetStaffRank(playerid));
        if (IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_YELLOW, nametag);
    }
}

timer LabelNormal[1000](playerid)
{
    //Jika player duty maka di atur ke warna biru (police)
    if(pData[playerid][pOnDuty]) {
        if(pData[playerid][pFaction] == 1) {
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_BLUE, (sprintf("%s (%d)", GetRPName(playerid), playerid)));
        } else if(pData[playerid][pFaction] == 2) {
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_LBLUE, (sprintf("%s (%d)", GetRPName(playerid), playerid)));
        } else if(pData[playerid][pFaction] == 3) {
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_PINK2, (sprintf("%s (%d)", GetRPName(playerid), playerid)));
        } else if(pData[playerid][pFaction] == 4) {
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_ORANGE2, (sprintf("%s (%d)", GetRPName(playerid), playerid)));
        } else if(pData[playerid][pFaction] == 5) {
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_GREEN, (sprintf("%s (%d)", GetRPName(playerid), playerid)));
        }
    } else if(pData[playerid][pAdminDuty]) {
        defer LabelAdmin(playerid);
    } else if(pData[playerid][pMaskOn]) {
        if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, (sprintf("Mask_#%d {ffffff}(%d)", pData[playerid][pMaskID], playerid)));
    } else {
        if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, (sprintf("%s (%d)", GetRPName(playerid), playerid)));
    }
}

PlayerLabelHit(playerid)
{
    //Update Ketika Player Terkena Damage
    new Float:datahp, Float:dataam;
    GetPlayerHealth(playerid, datahp);
    GetPlayerArmour(playerid, dataam);
    if(pData[playerid][pAdminDuty]) {
        if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_RED, (sprintf("H: %.0f A: %.0f\n%s {ffffff}(%d)", datahp, dataam, pData[playerid][pAdminname], playerid)));
    } else if(pData[playerid][pMaskOn]) {
        if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_RED, (sprintf("H: %.0f A: %.0f\nMask_#%d {ffffff}(%d)", datahp, dataam, pData[playerid][pMaskID], playerid)));
    } else {
        if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_RED, (sprintf("H: %.0f A: %.0f\n%s {ffffff}(%d)", datahp, dataam, GetRPName(playerid), playerid)));
    }

    //Mengatur label ke semula dalam 5 detik
    defer LabelNormal[5000](playerid);
}