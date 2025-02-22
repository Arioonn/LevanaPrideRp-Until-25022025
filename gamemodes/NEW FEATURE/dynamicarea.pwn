#include "NEW FEATURE\NotifCylinder.pwn"
public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if(areaid == Healing)
	{
	    ShowCylinderText(playerid, "Anda memasukin tempat healing");
        pData[playerid][TempatHealing] = true;
	}
    if(areaid == gzraps[0])
    {
        ShowCylinderText(playerid, "Anda telah memasuki Green Zone");
    }
    if(areaid == gzraps[1])
    {
        ShowCylinderText(playerid, "Anda telah memasuki Green Zone");
    }
    if(areaid == gzraps[2])
    {
        ShowCylinderText(playerid, "Anda telah memasuki Green Zone");
    }
    if(areaid == gzraps[3])
    {
        ShowCylinderText(playerid, "Anda telah memasuki Green Zone");
    }
    if(areaid == gzraps[4])
    {
        ShowCylinderText(playerid, "Anda telah memasuki Green Zone");
    }
    return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if(areaid == Healing)
	{
	    ShowCylinderText(playerid, "Anda telah meninggalkan tempat healing");
	    pData[playerid][TempatHealing] = false;
	    KillTimer(stresstimer[playerid]);
	}
    if(areaid == gzraps[0])
    {
        ShowCylinderText(playerid, "Anda telah meninggalkan Gz Area");
    }
    if(areaid == gzraps[1])
    {
        ShowCylinderText(playerid, "Anda telah meninggalkan Gz Area");
    }
    if(areaid == gzraps[2])
    {
    	ShowCylinderText(playerid, "Anda telah meninggalkan Gz Area");
    }
    if(areaid == gzraps[3])
    {
        ShowCylinderText(playerid, "Anda telah meninggalkan Gz Area");
    }
    if(areaid == gzraps[4])
    {
        ShowCylinderText(playerid, "Anda telah meninggalkan Gz Area");
    }
    if(ShowCylinderNotif[playerid]) HideCylinderText(playerid);
    return 1;
}