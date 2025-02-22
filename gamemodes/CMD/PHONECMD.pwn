CMD:phone(playerid, params[])
{
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	
	new str[800], info[800];
	format(str, sizeof(str), "GPS\nCall Number\nMessage Number\nMy Contact\nBanking\nCalculator\nPhone Status");
	strcat(info, str);

	ShowPlayerDialog(playerid, DIALOG_PHONE_TEKS, DIALOG_STYLE_LIST, "Phone", info, "Select", "Close");
	return 1;
}

CMD:call(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph;
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Handphone anda sedang dimatikan");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "Anda tidak memiliki Ponsel credits!");
	
	if(sscanf(params, "d", ph))
	{
		Usage(playerid, "/call [phone number] 933 - Taxi Call | 911 - SAPD Crime Call | 922 - SAMD Medic Call");
		foreach(new ii : Player)
		{	
			if(pData[ii][pMechDuty] == 1)
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "Mekanik Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
			}
		}
		return 1;
	}
	if(ph == 911)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for emergency crime only! please wait for SAPD respon!");
		SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
	
		pData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == 922)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for emergency medical only! please wait for SAMD respon!");
		SendFactionMessage(3, COLOR_PINK2, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency medical! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
	
		pData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == 933)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Your calling has sent to the taxi driver. please wait for respon!");
		pData[playerid][pCallTime] = gettime() + 60;
		foreach(new tx : Player)
		{
			if(pData[tx][pJob] == 1 || pData[tx][pJob2] == 1)
			{
				SendClientMessageEx(tx, COLOR_YELLOW, "[TAXI CALL] "WHITE_E"%s calling the taxi for order! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
			}
		}
	}
	if(ph == pData[playerid][pPhone]) return Error(playerid, "Nomor sedang sibuk!");
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			if(pData[ii][pPhoneStatus] == 0) return Error(playerid, "Tidak dapat menelepon, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(pData[ii][pCall] == INVALID_PLAYER_ID)
			{
				pData[playerid][pCall] = ii;
				
				SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
				SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE form %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
				PlayerPlaySound(playerid, 3600, 0,0,0);
				PlayerPlaySound(ii, 6003, 0,0,0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
				return 1;
			}
			else
			{
				Error(playerid, "Nomor ini sedang sibuk.");
				return 1;
			}
		}
	}
	return 1;
}

CMD:togphone(playerid)
{
    ShowPlayerDialog(playerid, DIALOG_TOGGLEPHONE, DIALOG_STYLE_LIST, "Setting", "Phone On\nPhone Off", "Select", "Back");
    return 1;
}

CMD:callteks(playerid)
{
    if(pData[playerid][pPhoneStatus] == 0) 
	{
		return Error(playerid, "Handphone anda sedang dimatikan");
	}	
	ShowPlayerDialog(playerid, DIALOG_PHONE_DIALUMBER, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Dial", "Back");
    return 1;
}

CMD:smsteks(playerid)
{
    if(pData[playerid][pPhoneStatus] == 0) 
	{
		return Error(playerid, "Handphone anda sedang dimatikan");
	}
	ShowPlayerDialog(playerid, DIALOG_PHONE_SENDSMS, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Dial", "Back");
    return 1;
}

CMD:gpsteks(playerid)
{
    if(pData[playerid][pPhoneStatus] == 0) 
	{
		return Error(playerid, "Handphone anda sedang dimatikan");
	}
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
    return 1;
}

CMD:contactteks(playerid)
{
   ShowContacts(playerid);
   return 1;
}

CMD:calculatorteks(playerid)
{
    TogglePlayerControllable(playerid, 0);
	CancelSelectTextDraw(playerid);
	SelectTextDraw(playerid,0x8C8C8CFF);
	TextDrawShowForPlayer(playerid, boxlator[0]);
	TextDrawShowForPlayer(playerid, Line1);
	TextDrawShowForPlayer(playerid, Line2);
	TextDrawShowForPlayer(playerid, Line3);
	TextDrawShowForPlayer(playerid, Line4);
	TextDrawShowForPlayer(playerid, zahl1);
	TextDrawShowForPlayer(playerid, zahl2);
	TextDrawShowForPlayer(playerid, zahl3);
	TextDrawShowForPlayer(playerid, zahl4);
	TextDrawShowForPlayer(playerid, zahl5);
	TextDrawShowForPlayer(playerid, zahl6);
	TextDrawShowForPlayer(playerid, zahl7);
	TextDrawShowForPlayer(playerid, zahl8);
	TextDrawShowForPlayer(playerid, zahl9);
	TextDrawShowForPlayer(playerid, plus);
	TextDrawShowForPlayer(playerid, minus);
	TextDrawShowForPlayer(playerid, mal);
	TextDrawShowForPlayer(playerid, geteilt);
	TextDrawShowForPlayer(playerid, gleich);
	TextDrawShowForPlayer(playerid, exxit);
	PlayerTextDrawShow(playerid, neu[playerid][0]);
	TextDrawShowForPlayer(playerid, Logo);
	for(new i = 0; i< sizeof(tdbox);i++)
	{
		TextDrawShowForPlayer(playerid, tdbox[i]);
	}
	return 1;
}