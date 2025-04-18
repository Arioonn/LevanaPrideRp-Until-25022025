#include <YSI\y_hooks>
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF

new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];

//-------------------------------------------------

stock IsKeyJustDown(key, newkeys, oldkeys)
{
    if((newkeys & key) && !(oldkeys & key)) return 1;
    return 0;
}

PlayAnimEx(playerid, animlib[], animname[], Float:fDelta, loop=1, lockx, locky, freeze, time=0, forcesync=1)
{
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
	gPlayerUsingLoopingAnim[playerid] = 1;
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0,1);
}

IsAblePedAnimation(playerid)
{
    if(pData[playerid][pInjured] == 1 || pData[playerid][pCuffed] == 1 || pData[playerid][pFreeze] == 1)
	{
   		SendClientMessageEx(playerid, COLOR_ARWIN, "ANIM: "WHITE_E"You can't do that at this time!");
   		return 0;
	}
    if(IsPlayerInAnyVehicle(playerid) == 1)
    {
		SendClientMessageEx(playerid, COLOR_ARWIN, "ANIM: "WHITE_E"This animation requires you to be outside a vehicle.");
		return 0;
	}
	return 1;
}

IsAbleVehicleAnimation(playerid)
{
    if(pData[playerid][pInjured] == 1 || pData[playerid][pCuffed] == 1 || pData[playerid][pFreeze] == 1)
	{
   		SendClientMessageEx(playerid, COLOR_ARWIN, "ANIM: "WHITE_E"You can't do that at this time!");
   		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0)
    {
		SendClientMessageEx(playerid, COLOR_ARWIN, "ANIM: "WHITE_E"This animation requires you to be inside a vehicle.");
		return 0;
	}
	return 1;
}

//-------------------------------------------------

// ********** SPECIFIC VEHICLES **********

IsCLowrider(carid)
{
	new Cars[] = { 536, 575, 567};
	for(new i = 0; i < sizeof(Cars); i++)
	{
		if(GetVehicleModel(carid) == Cars[i]) return 1;
	}
	return 0;
}

// ********** CALLBACKS **********

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPVarInt(playerid, "Injured") != 0) return;
	if(!gPlayerUsingLoopingAnim[playerid]) return;

	if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys))
	{
	    StopLoopingAnim(playerid);
    }
}

//------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(gPlayerUsingLoopingAnim[playerid])
	{
        gPlayerUsingLoopingAnim[playerid] = 0;
	}

 	return 1;
}

//-------------------------------------------------

hook OnPlayerSpawn(playerid)
{
	if(!gPlayerAnimLibsPreloaded[playerid])
	{
	    PreloadAnimLib(playerid,"AIRPORT");
		PreloadAnimLib(playerid,"Attractors");
		PreloadAnimLib(playerid,"BAR");
		PreloadAnimLib(playerid,"BASEBALL");
		PreloadAnimLib(playerid,"BD_FIRE");
		PreloadAnimLib(playerid,"benchpress");
        PreloadAnimLib(playerid,"BF_injection");
        PreloadAnimLib(playerid,"BIKED");
        PreloadAnimLib(playerid,"BIKEH");
        PreloadAnimLib(playerid,"BIKELEAP");
        PreloadAnimLib(playerid,"BIKES");
        PreloadAnimLib(playerid,"BIKEV");
        PreloadAnimLib(playerid,"BIKE_DBZ");
        PreloadAnimLib(playerid,"BMX");
        PreloadAnimLib(playerid,"BOX");
        PreloadAnimLib(playerid,"BSKTBALL");
        PreloadAnimLib(playerid,"BUDDY");
        PreloadAnimLib(playerid,"BUS");
        PreloadAnimLib(playerid,"CAMERA");
        PreloadAnimLib(playerid,"CAR");
        PreloadAnimLib(playerid,"CAR_CHAT");
        PreloadAnimLib(playerid,"CASINO");
        PreloadAnimLib(playerid,"CHAINSAW");
        PreloadAnimLib(playerid,"CHOPPA");
        PreloadAnimLib(playerid,"CLOTHES");
        PreloadAnimLib(playerid,"COACH");
        PreloadAnimLib(playerid,"COLT45");
        PreloadAnimLib(playerid,"COP_DVBYZ");
        PreloadAnimLib(playerid,"CRIB");
        PreloadAnimLib(playerid,"DAM_JUMP");
        PreloadAnimLib(playerid,"DANCING");
        PreloadAnimLib(playerid,"DILDO");
        PreloadAnimLib(playerid,"DODGE");
        PreloadAnimLib(playerid,"DOZER");
        PreloadAnimLib(playerid,"DRIVEBYS");
        PreloadAnimLib(playerid,"FAT");
        PreloadAnimLib(playerid,"FIGHT_B");
        PreloadAnimLib(playerid,"FIGHT_C");
        PreloadAnimLib(playerid,"FIGHT_D");
        PreloadAnimLib(playerid,"FIGHT_E");
        PreloadAnimLib(playerid,"FINALE");
        PreloadAnimLib(playerid,"FINALE2");
        PreloadAnimLib(playerid,"Flowers");
        PreloadAnimLib(playerid,"FOOD");
        PreloadAnimLib(playerid,"Freeweights");
        PreloadAnimLib(playerid,"GANGS");
        PreloadAnimLib(playerid,"GHANDS");
        PreloadAnimLib(playerid,"GHETTO_DB");
        PreloadAnimLib(playerid,"goggles");
        PreloadAnimLib(playerid,"GRAFFITI");
        PreloadAnimLib(playerid,"GRAVEYARD");
        PreloadAnimLib(playerid,"GRENADE");
        PreloadAnimLib(playerid,"GYMNASIUM");
        PreloadAnimLib(playerid,"HAIRCUTS");
        PreloadAnimLib(playerid,"HEIST9");
        PreloadAnimLib(playerid,"INT_HOUSE");
        PreloadAnimLib(playerid,"INT_OFFICE");
        PreloadAnimLib(playerid,"INT_SHOP");
        PreloadAnimLib(playerid,"JST_BUISNESS");
        PreloadAnimLib(playerid,"KART");
        PreloadAnimLib(playerid,"KISSING");
        PreloadAnimLib(playerid,"KNIFE");
        PreloadAnimLib(playerid,"LAPDAN1");
        PreloadAnimLib(playerid,"LAPDAN2");
        PreloadAnimLib(playerid,"LAPDAN3");
        PreloadAnimLib(playerid,"LOWRIDER");
        PreloadAnimLib(playerid,"MD_CHASE");
        PreloadAnimLib(playerid,"MEDIC");
        PreloadAnimLib(playerid,"MD_END");
        PreloadAnimLib(playerid,"MISC");
        PreloadAnimLib(playerid,"MTB");
        PreloadAnimLib(playerid,"MUSCULAR");
        PreloadAnimLib(playerid,"NEVADA");
        PreloadAnimLib(playerid,"ON_LOOKERS");
        PreloadAnimLib(playerid,"OTB");
        PreloadAnimLib(playerid,"PARACHUTE");
        PreloadAnimLib(playerid,"PARK");
        PreloadAnimLib(playerid,"PAULNMAC");
        PreloadAnimLib(playerid,"PED");
        PreloadAnimLib(playerid,"PLAYER_DVBYS");
        PreloadAnimLib(playerid,"PLAYIDLES");
        PreloadAnimLib(playerid,"POLICE");
        PreloadAnimLib(playerid,"POOL");
        PreloadAnimLib(playerid,"POOR");
        PreloadAnimLib(playerid,"PYTHON");
        PreloadAnimLib(playerid,"QUAD");
        PreloadAnimLib(playerid,"QUAD_DBZ");
        PreloadAnimLib(playerid,"RIFLE");
        PreloadAnimLib(playerid,"RIOT");
        PreloadAnimLib(playerid,"ROB_BANK");
        PreloadAnimLib(playerid,"ROCKET");
        PreloadAnimLib(playerid,"RUSTLER");
        PreloadAnimLib(playerid,"RYDER");
        PreloadAnimLib(playerid,"SCRATCHING");
        PreloadAnimLib(playerid,"SHAMAL");
        PreloadAnimLib(playerid,"SHOTGUN");
        PreloadAnimLib(playerid,"SILENCED");
        PreloadAnimLib(playerid,"SKATE");
        PreloadAnimLib(playerid,"SPRAYCAN");
        PreloadAnimLib(playerid,"STRIP");
        PreloadAnimLib(playerid,"SUNBATHE");
        PreloadAnimLib(playerid,"SWAT");
        PreloadAnimLib(playerid,"SWEET");
        PreloadAnimLib(playerid,"SWIM");
        PreloadAnimLib(playerid,"SWORD");
        PreloadAnimLib(playerid,"TANK");
        PreloadAnimLib(playerid,"TATTOOS");
        PreloadAnimLib(playerid,"TEC");
        PreloadAnimLib(playerid,"TRAIN");
        PreloadAnimLib(playerid,"TRUCK");
        PreloadAnimLib(playerid,"UZI");
        PreloadAnimLib(playerid,"VAN");
        PreloadAnimLib(playerid,"VENDING");
        PreloadAnimLib(playerid,"VORTEX");
        PreloadAnimLib(playerid,"WAYFARER");
        PreloadAnimLib(playerid,"WEAPONS");
        PreloadAnimLib(playerid,"WUZI");
        PreloadAnimLib(playerid,"SNM");
        PreloadAnimLib(playerid,"BLOWJOBZ");
        PreloadAnimLib(playerid,"SEX");
   		PreloadAnimLib(playerid,"BOMBER");
   		PreloadAnimLib(playerid,"RAPPING");
    	PreloadAnimLib(playerid,"SHOP");
   		PreloadAnimLib(playerid,"BEACH");
   		PreloadAnimLib(playerid,"SMOKING");
    	PreloadAnimLib(playerid,"FOOD");
    	PreloadAnimLib(playerid,"ON_LOOKERS");
    	PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"FOOD");
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	return 1;
}

//-------------------------------------------------

hook OnPlayerConnect(playerid)
{
    gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;

	return 1;
}

//-------------------------------------------------

CMD:anim(playerid, params[])
{
	#if defined ADD_RCON_PROTECTION
	if(!IsPlayerAdmin(playerid))
	return 1;
	#endif
	new
	animlib[32], animname[32],
	iAnimIndex = strval(params);
	if(iAnimIndex < 1 || iAnimIndex >= MAX_ANIMS)return SendClientMessage(playerid, COLOR_GRAD1, "Total Anims : (Index 1-1812)");
	else
	{
		GetAnimationName(iAnimIndex, animlib, 32, animname, 32);
		PlayAnimEx(playerid, animlib, animname, 4.1, 1, 0, 0, 1, 0, 1);
	}
	return 1;
}
alias:anilist("animhelp", "anims", "animation")
CMD:animlist(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Available Animations:");
	SendClientMessage(playerid, COLOR_GRAD1, "/handsup /drunk /bomb /rob /laugh /lookout /robman /crossarms /sit /siteat /hide /vomit /eat");
	SendClientMessage(playerid, COLOR_GRAD2, "/wave /slapass /deal /taichi /crack /smoke /chat /dance /fucku /drinkwater /pedmove /bat");
	SendClientMessage(playerid, COLOR_GRAD3, "/checktime /sleep /blob /opendoor /wavedown /shakehand /reload /cpr /dive /showoff /box /tag");
	SendClientMessage(playerid, COLOR_GRAD4, "/goggles /cry /dj /cheer /throw /robbed /hurt /nobreath /bar /getjiggy /fallover /rap /piss");
	SendClientMessage(playerid, COLOR_GRAD5, "/salute /crabs /washhands /signal /stop /gesture /jerkoff /idles /lowrider /carchat");
	SendClientMessage(playerid, COLOR_GRAD6, "/blowjob /spank /sunbathe /kiss /snatch /sneak /copa /sexy /holdup /misc /bodypush /walkstyle");
	SendClientMessage(playerid, COLOR_GRAD6, "/lowbodypush /headbutt /airkick /doorkick /leftslap /elbow /coprun /sitonchair /lean /wank");
	SendClientMessage(playerid, COLOR_GREEN, "Use /stopani to stop an animation.");
	return 1;
}

CMD:animhelp(playerid, params[])
{
	return callcmd::animlist(playerid, params);
}

CMD:stopanim(playerid, params[])
{
	if(GetPVarInt(playerid, "PlayerCuffed") != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "You can't do that at this time!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 1)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "This command requires you to be outside a vehicle.");
		return 1;
	}
	ClearAnimations(playerid);
	SetPlayerSkin(playerid, GetPlayerSkin(playerid));
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}

CMD:spray(playerid, params[])
{
    if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:bodypush(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"GANGS", "shake_cara", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:lowbodypush(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
	return 1;
}

CMD:headbutt(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"WAYFARER","WF_Fwd",4.0,0,0,0,0,0);
	return 1;
}

CMD:airkick(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"FIGHT_C","FightC_M",4.0,0,1,1,0,0);
	return 1;
}

CMD:doorkick(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
	return 1;
}

CMD:leftslap(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
	return 1;
}

CMD:elbow(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"FIGHT_D","FightD_3",4.0,0,1,1,0,0);
	return 1;
}

CMD:coprun(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    PlayAnimEx(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
	return 1;
}

CMD:handsup(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:piss(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
   	SetPlayerSpecialAction(playerid, 68);
	return 1;
}

CMD:sneak(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "PED", "Player_Sneak", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}

CMD:drunk(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	PlayAnimEx(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:bomb(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	PlayAnimEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:rob(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:laugh(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:lookout(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	PlayAnimEx(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robman(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hide(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:vomit(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:eat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:slapass(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crack(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:fucku(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:taichi(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:drinkwater(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:checktime(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}
/*
CMD:sleep(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckdeth4", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}
*/
CMD:blob(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckidle1", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:opendoor(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "AIRPORT", "thrw_barl_thrw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:wavedown(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BD_FIRE", "BD_Panic_01", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cpr(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "MEDIC", "CPR", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:dive(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "DODGE", "Crush_Jump", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:showoff(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "Freeweights", "gym_free_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:goggles(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "goggles", "goggles_put_on", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cry(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:throw(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "GRENADE", "WEAPON_throw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robbed(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "SHP_Rob_GiveCash", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hurt(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:box(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:washhands(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crabs(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:salute(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:jerkoff(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:stop(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "endchat_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:rap(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "RAPPING", "RAP_A_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "RAPPING", "RAP_B_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "RAPPING", "RAP_C_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/rap [1-3]");
	}
	return 1;
}

CMD:wank(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "PAULNMAC", "wank_in", 4.0, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/wank [1-3]");
	}
	return 1;
}

CMD:chat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkA", 4.0, 1, 0, 0, 0, 0, 1);
		case 3:	PlayAnimEx(playerid, "GANGS", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
		case 4: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkE", 4.0, 1, 0, 0, 0, 0, 1);
		case 5: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
		case 6: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
		case 7:	PlayAnimEx(playerid, "GANGS", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/chat [1-7]");
	}
	return 1;
}

CMD:sitdown(playerid, params[])
	return callcmd::sitonchair(playerid, params);
	
CMD:sitonchair(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "Attractors", "Stepsit_in", 4.0, 0, 0, 0, 1, 0, 1);
		case 2: PlayAnimEx(playerid, "CRIB", "PED_Console_Loop", 4.0, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "INT_HOUSE", "LOU_In", 4.0, 0, 0, 0, 1, 1, 1);
		case 4: PlayAnimEx(playerid, "MISC", "SEAT_LR", 4.0, 1, 0, 0, 0, 0, 1);
		case 5: PlayAnimEx(playerid, "MISC", "Seat_talk_01", 4.0, 1, 0, 0, 0, 0, 1);
		case 6: PlayAnimEx(playerid, "MISC", "Seat_talk_02", 4.0, 1, 0, 0, 0, 0, 1);
		case 7: PlayAnimEx(playerid, "ped", "SEAT_down", 4.0, 0, 0, 0, 1, 1, 1);
		default: Usage(playerid, "/sitonchair [1-7]");
	}
	return 1;
}

CMD:bat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid,"BASEBALL","Bat_IDLE",4.1, 0, 1, 1, 1, 1, 1);
		case 2: PlayAnimEx(playerid, "CRACK", "Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "CRACK", "Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/bat [1-3]");
	}
	return 1;
}

CMD:lean(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "GANGS", "leanIDLE", 4.0, 0, 0, 0, 1, 0, 1);
		case 2: PlayAnimEx(playerid, "MISC", "Plyrlean_loop", 4.0, 0, 0, 0, 1, 0, 1);
		default: Usage(playerid, "/lean [1-2]");
	}
	return 1;
}

CMD:gesture(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "GHANDS", "gsign1", 4.0, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "GHANDS", "gsign1LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "GHANDS", "gsign2", 4.0, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "GHANDS", "gsign2LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "GHANDS", "gsign3", 4.0, 0, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "GHANDS", "gsign3LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "GHANDS", "gsign4", 4.0, 0, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "GHANDS", "gsign4LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
	case 10: PlayAnimEx(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
	case 11: PlayAnimEx(playerid, "GHANDS", "gsign5LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 12: PlayAnimEx(playerid, "GANGS", "Invite_No", 4.0, 0, 0, 0, 0, 0, 1);
	case 13: PlayAnimEx(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0, 1);
	case 14: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 0, 0, 0, 0, 1);
	case 15: PlayAnimEx(playerid, "GANGS", "smkcig_prtl", 4.0, 0, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/gesture [1-15]");
	}
	return 1;
}

CMD:lay(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/lay [1-3]");
	}
	return 1;
}

CMD:wave(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "KISSING", "gfwave2", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "PED", "endchat_03", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/wave [1-3]");
	}
	return 1;
}

CMD:signal(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "POLICE", "CopTraf_Come", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/signal [1-2]");
	}
	return 1;
}

CMD:nobreath(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1); //Ini Animnya
	case 2: PlayAnimEx(playerid, "PED", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/nobreath [1-3]");
	}
	return 1;
}

CMD:fallover(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
	case 2: PlayAnimEx(playerid, "PED", "KO_shot_face", 4.0, 0, 1, 1, 1, 0, 1);
	case 3: PlayAnimEx(playerid, "PED", "KO_shot_stom", 4.0, 0, 1, 1, 1, 0, 1);
	case 4: PlayAnimEx(playerid, "PED", "BIKE_fallR", 4.1, 0, 1, 1, 1, 0, 1);
	case 5: PlayAnimEx(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
	default: Usage(playerid, "/fallover [1-5]");
	}
	return 1;
}

CMD:pedmove(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "PED", "run_fat", 4.0, 1, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "PED", "run_fatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "PED", "run_old", 4.0, 1, 1, 1, 1, 1, 1);
	case 7: PlayAnimEx(playerid, "PED", "Run_Wuzi", 4.0, 1, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "PED", "swat_run", 4.0, 1, 1, 1, 1, 1, 1);
	case 9: PlayAnimEx(playerid, "PED", "WALK_fat", 4.0, 1, 1, 1, 1, 1, 1);
	case 10: PlayAnimEx(playerid, "PED", "WALK_fatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 11: PlayAnimEx(playerid, "PED", "WALK_gang1", 4.0, 1, 1, 1, 1, 1, 1);
	case 12: PlayAnimEx(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 1, 1, 1);
	case 13: PlayAnimEx(playerid, "PED", "WALK_old", 4.0, 1, 1, 1, 1, 1, 1);
	case 14: PlayAnimEx(playerid, "PED", "WALK_shuffle", 4.0, 1, 1, 1, 1, 1, 1);
	case 15: PlayAnimEx(playerid, "PED", "woman_run", 4.0, 1, 1, 1, 1, 1, 1);
	case 16: PlayAnimEx(playerid, "PED", "WOMAN_runbusy", 4.0, 1, 1, 1, 1, 1, 1);
	case 17: PlayAnimEx(playerid, "PED", "WOMAN_runfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 18: PlayAnimEx(playerid, "PED", "woman_runpanic", 4.0, 1, 1, 1, 1, 1, 1);
	case 19: PlayAnimEx(playerid, "PED", "WOMAN_runsexy", 4.0, 1, 1, 1, 1, 1, 1);
	case 20: PlayAnimEx(playerid, "PED", "WOMAN_walkbusy", 4.0, 1, 1, 1, 1, 1, 1);
	case 21: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 22: PlayAnimEx(playerid, "PED", "WOMAN_walknorm", 4.0, 1, 1, 1, 1, 1, 1);
	case 23: PlayAnimEx(playerid, "PED", "WOMAN_walkold", 4.0, 1, 1, 1, 1, 1, 1);
	case 24: PlayAnimEx(playerid, "PED", "WOMAN_walkpro", 4.0, 1, 1, 1, 1, 1, 1);
	case 25: PlayAnimEx(playerid, "PED", "WOMAN_walksexy", 4.0, 1, 1, 1, 1, 1, 1);
	case 26: PlayAnimEx(playerid, "PED", "WOMAN_walkshop", 4.0, 1, 1, 1, 1, 1, 1);
	default: Usage(playerid, "/pedmove [1-26]");
	}
	return 1;
}

CMD:getjiggy(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
	case 10: PlayAnimEx(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/getjiggy [1-10]");
	}
	return 1;
}

CMD:stripclub(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "STRIP", "PLY_CASH", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "STRIP", "PUN_CASH", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/stripclub [1-2]");
	}
	return 1;
}

CMD:smoke(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SMOKING", "M_smk_in", 4.0, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/smoke [1-2]");
	}
	return 1;
}

CMD:dj(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0, 1);
		case 4: PlayAnimEx(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/dj [1-4]");
	}
	return 1;
}

CMD:reload(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/reload [1-2]");
	}
	return 1;
}

CMD:tag(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/tag [1-2]");
	}
	return 1;
}

CMD:deal(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "DEALER", "DEALER_DEAL", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "DEALER", "shop_pay", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/deal [1-2]");
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1, 1);
		case 2: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
		case 4: PlayAnimEx(playerid, "GRAVEYARD", "prst_loopa", 4.0, 1, 0, 0, 0, 0, 1);
		case 5: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/crossarms [1-5]");
	}
	return 1;
}

CMD:cheer(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "ON_LOOKERS", "shout_01", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "ON_LOOKERS", "shout_02", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "ON_LOOKERS", "shout_in", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "RIOT", "RIOT_CHANT", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "RIOT", "RIOT_shout", 4.0, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "STRIP", "PUN_HOLLER", 4.0, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "OTB", "wtchrace_win", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/cheer [1-8]");
	}
	return 1;
}

CMD:sit(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/sit [1-5]");
	}
	return 1;
}

CMD:siteat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/siteat [1-2]");
	}
	return 1;
}

CMD:bar(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BAR", "Barcustom_get", 4.0, 0, 1, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "BAR", "Barserve_give", 4.0, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "BAR", "BARman_idle", 4.0, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/bar [1-5]");
	}
	return 1;
}

CMD:dance(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
	switch(strval(params))
	{
		case 1: SetPlayerSpecialAction(playerid, 5);
		case 2: SetPlayerSpecialAction(playerid, 6);
		case 3: SetPlayerSpecialAction(playerid, 7);
		case 4: SetPlayerSpecialAction(playerid, 8);
		default: Usage(playerid, "/dance [1-4]");
	}
	return 1;
}

CMD:spank(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "SNM", "SPANKINGW", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "SNM", "SPANKINGP", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "SNM", "SPANKEDW", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: PlayAnimEx(playerid, "SNM", "SPANKEDP", 4.1, 1, 0, 0, 0, 0, 1);
		default: Usage(playerid, "/spank [1-4]");
	}
	return 1;
}

CMD:sexy(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "STRIP", "STR_A2B", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "STRIP", "STR_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "STRIP", "STR_Loop_B", 4.1, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "STRIP", "STR_Loop_C", 4.1, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/sexy [1-6]");
	}
	return 1;
}

CMD:holdup(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
	default: Usage(playerid, "/holdup [1-2]");
	}
	return 1;
}

CMD:stickjup(playerid, params[])
{
    PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:copa(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "POLICE", "CopTraf_Away", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "POLICE", "CopTraf_Left", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "POLICE", "CopTraf_Stop", 4.1, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "POLICE", "Cop_move_FWD", 4.1, 1, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "POLICE", "crm_drgbst_01", 4.1, 0, 0, 0, 1, 5000, 1);
	case 7: PlayAnimEx(playerid, "POLICE", "Door_Kick", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 0, 0, 0, 5000, 1);
	case 9: PlayAnimEx(playerid, "POLICE", "plc_drgbst_02", 4.1, 0, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/copa [1-9]");
	}
	return 1;
}

CMD:misc(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "CAR", "flag_drop", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "PED", "bomber", 4.1, 0, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/misc [1-3]");
	}
	return 1;
}

CMD:snatch(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "PED", "BIKE_elbowL", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "PED", "BIKE_elbowR", 4.1, 0, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/snatch [1-2]");
	}
	return 1;
}

CMD:blowjob(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/blowjob [1-2]");
	}
	return 1;
}

CMD:kiss(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/kiss [1-6]");
	}
	return 1;
}

CMD:idles(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "PLAYIDLES", "shift", 4.1, 1, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "PLAYIDLES", "shldr", 4.1, 1, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "PLAYIDLES", "stretch", 4.1, 1, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "PLAYIDLES", "strleg", 4.1, 1, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "PLAYIDLES", "time", 4.1, 1, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 1, 0, 0, 0, 0, 1);
	case 10: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 1, 0, 0, 0, 0, 1);
	case 11: PlayAnimEx(playerid, "PED", "roadcross", 4.1, 1, 0, 0, 0, 0, 1);
	case 12: PlayAnimEx(playerid, "PED", "roadcross_female", 4.1, 1, 0, 0, 0, 0, 1);
	case 13: PlayAnimEx(playerid, "PED", "roadcross_gang", 4.1, 1, 0, 0, 0, 0, 1);
	case 14: PlayAnimEx(playerid, "PED", "roadcross_old", 4.1, 1, 0, 0, 0, 0, 1);
	case 15: PlayAnimEx(playerid, "PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/idles [1-15]");
	}
	return 1;
}

CMD:sunbathe(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SUNBATHE", "batherdown", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "SUNBATHE", "batherup", 4.1, 0, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.1, 0, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.1, 0, 1, 1, 1, 1, 1);
	case 7: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 9: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 10: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.1, 0, 1, 1, 1, 1, 1);
	case 11: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.1, 0, 1, 1, 1, 1, 1);
	case 12: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.1, 0, 1, 1, 1, 1, 1);
	case 13: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 14: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 15: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.1, 0, 1, 1, 1, 1, 1);
	case 16: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_Out", 4.1, 0, 1, 1, 1, 1, 1);
	case 17: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 1, 1, 1, 1, 1);
	case 18: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_out_W", 4.1, 0, 1, 1, 1, 1, 1);
	default: Usage(playerid, "/sunbathe [1-18]");
	}
	return 1;
}

CMD:lowrider(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	if(IsCLowrider(GetPlayerVehicleID(playerid)))
	{
		switch(strval(params))
		{
		case 1: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_hair", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_hurry", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_idleloop", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 11: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.1, 0, 1, 1, 1, 1, 1);
		case 13: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 14: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 15: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.1, 0, 1, 1, 1, 1, 1);
		case 16: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
		case 17: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 18: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 19: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.1, 0, 1, 1, 1, 1, 1);
		case 20: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 21: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 22: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.1, 0, 1, 1, 1, 1, 1);
		case 23: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 24: PlayAnimEx(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 25: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkB", 4.1, 0, 1, 1, 1, 1, 1);
		case 26: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkC", 4.1, 0, 1, 1, 1, 1, 1);
		case 27: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkD", 4.1, 0, 1, 1, 1, 1, 1);
		case 28: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkE", 4.1, 0, 1, 1, 1, 1, 1);
		case 29: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkF", 4.1, 0, 1, 1, 1, 1, 1);
		case 30: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkG", 4.1, 0, 1, 1, 1, 1, 1);
		case 31: PlayAnimEx(playerid, "LOWRIDER", "prtial_gngtlkH", 4.1, 0, 1, 1, 1, 1, 1);
		default: Usage(playerid, "/lowrider [1-31]");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAD2, "This animation requires you to be in a convertible lowrider.");
	}
	return 1;
}

CMD:carchat(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "CAR_CHAT", "carfone_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "CAR_CHAT", "carfone_loopA", 4.1, 0, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "CAR_CHAT", "carfone_loopA_to_B", 4.1, 0, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "CAR_CHAT", "carfone_loopB", 4.1, 0, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "CAR_CHAT", "carfone_loopB_to_A", 4.1, 0, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "CAR_CHAT", "carfone_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 7: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc1_BL", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc1_BR", 4.1, 0, 1, 1, 1, 1, 1);
	case 9: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc1_FL", 4.1, 0, 1, 1, 1, 1, 1);
	case 10: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc1_FR", 4.1, 0, 1, 1, 1, 1, 1);
	case 11: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc2_FL", 4.1, 0, 1, 1, 1, 1, 1);
	case 12: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc3_BR", 4.1, 0, 1, 1, 1, 1, 1);
	case 13: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc3_FL", 4.1, 0, 1, 1, 1, 1, 1);
	case 14: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc3_FR", 4.1, 0, 1, 1, 1, 1, 1);
	case 15: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.1, 0, 1, 1, 1, 1, 1);
	case 16: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.1, 0, 1, 1, 1, 1, 1);
	case 17: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc4_FL", 4.1, 0, 1, 1, 1, 1, 1);
	case 18: PlayAnimEx(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.1, 0, 1, 1, 1, 1, 1);
	case 19: PlayAnimEx(playerid, "CAR", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);
	//case 20: PlayAnimEx(playerid, "CAR", "Tap_hand", 4.1, 1, 0, 0, 0, 0, 1);
	default: Usage(playerid, "/carchat [1-19]");
	}
	return 1;
}
// I guess its all animations for your samp server. Thank You.
// Credits by KushalD
