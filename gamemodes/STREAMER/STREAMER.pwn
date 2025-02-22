stock Streamer_SetPosition(type, STREAMER_ALL_TAGS:id, Float:x, Float:y, Float:z)
{
	Streamer_SetFloatData(type, id, E_STREAMER_X, x);
	Streamer_SetFloatData(type, id, E_STREAMER_Y, y);
	Streamer_SetFloatData(type, id, E_STREAMER_Z, z);
}

stock Streamer_SetRotation(type, STREAMER_ALL_TAGS:id, Float:rx, Float:ry, Float:rz)
{
	Streamer_SetFloatData(type, id, E_STREAMER_R_X, rx);
	Streamer_SetFloatData(type, id, E_STREAMER_R_Y, ry);
	Streamer_SetFloatData(type, id, E_STREAMER_R_Z, rz);
}

stock StreamerConfig()
{
	Streamer_MaxItems(STREAMER_TYPE_OBJECT, 990000);
	Streamer_MaxItems(STREAMER_TYPE_MAP_ICON, 2000);
	Streamer_MaxItems(STREAMER_TYPE_PICKUP, 2000);
	for(new playerid = (GetMaxPlayers() - 1); playerid != -1; playerid--)
	{
		Streamer_DestroyAllVisibleItems(playerid, 0);
	}
	return 1;
}

CMD:setrender(playerid, params[])
{
	new strrender[1000];
	format(strrender, sizeof(strrender), "Jenis\t\tRadius\nHigh\t\t300.00\nMedium\t\t200.00\nLow\t\t100.00\nPotato\t\t50.00");
	ShowPlayerDialog(playerid, DIALOG_STREAMER_CONFIG, DIALOG_STYLE_TABLIST_HEADERS, "Render Settings", strrender, "Set", "Batal");	
	return 1;
}
