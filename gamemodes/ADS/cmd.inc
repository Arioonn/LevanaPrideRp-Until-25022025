
CMD:ads(playerid, params[])
{
	if(pData[playerid][pPhone] < 1) return Error(playerid, "You dont have phone!");
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Your phone is Offline");
	ShowAdvertisements(playerid);
	return 1;
}

CMD:ad(playerid, params[])
{
	if(pData[playerid][pPhone] < 1) return Error(playerid, "You dont have phone!");
	if(pData[playerid][pCS] < 1) return Error(playerid, "Anda harus mempunyai Character Story untuk membuat iklan!");
    if(!IsPlayerInRangeOfPoint(playerid, 5, 2461.21, 2270.07, 91.67)) return Error(playerid, "You must in SANA Station!");
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Your phone this offline");
	{
		if(pData[playerid][pDelayIklan] > 0) return Error(playerid, "Tunggu %d menit untuk membuat iklan.", pData[playerid][pDelayIklan] / 60);
		if(isnull(params)) return Usage(playerid, "(/ad)vertise [advert text]");
		if (strlen(params) > 200) return Error(playerid, "Max characters length is 200 chars");
		format(pData[playerid][pAdvertise], 200, params);
		Dialog_Show(playerid, AdsType, DIALOG_STYLE_LIST, "Advertisement Type", "Automotive\nProperty\nEvent\nService\nJob Search", "Input", "Close");
    }
    return 1;
}
