new bool:ShowCylinderNotif[MAX_PLAYERS];
new PlayerText:BoxClyn[MAX_PLAYERS];
new PlayerText:TextCyln[MAX_PLAYERS];
new PlayerText:BoxCylnCol[MAX_PLAYERS];
stock ShowCylinderText(playerid, const text[] = "_")
{
	if(ShowCylinderNotif[playerid]) HideCylinderText(playerid);
	new lenght = strlen(text);
	new Float:lenghtbox = lenght*4+1.0;
	BoxClyn[playerid] = CreatePlayerTextDraw(playerid, 7.000000, 253.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BoxClyn[playerid], 4);
	PlayerTextDrawLetterSize(playerid, BoxClyn[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BoxClyn[playerid], lenghtbox, 18.500000);
	PlayerTextDrawSetOutline(playerid, BoxClyn[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BoxClyn[playerid], 0);
	PlayerTextDrawAlignment(playerid, BoxClyn[playerid], 1);
	PlayerTextDrawColor(playerid, BoxClyn[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, BoxClyn[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BoxClyn[playerid], 50);
	PlayerTextDrawUseBox(playerid, BoxClyn[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BoxClyn[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BoxClyn[playerid], 0);

	TextCyln[playerid] = CreatePlayerTextDraw(playerid, 9.000000, 255.000000, "Gunakan Y Untuk Mencabut Kanabis");
	PlayerTextDrawFont(playerid, TextCyln[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextCyln[playerid], 0.200000, 1.450000);
	PlayerTextDrawTextSize(playerid, TextCyln[playerid], 277.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TextCyln[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextCyln[playerid], 0);
	PlayerTextDrawAlignment(playerid, TextCyln[playerid], 1);
	PlayerTextDrawColor(playerid, TextCyln[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TextCyln[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TextCyln[playerid], 0);
	PlayerTextDrawUseBox(playerid, TextCyln[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TextCyln[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TextCyln[playerid], 0);

	BoxCylnCol[playerid] = CreatePlayerTextDraw(playerid, 4.000000, 253.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BoxCylnCol[playerid], 4);
	PlayerTextDrawLetterSize(playerid, BoxCylnCol[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BoxCylnCol[playerid], 3.500000, 18.500000);
	PlayerTextDrawSetOutline(playerid, BoxCylnCol[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BoxCylnCol[playerid], 0);
	PlayerTextDrawAlignment(playerid, BoxCylnCol[playerid], 1);
	PlayerTextDrawColor(playerid, BoxCylnCol[playerid], 1687547311);
	PlayerTextDrawBackgroundColor(playerid, BoxCylnCol[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BoxCylnCol[playerid], 50);
	PlayerTextDrawUseBox(playerid, BoxCylnCol[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BoxCylnCol[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BoxCylnCol[playerid], 0);

	new str[518];
	format(str, 518, "%s", text);
	PlayerTextDrawSetString(playerid, TextCyln[playerid], str);

	PlayerTextDrawShow(playerid, BoxClyn[playerid]);
	PlayerTextDrawShow(playerid, TextCyln[playerid]);
	PlayerTextDrawShow(playerid, BoxCylnCol[playerid]);
	ShowCylinderNotif[playerid] = true;
	return 1;
}

stock HideCylinderText(playerid)
{
	PlayerTextDrawDestroy(playerid, BoxClyn[playerid]);
	PlayerTextDrawDestroy(playerid, TextCyln[playerid]);
	PlayerTextDrawDestroy(playerid, BoxCylnCol[playerid]);
	ShowCylinderNotif[playerid] = false;
	return 1;
}