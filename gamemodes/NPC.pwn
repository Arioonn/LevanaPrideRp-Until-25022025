#include <a_samp>

#define NPC_NAME "TrainNPC"
#define TRAIN_RECORD "train_path"  // Path recording file

#define STATION_COUNT 3 // Jumlah stasiun yang ingin ditambahkan

// Struktur untuk menyimpan data stasiun
new Float:StationPos[STATION_COUNT][4] =
{
{1985.234, -2332.447, 13.00, 15.0},    // Stasiun 1
{1704.333, -1953.445, 13.00, 10.0},   // Stasiun 2
{1501.987, -1875.234, 13.00, 20.0}    // Stasiun 3
};

new stationIndex[MAX_PLAYERS]; // Indeks stasiun saat ini untuk setiap pemain

forward OnNPCConnect(npcid);
forward MoveToNextStation(playerid);

// Callback ketika NPC terhubung
public OnNPCConnect(npcid)
{
    if (strcmp(NPC_NAME, GetName(npcid), true) == 0)
    {
        // Masukkan NPC ke kereta
        PutPlayerInVehicle(npcid, AddStaticVehicle(537, 1985.234, -2332.447, 13.00, 0.0, 1, 1), 0);
        stationIndex[npcid] = 0;
        MoveToNextStation(npcid);
    }
    return 1;
}

// Fungsi untuk menggerakkan NPC ke stasiun berikutnya
public MoveToNextStation(playerid)
{
    if (stationIndex[playerid] < STATION_COUNT)
    {
        new Float:x = StationPos[stationIndex[playerid]][0];
        new Float:y = StationPos[stationIndex[playerid]][1];
        new Float:z = StationPos[stationIndex[playerid]][2];
        new holdTime = floatround(StationPos[stationIndex[playerid]][3], floatround_tozero); // Hold time in seconds

        // Menggerakkan kendaraan ke posisi stasiun dan berhenti
        GameTextForPlayer(playerid, "~w~Stasiun berikutnya!", 2000, 1);
        InterpolateCameraPos(playerid, x, y, z, 3.0); // Kamera mengikuti
        SetTimerEx("MoveToNextStation", holdTime * 1000, false, "i", playerid);
    }
    else
    {
    stationIndex[playerid] = 0;
    MoveToNextStation(playerid);
    }
    stationIndex[playerid]++;
    return 1;
}