// Deklarasi variabel global
new Text: countdownText;
new arii = 50;

// Forward deklarasi untuk fungsi otomatis
forward UpdateCountdown(playerid);

public UpdateCountdown(playerid)
{
    if (arii > 0)
    {
        new string[128];
        format(string, sizeof(string), "Maintenance in %d seconds, please use /saveme to not get reset", arii);
        TextDrawSetString(countdownText, string);
        TextDrawShowForAll(countdownText);
        arii--;

        SetTimerEx("UpdateCountdown", 1000, false, "i", playerid);
    }
    else
    {
        TextDrawHideForAll(countdownText);
        TextDrawDestroy(countdownText);
        arii = 50; // Reset count for future use

        // Kick all players except the admin
        foreach (new pid : Player)
        {
            if (pid != playerid)
            {
                UpdateWeapons(pid);
                UpdatePlayerData(pid);
                GameTextForPlayer(pid, "Sorry, the server will be under maintenance and your data has been saved.", 3000, 5);
                Kick(pid);
            }
        }

        // Lock the server
        SendRconCommand("hostname Levana Pride [Maintenance]");
        SendRconCommand("password wahyuarilsaputra"); // Replace 'yourpassword' with your actual server password
    }

    return 1;
}

CMD:kickall(playerid, params[])
{
    if (pData[playerid][pAdmin] < 6)
    {
        return PermissionError(playerid);
    }

    // Initialize the TextDraw here if it wasn't initialized before
    countdownText = TextDrawCreate(281.000, 393.000, "Server Maintenance in 50 seconds, please use /saveme to not get reset");
    TextDrawLetterSize(countdownText, 0.190, 1.299);
    TextDrawAlignment(countdownText, 1);
    TextDrawColor(countdownText, -1);
    TextDrawSetShadow(countdownText, 1);
    TextDrawSetOutline(countdownText, 1);
    TextDrawBackgroundColor(countdownText, 150);
    TextDrawFont(countdownText, 1);
    TextDrawSetProportional(countdownText, 1);
    // Start the countdown using SetTimerEx to pass the 'playerid' to 'UpdateCountdown'
    SetTimerEx("UpdateCountdown", 1000, false, "i", playerid);

    return 1;
}