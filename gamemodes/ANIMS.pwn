
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimationEx(playerid,animlib,"null",0.0,0,0,0,0,0,1);
}

ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimationEx(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);

	if(loop > 0 || freeze > 0)
	{
		pData[playerid][pLoopAnim] = 1;

		if(!pData[playerid][pHospital])
		{
			TextDrawShowForPlayer(playerid, AnimationTD);
		}
	}
}

//OnPlayerSpawn
LoadAnims(playerid)
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
}

stock AnimationCheck(playerid)
{
	return (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT || pData[playerid][pInjured] == 1 || pData[playerid][pCuffed] == 1 || pData[playerid][pFreeze] == 1);
}

CMD:handsup(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}


CMD:fall(playerid, params[]) {
    new type;

    if(!AnimationCheck(playerid))
        return Error(playerid, "Kamu tidak dapat melakukan animasi saat ini.");

    if(sscanf(params, "d", type))
        return Usage(playerid, "/fall [1-4]");

    if(type < 1 || type > 4)
        return Error(playerid, "Jenis yang ditentukan tidak valid.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "PED", "KO_skid_front", 4.1, 0, 0, 0, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "PED", "KO_shot_face", 4.1, 0, 0, 0, 1, 0, 1);
        case 3: ApplyAnimationEx(playerid, "PED", "KO_shot_stom", 4.1, 0, 0, 0, 1, 0, 1);
        case 4: ApplyAnimationEx(playerid, "PED", "BIKE_fallR", 4.1, 0, 0, 0, 1, 0, 1);
    }
    return 1;
}

CMD:fallover(playerid, params[])
{
	if(!AnimationCheck(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
	case 2: ApplyAnimationEx(playerid, "PED", "KO_shot_face", 4.0, 0, 1, 1, 1, 0, 1);
	case 3: ApplyAnimationEx(playerid, "PED", "KO_shot_stom", 4.0, 0, 1, 1, 1, 0, 1);
	case 4: ApplyAnimationEx(playerid, "PED", "BIKE_fallR", 4.1, 0, 1, 1, 1, 0, 1);
	case 5: ApplyAnimationEx(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
	default: Usage(playerid, "/fallover [1-5]");
	}
	return 1;
}

CMD:piss(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, 68);
	return 1;
}
alias:animcmds("animhelp", "anims", "animation")
CMD:animcmds(playerid, params[])
{
	SendClientMessage(playerid, COLOR_CLIENT, "[ANIMATION]:{FFFFFF} /handsup, /bat, /slapp, /bar, /wash, /lay, /workout, /blowjob, /bomb.");
	SendClientMessage(playerid, COLOR_CLIENT, "[ANIMATION]:{FFFFFF} /carry, /crack, /slep, /jump, /deal, /dancing, /eating, /puke, /gsign, /chat.");
	SendClientMessage(playerid, COLOR_CLIENT, "[ANIMATION]:{FFFFFF} /goggles, /spray, /throw, /swipe, /office, /kiss, /knife, /cpr, /scratch, /point.");
	SendClientMessage(playerid, COLOR_CLIENT, "[ANIMATION]:{FFFFFF} /cheer, /wave, /strip, /smoke, /reload, /taichi, /wank, /hide, /drunk.");
	SendClientMessage(playerid, COLOR_CLIENT, "[ANIMATION]:{FFFFFF} /cry, /tired, /sit, /crossarms, /fucku, /walk, /piss, /stopanim /fallover.");
	return 1;
}

CMD:stopanim(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return Error(playerid, "You don't need to use this command right now.");

	ClearAnimations(playerid);
    StopLoopingAnim(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    TogglePlayerControllable(playerid, 1);

	return 1;
}

CMD:bat(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/bat [1-5]");

	if (type < 1 || type > 5)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BASEBALL", "Bat_1", 4.1, 0, 1, 1, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BASEBALL", "Bat_2", 4.1, 0, 1, 1, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BASEBALL", "Bat_3", 4.1, 0, 1, 1, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BASEBALL", "Bat_4", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BASEBALL", "Bat_IDLE", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:slapp(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BASEBALL", "Bat_M", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:bar(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/bar [1-8]");

	if (type < 1 || type > 8)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BAR", "Barserve_bottle", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BAR", "Barserve_give", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BAR", "Barserve_glass", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BAR", "Barserve_in", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BAR", "Barserve_order", 4.1, 0, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.1, 1, 0, 0, 0, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "BAR", "dnk_stndM_loop", 4.1, 0, 0, 0, 0, 0, 1);
	    case 8: ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:wash(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:lay(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/lay [1-5]");

	if (type < 1 || type > 5)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BEACH", "ParkSit_W_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:workout(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/workout [1-7]");

	if (type < 1 || type > 7)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:blowjob(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/blowjob [1-4]");

	if (type < 1 || type > 4)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:bomb(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:carry(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/carry [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CARRY", "liftup05", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:crack(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/crack [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth1", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "CRACK", "crckdeth3", 4.1, 0, 0, 0, 1, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.1, 0, 0, 0, 1, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:slep(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/sleep [1-2]");

	if (type < 1 || type > 2)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:jump(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "DODGE", "Crush_Jump", 4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:deal(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/deal [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "DEALER", "DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "DEALER", "shop_pay", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 1, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_03", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:dancing(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/dancing [1-10]");

	if (type < 1 || type > 10)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
	    case 8: ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.1, 1, 0, 0, 0, 0, 1);
	    case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
	    case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:eating(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/eating [1-3]");

	if (type < 1 || type > 3)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:puke(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:gsign(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/gsign [1-15]");

	if (type < 1 || type > 15)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "GHANDS", "gsign1", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "GHANDS", "gsign1LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "GHANDS", "gsign2", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "GHANDS", "gsign2LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "GHANDS", "gsign3", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "GHANDS", "gsign3LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "GHANDS", "gsign4", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "GHANDS", "gsign4LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 9: ApplyAnimationEx(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
		case 10: ApplyAnimationEx(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
		case 11: ApplyAnimationEx(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 12: ApplyAnimationEx(playerid, "GANGS", "Invite_No", 4.1, 0, 0, 0, 0, 0, 1);
		case 13: ApplyAnimationEx(playerid, "GANGS", "Invite_Yes", 4.1, 0, 0, 0, 0, 0, 1);
		case 14: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkD", 4.1, 0, 0, 0, 0, 0, 1);
		case 15: ApplyAnimationEx(playerid, "GANGS", "smkcig_prtl", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:chat(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/chat [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkB", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkE", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkF", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkG", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkH", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:goggles(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "goggles", "goggles_put_on", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:spray(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

 	ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:throw(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:swipe(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:office(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/office [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:kiss(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/kiss [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:knife(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/knife [1-8]");

	if (type < 1 || type > 8)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "KNIFE", "knife_1", 4.1, 0, 1, 1, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "KNIFE", "knife_2", 4.1, 0, 1, 1, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "KNIFE", "knife_3", 4.1, 0, 1, 1, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "KNIFE", "knife_4", 4.1, 0, 1, 1, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "KNIFE", "WEAPON_knifeidle", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Player", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Ped_Damage", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cpr(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:scratch(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/scratch [1-4]");

	if (type < 1 || type > 4)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
    	case 1: ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:point(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/point [1-4]");

	if (type < 1 || type > 4)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "ARRESTgun", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 1, 0, 0, 0, 0, 1);
    	case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "point_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cheer(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/cheer [1-8]");

	if (type < 1 || type > 8)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_in", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "RIOT", "RIOT_CHANT", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "RIOT", "RIOT_shout", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "OTB", "wtchrace_win", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:strip(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/strip [1-7]");

	if (type < 1 || type > 7)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.1, 1, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:wave(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/wave [1-3]");

	if (type < 1 || type > 3)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "endchat_03", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "KISSING", "gfwave2", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:smoke(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/smoke [1-3]");

	if (type < 1 || type > 3)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:reload(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/reload [1-4]");

	if (type < 1 || type > 4)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "BUDDY", "buddy_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "UZI", "UZI_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "RIFLE", "rifle_load", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:taichi(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:wank(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/wank [1-3]");

	if (type < 1 || type > 3)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "PAULNMAC", "wank_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "PAULNMAC", "wank_in", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "PAULNMAC", "wank_out", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:hide(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "cower", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:drunk(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "WALK_drunk", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}

CMD:cry(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:tired(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/tired [1-2]");

	if (type < 1 || type > 2)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "FAT", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:sit(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/sit [1-6]");

	if (type < 1 || type > 6)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.1, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 0, 0, 1, 0);
		case 3: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.1, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.1, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.1, 1, 0, 0, 0, 0);
		case 6: ApplyAnimationEx(playerid, "ped", "SEAT_down", 4.1, 0, 0, 0, 1, 0);
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/crossarms [1-4]");

	if (type < 1 || type > 4)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 0, 1);
	}
	return 1;
}

CMD:fucku(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "fucku", 4.1, 0, 0, 0, 0, 0);
	return 1;
}

CMD:walk(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return Error(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return Info(playerid, "/walk [1-16]");

	if (type < 1 || type > 17)
	    return Error(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "FAT", "FatWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 2: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 3: ApplyAnimationEx(playerid, "PED", "WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
	    case 4: ApplyAnimationEx(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 5: ApplyAnimationEx(playerid, "PED", "WALK_fat", 4.1, 1, 1, 1, 1, 1, 1);
	    case 6: ApplyAnimationEx(playerid, "PED", "WALK_fatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 7: ApplyAnimationEx(playerid, "PED", "WALK_gang1", 4.1, 1, 1, 1, 1, 1, 1);
	    case 8: ApplyAnimationEx(playerid, "PED", "WALK_gang2", 4.1, 1, 1, 1, 1, 1, 1);
	    case 9: ApplyAnimationEx(playerid, "PED", "WALK_player", 4.1, 1, 1, 1, 1, 1, 1);
	    case 10: ApplyAnimationEx(playerid, "PED", "WALK_old", 4.1, 1, 1, 1, 1, 1, 1);
	    case 11: ApplyAnimationEx(playerid, "PED", "WALK_wuzi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 12: ApplyAnimationEx(playerid, "PED", "WOMAN_walkbusy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 13: ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 14: ApplyAnimationEx(playerid, "PED", "WOMAN_walknorm", 4.1, 1, 1, 1, 1, 1, 1);
	    case 15: ApplyAnimationEx(playerid, "PED", "WOMAN_walksexy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 16: ApplyAnimationEx(playerid, "PED", "WOMAN_walkshop", 4.1, 1, 1, 1, 1, 1, 1);
	}
	return 1;
}