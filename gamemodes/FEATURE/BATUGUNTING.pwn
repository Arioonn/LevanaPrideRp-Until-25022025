#define INVALID_TIMER_ID -1           // Definisi INVALID_TIMER_ID
new gRPS_Challenger[MAX_PLAYERS]; // Menyimpan ID pemain yang mengajak bermain
new gRPS_Choice[MAX_PLAYERS];      // Menyimpan pilihan pemain (1: Batu, 2: Gunting, 3: Kertas)
new gRPS_Active[MAX_PLAYERS];      // Menyimpan status apakah pemain sedang dalam permainan
new gRPSTimer[MAX_PLAYERS];        // Menyimpan ID timer untuk setiap permainan

forward EndRPSGame(playerid1, playerid2);
public EndRPSGame(playerid1, playerid2) {
    // Hitung hasil permainan
    new result1 = gRPS_Choice[playerid1], result2 = gRPS_Choice[playerid2];
    if (result1 == result2) {
        SendClientMessage(playerid1, 0xFFFF00FF, "Hasil : Seri !");
        SendClientMessage(playerid2, 0xFFFF00FF, "Hasil : Seri !");
    } else if ((result1 == 1 && result2 == 2) || (result1 == 2 && result1 == 3) || (result1 == 3 && result2 == 1)) {
        SendClientMessage(playerid1, 0x00FF00FF, "Hasil : Kamu Menang !");
        SendClientMessage(playerid2, 0xFF0000FF, "Hasil : Kamu Kalah !");
    } else {
        SendClientMessage(playerid1, 0xFF0000FF, "Hasil : Kamu Kalah !");
        SendClientMessage(playerid2, 0x00FF00FF, "Hasil : Kamu Menang !");
    }
    // Hentikan Timer jika masih ada
    if (gRPSTimer[playerid1] != INVALID_TIMER_ID) {
    KillTimer(gRPSTimer[playerid1]);
    gRPSTimer[playerid1] = INVALID_TIMER_ID;
    }
    if (gRPSTimer[playerid2] != INVALID_TIMER_ID) {
    KillTimer(gRPSTimer[playerid2]);
    gRPSTimer[playerid2] = INVALID_TIMER_ID;
    }

    // Reset status pemain
    gRPS_Active[playerid1] = 0;
    gRPS_Active[playerid2] = 0;
    gRPS_Choice[playerid1] = 0;
    gRPS_Choice[playerid2] = 0;
    gRPS_Challenger[playerid1] = INVALID_PLAYER_ID;
    gRPS_Challenger[playerid2] = INVALID_PLAYER_ID;

    return 1;
}

CMD:rpschallenge(playerid, params[])
{
    new targetPlayerID;

    if (sscanf(params, "d", targetPlayerID)) {
    Usage(playerid, "Penggunaan perintah : /rpschallenge [playerid]");
    return 1;
    }

    if (!IsPlayerConnected(targetPlayerID) || targetPlayerID == playerid) {
    Error(playerid, "Pemain tidak ditemukan atau ID tidak valid .");
    return 1;
    }

    if (gRPS_Active[playerid] || gRPS_Active[targetPlayerID]) {
    Info(playerid, "Salah satu pemain sedang dalam permainan lain .");
    return 1;
    }

    gRPS_Challenger[targetPlayerID] = playerid;
    gRPS_Active[playerid] = 1;
    gRPS_Active[targetPlayerID] = 1;

    Info(targetPlayerID, "Kamu diundang untuk bermain batu gunting kertas . Gunakan /rpsaccept untuk menerima .");
    Info(playerid, "Ajakan telah dikirim .");
    return 1;
}

CMD:rpsaccept(playerid)
{
    if (gRPS_Challenger[playerid] == INVALID_PLAYER_ID) {
    Info(playerid, "Tidak ada ajakan yang diterima .");
    return 1;
    }

    new challenger = gRPS_Challenger[playerid];
    Info(playerid, "Permainan dimulai . Gunakan /rps [1 / Batu , 2 / Gunting ,  3 / Kertas] untuk memilih .");
    Info(challenger, "Permainan dimulai . Gunakan /rps [1 / Batu , 2 / Gunting ,  3 / Kertas] untuk memilih .");

    return 1;
}

CMD:rps(playerid, params[])
{
    new choice;

    if (sscanf(params, "d", choice)) {
    Usage(playerid, "/rps [1 / Batu , 2 / Gunting ,  3 / Kertas]");
    return 1;
    }

    if (!gRPS_Active[playerid] || choice < 1 || choice > 3) {
    Error(playerid, "Anda tidak dalam permainan atau pilihan tidak valid .");
    return 1;
    }

    gRPS_Choice[playerid] = choice;

    new opponent = gRPS_Challenger[playerid] == INVALID_PLAYER_ID ? playerid : gRPS_Challenger[playerid];
    if (gRPS_Choice[opponent] == 0) {
        // Jika lawan belum memilih
    Info(playerid, "Pilihan Anda telah disimpan , menunggu lawan memilih .");
    } else {
    // Jika lawan sudah memilih
    EndRPSGame(playerid, opponent);
    }

    return 1;
}