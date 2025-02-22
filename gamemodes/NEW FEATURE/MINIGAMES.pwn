#define MAX_KADO 50               // jumlah maksimum kado yang akan disebar
#define KADO_PICKUP_RADIUS 5.0    // jarak radius untuk mengambil kado
#define KADO_OBJECT_ID 19057      // ID objek kado

new KadoCount = 0;
new KadoObjects[MAX_KADO];        // array untuk menyimpan ID objek kado
new Float:KadoPositions[MAX_KADO][3]; // array untuk menyimpan posisi kado

stock LoadKadoPositionsFromFile()
{
    KadoCount = 0;
    new File:kadoFile;
    
    if (!(kadoFile = fopen("kado.cfg", io_readwrite)))
    {
        print("File kado.cfg tidak ditemukan. Membuat file baru.");
        kadoFile = fopen("kado.cfg", io_write);
        fclose(kadoFile);
        return KadoCount;
    }
    
    while (KadoCount < MAX_KADO)
    {
        new line[128];
        if (!fread(kadoFile, line)) 
        {
            break; // break loop if no more lines to read
        }

        new Float:x, Float:y, Float:z;
        if (sscanf(line, "%f %f %f", x, y, z) == 3)
        {
            KadoPositions[KadoCount][0] = x;
            KadoPositions[KadoCount][1] = y;
            KadoPositions[KadoCount][2] = z;
            KadoObjects[KadoCount] = CreateObject(KADO_OBJECT_ID, x, y, z, 0.0, 0.0, 0.0);
            KadoCount++;
        }
    }
    fclose(kadoFile);
    
    return KadoCount;
}

stock SaveKadoPositionsToFile()
{
    new File:kadoFile = fopen("kado.cfg", io_write);
    if (kadoFile)
    {
        for (new i = 0; i < KadoCount; i++)
        {
            if (KadoObjects[i] != -1)
            {
                new line[128];
                format(line, sizeof(line), "%f %f %f", KadoPositions[i][0], KadoPositions[i][1], KadoPositions[i][2]);
                fwrite(kadoFile, line);
            }
        }
        fclose(kadoFile);
        return 1;
    }
    return 0;
}

CMD:createkado(playerid)
{
    if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
    
    if (KadoCount >= MAX_KADO)
    {
        SendClientMessage(playerid, COLOR_ARWIN, "ERROR: {FFFFFF}Jumlah kado telah mencapai batas maksimum.");
        return 1;
    }

    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    // simpan posisi kado
    KadoPositions[KadoCount][0] = px;
    KadoPositions[KadoCount][1] = py;
    KadoPositions[KadoCount][2] = pz;
    KadoObjects[KadoCount] = CreateObject(KADO_OBJECT_ID, px, py, pz, 0.0, 0.0, 0.0);
    KadoCount++;

    SaveKadoPositionsToFile();

    SendClientMessage(playerid, COLOR_ARWIN, "INFO: {FFFFFF}Kado berhasil dibuat di posisi Anda.");
    return 1;
}

CMD:pickupkado(playerid)
{
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    for (new i = 0; i < KadoCount; i++)
    {
        if (KadoObjects[i] != -1 && IsPlayerInRangeOfPoint(playerid, KADO_PICKUP_RADIUS, KadoPositions[i][0], KadoPositions[i][1], KadoPositions[i][2]))
        {
            // memulai animasi pengambilan barang
            ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 0, 1);
            // hapus kado di lokasi ini
            DestroyObject(KadoObjects[i]);
            KadoObjects[i] = -1;

            // hadiahkan pemain
            new money = random(5000) + 6000; // uang acak antara 10000 sampai 50000
            new coins = random(10) + 1;       // coin acak antara 1 sampai 10

            pData[playerid][pMoney] += money;
            pData[playerid][pGold] += coins;

            new message[128];
            format(message, sizeof(message), "INFO: {FFFFFF}Anda telah mendapatkan Money {7fff00}%s {ffffff}dan LevanaCoin {FFFF00}%d.",  FormatMoney(money), coins);
            SendClientMessage(playerid, COLOR_ARWIN, message);

            SaveKadoPositionsToFile();
            return 1;
        }
    }
    SendClientMessage(playerid, COLOR_ARWIN, "ERROR: {ffffff}Tidak ada kado di dekat Anda.");
    return 1;
}

CMD:gotokado(playerid, params[])
{
    if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

    new kadoid;
    if (sscanf(params, "d", kadoid)  || kadoid < 1 ||  kadoid > KadoCount)
    {
        SendClientMessage(playerid, COLOR_ARWIN, "USAGE: {FFFFFF}/gotokado [ID Kado]");
        return 1;
    }

    SetPlayerPos(playerid, KadoPositions[kadoid - 1][0], KadoPositions[kadoid - 1][1], KadoPositions[kadoid - 1][2]);
    SendClientMessage(playerid, COLOR_ARWIN, "INFO: {FFFFFF}Anda telah berpindah ke lokasi kado.");

    return 1;
}