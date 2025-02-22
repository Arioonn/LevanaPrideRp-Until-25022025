
Advertisement_Create(playerid, number, type, content[]) {
    new payout = strlen(content) * 2;
    if(GetPlayerMoney(playerid) < payout) return Error(playerid, "Not enough money.");
    new index = Advertisement_GetFreeID(), count = 1;
    if (index == -1) return Error(playerid, "Advertisement is full!");
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[index][adsAntri]) count++;
    AdsQueue[index][adsAntri] = true; 
    AdsQueue[index][adsExists] = true;
    AdsQueue[index][adsContact] = number;
    AdsQueue[index][adsType] = type;
    strunpack(AdsQueue[index][adsContent], content);
    strunpack(AdsQueue[index][adsContactName], ReturnName2(playerid));
    AdsQueue[index][adsUsed] = 0;
    pData[playerid][pDelayIklan] = 600;
    AdsQueue[index][adsMinutes] = count*2;
    GivePlayerMoneyEx(playerid, -payout);
    Server_AddMoney(payout);
    SendCustomMessage(playerid, "ADVERT", "You've paid {00FF00}%s {FFFFFF}(%d letters) for the advertisement", FormatMoney(payout), strlen(content));
    SendCustomMessage(playerid, "ADVERT", "Your advertisement has been added to the queue and it'll be displayed in {FFFF00}%d minute(s)", AdsQueue[index][adsMinutes]/10);
    return 1;
}

Advertisement_GetFreeID() {
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (!AdsQueue[i][adsExists]) {
        return i;
    }
    return -1;
}

ShowAdvertisements(playerid) {
    Dialog_Show(playerid, Dialog_Advertisements, DIALOG_STYLE_LIST, "Categories", "Automotive\nProperty\nEvent\nServices\nJob Search", "Select", "Cancel");
    return 1;
}

Advertisement_Remove(playerid) {
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[i][adsExists] && AdsQueue[i][adsUsed] == 1 && AdsQueue[i][adsContact] == pData[playerid][pPhone]) {
        AdsQueue[i][adsAntri] = false;
        AdsQueue[i][adsExists] = false;
        AdsQueue[i][adsContact] = 0;
        AdsQueue[i][adsContent] = EOS;
        AdsQueue[i][adsType] = 0;
        AdsQueue[i][adsUsed] = 0;
        AdsQueue[i][adsMinutes] = -1;
    }
    return 1;
}

task Advertise[1000]() {
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[i][adsExists] && !AdsQueue[i][adsUsed]) {
        if(AdsQueue[i][adsMinutes] > 0) {
            AdsQueue[i][adsMinutes]--;
            if(AdsQueue[i][adsMinutes] == 0) {
                foreach (new player : Player) 
                {
                    if(pData[player][pTogAds] == 0)
                    {
                        SendClientMessageEx(player, COLOR_RED, "{FF0000}Ad: {33AA33}%s", AdsQueue[i][adsContent]);
                        SendClientMessageEx(player, COLOR_RED, "{FF0000}Contact Info: [{33AA33}%s{FF0000}] Phone Number: [{33AA33}%d{FF0000}]", AdsQueue[i][adsContactName], AdsQueue[i][adsContact]);
                    }
                }
                AdsQueue[i][adsAntri] = false;
                AdsQueue[i][adsUsed] = 1;
            }
        }
    }
    return 1;
}
