#include <YSI_Coding\y_hooks>
new customModelLoadCount = 0;

static LoadCustomModels()
{
	customModelLoadCount++;
	printf("[CustomSkin]: %d Loaded", customModelLoadCount);
	return 1;
}

public OnPlayerRequestDownload(playerid, type, crc)
{
    return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

hook OnGameModeInit()
{
	LoadCustomModels();
	return 1;
}