#include <a_samp>

#define SPEED_ROTATE_LEFTRIGHT_SLOW 3.0
#define SPEED_ROTATE_LEFTRIGHT_FAST 4.0

#define SPEED_ROTATE_UPDOWN_SLOW 0.15
#define SPEED_ROTATE_UPDOWN_FAST 0.15

#define SPEED_MOVE_UPDOWN_SLOW 1.0
#define SPEED_MOVE_UPDOWN_FAST 1.0

#define SPEED_MOVE_FORWARDBACKWARD_SLOW 3.0
#define SPEED_MOVE_FORWARDBACKWARD_FAST 4.0

#define SPEED_MOVE_LEFTRIGHT_SLOW 2.0
#define SPEED_MOVE_LEFTRIGHT_FAST 2.0



#define ScriptVersion 2.0

//Cameradefines:
new Float:PCP[MAX_PLAYERS][3]; // PCP = PlayerCameraPosition
new Float:PCL[MAX_PLAYERS][3]; // PCL = PlayerCameraLookat
new Float:PCA[MAX_PLAYERS];    // PCA = PlayerCameraAngle

//Playerdefines:
new IsInCameraMode[MAX_PLAYERS];
new KeyTimer[MAX_PLAYERS];
new KeyState[MAX_PLAYERS];
new CameraLocked[MAX_PLAYERS];
new FollowOn[MAX_PLAYERS];

CMD:cameracmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	SendClientMessage(playerid, 0xC6E2FFFF, "INFO: {FFFFFF}Flying Camera Help:");
	SendClientMessage(playerid, 0xC6E2FFFF, "INFO: {FFFFFF}*/specfly*  Start Flying Camera Mode");
	SendClientMessage(playerid, 0xC6E2FFFF, "INFO: {FFFFFF}*Arrow-keys*: Move camera forward/backward/left/right");
	SendClientMessage(playerid, 0xC6E2FFFF, "INFO: {FFFFFF}*Walk-key + Arrow-keys*: *Move camera up/down");
	SendClientMessage(playerid, 0xC6E2FFFF, "INFO: {FFFFFF}*Crouch-key + Arrow-keys*: *Rotate camera up/down/left/right");
	SendClientMessage(playerid, 0xC6E2FFFF, "INFO: {FFFFFF}*Sprint-key*: Speeds up every movement");

	return 1;
}

CMD:specfly(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);


	if(IsInCameraMode[playerid] == 0)
	{
	    TogglePlayerControllable(playerid, 0);
	    CameraLocked[playerid] = 0;
	    IsInCameraMode[playerid] = 1;
	    FollowOn[playerid] = 0;
		GetPlayerPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
		GetPlayerFacingAngle(playerid, PCA[playerid]);
		if(IsPlayerInAnyVehicle(playerid))
		{
			GetVehicleZAngle(GetPlayerVehicleID(playerid), PCA[playerid]);
		}
		PCL[playerid][0] = PCP[playerid][0];
		PCL[playerid][1] = PCP[playerid][1];
		PCL[playerid][2] = PCP[playerid][2];
		PCP[playerid][0] = PCP[playerid][0] - (5.0 * floatsin(-PCA[playerid], degrees));
		PCP[playerid][1] = PCP[playerid][1] - (5.0 * floatcos(-PCA[playerid], degrees));
		PCP[playerid][2] = PCP[playerid][2]+2.0;
		SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
		SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
		KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 70, 1, "i", playerid);
	}
	else
	{
	    TogglePlayerControllable(playerid, 1);
	    KillTimer(KeyTimer[playerid]);
		IsInCameraMode[playerid] = 0;
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_CROUCH)
	{
	    KeyState[playerid] = 1;
	}
	else if(newkeys == KEY_SPRINT)
	{
	    KeyState[playerid] = 2;
	}
	else if(newkeys == (KEY_CROUCH+KEY_SPRINT))
	{
	    KeyState[playerid] = 3;
	}
	else if(newkeys == KEY_WALK)
	{
	    KeyState[playerid] = 4;
	}
	else if(newkeys == (KEY_WALK+KEY_SPRINT))
	{
	    KeyState[playerid] = 5;
	}
	else
	{
	    KeyState[playerid] = 0;
	}
	return 1;
}

forward CheckKeyPress(playerid);
public CheckKeyPress(playerid)
{
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    
    //==================================================
    //ROTATING CAMERA
    //==================================================
    if(KeyState[playerid] == 1 || KeyState[playerid] == 3)
    {
		if(leftright == KEY_RIGHT)
		{
		    if(KeyState[playerid] == 3)
		    {
		        PCA[playerid] = (PCA[playerid]-SPEED_ROTATE_LEFTRIGHT_FAST);
		    }
		    else
		    {
		    	PCA[playerid] = (PCA[playerid]-SPEED_ROTATE_LEFTRIGHT_SLOW);
			}
			if(PCA[playerid] <= 0)
			{
			    PCA[playerid] = (360-PCA[playerid]);
			}
			MovePlayerCamera(playerid);
		}
		if(leftright == KEY_LEFT)
		{
		    if(KeyState[playerid] == 3)
		    {
		        PCA[playerid] = (PCA[playerid]+SPEED_ROTATE_LEFTRIGHT_FAST);
		    }
		    else
		    {
		    	PCA[playerid] = (PCA[playerid]+SPEED_ROTATE_LEFTRIGHT_SLOW);
			}
			if(PCA[playerid] >= 360)
			{
			    PCA[playerid] = (PCA[playerid]-360);
			}
			MovePlayerCamera(playerid);
		}
		if(updown == KEY_UP)
		{
		    if(PCL[playerid][2] < (PCP[playerid][2]+5))
		    {
				if(KeyState[playerid] == 3)
				{
				    PCL[playerid][2] = PCL[playerid][2]+SPEED_ROTATE_UPDOWN_FAST;
				}
				else
				{
				    PCL[playerid][2] = PCL[playerid][2]+SPEED_ROTATE_UPDOWN_SLOW;
				}
			}
			MovePlayerCamera(playerid);
		}
		if(updown == KEY_DOWN)
		{
		    if(PCL[playerid][2] > (PCP[playerid][2]-5))
		    {
				if(KeyState[playerid] == 3)
				{
				    PCL[playerid][2] = PCL[playerid][2]-SPEED_ROTATE_UPDOWN_FAST;
				}
				else
				{
				    PCL[playerid][2] = PCL[playerid][2]-SPEED_ROTATE_UPDOWN_SLOW;
				}
			}
			MovePlayerCamera(playerid);
		}
	}
	
	//==================================================
    //MOVING CAMERA UP/DOWN
    //==================================================
	if(KeyState[playerid] == 4 || KeyState[playerid] == 5)
	{
		if(updown == KEY_UP)
		{
		    if(KeyState[playerid] == 4)  //Slow Up
		    {
		        PCP[playerid][2] = (PCP[playerid][2]+SPEED_MOVE_UPDOWN_SLOW);
		        PCL[playerid][2] = (PCL[playerid][2]+SPEED_MOVE_UPDOWN_SLOW);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else if(KeyState[playerid] == 5)  //Fast Up
		    {
		        PCP[playerid][2] = (PCP[playerid][2]+SPEED_MOVE_UPDOWN_FAST);
		        PCL[playerid][2] = (PCL[playerid][2]+SPEED_MOVE_UPDOWN_FAST);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}
		if(updown == KEY_DOWN)
		{
		    if(KeyState[playerid] == 4)  //Slow Down
		    {
		        PCP[playerid][2] = (PCP[playerid][2]-SPEED_MOVE_UPDOWN_SLOW);
		        PCL[playerid][2] = (PCL[playerid][2]-SPEED_MOVE_UPDOWN_SLOW);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else if(KeyState[playerid] == 5)  //Fast Down
		    {
		        PCP[playerid][2] = (PCP[playerid][2]-SPEED_MOVE_UPDOWN_FAST);
		        PCL[playerid][2] = (PCL[playerid][2]-SPEED_MOVE_UPDOWN_FAST);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}
	}
		        
	
	
	//==================================================
    //MOVING CAMERA
    //==================================================
	else if(KeyState[playerid] == 2 || KeyState[playerid] == 0)
	{
	    if(leftright == KEY_RIGHT)
		{
            new Float:Angle;
			Angle = PCA[playerid];
			Angle -= 90.0;
		    if(KeyState[playerid] == 2)
			{
		        
		        PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
		    }
		    else
			{
		    	PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
			}
			SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
			SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
		}
		if(leftright == KEY_LEFT)
		{
		    new Float:Angle;
			Angle = PCA[playerid];
			Angle += 90.0;
		    if(KeyState[playerid] == 2)
			{
		        PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
		    }
		    else
			{
		    	PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
			}
			SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
			SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
		}
		
		if(updown == KEY_UP)
		{
		    new Float:X, Float:Y, Float:Z;
      		if(KeyState[playerid] == 2)
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], SPEED_MOVE_FORWARDBACKWARD_FAST, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
				X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], SPEED_MOVE_FORWARDBACKWARD_SLOW, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
				X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}

		if(updown == KEY_DOWN)
		{
		    new Float:X, Float:Y, Float:Z;
			if(KeyState[playerid] == 2)
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], -SPEED_MOVE_FORWARDBACKWARD_FAST, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
			    X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], -SPEED_MOVE_FORWARDBACKWARD_SLOW, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
			    X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}
	}
}

stock MovePlayerCamera(playerid)
{
	PCL[playerid][0] = PCP[playerid][0] + (floatmul(5.0, floatsin(-PCA[playerid], degrees)));
	PCL[playerid][1] = PCP[playerid][1] + (floatmul(5.0, floatcos(-PCA[playerid], degrees)));
	SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
	SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
}

GetCoordsOnLine3D(Float:startX, Float:startY, Float:startZ, Float:endX, Float:endY, Float:endZ, Float:length, &Float:RX, &Float:RY, &Float:RZ) //Original function by Nubotron. Slightly edited by me.
{
    RX = startX - endX;
    RY = startY - endY;
    RZ = startZ - endZ;
    new Float:sqrt = floatsqroot((RX * RX) + (RY * RY) + (RZ * RZ));
    if (sqrt < 0.01)
        sqrt = 0.01;
    RX = -length * (RX / sqrt) + startX;
    RY = -length * (RY / sqrt) + startY;
    RZ = -length * (RZ / sqrt) + startZ;
}

stock Float:GetAngle(playerid, Float:x, Float:y)  //Original function by Fallout. Edited by me.
{
	new Float: Pa;
	Pa = floatabs(atan((y-PCP[playerid][1])/(x-PCP[playerid][0])));
	if (x <= PCP[playerid][0] && y >= PCP[playerid][1]) Pa = floatsub(180, Pa);
	else if (x < PCP[playerid][0] && y < PCP[playerid][1]) Pa = floatadd(Pa, 180);
	else if (x >= PCP[playerid][0] && y <= PCP[playerid][1]) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	return Pa;
}


forward FollowPlayer(playerid);
public FollowPlayer(playerid)
{
	new Float:PX, Float:PY, Float:PZ;
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, PX, PY, PZ);
	GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PX, PY, PZ, 5.0, X, Y, Z);
	PCL[playerid][0] = X;
    PCL[playerid][1] = Y;
    PCL[playerid][2] = Z;
    PCA[playerid] = GetAngle(playerid, PX, PY);
	SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
}
