#include <a_samp>

#define DRIVEBY_RANGE 10.0 // Jarak tembakan drive-by

// Daftar senjata drive-by
enum DriveByWeapons {
    DRIVEBY_WEAPON_SHOTGUN = 25,
    DRIVEBY_WEAPON_M4 = 30,
    DRIVEBY_WEAPON_AK47 = 31,
    DRIVEBY_WEAPON_MP5 = 28,
    DRIVEBY_WEAPON_TEC9 = 29
};

// Variabel untuk menyimpan status mode drive-by per pemain
new bool:g_bDriveByMode[MAX_PLAYERS];

// Perintah driveby
CMD:driveby(playerid, params[])
{
    if (IsPlayerInAnyVehicle(playerid))
    {
        if (g_bDriveByMode[playerid])
        {
            g_bDriveByMode[playerid] = false;
            SendClientMessage(playerid, 0xFF0000FF, "Drive-by mode disabled.");
        }
        else
        {
            g_bDriveByMode[playerid] = true;
            SendClientMessage(playerid, 0x00FF00FF, "Drive-by mode enabled.");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xFF0000FF, "You must be in a vehicle to use this command.");
    }
    return 1;
}

// Callback OnPlayerWeaponShot
hook OnPlayerWeaponShot(playerid, weaponid)
{
    // Cek jika pemain dalam mode drive-by dan menggunakan senjata yang diizinkan
    if (g_bDriveByMode[playerid] &&
        (weaponid == DRIVEBY_WEAPON_SHOTGUN ||
         weaponid == DRIVEBY_WEAPON_M4 ||
         weaponid == DRIVEBY_WEAPON_AK47 ||
         weaponid == DRIVEBY_WEAPON_MP5 ||
         weaponid == DRIVEBY_WEAPON_TEC9))
    {
        // Logika untuk drive-by
        // Misalnya, lakukan penembakan dengan menyesuaikan arah tembakan
        // dan target yang terkena tembakan
        // Ini bisa melibatkan logika tambahan sesuai kebutuhan
    }
    return 1;
}
