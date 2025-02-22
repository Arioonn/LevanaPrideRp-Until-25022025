
new RestartTimer = -1;
new RestartTime = 10; 
new ProgressTimer = -1;
new Progress = 0;

//Commands Server Maintance
forward RestartServer();
stock RestartServer()
{
SendRconCommand("gmx");
return 1;
}

forward ShowRestartCountdown();
public ShowRestartCountdown()
{
    new string[128];
    RestartTime--;

    if (RestartTime > 0)
    {
        format(string, sizeof(string), "INFO: {FFFFFF}Server akan Maintance dalam %d detik.", RestartTime);
        SendClientMessageToAll(COLOR_WHITEP, string);
    }
    else
    {
        SendRconCommand("gmx");
        KillTimer(RestartTimer);
        RestartTimer = -1;
    }
    return 1;
}

CMD:servermt(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

    SendClientMessageEx(playerid, COLOR_WHITEP, "INFO: {FFFFFF}Server akan Maintance");
    RestartTimer = SetTimer("ShowRestartCountdown", 1000, true);
    RestartTime = 10;


    return 1;
}

//Server Loading
hook OnGameModeInit()
{
    SendRconCommand("levanaPrideOntop");
    SendRconCommand("vinzzontop");
    ProgressTimer = SetTimer("UpdateProgress", 0, true);
    return 1;
}

hook OnGameModeExit()
{
    if (ProgressTimer != -1)
    {
        KillTimer(ProgressTimer);
    }
    return 1;
}

forward UpdateProgress();
public UpdateProgress()
{
    if (Progress <= 100)
    {
    new string[64];
    format(string, sizeof(string), "hostname Load Database [%d]", Progress);
    SendRconCommand(string);

    Progress++;
    }
    else
    {
        KillTimer(ProgressTimer);
        ProgressTimer = -1;
        SendRconCommand("password MT");

        SendRconCommand("hostname Levana Pride Roleplay | MMT");
    }
    return 1;
}