//AUCTION
new AuctionText,
    HighBidText,
    PropID,
    PropType,
    StartInBid;
new AuctionLocked = 0,
    Participant = 0,
    Remaining = 300,
    AtAuction[MAX_PLAYERS];
new HighBid;

function RefreshAuctionText(atype, id)
{
    new type[50],
        text[200],
        yangikut = Participant;

    if(atype == 1) // House
    {
        if(hData[id][hType] == 1) type = "Small";
        else if(hData[id][hType] == 2) type = "Medium";
        else if(hData[id][hType] == 3) type = "Large";
        else type = "Unknow";

        format(text, sizeof(text), "{FFFF00}[%d]House\n%s\n{FF0000}Start In Bid:{FFFF00} %s\n{00FFFF}Participant: {FFFF00}%d\n{00FFFF}Remaining:{FFFF00} %d",
        id, type, FormatMoney(StartInBid), yangikut, Remaining);
        SetDynamicObjectMaterialText(AuctionText, 0, text, 90, "Ariel", 20, 1, 0x00000000, 0x00000001, 1);
    }
    else if(atype == 2) // Business
    {
        if(bData[id][bType] == 1) type = "Fast Food";
        else if(bData[id][bType] == 2) type = "Market";
        else if(bData[id][bType] == 3) type = "Clothes";
        else if(bData[id][bType] == 4) type = "Equipment";
        else if(bData[id][bType] == 5) type = "Electronic";
        else type = "Unknow";

        format(text, sizeof(text), "{FFFF00}[%d]Business\n%s\n{FF0000}Start In Bid:{FFFF00} %s\n{00FFFF}Participant: {FFFF00}%d\n{00FFFF}Remaining:{FFFF00} %d",
        id, type, FormatMoney(StartInBid), yangikut, Remaining);
        SetDynamicObjectMaterialText(AuctionText, 0, text, 90, "Ariel", 20, 1, 0x00000000, 0x00000001, 1);
    }
    return 1;
}

function RefreshTextHighOffer(playerid)
{
    new Amount = GetPVarInt(playerid, "Sontol");
    new text[100];
    //AuctionMessage("%s Has Bid In Amount : %s!", pData[playerid][pName], FormatMoney(Amount));
    format(text, sizeof(text), "{FF0000}High Bidder\n{FFFF00}%s\n{FF0000}%s", pData[playerid][pName], FormatMoney(Amount));
    SetDynamicObjectMaterialText(HighBidText, 0, text, 130, "Ariel", 50, 1, 0xFFFFFFFF, 0xFF000000, 1);
    return 1;
}

stock AuctionMessage(String[])
{
    foreach(new i : Player)
    {
        if(AtAuction[i] == 1)
        {
            SendClientMessage(i, COLOR_JOB, String);
        }
    }
    return 1;
}

CMD:auctionend(playerid)
{
    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    AuctionLocked = 0;

    foreach(new ii : Player)
    {
        AtAuction[ii] = 0;
    }
    SetDynamicObjectMaterialText(AuctionText, 0, "{FFFF00}Welcome\nTo Los Santos\n{FFFF00}Auction Office", 90, "Ariel", 20, 1, 0x00000000, 0x00000001, 1);
    Participant = 0;

    Servers(playerid, "Succes To End Auction");
    SendClientMessageToAll(-1, "{ffff00}[Goverment]{FFFFFF} auction has ended, thank you for joining");
    return 1;
}
CMD:auctionstart(playerid)
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    AuctionLocked = 1;
    Servers(playerid, "Pelelangan berhasil dibuka!");

    SendClientMessageToAll(-1, "{ffff00}[Goverment]{FFFFFF} Auction Begins, Go to the Auction Office to join!");
    return 1;
}

CMD:auction(playerid, params[])
{
    new id = PropID;
    new atype = PropType;
    if(isnull(params))
    {
        Usage(playerid, "USAGE: /auction [name]");
        Info(playerid, "Names: join, leave");
        return 1;
    }
    if(strcmp(params,"join",true) == 0)
    {
        if(AuctionLocked == 0)
            return Error(playerid, "pelelangan Belum dibuka");

        if(IsPlayerInAnyVehicle(playerid))
            return Error(playerid, "Harap turun dari kendaraan sebelum bergabung kedalam pelelangan");

        if(AtAuction[playerid] == 1)
            return Error(playerid, "Anda Sudah Bergabung Ke Pelelangan");

        AtAuction[playerid] = 1;
        Servers(playerid, "Anda berhasil masuk ke Pelelangan");
        Participant++;
        RefreshAuctionText(atype, id);
        return 1;
    }
    if(strcmp(params,"leave",true) == 0)
    {
        if(AtAuction[playerid] == 0)
            return Error(playerid, "Anda tidak berada di Pelelangan");

        AtAuction[playerid] = 0;
        Servers(playerid, "Anda berhasil keluar dari Pelelangan");
        Participant--;
        RefreshAuctionText(atype, id);
        return 1;
    }
    return 1;
}

CMD:bid(playerid, params[])
{
    // Memeriksa apakah pemain bergabung ke pelelangan atau tidak
    if (AtAuction[playerid] == 0)
    {
        return Error(playerid, "Anda Tidak Bergabung Ke Pelelangan");
    }

    new Float:Amount;
    if (sscanf(params, "f", Amount) || Amount <= 0.0)
    {
        return Error(playerid, "Invalid bid amount.");
    }

    // Mengonversi float ke nilai integer
    new AmountInt = floatval(Amount);

    // Mendapatkan jumlah penawaran tertinggi saat ini
    new HighBidInt = floatval(HighBid);

    // Memeriksa apakah pemain memiliki cukup uang untuk penawaran
    if (GetPlayerMoney(playerid) < AmountInt)
    {
        return Error(playerid, "Not Enough Money To Bid That Much");
    }
        // Memeriksa apakah penawaran lebih tinggi dari penawaran sebelumnya
    if (AmountInt <= HighBidInt)
    {
        return Error(playerid, "You cannot enter a value smaller than the highest bidder's value");
    }

    Info(playerid, "You bid in amount $%.2f.", Amount);
    SetPVarInt(playerid, "Sontol", AmountInt);

    RefreshTextHighOffer(playerid);
    RefreshAuctionText(PropID, PropType);

    return 1;
}

CMD:auctioncreate(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
        
    AuctionLocked = 1;

    static
    types[24], string[24], id, abid;
    if(sscanf(params, "s[24]S()[128]", types, string))
    {
        Usage(playerid, "/acreate [Type]");
        Info(playerid, "1.House , 2.Bis ");
        return 1;
    }
    if(!strcmp(types, "2", true))
    {
        if(sscanf(string, "dd", id, abid))
        return Usage(playerid, "/acreate [Bis] [id] [start in bid]");
        StartInBid = abid;
        PropID = id;
        PropType = 2;
        RefreshAuctionText(PropType, PropID);
    }
    if(!strcmp(types, "1", true))
    {
        if(sscanf(string, "dd", id, abid))
        return Usage(playerid, "/acreate [House] [id] [start in bid]");
        StartInBid = abid;
        PropID = id;
        PropType = 1;
        RefreshAuctionText(PropType, PropID);
    }
    return 1;
}
