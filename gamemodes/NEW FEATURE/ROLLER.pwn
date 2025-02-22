#include <a_samp>
#include <streamer>
#include <sscanf2>
#include <file>

new gRollerID[MAX_PLAYERS];        // Menyimpan ID objek roller untuk setiap pemain
new gRollerTimer[MAX_PLAYERS];     // Menyimpan ID timer untuk putaran roller
new gRandomRollerResult[MAX_PLAYERS]; // Menyimpan hasil acak untuk setiap pemain
#define INVALID_TIMER_ID -1 // Definisi INVALID_TIMER_ID jika belum ada

// Fungsi untuk membuat objek roller
CreateRollerForPlayer(playerid, Float:x, Float:y, Float:z)
{
    if (gRollerID[playerid] != INVALID_STREAMER_ID) {
        DestroyDynamicObject(gRollerID[playerid]);
    }

    gRollerID[playerid] = CreateDynamicObject(18804, x, y, z, 0.0, 0.0, 0.0); // 18804 adalah ID objek roller, Anda bisa menggantinya dengan ID objek yang Anda inginkan
    gRollerTimer[playerid] = INVALID_TIMER_ID;
}

// Fungsi untuk menghancurkan objek roller
DestroyRollerForPlayer(playerid)
{
    if (gRollerID[playerid] != INVALID_STREAMER_ID) {
        DestroyDynamicObject(gRollerID[playerid]);
        gRollerID[playerid] = INVALID_STREAMER_ID;
    }
    if (gRollerTimer[playerid] != INVALID_TIMER_ID) {
        KillTimer(gRollerTimer[playerid]);
        gRollerTimer[playerid] = INVALID_TIMER_ID;
    }
}

// Fungsi untuk menyimpan hasil roller ke file
SaveRollerResultToFile(playerid, result)
{
    new File:file = fopen("scriptfiles/roller.cfg", io_append);
    if (file) {
        new string[128];
        format(string, sizeof(string), "PlayerID: %d - Result: %d", playerid, result);
        fwrite(file, string);
        fclose(file);
    }
}

forward RollerTick(playerid);
public RollerTick(playerid)
{
    if (gRollerID[playerid] != INVALID_STREAMER_ID) {
        // Mengambil hasil acak antara 1 dan 6 (seperti dadu)
        new result = random(6) + 1;
        gRandomRollerResult[playerid] = result;

        // Menyimpan hasil ke file
        SaveRollerResultToFile(playerid, result);

        // Membuat roller berputar
        new Float:rx, Float:ry, Float:rz;
        GetDynamicObjectRot(gRollerID[playerid], rx, ry, rz);
        SetDynamicObjectRot(gRollerID[playerid], rx, ry, rz + 30); // Berputar secara sederhana

        // Mengirim hasil acak ke pemain
        new msg[128];
        format(msg, sizeof(msg), "Roller menghasilkan angka acak: %d", result);
        SendClientMessage(playerid, 0x00FF00FF, msg);
    } else {
        KillTimer(gRollerTimer[playerid]);
        gRollerTimer[playerid] = INVALID_TIMER_ID;
    }
}

CMD:makeroller(playerid, params[])
{
    new Float:x, Float:y, Float:z;

    // Mengambil posisi pemain
    GetPlayerPos(playerid, x, y, z);

    // Menambahkan posisi offset untuk memunculkan obyek di depan pemain
    new Float:offset = 5.0;
    new Float:angle;
    GetPlayerFacingAngle(playerid, angle);
    x += floatsin(-angle, degrees) * offset;
    y += floatcos(-angle, degrees) * offset;

    // Membuat objek roller di posisi yang ditentukan
    CreateRollerForPlayer(playerid, x, y, z);
    SendClientMessage(playerid, 0x00FF00FF, "Obyek roller telah dibuat.");
    return 1;
}

CMD:removeroller(playerid, params[])
{
    // Menghancurkan objek roller
    DestroyRollerForPlayer(playerid);
    SendClientMessage(playerid, 0xFF0000FF, "Obyek roller telah dihancurkan.");
    return 1;
}

CMD:spinroller(playerid, params[])
{
    if (gRollerID[playerid] == INVALID_STREAMER_ID) {
        SendClientMessage(playerid, 0xFF0000FF, "Tidak ada obyek roller yang ditemukan.");
        return 1;
    }

    // Mulai putar roller jika ada
    if (gRollerTimer[playerid] == INVALID_TIMER_ID) {
        gRollerTimer[playerid] = SetTimerEx("RollerTick", 500, true, "i", playerid);
        SendClientMessage(playerid, 0x00FF00FF, "Roller mulai berputar.");
    } else {
        SendClientMessage(playerid, 0xFF0000FF, "Roller sudah berputar.");
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyRollerForPlayer(playerid);
    return 1;
}