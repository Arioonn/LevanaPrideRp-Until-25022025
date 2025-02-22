
Dialog:AdsType(playerid, response, listitem, inputtext[]) {
    new string[999];
    if (response) 
	{
       switch(listitem)
	   {
			case 0:
			{
                format(string, sizeof(string), ""GREY_E"Advertisemen Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Automotive\n"WHITE_E"Lengt: "GREY_E"%d\n"WHITE_E"Price: "LG_E"%s\n\n"WHITE_E"Confirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(pData[playerid][pAdvertise]*2));
                Dialog_Show(playerid, AdsConfirmAuto, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 1:
			{
				format(string, sizeof(string), ""WHITE_E"Advertisemen Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Property\n"WHITE_E"Lengt: "GREY_E"%d\n"WHITE_E"Price: "LG_E"%s\n\n"WHITE_E"Confirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(pData[playerid][pAdvertise]*2));
                Dialog_Show(playerid, AdsConfirmPro, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 2:
			{
				format(string, sizeof(string), ""WHITE_E"Advertisemen Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Event\n"WHITE_E"Lengt: "GREY_E"%d\n"WHITE_E"Price: "LG_E"%s\n\n"WHITE_E"Confirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(pData[playerid][pAdvertise]*2));
                Dialog_Show(playerid, AdsConfirmEvent, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 3:
			{
				format(string, sizeof(string), ""WHITE_E"Advertisemen Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Service\n"WHITE_E"Lengt: "GREY_E"%d\n"WHITE_E"Price: "LG_E"%s\n\n"WHITE_E"Confirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(pData[playerid][pAdvertise]*2));
                Dialog_Show(playerid, AdsConfirmService, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 4:
			{
				format(string, sizeof(string), ""WHITE_E"Advertisemen Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Job Search\n"WHITE_E"Lengt: "GREY_E"%d\n"WHITE_E"Price: "LG_E"%s\n\n"WHITE_E"Confirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(pData[playerid][pAdvertise]*2));
                Dialog_Show(playerid, AdsConfirmJob, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
	   }
    }
    return 1;
}

Dialog:AdsConfirmAuto(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 1, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmPro(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 2, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmEvent(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 3, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmService(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 4, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmJob(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 5, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:Dialog_Advertisements(playerid, response, listitem, inputtext[]) {
    if (response) {
        new ads[150 * 10], count = 0;
        strcat(ads, "Contact Person\tContact Number\tAdvertisement\n");
        for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[i][adsExists] && AdsQueue[i][adsType] == (listitem + 1)) {
            if (strlen(AdsQueue[i][adsContent]) > 64) {
                format(ads, sizeof(ads), "%s%s\t%d\t%.64s...\n", ads, AdsQueue[i][adsContactName], AdsQueue[i][adsContact], AdsQueue[i][adsContent]);
            } else format(ads, sizeof(ads), "%s%s\t%d\t%s\n", ads, AdsQueue[i][adsContactName], AdsQueue[i][adsContact], AdsQueue[i][adsContent]);
            ListedAds[playerid][count++] = i;
        }
        if (!count) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, inputtext, "Advertisement History", "Detail", "Back");
        else Dialog_Show(playerid, SelectAds, DIALOG_STYLE_TABLIST_HEADERS, "Advertisement History", ads, "Detail", "Back");
    }
    return 1;
}

Dialog:SelectAds(playerid, response, listitem, inputtext[]) {
    if (!response) ShowAdvertisements(playerid);
    else {
        new index = ListedAds[playerid][listitem],
            targetid = GetNumberOwner(AdsQueue[index][adsContact]);

        if (targetid == INVALID_PLAYER_ID)
            return Error(playerid, "The specified phone number is not in service.");

        if(targetid == playerid)
            return Dialog_Show(playerid, RemoveAds, DIALOG_STYLE_MSGBOX,"Advertisement","Are you sure you want to remove your ads?","Yes","No");

        if(pData[playerid][pPhoneStatus] == 0)
            return Error(playerid, "The recipient has their cellphone powered off.");

        SetPVarInt(playerid, "replyTextTo", targetid);
        new lstr[512];
        format(lstr,sizeof(lstr),""RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]", AdsQueue[index][adsContent], AdsQueue[index][adsContactName], AdsQueue[index][adsContact]);
        Dialog_Show(playerid, ReplyAds, DIALOG_STYLE_MSGBOX,"Advertisement",lstr,"Reply","Close");
    }
    return 1;
}

Dialog:RemoveAds(playerid, response, listitem, inputtext[]) 
{
    if (response) 
    {
        Advertisement_Remove(playerid);
        SendCustomMessage(playerid, "ADVERTISEMENT", "You successfully removed your ads");
    } 
    return 1;
}

Dialog:ReplyAds(playerid, response, listitem, inputtext[]) {
    if (response) {
        new lstr[512], index = GetPVarInt(playerid, "replyTextTo");
        format(lstr,sizeof(lstr),"To: %d\nMessage:", pData[index][pPhone]);
        Dialog_Show(playerid, ReplyMessage, DIALOG_STYLE_INPUT,"Phone > Messaging > Write",lstr,"Send","Close");
    } else DeletePVar(playerid, "replyTextTo");
    return 1;
}

Dialog:ReplyMessage(playerid, response, listitem, inputtext[]) {
    if (response) {
        if (GetPVarInt(playerid, "replyTextTo") != INVALID_PLAYER_ID) {
            new targetid = GetPVarInt(playerid, "replyTextTo"), msg[64];

            if (sscanf(inputtext, "s[64]", msg))
                return Dialog_Show(playerid, ReplyMessage, DIALOG_STYLE_INPUT, "Reply Message", "Replying message to: %d", "Send", "Cancel", pData[targetid][pPhone]);

            if (strlen(msg) > 64)
                return Dialog_Show(playerid, ReplyMessage, DIALOG_STYLE_INPUT, "Reply Message", "Replying message to: %d", "Send", "Cancel", pData[targetid][pPhone]);

            new ph = pData[targetid][pPhone];
			new String[512];
			if (!ph)
            return Error(playerid, "The specified phone number is not in service.");
            format(String, sizeof(String), "%d %s", ph, inputtext);
            callcmd::sms(playerid, String);
        }
    } else DeletePVar(playerid, "replyTextTo");
    return 1;
}
