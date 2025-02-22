// Server Define
#define TEXT_GAMEMODE	"LPRP V.1.0"
#define TEXT_WEBURL		"https://discord.gg/tKAg6JRv"
#define TEXT_LANGUAGE	"English/Indonesia"
#define SERVER_BOT      "Levana Pride"
#define SERVER_NAME     "Levana Pride"

// localhost
/*#define		MYSQL_HOST 			"localhost"
#define		MYSQL_USER 			"root"
#define		MYSQL_PASSWORD 		""
#define		MYSQL_DATABASE 		"test"*/

// hosting
#define		MYSQL_HOST 			"51.79.136.184"
#define		MYSQL_USER 			"u270_IC2vBP5pEP"
#define		MYSQL_PASSWORD 		"opezm.whapTJs1CSpBA6IRx."
#define		MYSQL_DATABASE 		"s270_levana"

// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	200

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1744.3411
#define 	DEFAULT_POS_Y 		-1862.8655
#define 	DEFAULT_POS_Z 		13.3983
#define 	DEFAULT_POS_A 		270.0000

//Android Client Check
//#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)
#define MAX_ANIMS (1812)

// Message
#define function%0(%1) forward %0(%1); public %0(%1)
#define Servers(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "SERVER: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "INFO: "WHITE_E""%2)
#define Vehicle(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, "VEHICLE: "WHITE_E""%2)
#define Usage(%1,%2) SendClientMessage(%1, COLOR_ARWIN , "USAGE: "WHITEP_E""%2)
#define Error(%1,%2) SendClientMessageEx(%1, COLOR_RED, "ERROR: "WHITE_E""%2)
#define AdminCMD(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN , "AdmCmd: "WHITEP_E""%2)
#define Looping(%0,%1) for(new %0 = 1; %0 < %1; %0++)
#define Gps(%1,%2) SendClientMessageEx(%1, COLOR_ARWIN, ""COLOR_GPS"GPS: "WHITE_E""%2)
#define PermissionError(%0) SendClientMessage(%0, COLOR_RED, "ERROR: "WHITE_E"Kamu tidak memiliki akses untuk melakukan command ini!")
#define SendCustomMessage(%0,%1,%2)     SendClientMessageEx(%0, COLOR_ARWIN, %1": "WHITE_E""%2)
#define SCM SendClientMessage
#define SM(%0,%1) \
    SendClientMessageEx(%0, COLOR_YELLOW, "»"WHITE_E" "%1)

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//Converter
#define minplus(%1) \
        (((%1) < 0) ? (-(%1)) : ((%1)))

// AntiCaps
#define UpperToLower(%1) for( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Banneds
const BAN_MASK = (-1 << (32 - (/*this is the CIDR ip detection range [def: 26]*/26)));

//---------[ Define Faction ]-----
#define SAPD	1		//locker 1573.26, -1652.93, -40.59
#define	SAGS	2		// 1464.10, -1790.31, 2349.68
#define SAMD	3		// -1100.25, 1980.02, -58.91
#define SANEW	4		// 256.14, 1776.99, 701.08
//---------[ JOB ]---------//
#define BOX_INDEX            9 // Index Box Barang

#define MAX_AUCTIONS    10
#define KEY_2 2 // Anda bisa menggunakan nilai lain sesuai kebutuhan Anda

//= DYNAMIC BARRICADE
#define MAX_BARRICADES 20
#define MODEL_SELECTION_Barricade     0

//= RACE SYSTEM
#define MAX_ROUTE 9 + 1 //Yang ke 10 finish
#define NO_SOUND_ID 0

//= GYM FITNESS
#define ONE_DAY_IN_SECONDS 86400 // 1 hari dalam detik (24 jam * 60 menit * 60 detik)
#define TWO_DAYS_IN_SECONDS (2 * ONE_DAY_IN_SECONDS) // 2 hari dalam detik
#define BONE_STRENGTH_INTERVAL 10 // waktu dalam detik untuk penambahan kekuatan
#define BONE_STRENGTH_INCREASE 0.1 // jumlah peningkatan kekuatan setiap interval
#define MAX_BONE_STRENGTH 10.0 // maksimum nilai kekuatan tulang
