// Author : BigBee (India)
// Type : Library Function
// Please add these credits in your code


// ATTENTION SCRIPTERS : Add include "bhop.pwn" in the main script and put this file also
// where the main script file is


// Defines for checking keys
#define HOLDING(%0) ((newkeys & (%0)) == (%0))
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// ATTENTION SCRIPTERS : Change this value to your desired values
// default is 3.. means..HTTP when player jumps three times continuosly then the
// callback OnPlayerBHopAbuse(playerid) is called
//--------------------------------------------------------------------------
#define MAX_HOPS_ALLOWED 3
//---------------------------------------------------------------------------

// variables to store data
new hopCount[MAX_PLAYERS];
new lastHopOn[MAX_PLAYERS];

new Float:lastHopSpot[MAX_PLAYERS][3];

new timerVal;       // Holds the current time
new timerID;        // holds the timers ID. usefull for killing the timer
new bool:check;     // bool value to whether to check or not


// forwards
forward hopTimeCounter();

// ATTENTION SCRIPTERS : MUST BE IMPLEMENTED IN MAIN SCRIPT
//---------------------------------------------------
forward OnPlayerBHopAbuse(playerid);
//---------------------------------------------------


// ATTENTION SCRIPTERS : This stock should be CALLED from the OnGameModeInit() in main script
// ------------------------------------------------------------------------------------------
stock initBunnyHopCheck() {
	cleanCounters();
	startHopTimeCounter();
}
// -------------------------------------------------------------------------------------------


stock cleanCounters() {
	check=false;
	for(new i=0;i<MAX_PLAYERS;i++) {
	    hopCount[i]=0;
	    lastHopOn[i]=0;
	}
	check=true;
}


public hopTimeCounter() {
	if(!check) {
	    return;
	}
	
	if(timerVal<0) {
	    cleanCounters();
	    timerVal=0;
	} else {
	    timerVal+=1;
	}
}

stock startHopTimeCounter() {
	timerID = SetTimer("hopTimeCounter",1000,1); // increments the count each second
}

stock stopHopTimeCounter() {
	KillTimer(timerID);
}

// ATTENTION SCRIPTERS : This stock must be CALLED from the main script from OnKeyStateChange()
//---------------------------------------------------------------------------------------------
stock OnPlayerJump(playerid, newkeys, oldkeys) {

	if(! RELEASED(KEY_JUMP)) {
	    return;
	}

	if(!check) {
	    return;
	}
	
	new currTimerVal = timerVal;
	
	if( (currTimerVal-lastHopOn[playerid]) <= 2 ) {
	    hopCount[playerid]+=1;
	}
	
	if( (currTimerVal-lastHopOn[playerid]) > 10 ) {
			hopCount[playerid]=0;
	}
	
    lastHopOn[playerid] = currTimerVal;

	if(hopCount[playerid] >= MAX_HOPS_ALLOWED) {
	    hopCount[playerid]=0;
	    lastHopOn[playerid]=0;
	    OnPlayerBHopAbuse(playerid);
	}
}
//-----------------------------------------------------------------------------------------------
