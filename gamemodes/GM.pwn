 
/*  
	   __      ________            ______  _____
	   \ \    / / ____|	           |  __ \|  __ \		
		\ \  / / |        _____    | |__) | |__) |
		 \ \/ /| |        _____    |  _  /|  _  /	
		  \  / | |_____            | | \ \| |	
		   \/  |______|            |_|  \_\_|

		   Gamemode Based :  LRP ( Thanks for Dendy, Parents, Adit04(Sugenggod) )
		   Remake Gamemode By : wahyuarilsaputra (arilflexose)
		   Copyright VC-RP 2024

		   Gamemode ini adalah based dari LRP (Lifestar Roleplay) dan sudah di remake oleh wahyuarilsaputra, Jika gamemode ini sudah di tangan orang lain tolong jangan hapus teks ini
		   gua mohon aja, dan Gamemode ini menggunakan UCP yang tersambung ke Discord Bot Javascript, Sebenernya ada project yang belum selsai karena gua mau buat AntiCheat based dari connecting AI
		   pakek bahasa Python, Mungkin kalian bisa selsaikan sendiri, Adios
 */
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS	100
#include <crashdetect>
#include <gvar>
#include <a_mysql>
#include <a_actor>
#include <a_zones>
#include <progress2>
#include <Pawn.CMD>
#include <selection>
//include <VehiclePartPosition>
#include <strlib>
#include <FiTimestamp>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg>
#include <streamer>
#include <EVF2>
#include <YSI\y_timers>
#include <YSI\y_ini>
#include <sscanf2>
#include <yom_buttons>
#include <geoiplite>
#include <garageblock>
#include <tp>
#include <compat>
#include <pause>
#include <easyDialog> 
#include <YSF>
#define DCMD_PREFIX '!'
#include <discord-connector>
#include <discord-cmd>


//------[ANTICHEAT]------//

//-----[ Modular ]-----
#include "DEFINE.pwn"

//pocketloss
new PacketSent[MAX_PLAYERS];
new PacketReceived[MAX_PLAYERS];

//-----[ Twitter ]-----
new tweet[60];

//-----[ Rob ]-----
new RobMember = 0;

//disnaker
new Disnaker;

//green zone
new gzraps[5];

//disnaker
new tukangtebang,
	taxikontol,
	Trucker,
	minerkntol,
	product,
	farmeranjing,
	baggage;

//afk system
new p_tick[MAX_PLAYERS],
    p_afktime[MAX_PLAYERS];
#define CONVERT_TIME_TO_SECONDS 	1
#define CONVERT_TIME_TO_MINUTES 	2
#define CONVERT_TIME_TO_HOURS 		3
#define CONVERT_TIME_TO_DAYS 		4
#define CONVERT_TIME_TO_MONTHS 		5
#define CONVERT_TIME_TO_YEARS 		6

//-----[ Event ]-----
new EventCreated = 0, 
	EventStarted = 0, 
	EventPrize = 500;
new Float: RedX, 
	Float: RedY, 
	Float: RedZ, 
	EventInt, 
	EventWorld;
new Float: BlueX, 
	Float: BlueY, 
	Float: BlueZ;
new EventHP = 100,
	EventArmour = 0,
	EventLocked = 0;
new EventWeapon1, 
	EventWeapon2, 
	EventWeapon3, 
	EventWeapon4, 
	EventWeapon5;
new BlueTeam = 0, 
	RedTeam = 0;
new MaxRedTeam = 5, 
	MaxBlueTeam = 5;
new IsAtEvent[MAX_PLAYERS];

new AntiBHOP[MAX_PLAYERS];
//new cbugwarn[MAX_PLAYERS];

new stresstimer[MAX_PLAYERS];
new Healing;

//-----[ Discord Connector ]-----
new pemainic;
new upt = 0;

//-----[ Selfie System ]-----
new takingselfie[MAX_PLAYERS];
new Float:Degree[MAX_PLAYERS];
const Float: Radius = 1.4; //do not edit this
const Float: Speed  = 1.25; //do not edit this
const Float: Height = 1.0; // do not edit this
new Float:lX[MAX_PLAYERS];
new Float:lY[MAX_PLAYERS];
new Float:lZ[MAX_PLAYERS];

//anjay
new zahl[MAX_PLAYERS][10],
	azahl[MAX_PLAYERS][10],
	rrechnung[MAX_PLAYERS],
	ergeb[MAX_PLAYERS],
	rech[MAX_PLAYERS][5],
	rechi[MAX_PLAYERS][25];


enum
{
	DIALOG_HUDMODE,
	DIALOG_MAKE_CHAR,
	DIALOG_CHARLIST,
	DIALOG_VERIFYCODE,
	DIALOG_EMOTEPROPERTY,
	DIALOG_UNUSED,
	DIALOG_LISTVEHGO,
	DIALOG_CARGO,
	DIALOG_MOTORCYCLEGO,
	DEALER_EDITPROD,
	DEALER_PRICESET,
	DIALOG_BUYTRUCKVEHICLE,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_EMAIL,
	DIALOG_PASSWORD,
	DIALOG_STATS,
	DIALOG_SETTINGS,
	DIALOG_HBEMODE,
	DIALOG_CHANGEAGE,
	DIALOG_GOLDSHOP,
	DIALOG_GOLDNAME,
	CourierSidejob,
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_DISNAKER,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,
	DIALOG_SELL_HOUSES,
	DIALOG_SELL_HOUSE,
	DIALOG_MY_HOUSES,
	HOUSE_INFO,
	HOUSE_STORAGE,
	HOUSE_CLOTHES,
	HOUSE_CLOTHES1,
	HOUSE_CLOTHES2,
	HOUSE_CLOTHES3,
	HOUSE_WEAPONS,
	HOUSE_MONEY,
	HOUSE_REALMONEY,
	HOUSE_WITHDRAW_REALMONEY,
	HOUSE_DEPOSIT_REALMONEY,
	HOUSE_REDMONEY,
	HOUSE_WITHDRAW_REDMONEY,
	HOUSE_DEPOSIT_REDMONEY,
	HOUSE_FOODDRINK,
	HOUSE_FOOD,
	HOUSE_FOOD_DEPOSIT,
	HOUSE_FOOD_WITHDRAW,
	HOUSE_DRINK,
	HOUSE_DRINK_DEPOSIT,
	HOUSE_DRINK_WITHDRAW,
	HOUSE_DRUGS,
	HOUSE_MEDICINE,
	HOUSE_MEDICINE_DEPOSIT,
	HOUSE_MEDICINE_WITHDRAW,
	HOUSE_MEDKIT,
	HOUSE_MEDKIT_DEPOSIT,
	HOUSE_MEDKIT_WITHDRAW,
	HOUSE_BANDAGE,
	HOUSE_BANDAGE_DEPOSIT,
	HOUSE_BANDAGE_WITHDRAW,
	HOUSE_OTHER,
	HOUSE_SEED,
	HOUSE_SEED_DEPOSIT,
	HOUSE_SEED_WITHDRAW,
	HOUSE_MATERIAL,
	HOUSE_MATERIAL_DEPOSIT,
	HOUSE_MATERIAL_WITHDRAW,
	HOUSE_COMPONENT,
	HOUSE_COMPONENT_DEPOSIT,
	HOUSE_COMPONENT_WITHDRAW,
	HOUSE_MARIJUANA,
	HOUSE_MARIJUANA_DEPOSIT,
	HOUSE_MARIJUANA_WITHDRAW,
	DIALOG_FINDVEH,
	DIALOG_TRACKVEH,
	DIALOG_TRACKVEH2,
	DIALOG_TRACKPARKEDVEH,
	DIALOG_GOTOVEH,
	DIALOG_GETVEH,
	DIALOG_DELETEVEH,
	DIALOG_BUYPV,
	DIALOG_BUYVIPPV,
	DIALOG_BUYPLATE,
	DIALOG_BUYPVCP,
	DIALOG_BUYPVCP_BIKES,
	DIALOG_BUYPVCP_CARS,
	DIALOG_BUYPVCP_UCARS,
	DIALOG_BUYPVCP_JOBCARS,
	DIALOG_BUYPVCP_VIPCARS,
	DIALOG_BUYPVCP_CONFIRM,
	DIALOG_BUYPVCP_VIPCONFIRM,
	DIALOG_RENT_JOBCARS,
	DIALOG_RENT_JOBCARSCONFIRM,
	DIALOG_RENT_BOAT,
	DIALOG_RENT_BOATCONFIRM,
	DIALOG_RENT_BIKE,
	DIALOG_RENT_BIKECONFIRM,
	DIALOG_MY_VEHICLE,
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYEDIT_ANDROID,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
	DIALOG_TOYPOSSX,
	DIALOG_TOYPOSSY,
	DIALOG_TOYPOSSZ,
	DIALOG_HELP,
	DIALOG_GPS,
	DIALOG_JOB,
	DIALOG_GPS_JOB,
	DIALOG_GPS_PUBLIC,
	DIALOG_GPS_PROPERTIES,
	DIALOG_GPS_GENERAL,
	DIALOG_GPS_MISSION,
	DIALOG_TRACKBUSINESS,
	DIALOG_ELECTRONIC_TRACK,
	DIALOG_PAY,
	DIALOG_RENTBIKES,
	DIALOG_RENTBOAT,
	DIALOG_RENTAL_CONFIRM,
	DIALOG_EDITBONE,
	FAMILY_SAFE,
	FAMILY_STORAGE,
	FAMILY_WEAPONS,
	FAMILY_MARIJUANA,
	FAMILY_WITHDRAWMARIJUANA,
	FAMILY_DEPOSITMARIJUANA,
	FAMILY_COMPONENT,
	FAMILY_WITHDRAWCOMPONENT,
	FAMILY_DEPOSITCOMPONENT,
	FAMILY_MATERIAL,
	FAMILY_WITHDRAWMATERIAL,
	FAMILY_DEPOSITMATERIAL,
	FAMILY_MONEY,
	FAMILY_WITHDRAWMONEY,
	FAMILY_DEPOSITMONEY,
	FAMILY_INFO,
	DIALOG_SERVERMONEY,
	DIALOG_SERVERMONEY_STORAGE,
	DIALOG_SERVERMONEY_WITHDRAW,
	DIALOG_SERVERMONEY_DEPOSIT,
	DIALOG_SERVERMONEY_REASON,
	DIALOG_LOCKERSAPD,
	DIALOG_WEAPONSAPD,
	DIALOG_LOCKERSAGS,
	DIALOG_WEAPONSAGS,
	DIALOG_LOCKERSAMD,
	DIALOG_WEAPONSAMD,
	DIALOG_INPUTOBATSAMD,
	DIALOG_DRUGSSAMD,
	DIALOG_LOCKERSANEW,
	DIALOG_WEAPONSANEW,
	DIALOG_LOCKERVIP,
	DIALOG_SERVICE,
	DIALOG_SERVICE_COLOR,
	DIALOG_SERVICE_COLOR2,
	DIALOG_SERVICE_PAINTJOB,
	DIALOG_SERVICE_WHEELS,
	DIALOG_SERVICE_SPOILER,
	DIALOG_SERVICE_HOODS,
	DIALOG_SERVICE_VENTS,
	DIALOG_SERVICE_LIGHTS,
	DIALOG_SERVICE_EXHAUSTS,
	DIALOG_SERVICE_FRONT_BUMPERS,
	DIALOG_SERVICE_REAR_BUMPERS,
	DIALOG_SERVICE_ROOFS,
	DIALOG_SERVICE_SIDE_SKIRTS,
	DIALOG_SERVICE_BULLBARS,
	DIALOG_SERVICE_NEON,
	DIALOG_MENU_TRUCKER,
	DIALOG_SHIPMENTS,
	DIALOG_SHIPMENTS_VENDING,
	DIALOG_HAULING,
	DIALOG_RESTOCK,
	DIALOG_RESTOCK_VENDING,
	DIALOG_ARMS_GUN,
	DIALOG_PLANT,
	DIALOG_EDIT_PRICE,
	DIALOG_EDIT_PRICE1,
	DIALOG_EDIT_PRICE2,
	DIALOG_EDIT_PRICE3,
	DIALOG_EDIT_PRICE4,
	DIALOG_OFFER,
	DIALOG_MATERIAL,
	DIALOG_COMPONENT,
	DIALOG_FOOD,
	DIALOG_FOOD_BUY,
	DIALOG_SEED_BUY,
	DIALOG_PRODUCT,
	DIALOG_GASOIL,
	DIALOG_APOTEK,
	DIALOG_ATM,
	DIALOG_TRACKATM,
	DIALOG_ATMWITHDRAW,
	DIALOG_BANK,
	DIALOG_BANKDEPOSIT,
	DIALOG_BANKWITHDRAW,
	DIALOG_BANKREKENING,
	DIALOG_BANKTRANSFER,
	DIALOG_BANKCONFIRM,
	DIALOG_BANKSUKSES,
	DIALOG_PHONE,
	DIALOG_TWITTER,
	DIALOG_TWITTERPOST,
	DIALOG_TWITTERNAME,
	//pedagang
	DIALOG_LOCKERPEDAGANG,
	DIALOG_GUDANGPEDAGANG,
	DIALOG_TAKEFOOD,
	DIALOG_MENU,
	DIALOG_PHONE_TEKS,
	DIALOG_PHONE_ADDCONTACT,
	DIALOG_PHONE_CONTACT,
	DIALOG_PHONE_NEWCONTACT,
	DIALOG_PHONE_INFOCONTACT,
	DIALOG_PHONE_SENDSMS,
	DIALOG_PHONE_TEXTSMS,
	DIALOG_PHONE_DIALUMBER,
	DIALOG_TOGGLEPHONE,
	DIALOG_IBANK,
	DIALOG_REPORTS,
	DIALOG_ANSWER_REPORTS,
	DIALOG_ASKS,
	DIALOG_SALARY,
	DIALOG_PAYCHECK,
	DIALOG_SWEEPER,
	DIALOG_BUS,
	DIALOG_FORKLIFT,
	DIALOG_MOWER,
	DIALOG_RUTE_SWEEPER,
	DIALOG_RUTE_BUS,
	DIALOG_BAGGAGE,
	DIALOG_HEALTH,
	DIALOG_OBAT,
	DIALOG_ISIKUOTA,
	DIALOG_DOWNLOAD,
	DIALOG_KUOTA,
	DIALOG_STUCK,
	DIALOG_TDM,
	DIALOG_PICKUPVEH,
	DIALOG_TRACKPARK,
	DIALOG_MY_WS,
	DIALOG_TRACKWS,
	WS_MENU,
	WS_SETNAME,
	WS_SETOWNER,
	WS_SETEMPLOYE,
	WS_SETEMPLOYEE,
	WS_SETOWNERCONFIRM,
	WS_SETMEMBER,
	WS_SETMEMBERE,
	WS_MONEY,
	WS_WITHDRAWMONEY,
	WS_DEPOSITMONEY,
	WS_COMPONENT,
	WS_COMPONENT2,
	WS_MATERIAL,
	WS_MATERIAL2,
	DIALOG_ACTORANIM,
	DIALOG_MY_VENDING,
	DIALOG_VENDING_INFO,
	DIALOG_VENDING_BUYPROD,
	DIALOG_VENDING_MANAGE,
	DIALOG_VENDING_NAME,
	DIALOG_VENDING_VAULT,
	DIALOG_VENDING_WITHDRAW,
	DIALOG_VENDING_DEPOSIT,
	DIALOG_VENDING_EDITPROD,
	DIALOG_VENDING_PRICESET,
	DIALOG_VENDING_RESTOCK,
	DIALOG_SPAWN_1,
	DIALOG_MYVEH,
	DIALOG_MYVEH_INFO,
	DIALOG_FAMILY_INTERIOR,
	DIALOG_SPAREPART,
	DIALOG_BUYPARTS,
	DIALOG_BUYPARTS_DONE,
	ST_WEAPON,
	VEHICLE_STORAGE,
	VEHICLE_WEAPON,
	VEHICLE_MONEY,
	VEHICLE_REALMONEY,
	VEHICLE_REALMONEY_WITHDRAW,
	VEHICLE_REALMONEY_DEPOSIT,
	VEHICLE_REDMONEY,
	VEHICLE_REDMONEY_WITHDRAW,
	VEHICLE_REDMONEY_DEPOSIT,
	VEHICLE_DRUGS,
	VEHICLE_MEDICINE,
	VEHICLE_MEDICINE_WITHDRAW,
	VEHICLE_MEDICINE_DEPOSIT,
	VEHICLE_MEDKIT,
	VEHICLE_MEDKIT_WITHDRAW,
	VEHICLE_MEDKIT_DEPOSIT,
	VEHICLE_BANDAGE,
	VEHICLE_BANDAGE_WITHDRAW,
	VEHICLE_BANDAGE_DEPOSIT,
	VEHICLE_OTHER,
	VEHICLE_SEED,
	VEHICLE_SEED_WITHDRAW,
	VEHICLE_SEED_DEPOSIT,
	VEHICLE_MATERIAL,
	VEHICLE_MATERIAL_WITHDRAW,
	VEHICLE_MATERIAL_DEPOSIT,
	VEHICLE_COMPONENT,
	VEHICLE_COMPONENT_WITHDRAW,
	VEHICLE_COMPONENT_DEPOSIT,
	VEHICLE_MARIJUANA,
	VEHICLE_MARIJUANA_WITHDRAW,
	VEHICLE_MARIJUANA_DEPOSIT,
	DIALOG_NONRPNAME,
	//PRIVATE STORAGE
	//Storage
	ST_MENU,
	ST_MONEY,
	ST_WITHDRAWMONEY,
	ST_DEPOSITMONEY,
	ST_COMPONENT,
	ST_COMPONENT2,
	ST_MATERIAL,
	ST_MATERIAL2,
	DIALOG_PVSAPD,
	DIALOG_PVSAMD,
	DIALOG_STREAMERSETTINGS,
	DIALOG_STREAMER_CONFIG,
	DEVICE_MOBILE,
	MAX_OWN_COMMERCIAL,
	DIALOG_TIMEANDDATE,
	DIALOG_SERVERNAME,
	DIALOG_TOGGLE,
	DIALOG_MONEYDOT,
	DIALOG_CHECKSTARTERPACK,
    //DEALER
	DIALOG_BUYJOBCARSVEHICLE,
	DIALOG_BUYDEALERCARS_CONFIRM,
	DIALOG_BUYBOAT,
	DIALOG_BUYMOTORCYCLEVEHICLE,
	DIALOG_BUYUCARSVEHICLE,
	DIALOG_BUYCARSVEHICLE,
	DIALOG_DEALER_MANAGE,
	DIALOG_DEALER_VAULT,
	DIALOG_DEALER_WITHDRAW,
	DIALOG_DEALER_DEPOSIT,
	DIALOG_DEALER_NAME,
	DIALOG_FIND_DEALER,
	DIALOG_DEALER_RESTOCK,
	DIALOG_MY_DEALERSHIP,
	DEALERSHIP_INFO,
	//MDC
	DIALOG_INFO_BIS,
	DIALOG_INFO_HOUSE,
	DIALOG_TRACK_PH,
	DIALOG_TRACK,
}

//=====[ Hauling ]--------
new bool:DialogHauling[10];
new bool:DialogSaya[MAX_PLAYERS][10];
new TrailerHauling[MAX_PLAYERS];

//-----[ Download System ]-----
new download[MAX_PLAYERS];

//-----[ Count System ]-----
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

//-----[ Rob System ]-----
new robmoney;

//-----[ Server Uptime ]-----
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

// EPROP
#define DIALOG_EMOTEPROPERTY 2221

//-----[ Faction Vehicle ]-----	
#define VEHICLE_RESPAWN 7200

new SAGSVehicles[30],
	SANAVehicles[30];

new DutyTimer;
new MalingKendaraan;

//-----[ Button ]-----	
new SAGSLobbyBtn[8],
	SAGSLobbyDoor[4],
	SAMCLobbyBtn[6],
	SAMCLobbyDoor[3];

//-----[ MySQL Connect ]-----	
new MySQL: g_SQL;

new TogOOC = 1;

//-----[ Player Data ]-----	
enum E_PLAYERS
{
	pAdminTime,
	pVerifyCode,
	pID,
	pUCP[22],
	pExtraChar,
	pChar,
	pDelayCourier,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pIP[16],
	pLastCar,
	pCode,
	pPassword[65],
	pSalt[17],
	pEmail[40],
	pAdmin,
	pHelper,
	pLevel,
	pLevelUp,
	pVip,
	pVipTime,
	pSpawnPD,
	pSpawnMD,
	pGold,
	pNasgor,
	pSusuGO,
	pBladder,
	pSkate,
	pModeSkate,
	pRegDate[50],
	pLastLogin[50],
	pMoney,
	pRedMoney,
	pSpawnGo,
	pBankMoney,
	pBankRek,
	pPhone,
	pPhoneCredit,
	pContact,
	pPhoneBook,
	pSMS,
	pCall,
	pCallTime,
	pWT,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	pSkin,
	pFacSkin,
	pGender,
	pAge[50],
	pInDoor,
	pInHouse,
	pInBiz,
	pInVending,
	pInFamily,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	pInt,
	pCourierCP,
	pWorld,
	pGetRENID,
	pSudahrent,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pEnergy,
	pHungerTime,
	pEnergyTime,
	pSick,
	pSickTime,
	pHospital,
	pHospitalTime,
	pInjured,
	Text3D: pInjuredLabel,
	bool:TempatHealing,
	pOnDuty,
	pOnDutyTime,
	pFaction,
	pFactionRank,
	pFactionLead,
	pTazer,
	pBroadcast,
	pNewsGuest,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pArrest,
	pArrestTime,
	pWarn,
	pJob,
	pJob2,
	pCreateSell,
	pJobTime,
	pExitJob,
	pMedicine,
	pMedkit,
	pMask,
	pHelmet,
	pSnack,
	pSprunk,
	pGas,
	pBandage,
	pGPS,
	pGpsActive,
	pMaterial,
	pComponent,
	pFood,
	pSeed,
	pPotato,
	pWheat,
	pOrange,
	pPrice1,
	pPrice2,
	pPrice3,
	pPrice4,
	pMarijuana,
	pPlant,
	pPlantTime,
	pFishTool,
	pWorm,
	pFish,
	pInFish,
	pIDCard,
	pIDCardTime,
	pDriveLic,
	pDriveLicTime,
	pDriveLicApp,
	pBoatLic,
	pBoatLicTime,
	pWeaponLic,
	pWeaponLicTime,
	pFlyLic,
	pFlyLicTime,
	pTruckerLic,
	pTruckerLicTime,
	pGuns[13],
    pAmmo[13],
	pWeapon,
	pProgress,
	pSusu,
	pSusuolah,
	pSapiTimer,
	//Not Save
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,
	pSpawned,
	pSpawnList,
	pAdminDuty,
	pFreezeTimer,
	pFreeze,
	pMaskID,
	pMaskOn,
	pSPY,
	pTogPM,
	pTogLog,
	pTogAds,
	pTogWT,
	Text3D:pAdoTag,
	Text3D:pBTag,
	bool:pBActive,
	bool:pAdoActive,
	pFlare,
	bool:pFlareActive,
	pTrackCar,
	pBuyPvModel,
	pTrackHouse,
	pTrackBisnis,
	pTrackVending,
	pFacInvite,
	pFacOffer,
	pFamInvite,
	pFamOffer,
	pFindEms,
	pCuffed,
	toySelected,
	bool:PurchasedToy,
	pEditingItem,
	pProductModify,
	pEditingVendingItem,
	pVendingProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	playerSpectated,
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHBEMode,
	pHelmetOn,
	pSeatBelt,
	pReportTime,
	pAskTime,
	//Activtybar
	PlayerBar:activitybar,
	//player proggres bar modern
	PlayerBar:fuelbar,
	PlayerBar:damagebar,
	PlayerBar:hungrybar,
	PlayerBar:energybar,
	//player progress bar hbe new
	PlayerBar:fuelnew,
	PlayerBar:damagenew,
	pProducting,
	pProductingStatus,
	pCooking,
	pCookingStatus,
	pArmsDealer,
	pArmsDealerStatus,
	pMechanic,
	pMechanicStatus,
	pActivity,
	pActivityStatus,
	pActivityTime,
	//Jobs
	pSideJob,
	pSideJobTime,
	pSweeperTime,
	pForklifterTime,
	pBusTime,
	pMowerTime,
	pGetJob,
	pGetJob2,
	pTaxiDuty,
	pTaxiTime,
	pFare,
	pFareTimer,
	pTotalFare,
	Float:pFareOldX,
	Float:pFareOldY,
	Float:pFareOldZ,
	Float:pFareNewX,
	Float:pFareNewY,
	Float:pFareNewZ,
	pMechDuty,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	//ATM
	EditingATMID,
	//lumber job
	EditingTreeID,
	CuttingTreeID,
	bool:CarryingLumber,
	//Miner job
	EditingOreID,
	MiningOreID,
	CarryingLog,
	LoadingPoint,
	//Vending
	EditingVending,
	//production
	CarryProduct,
	//trucker
	pMission,
	pHauling,
	pVendingRestock,
	bool: CarryingBox,
	//Farmer
	pHarvest,
	pHarvestID,
	pOffer,
	//Bank
	pTransfer,
	pTransferRek,
	pTransferName[128],
	//Gas Station
	pFill,
	pFillStatus,
	pFillTime,
	pFillPrice,
	//Gate
	gEditID,
	gEdit,
	// WBR
	pHead,
 	pPerut,
 	pLHand,
 	pRHand,
 	pLFoot,
 	pRFoot,
 	// Inspect Offer
 	pInsOffer,
 	// Obat System
 	pObat,
 	// Suspect
 	pSuspectTimer,
 	pSuspect,
 	// Phone On Off
 	pPhoneStatus,
 	// Kurir
 	pKurirEnd,
 	// Shareloc Offer
 	pLocOffer,
 	// Twitter
 	pTwitter,
	pTwitterStatus, 
	pTwittername[MAX_PLAYER_NAME],
	pTwitterPostCooldown,
	pTwitterNameCooldown,
 	pRegTwitter,
 	// Kuota
 	pKuota,
 	// DUTY SYSTEM
 	pDutyHour,
 	// CHECKPOINT
 	pCP,
 	// ROBBERY
 	pRobTime,
 	pRobOffer,
 	pRobLeader,
 	pRobMember,
 	pMemberRob,
	pTrailer,
	// Smuggler
	bool:pTakePacket,
	pTrackPacket,
	// Garkot
	pPark,
	pLoc,
	// WS
	pMenuType,
	pInWs,
	pTransferWS,
	//Baggage
	pBaggage,
	pDelayBaggage,
	pTrailerBaggage,
	//Anticheat
	pACWarns,
	pACTime,
	pJetpack,
	pArmorTime,
	pLastUpdate,
	//Checkpoint
	pCheckPoint,
	pBus,
	pSweeper,
	pMower,
	//SpeedCam
	pSpeedTime,
	//Forklifter New System
	pForklifter,
	pForklifterLoad,
	pForklifterLoadStatus,
	pForklifterUnLoad,
	pForklifterUnLoadStatus,
	//mask
	STREAMER_TAG_3D_TEXT_LABEL:pMaskLabel,
	//Starterpack
	pStarterpack,
	//Anim
	pLoopAnim,
	//Rob Car
	pLastChop,
	pLastChopTime,
	pIsStealing,
	//Sparepart
	pSparepart,
	//
	pUangKorup,
	//Senter
	pFlashlight,
	pUsedFlashlight,
	//Moderator
	pServerModerator,
	pEventModerator,
	pFactionModerator,
	pFamilyModerator,
	//
	pPaintball,
	pPaintball2,
	//Character Story
	pCS,
	// Roleplay Booster
 	pBooster,
 	pBoostTime,
	//
	pDelayIklan,
	//berry
	pBerry,
	//Berry Farmers
	EditingBerryID,
	HarvestBerryID,
	//PrivateStorage
	pInSt,
	//foghttyle
	pFightStyle,
	pStreamer,
	//roadblock
	pEditingmode,
	pEditRoadblock,
	pEditingMode,
	pDeviceType,
	pPemberitahuan,
	pAFK,
	pPaused,
	//married
	pMarried,
	pMarriedTo[128],
	pMarriedAccept,
	pMarriedCancel,
	pTimeAndDate,
	pServerName,
	pMoneyDot,
	//Dealersdhip
	pInDealer,
	pDealerMission,
	pTrackDealership,
	//GYM
	pGymVip,
	pGymTime,
	pFitnessTimer,
	pFitnessType,
	pIsFitnessActive,
	//Delaysw
	pTagsTime,
	//ads
	pAdvertise[200],
};


new pData[MAX_PLAYERS][E_PLAYERS];
new g_MysqlRaceCheck[MAX_PLAYERS];

//married
new WatchingTV[MAX_PLAYERS];
new Spectating[MAX_PLAYERS];
new gNews[MAX_PLAYERS];

//PRIVATEGARAGE
new PvGarageEdit[MAX_PLAYERS][3];

//race
new
	Float:RacePos[MAX_PLAYERS][MAX_ROUTE][3],//[3] ini array buat x, y, z.
	RaceIndex[MAX_PLAYERS],
	RaceWith[MAX_PLAYERS],
	bool:InRace[MAX_PLAYERS];

//ANTIAFK
new PlayerAFK[MAX_PLAYERS], PlayerPause[MAX_PLAYERS];

//-----[ Smuggler ]-----	

new Text3D:packetLabel,
	packetObj,
	Float:paX, 
	Float:paY, 
	Float:paZ;

//-----[ Forklifter Object ]-----	
new 
	VehicleObject[MAX_VEHICLES] = {-1, ...};

//-----[ Lumber Object Vehicle ]-----	
#define MAX_BOX 50
#define BOX_LIFETIME 100
#define BOX_LIMIT 5

enum    E_BOX
{
	boxDroppedBy[MAX_PLAYER_NAME],
	boxSeconds,
	boxObjID,
	boxTimer,
	boxType,
	Text3D: boxLabel
}
new BoxData[MAX_BOX][E_BOX],
	Iterator:Boxs<MAX_BOX>;

new
	BoxStorage[MAX_VEHICLES][BOX_LIMIT];

//-----[ Lumber Object Vehicle ]-----	
#define MAX_LUMBERS 50
#define LUMBER_LIFETIME 100
#define LUMBER_LIMIT 10

enum    E_LUMBER
{
	lumberDroppedBy[MAX_PLAYER_NAME],
	lumberSeconds,
	lumberObjID,
	lumberTimer,
	Text3D: lumberLabel
}
new LumberData[MAX_LUMBERS][E_LUMBER],
	Iterator:Lumbers<MAX_LUMBERS>;

new
	LumberObjects[MAX_VEHICLES][LUMBER_LIMIT];

	
new
	Float: LumberAttachOffsets[LUMBER_LIMIT][4] = {
	    {-0.223, -1.089, -0.230, -90.399},
		{-0.056, -1.091, -0.230, 90.399},
		{0.116, -1.092, -0.230, -90.399},
		{0.293, -1.088, -0.230, 90.399},
		{-0.123, -1.089, -0.099, -90.399},
		{0.043, -1.090, -0.099, 90.399},
		{0.216, -1.092, -0.099, -90.399},
		{-0.033, -1.090, 0.029, -90.399},
		{0.153, -1.089, 0.029, 90.399},
		{0.066, -1.091, 0.150, -90.399}
	};

//-----[ Ores Miner ]-----	
#define LOG_LIFETIME 100
#define LOG_LIMIT 10
#define MAX_LOG 100

enum    E_LOG
{
	bool:logExist,
	logType,
	logDroppedBy[MAX_PLAYER_NAME],
	logSeconds,
	logObjID,
	logTimer,
	Text3D:logLabel
}
new LogData[MAX_LOG][E_LOG];

new
	LogStorage[MAX_VEHICLES][2];

//-----[ Trucker ]-----	
new VehProduct[MAX_VEHICLES];
new VehGasOil[MAX_VEHICLES];

//-----[ Baggage ]-----	
new bool:DialogBaggage[10];
new bool:MyBaggage[MAX_PLAYERS][10];

//-----[ Type Checkpoint ]-----	
enum
{
	CHECKPOINT_NONE = 0,
	CHECKPOINT_FORKLIFTER,
	CHECKPOINT_DRIVELIC,
	CHECKPOINT_SWEEPER,
	CHECKPOINT_BAGGAGE,
	CHECKPOINT_MOWER,
	CHECKPOINT_MISC,
	CHECKPOINT_BUS
}

//-----[ Storage Limit ]-----	
enum
{
	LIMIT_SNACK,
	LIMIT_SPRUNK,
	LIMIT_MEDICINE,
	LIMIT_MEDKIT,
 	LIMIT_BANDAGE,
 	LIMIT_SEED,
	LIMIT_MATERIAL,
	LIMIT_COMPONENT,
	LIMIT_MARIJUANA
};

//-----[ eSelection Define ]-----	
#define 	SPAWN_SKIN_MALE 		1
#define 	SPAWN_SKIN_FEMALE 		2
#define 	SHOP_SKIN_MALE 			3
#define 	SHOP_SKIN_FEMALE 		4
#define 	VIP_SKIN_MALE 			5
#define 	VIP_SKIN_FEMALE 		6
#define 	SAPD_SKIN_MALE 			7
#define 	SAPD_SKIN_FEMALE 		8
#define 	SAPD_SKIN_WAR 			9
#define     SAPD_SKIN_03DL          10
#define 	SAGS_SKIN_MALE 			11
#define 	SAGS_SKIN_FEMALE 		12
#define 	SAMD_SKIN_MALE 			13
#define 	SAMD_SKIN_FEMALE 		14
#define 	SANA_SKIN_MALE 			15
#define 	SANA_SKIN_FEMALE 		16
#define 	TOYS_MODEL 				17
#define 	VIPTOYS_MODEL 			18
#define 	GOCAR_SKIN_MALE 		19
#define 	GOCAR_SKIN_FEMALE 		20

new SpawnSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 14, 100, 299
};

new SpawnSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41
};

new GOCARSkinMale[] =
{
	215, 155, 168
};

new GOCARSkinFemale[] =
{
	119, 11, 141, 205
};

new ShopSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new ShopSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new SAPDSkinWar[] =
{
	121, 285, 286, 287, 117, 118, 165, 166
};

new SAPDSkinMale[] =
{
	280, 281, 282, 283, 284, 288, 300, 301, 302, 303, 304, 305, 310, 311, 165, 166
};

new SAPDSkinFemale[] =
{
	306, 307, 309, 148, 150
};

new SAPDSkin03DL[] =
{
	20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010
};

new SAGSSkinMale[] =
{
	171, 17, 71, 147, 187, 165, 166, 163, 164, 255, 295, 294, 303, 304, 305, 189, 253
};

new SAGSSkinFemale[] =
{
	9, 11, 76, 141, 150, 219, 169, 172, 194, 263
};

new SAMDSkinMale[] =
{
	70, 187, 303, 304, 305, 274, 275, 276, 277, 278, 279, 165, 71, 177
};

new SAMDSkinFemale[] =
{
	308, 76, 141, 148, 150, 169, 172, 194, 219
};

new SANASkinMale[] =
{
	171, 187, 189, 240, 303, 304, 305, 20, 59
};

new SANASkinFemale[] =
{
	172, 194, 211, 216, 219, 233, 11, 9
};

new ToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942, 
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142
};

new VipToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942, 
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142
};

new VipSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new VipSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};



//-----[ Modular ]-----	
main() 
{
	SetTimer("onlineTimer", 1000, true);
	SetTimer("TDUpdates", 8000, true);
}

#include "DEFINE.pwn"
#include "NEW FEATURE\TRANSLATE.pwn"
#include "NEW FEATURE\dynamicarea.pwn"
#include "NEW FEATURE\DAMAGELOGS.pwn"
//#include "NEW FEATURE\BASKETBALL.pwn"
//#include "NEW FEATURE\BLACKJACK.pwn"
#include "BOOMBOX.pwn"
#include "COLOR.pwn"
#include "UCP.pwn"
#include "TEXTDRAW.pwn"
#include "AnimsVinzz.pwn"
#include "RENTAL.pwn"
#include "PRIVATE_VEHICLE.pwn"
#include "VSTORAGE.pwn"
#include "REPORT.pwn"
#include "ASK.pwn"
#include "WEAPON_ATTH.pwn"
#include "TOYS.pwn"
#include "HELMET.pwn"
#include "SERVER.pwn"
#include "DOOR.pwn"
#include "FEATURE\FAMILY.pwn"
//#include "PLAYERLABEL.pwn"
#include "HOUSE.pwn"
#include "BISNIS.pwn"
#include "GAS_STATION.pwn"
#include "DYNAMIC_LOCKER.pwn"
#include "NATIVE.pwn"
#include "VOUCHER.pwn"
#include "SALARY.pwn"
#include "ATM.pwn"
#include "ARMS_DEALER.pwn"
#include "GATE.pwn"
#include "ROBBERY.pwn"
#include "WORKSHOP.pwn"
#include "DMV.pwn"
#include "ANTICHEAT.pwn"
#include "SPEEDCAM.pwn"
#include "ACTOR.pwn"
#include "VENDING.pwn"
#include "CONTACT.pwn"
#include "TOLL.pwn"
#include "ANSWER.pwn"
#include "NEW FEATURE\AUCTION.pwn"
#include "NEW FEATURE\BERRY.pwn"
#include "VOTE.pwn"
#include "NEW FEATURE\STORAGE.pwn"
#include "NEW FEATURE\ROADBLOCK.pwn"
#include "PRIVATEGARAGE.pwn"
#include "JOB\JOB_PRODUCTION.pwn"
#include "JOB\JOB_KURIR.pwn"
#include "JOB\JOB_SAPI.pwn"
#include "JOB\JOB_FORKLIFT.pwn"
#include "JOB\JOB_GOCAR.pwn"
#include "JOB\JOB_SMUGGLER.pwn"
#include "JOB\JOB_SWEEPER.pwn"
#include "JOB\JOB_TRUCKER.pwn"
#include "JOB\JOB_BAGGAGE.pwn"
#include "JOB\JOB_LUMBER.pwn"
#include "JOB\JOB_FARMER.pwn"
#include "JOB\JOB_MINER.pwn"
#include "JOB\JOB_MOWER.pwn"
#include "JOB\JOB_TAXI.pwn"
#include "JOB\JOB_MECH.pwn"
#include "JOB\JOB_FISH.pwn"
#include "JOB\JOB_BUS.pwn"
#include "JOB\JOB_TRASHMASTER.pwn"
#include "CMD\FACTION.pwn"
#include "CMD\PLAYER.pwn"
#include "CMD\ADMIN.pwn"
#include "CMD\DISCORD.pwn"
#include "NEW FEATURE\LIGHT.pwn"
#include "SAPD_TASER.pwn"
#include "SAPD_SPIKE.pwn"
//#include "DEALERSHIP.pwn"
#include "DEALER.pwn"
#include "GARKOT.pwn"
#include "DIALOG.pwn"
#include "MAPPING\MAPPING.pwn"
#include "MAPPING\MAPPINGHOUSEPLAYER.pwn"
#include "MAPPING\MAPPINGWS.pwn"
#include "CMD\ALIAS\ALIAS_PRIVATE_VEHICLE.pwn"
#include "CMD\ALIAS\ALIAS_PLAYER.pwn"
#include "CMD\ALIAS\ALIAS_BISNIS.pwn"
#include "CMD\ALIAS\ALIAS_ADMIN.pwn"
#include "CMD\ALIAS\ALIAS_HOUSE.pwn"
#include "EVENT.pwn"
#include "FUNCTION.pwn"
#include "TASK.pwn"
#include "MAPPING\MODULAR.pwn"
#include "MAPPING\COBJECT.pwn"
#include "STREAMER\STREAMER.pwn"
//#include "MAPPING\MAPPINGENVL.pwn"
#include "CMD\PHONECMD.pwn"
#include "CONSOLE\RCON.pwn"
#include "CONSOLE\CMD_DEV.pwn"
#include "NEW FEATURE\CUSTOMSKIN.pwn"
#include "NEW FEATURE\FREECAM.pwn"
#include "NEW FEATURE\NotifCylinder.pwn"
#include "NEW FEATURE\BATUGUNTING.pwn"
#include "GYM.pwn"
#include "NEW FEATURE\MINIGAMES.pwn"
#include "MDC.pwn"
#include "BASEMENT.pwn"	
#include "TAGS.pwn"
#include "CAMERASPEC.pwn"
#include "ADS.pwn"
#include "ATMM.pwn"
#include "ARIL.pwn"
//#include "POKER.pwn"

forward BotStatus();
public BotStatus()
{
    new h = 0, m = 0, statuz[256];
	h = floatround(upt / 3600);
	m = floatround((upt / 60) - (h * 60));
	upt++;
	//format(statuz,sizeof(statuz),"!register [nama ucp]");
	format(statuz,sizeof(statuz),"%d Players | %dh %02dm Uptime", pemainic, h, m);
	DCC_SetBotActivity(statuz);
}

public OnGameModeInit()
{	
	SetTimer("RestartServer", 60000, false);
	SetTimer("BotStatus", 1000, true);
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}
	print("MySQL connection is successful.");

	mysql_tquery(g_SQL, "SELECT * FROM `server`", "LoadServer");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `vouchers`", "LoadVouchers");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	mysql_tquery(g_SQL, "SELECT * FROM `ores`", "LoadOres");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "LoadWorkshop");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `berry`", "LoadBerry");
	mysql_tquery(g_SQL, "SELECT * FROM `speedcameras`", "LoadSpeedCam");
	mysql_tquery(g_SQL, "SELECT * FROM `actor`", "LoadActor");
	mysql_tquery(g_SQL, "SELECT * FROM `vending`", "LoadVending");
	mysql_tquery(g_SQL, "SELECT * FROM `storage`", "LoadStorage");
	mysql_tquery(g_SQL, "SELECT * FROM `privategarage`", "PvGarageLoad");
	mysql_tquery(g_SQL, "SELECT * FROM `dealership`", "LoadDealership");
	mysql_tquery(g_SQL, "SELECT * FROM `basement`", "Basement_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `rental`", "LoadRental");
	mysql_tquery(g_SQL, "SELECT * FROM `tags` ORDER BY `tagId` ASC LIMIT "#MAX_DYNAMIC_TAGS";", "Tags_Load", "");
	
	ShowNameTags(true);
	CreateTextDraw();
	CreateServerPoint();
	CreateJoinLumberPoint();
	CreateJoinTaxiPoint();
	CreateJoinMechPoint();
	CreateJoinMinerPoint();
	CreateJoinProductionPoint();
	CreateJoinTruckPoint();
	CreateArmsPoint();
	CreateJoinFarmerPoint();
	LoadTazerSAPD();
	CreateJoinGocarPoint();
	CreateJoinSmugglerPoint();
	CreateJoinBaggagePoint();
	CreateCarStealingPoint();
	LoadMap();
	LoadGym();
	LoadGYMObject();
	CreateHousePlayer();
	//MappingEnvl();
	MappingWs();
	LoadObjects();
	LoadKadoPositionsFromFile();
	ResetCarStealing();

	//gzraps
   	gzraps[0] = CreateDynamicSphere(1537.9435,-1675.3668,13.5469, 80.0, 0, 0);
   	gzraps[1] = CreateDynamicSphere(1164.0677,-2036.7128,69.0078, 80.0, 0, 0); //balkot
   	gzraps[2] = CreateDynamicSphere(2039.9360,-1415.0548,17.1708, 80.0, 0, 0); //rs
   	gzraps[3] = CreateDynamicSphere(642.7583,-1357.4150,13.5847, 80.0, 0, 0);
   	gzraps[4] = CreateDynamicSphere(375.8298,-1812.6981,7.8319, 80.0, 0, 0);

	Healing = CreateDynamicSphere(386.7870,-2086.2473,7.8459, 50.0, 0, 0);

	new gm[32];
	format(gm, sizeof(gm), "%s", TEXT_GAMEMODE);
	SetGameModeText(gm);
	format(gm, sizeof(gm), "weburl %s", TEXT_WEBURL);
	SendRconCommand(gm);
	format(gm, sizeof(gm), "language %s", TEXT_LANGUAGE);
	SendRconCommand(gm);
	//SendRconCommand("hostname Xero Gaming Roleplay");
	SendRconCommand("mapname San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	DynamicSusuSapi();
	//SetNameTagDrawDistance(20.0);
	//DisableNameTagLOS();
	//ConnectNPC(NPC_NAME, TRAIN_RECORD);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	BlockGarages(.text="NO ENTER");
	//Audio_SetPack("default_pack");	
	
	new strings[150];

	//-----[ Toll System ]-----	
	for(new i;i < sizeof(BarrierInfo);i ++)
	{
		new
		Float:X = BarrierInfo[i][brPos_X],
		Float:Y = BarrierInfo[i][brPos_Y];

		ShiftCords(0, X, Y, BarrierInfo[i][brPos_A]+90.0, 3.5);
		CreateDynamicObject(966,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z],0.00000000,0.00000000,BarrierInfo[i][brPos_A]);
		if(!BarrierInfo[i][brOpen])
		{
			gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,90.00000000,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[i][brPos_A]+180);
		}
		else gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,20.00000000,BarrierInfo[i][brPos_A]+180);
	}

	//Auction
	AuctionText = CreateDynamicObject(18244, 189.572525, -80.501548, 1032.988037, 89.999946, -0.499999, 0.699999, -1, -1, -1, 250.00, 250.00);
	SetDynamicObjectMaterialText(AuctionText, 0, "{FFFF00}Welcome\nTo Los Santos\n{FFFF00}Auction Office", 90, "Ariel", 20, 1, 0x00000000, 0x00000001, 1);
	HighBidText = CreateDynamicObject(3077, 195.396118, -81.974838, 1030.729858, 0.000000, 0.000000, -36.599998, -1, -1, -1, 300.00, 300.00);

	CreateDynamicPickup(1239, 23, 358.3517,178.7152,1008.3828, -1, -1, -1, 50);
	Disnaker = CreateDynamicCP(358.3517,178.7152,1008.3828, 1.0, -1, -1, -1, 20.0);
	format(strings, sizeof(strings), "Tekan "LG_E"ALT {ffffff}Melihat Layanan Disnaker");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 358.3517,178.7152,1008.3828, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // LAYANAN PEMERINTAH

	CreateDynamicPickup(1239, 23, 1694.03, -2246.89, 13.54, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Rental]\n{BABABA}/rentbike {ffffff}untuk anda merental kendaraan\n{BABABA}/unrentveh {ffffff}untuk anda menggamblikan kendaraan");
	CreateDynamic3DTextLabel(strings, COLOR_WHITE, 1694.03, -2246.89, 13.54, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike

	CreateDynamicPickup(1239, 23, 1688.70, -2246.87, 13.53, -1, -1, -1, 100);
	format(strings, sizeof(strings), "Selamat datang jika menggalami masalah {FF0000}/reports {ffffff}dan {FF0000}/ask\n{FFFF00}/claimsp {ffffff}untuk menggambil hadiah");
	CreateDynamic3DTextLabel(strings, COLOR_WHITE, 1688.70, -2246.87, 13.53, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); 

	CreateDynamicPickup(1239, 23, 361.83, 173.637, 1008.68, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[City Hall]\n{FFFFFF}/newidcard - create new ID Card\n/newage - Change Birthday\n/sellhouse - sell your house\n/sellbusiness - sell your bisnis");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 361.83, 173.679, 1008.68, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card
	
	CreateDynamicPickup(1239, 23, 2792.800293, -1087.574097, 30.718750, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Veh Insurance]\n{FFFFFF}/buyinsu - buy insurance\n/claimpv - claim insurance\n/sellpv - sell vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2792.800293, -1087.574097, 30.718750, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance 1324.03, 740.21, 111.32

	//////
	CreateDynamicPickup(1239, 23, 2800.56, -1105.23, 30.71, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Sparepart Shop]\n{FFFFFF}/buysparepart\n");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2800.56, -1105.23, 30.71, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	CreateDynamicPickup(1239, 23, 1324.03, 740.21, 111.32, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Police Data Checking]\n{FFFFFF}/mdc - check police data");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1324.03, 740.21, 111.32, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	CreateDynamicPickup(1239, 23, 1490.28, 1305.95, 1093.6, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[License]\n{FFFFFF}/newdrivelic - create new license");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1490.28, 1305.95, 1093.6, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	
	CreateDynamicPickup(1239, 23, 101.9294, 1064.6431, -48.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 101.9294, 1064.6431, -48.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota LS
	
	CreateDynamicPickup(1239, 23, 250.05, 67.6138, 1003.94, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 250.05, 67.6138, 1003.94, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, 250.055, 69.2412, 1003.94, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE,  250.055, 69.2412, 1003.94, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota Dilimore
	
	CreateDynamicPickup(1239, 23, 1320.85, 739.36, 111.32, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Police Service]\n{FFFFFF}/payticket - to pay ticket\n/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1320.85, 739.36, 111.32, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Ls
	
	CreateDynamicPickup(1239, 23, 1546.63, 1350.38, 1510.91, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Arrest Point]\n{FFFFFF}/arrest - arrest wanted player");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1546.63, 1350.38, 1510.91, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // arrest
	
	CreateDynamicPickup(1239, 23, 2042.3931,-1416.2369,17.1641, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Hospital]\n{FFFFFF}/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_PINK, 2042.3931,-1416.2369,17.1641, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital
	
	CreateDynamicPickup(1239, 23, 2308.8, -13.2487, 27.0422, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/newrek - create new rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2308.8, -13.2487, 27.0422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, 2316.62, -7.25945, 27.0422, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/bank - access rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2316.62, -7.25945, 27.0422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, 2461.28, 2270.08, 91.9744, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[IKLAN]\n{FFFFFF}/ad - public ads");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, 2461.28, 2270.08, 91.9744, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	// CreateDynamicPickup(1241, 23,1832.69, -1075.17, 41.65, -1, -1, -1, 50);
	// format(strings, sizeof(strings), "[MYRICOUS PRODUCTION]\n{FFFFFF}/mix");
	// CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, 1832.69, -1075.17, 41.65, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // racik obat

	// CreateDynamicPickup(1241, 23, 1842.52, -1077.10, 41.65, -1, -1, -1, 50);
	// format(strings, sizeof(strings), "[SAMD SHOP]\n{FFFFFF}/buy");
	// CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, 1842.52, -1077.10, 41.65, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // racik obat

	CreateDynamicPickup(1239, 23, -427.3773, -392.3799, 16.5802, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Exchange Money]\n{FFFFFF}/washmoney");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -427.3773, -392.3799, 16.5802, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // pencucian uang haram

	CreateDynamicPickup(1239, 23, 2033.2816,-1428.9435,17.0132, -1);
	format(strings, sizeof(strings), "[SAMD VEHICLE]\n{FFFFFF}/samdvehicle\n Vehicle For SAMD");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2033.2816,-1428.9435,17.0132, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //samd vehicle

	CreateDynamicPickup(1239, 23, 2014.4462,-1412.3612,16.9922, -1);
	format(strings, sizeof(strings), "[SAMD PARKING]\n{FFFFFF}/samdparking\n Parking For SAPD");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE,  2014.4462,-1412.3612,16.9922, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //sapd parking

	CreateDynamicPickup(1239, 23, 1602.9182,-1644.2645,13.3311, -1);
	format(strings, sizeof(strings), "[SAPD VEHICLE]\n{FFFF00}/sapdvehicle {FFFFFF}-Untuk mengambil Kendaraan SAPD\n{FFFF00}/sapdparking {FFFFFF}-Untuk memarkirkan Kendaraan SAPD");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1602.9182,-1644.2645,13.3311, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //sapd vehicle

	
	//-----[ Dynamic Checkpoint ]-----	
	SAGSLobbyBtn[0] = CreateButton(-2688.83, 808.989, 1501.67, 180.0000);//bank
	SAGSLobbyBtn[1] = CreateButton(-2691.719238, 807.353333, 1501.422241, 0.000000); //bank
	SAGSLobbyBtn[2] = CreateButton(-2067.57, 2692.6, 1501.75, 90.0000);
	SAGSLobbyBtn[3] = CreateButton(-2067.81, 2692.64, 1501.64, -90.0000);
	SAGSLobbyBtn[4] = CreateButton(-2062.34, 2695.24, 1501.72, -90.0000);
	SAGSLobbyBtn[5] = CreateButton(-2062.09, 2695.21, 1501.7, 90.0000);
	SAGSLobbyBtn[6] = CreateButton(-2062.33, 2706.59, 1501.71, -90.0000);
	SAGSLobbyBtn[7] = CreateButton(-2062.08, 2706.69, 1501.73, 90.0000);
	SAGSLobbyDoor[0] = CreateDynamicObject(1569, -2689.33, 807.425, 1499.95, 0.000000, 0.000000, -179.877, -1, -1, -1, 300.00, 300.00);//Bank
	SAGSLobbyDoor[1] = CreateDynamicObject(1569, -2067.72, 2694.67, 1499.96, 0.000000, 0.000000, -89.6241, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[2] = CreateDynamicObject(1569, -2062.2, 2693.16, 1499.98, 0.000000, 0.000000, 89.9741, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[3] = CreateDynamicObject(1569, -2062.22, 2704.74, 1499.96, 0.000000, 0.000000, 90.2693, -1, -1, -1, 300.00, 300.00);

	SAMCLobbyBtn[0] = CreateButton(-1786.67, -1999.45, 1501.55, 90.0000);
	SAMCLobbyBtn[1] = CreateButton(-1786.89, -1999.48, 1501.56, -90.0000);
	SAMCLobbyBtn[2] = CreateButton(-1773.67, -1994.98, 1501.57, 180.0000);
	SAMCLobbyBtn[3] = CreateButton(-1773.71, -1995.25, 1501.56, 0.0000);
	SAMCLobbyBtn[4] = CreateButton(-1758.02, -1999.46, 1501.56, -90.0000);
	SAMCLobbyBtn[5] = CreateButton(-1757.81, -1999.46, 1501.57, 90.0000);
	SAMCLobbyDoor[0] = CreateDynamicObject(1569, -1786.8, -1997.48, 1499.77, 0.000000, 0.000000, -90.4041, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[1] = CreateDynamicObject(1569, -1771.77, -1995.14, 1499.77, 0.000000, 0.000000, -179.415, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[2] = CreateDynamicObject(1569, -1757.91, -1997.48, 1499.76, 0.000000, 0.000000, -91.6195, -1, -1, -1, 300.00, 300.00);
	
	//-----[ Sidejob Vehicle ]-----	
	AddSweeperVehicle();
	AddBusVehicle();
	AddForVehicle();
	AddMowerVehicle();

	//-----[ Job Vehicle ]-----	
	AddBaggageVehicle();

	//-----[ DMV ]-----	
	AddDmvVehicle();
	
	//-----[ SAPD Vehicle ]-----	
	/*SAPDVehicles[0] = AddStaticVehicleEx(596,1602.0660,-1683.9678,5.6124,90.3080,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[1] = AddStaticVehicleEx(596,1602.1194,-1687.9663,5.6107,90.5233,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[2] = AddStaticVehicleEx(596,1602.1680,-1692.0110,5.6113,89.5516,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[3] = AddStaticVehicleEx(596,1602.1666,-1696.1469,5.6123,90.4002,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[4] = AddStaticVehicleEx(596,1602.1936,-1700.1580,5.6113,89.7974,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[5] = AddStaticVehicleEx(596,1602.1382,-1704.3373,5.6118,88.9091,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[6] = AddStaticVehicleEx(407,1595.5073,-1710.6666,5.6109,0.1711,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[7] = AddStaticVehicleEx(544,1591.3687,-1710.6256,5.6119,358.8773,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[8] = AddStaticVehicleEx(596,1587.3217,-1710.6517,5.6118,0.3150,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[9] = AddStaticVehicleEx(596,1583.3668,-1710.7098,5.6118,0.0238,0,1, VEHICLE_RESPAWN, 1); // Cruiser
	SAPDVehicles[10] = AddStaticVehicleEx(599,1545.7213,-1655.0195,6.0814,90.4218,0,1, VEHICLE_RESPAWN, 1); // Rancher
	SAPDVehicles[11] = AddStaticVehicleEx(599,1545.8069,-1651.1516,6.0790,88.2897,0,1, VEHICLE_RESPAWN, 1); // Rancher
	SAPDVehicles[12] = AddStaticVehicleEx(601,1526.5850,-1644.1801,5.6494,180.3210,1,1, VEHICLE_RESPAWN, 1); // Splashy
	SAPDVehicles[13] = AddStaticVehicleEx(601,1530.7244,-1644.2538,5.6494,179.6148,1,1, VEHICLE_RESPAWN, 1); // Splashy
	//SAPDVehicles[14] = AddStaticVehicleEx(427,1534.8553,-1644.8682,6.0226,180.7921,0,0, VEHICLE_RESPAWN, 1); // Enforcer
	//SAPDVehicles[15] = 	AddStaticVehicleEx(427,1538.9325,-1644.9508,6.0226,179.5991,0,0, VEHICLE_RESPAWN, 1); // Enforcer
	SAPDVehicles[14] = AddStaticVehicleEx(528,1527.6542,-1655.9646,5.9339,270.1992,0,0, VEHICLE_RESPAWN, 1); // SWAT Van
	SAPDVehicles[15] = AddStaticVehicleEx(560,1584.7515,-1667.5281,5.5974,270.7136,0,0, VEHICLE_RESPAWN, 1); // Sultan
	SAPDVehicles[16] = AddStaticVehicleEx(560,1584.7291,-1671.6987,5.5982,268.7675,0,0, VEHICLE_RESPAWN, 1); // Sultan
	SAPDVehicles[17] = AddStaticVehicleEx(523,1584.7783,-1675.3850,5.4639,270.6620,0,0, VEHICLE_RESPAWN, 1); // Police Bike
	SAPDVehicles[18] = AddStaticVehicleEx(523,1585.0814,-1680.4186,5.4661,272.0062,0,0, VEHICLE_RESPAWN, 1); // Police Bike
	SAPDVehicles[19] = AddStaticVehicleEx(523,1587.2833,-1677.7260,5.4654,269.2448,0,0, VEHICLE_RESPAWN, 1); // Police Bike
	SAPDVehicles[20] = AddStaticVehicleEx(596,1535.9803,-1677.6580,13.1176,359.4672,0,1, VEHICLE_RESPAWN, 1); // Cruiser (Front)
	SAPDVehicles[21] = AddStaticVehicleEx(596,1535.9502,-1667.3008,13.1039,180.1666,0,1, VEHICLE_RESPAWN, 1); // Cruiser (Front)
	SAPDVehicles[22] = AddStaticVehicleEx(525,1556.5985,-1606.3214,13.2680,179.1279,17,20, VEHICLE_RESPAWN, 1); // Tow Truck
	SAPDVehicles[23] = AddStaticVehicleEx(525,1560.8201,-1606.3423,13.2557,178.6305,18,20, VEHICLE_RESPAWN, 1); // Tow Truck
	SAPDVehicles[24] = AddStaticVehicleEx(497,1569.1587,-1641.0361,28.5788,89.5537,0,1, VEHICLE_RESPAWN, 1); // Maverick
	SAPDVehicles[25] = AddStaticVehicleEx(497,1547.7992,-1643.6317,28.5923,91.2595,0,1, VEHICLE_RESPAWN, 1); // Maverick
 	SAPDVehicles[26] = AddStaticVehicleEx(411,1578.5643,-1710.6968,5.6112,0.0933,0,1, VEHICLE_RESPAWN, 1); // Infernus
	SAPDVehicles[27] = AddStaticVehicleEx(411,1574.3217,-1710.7924,5.6117,0.8341,0,1, VEHICLE_RESPAWN, 1); // Infernus*/
	//Anto
	/* SAPDVehicles[28] = AddStaticVehicleEx(596, 1602.5725, -1703.6426, 5.6302, 93.0517, 0, 1, VEHICLE_RESPAWN, 1); // (1-LINCOLN-1)
	SAPDVehicles[29] = AddStaticVehicleEx(596, 1602.6649, -1700.1345, 5.6098, 88.3226, 0, 1, VEHICLE_RESPAWN, 1); // (1-LINCOLN-2)
	SAPDVehicles[30] = AddStaticVehicleEx(596, 1602.5731, -1696.3154, 5.6185, 89.5375, 0, 1, VEHICLE_RESPAWN, 1); // (1-LINCOLN-3)
	SAPDVehicles[31] = AddStaticVehicleEx(596, 1602.4727, -1692.1736, 5.6305, 90.5782, 0, 1, VEHICLE_RESPAWN, 1); // (1-ADAM-1)
	SAPDVehicles[32] = AddStaticVehicleEx(596, 1602.6803, -1688.0616, 5.6028, 88.6160, 0, 1, VEHICLE_RESPAWN, 1); // (1-ADAM-2)
	SAPDVehicles[33] = AddStaticVehicleEx(596, 1602.3104, -1683.8103, 5.6366, 90.5165, 0, 1, VEHICLE_RESPAWN, 1); // (1-ADAM-3)
	SAPDVehicles[34] = AddStaticVehicleEx(598, 1595.3843, -1711.7159, 5.6531, 357.9430, 0, 1, VEHICLE_RESPAWN, 1); // (1-JOHN-1)
	SAPDVehicles[35] = AddStaticVehicleEx(598, 1591.6226, -1711.9098, 5.6791, 359.8374, 0, 1, VEHICLE_RESPAWN, 1); // (1-JOHN-2)
	SAPDVehicles[36] = AddStaticVehicleEx(598, 1587.3667, -1712.0635, 5.6635, 357.6382, 0, 1, VEHICLE_RESPAWN, 1); // (1-JOHN-3)
	SAPDVehicles[37] = AddStaticVehicleEx(598, 1583.3821, -1711.9270, 5.6450, 358.9687, 0, 1, VEHICLE_RESPAWN, 1); // (1-JOHN-4)
	SAPDVehicles[38] = AddStaticVehicleEx(597, 1578.5861, -1711.7607, 5.6610, 359.4702, 125, 1, VEHICLE_RESPAWN, 1); // (1-METRO-1)
	SAPDVehicles[39] = AddStaticVehicleEx(597, 1574.5916, -1711.4386, 5.6672, 0.9253, 125, 1, VEHICLE_RESPAWN, 1); // (1-METRO-2)
	SAPDVehicles[40] = AddStaticVehicleEx(597, 1570.4297, -1711.7886, 5.6851, 359.1385, 125, 1, VEHICLE_RESPAWN, 1); // (1-METRO-3)
	SAPDVehicles[41] = AddStaticVehicleEx(560, 1566.8059, -1711.5085, 5.5967, 0.3331, 0, 0, VEHICLE_RESPAWN, 1); // (1-STAFF-1)
	SAPDVehicles[42] = AddStaticVehicleEx(560, 1562.5171, -1711.5936, 5.5957, 0.7919, 0, 0, VEHICLE_RESPAWN, 1); // (1-STAFF-2)
	SAPDVehicles[43] = AddStaticVehicleEx(560, 1558.8313, -1711.4489, 5.5799, 359.7097, 0, 0, VEHICLE_RESPAWN, 1); // (1-STAFF-3)
	SAPDVehicles[44] = AddStaticVehicleEx(599, 1584.9136, -1667.7096, 6.1215, 269.2378, 0, 1, VEHICLE_RESPAWN, 1); // (1-ALPHA-1)
	SAPDVehicles[45] = AddStaticVehicleEx(599, 1584.7681, -1671.7507, 6.1155, 270.4269, 0, 1, VEHICLE_RESPAWN, 1); // (1-ALPHA-2)
	SAPDVehicles[46] = AddStaticVehicleEx(523, 1583.3853, -1674.4485, 5.4557, 271.5863, 0, 0, VEHICLE_RESPAWN, 1); // (1-MARRY-1)
	SAPDVehicles[47] = AddStaticVehicleEx(523, 1583.3677, -1675.9417, 5.4455, 266.5611, 0, 0, VEHICLE_RESPAWN, 1); // (1-MARRY-2)
	SAPDVehicles[48] = AddStaticVehicleEx(523, 1583.4041, -1676.8492, 5.4546, 262.9349, 0, 0, VEHICLE_RESPAWN, 1); // (1-MARRY-3)
	SAPDVehicles[49] = AddStaticVehicleEx(468, 1583.4658, -1678.7776, 5.5580, 275.8166, 0, 0, VEHICLE_RESPAWN, 1); // (1-UNION-1)
	SAPDVehicles[50] = AddStaticVehicleEx(468, 1583.3402, -1680.2417, 5.5736, 267.8846, 0, 0, VEHICLE_RESPAWN, 1); // (1-UNION-2)
	SAPDVehicles[51] = AddStaticVehicleEx(468, 1583.1974, -1681.5450, 5.5625, 270.1680, 0, 0, VEHICLE_RESPAWN, 1); // (1-UNION-3)
	SAPDVehicles[52] = AddStaticVehicleEx(426, 1528.7328, -1683.7745, 5.6337, 270.3810, 0, 0, VEHICLE_RESPAWN, 1); // (7-HENDRY-1)
	SAPDVehicles[53] = AddStaticVehicleEx(426, 1528.8241, -1687.8558, 5.6271, 269.6481, 0, 0, VEHICLE_RESPAWN, 1); // (7-HENDRY-2) 
	SAPDVehicles[54] = AddStaticVehicleEx(415, 1546.2323, -1684.3895, 5.6639, 89.7967, 0, 0, VEHICLE_RESPAWN, 1); // (6-HOTEL-1) 
	SAPDVehicles[55] = AddStaticVehicleEx(451, 1545.9630, -1680.3013, 5.5935, 89.8930, 0, 0, VEHICLE_RESPAWN, 1); // (6-HOTEL-2) 
	SAPDVehicles[56] = AddStaticVehicleEx(411, 1546.0787, -1676.0718, 5.6123, 89.5010, 0, 0, VEHICLE_RESPAWN, 1); // (6-HOTEL-3) 
	SAPDVehicles[57] = AddStaticVehicleEx(541, 1546.3257, -1672.0012, 5.5220, 87.7172, 0, 0, VEHICLE_RESPAWN, 1); // (6-HOTEL-4) 
	SAPDVehicles[58] = AddStaticVehicleEx(415, 1546.1973, -1667.8490, 5.6513, 89.1564, 0, 0, VEHICLE_RESPAWN, 1); // (6-HOTEL-5) 
	SAPDVehicles[59] = AddStaticVehicleEx(490, 1545.6974, -1663.2489, 5.9837, 89.4131, 0, 0, VEHICLE_RESPAWN, 1); // (6-DAVID-1) 
	SAPDVehicles[60] = AddStaticVehicleEx(490, 1545.6665, -1659.1666, 6.0187, 89.9371, 0, 0, VEHICLE_RESPAWN, 1); // (6-DAVID-2)
	SAPDVehicles[61] = AddStaticVehicleEx(427, 1545.1559, -1654.9792, 6.0160, 92.9525, 0, 0, VEHICLE_RESPAWN, 1); // (6-RESCUE-1)
	SAPDVehicles[62] = AddStaticVehicleEx(528, 1545.2665, -1651.0095, 5.9452, 89.8496, 0, 0, VEHICLE_RESPAWN, 1); // (6-RESCUE-2)
	SAPDVehicles[63] = AddStaticVehicleEx(528, 1538.9622, -1643.8527, 5.9334, 179.4513, 0, 0, VEHICLE_RESPAWN, 1); // (6-RESCUE-3)
	SAPDVehicles[64] = AddStaticVehicleEx(601, 1534.4694, -1644.1987, 5.6502, 181.0810, 0, 0, VEHICLE_RESPAWN, 1); // (6-RESISTOR-1)
	SAPDVehicles[65] = AddStaticVehicleEx(416, 1530.6296, -1644.6029, 6.0405, 179.5005, 1, 0, VEHICLE_RESPAWN, 1); // (6-RA-1)
	SAPDVehicles[66] = AddStaticVehicleEx(416, 1526.7708, -1644.4241, 6.0408, 180.6860, 1, 0, VEHICLE_RESPAWN, 1); // (6-RA-2)
	SAPDVehicles[67] = AddStaticVehicleEx(522, 1546.8297, -1645.6454, 5.4547, 136.2838, 0, 0, VEHICLE_RESPAWN, 1); // (6-RAPID-1)
	SAPDVehicles[68] = AddStaticVehicleEx(522, 1545.2856, -1644.6224, 5.4618, 135.7204, 0, 0, VEHICLE_RESPAWN, 1); // (6-RAPID-2)
	SAPDVehicles[69] = AddStaticVehicleEx(522, 1543.8486, -1642.8555, 5.4522, 130.9668, 0, 0, VEHICLE_RESPAWN, 1); // (6-RAPID-3)
	SAPDVehicles[70] = AddStaticVehicleEx(525, 1544.3879, -1608.7629, 13.2591, 271.1566, 1, 0, VEHICLE_RESPAWN, 1); // (1-TOM-1)
	SAPDVehicles[71] = AddStaticVehicleEx(525, 1544.3621, -1613.4329, 13.2622, 268.6892, 1, 0, VEHICLE_RESPAWN, 1); // (1-TOM-2)
	SAPDVehicles[72] = AddStaticVehicleEx(497, 1564.9788, -1656.4011, 28.5746, 86.3983, 0, 0, VEHICLE_RESPAWN, 1); // (6-AIR-1)
	SAPDVehicles[73] = AddStaticVehicleEx(497, 1564.4425, -1694.8608, 28.5880, 90.2365, 0, 0, VEHICLE_RESPAWN, 1); // (6-AIR-2)

	for(new x;x<sizeof(SAPDVehicles);x++)
	{
	    format(strings, sizeof(strings), "SAPD-%d", SAPDVehicles[x]);
	    SetVehicleNumberPlate(SAPDVehicles[x], strings);
	    SetVehicleToRespawn(SAPDVehicles[x]);
	} */
	
/* 	//-----[ SAGS Vehicle ]-----	
	SAGSVehicles[0] = AddStaticVehicleEx(405, 1507.6377, -1747.9199, 13.5757, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[1] = AddStaticVehicleEx(405, 1455.3049, -1748.5181, 13.3789, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[2] = AddStaticVehicleEx(409, 1498.6385, -1744.0792, 13.2442, 91.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[3] = AddStaticVehicleEx(409, 1463.2329, -1743.9989, 13.2442, -91.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[4] = AddStaticVehicleEx(411, 1524.1866, -1846.0491, 13.3714, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[5] = AddStaticVehicleEx(411, 1534.8187, -1845.9094, 13.3714, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[6] = AddStaticVehicleEx(411, 1529.4353, -1845.9347, 13.3714, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[7] = AddStaticVehicleEx(521, 1512.8479, -1846.1010, 13.0548, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[8] = AddStaticVehicleEx(521, 1519.4961, -1846.0326, 13.0548, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[9] = AddStaticVehicleEx(521, 1515.9736, -1845.9476, 13.0548, 0.0000, 0, 0, VEHICLE_RESPAWN);
	SAGSVehicles[10] = AddStaticVehicleEx(437, 1494.1495, -1845.1425, 13.5694, -91.0000, 0, 0, VEHICLE_RESPAWN); */

	
	for(new x;x<sizeof(SAGSVehicles);x++)
	{
	    format(strings, sizeof(strings), "SAGS-%d", SAGSVehicles[x]);
	    SetVehicleNumberPlate(SAGSVehicles[x], strings);
	    SetVehicleToRespawn(SAGSVehicles[x]);
	}
	
	/* //-----[ SAMD Vehicle ]-----	
	SAMDVehicles[0] = AddStaticVehicleEx(407, 1111.0358, -1328.3903, 13.6102, 0.0000, -1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[1] = AddStaticVehicleEx(407, 1098.1630, -1328.7020, 13.7072, 0.0000, -1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[2] = AddStaticVehicleEx(544, 1124.4944, -1327.0439, 13.9194, 0.0000, -1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[3] = AddStaticVehicleEx(416, 1116.0294, -1296.6489, 13.6160, 179.4438, 1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[4] = AddStaticVehicleEx(416, 1125.8785, -1296.2780, 13.6160, 179.4438, 1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[5] = AddStaticVehicleEx(416, 1121.1556, -1296.4138, 13.6160, 179.4438, 1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[6] = AddStaticVehicleEx(442, 1111.1719, -1296.7606, 13.4886, 185.0000, 0, 1, VEHICLE_RESPAWN, 1);
	SAMDVehicles[7] = AddStaticVehicleEx(426, 1136.0360, -1341.2158, 13.3050, 0.0000, 0, 1, VEHICLE_RESPAWN, 1);
	SAMDVehicles[8] = AddStaticVehicleEx(416, 1178.5963, -1338.9039, 14.1457, -91.0000, 1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[9] = AddStaticVehicleEx(586, 1130.7795, -1330.4045, 13.3639, 0.0000, 0, 1, VEHICLE_RESPAWN, 1);
	SAMDVehicles[10] = AddStaticVehicleEx(563, 1162.9077, -1313.8203, 32.1891, 270.6980, -1, 3, VEHICLE_RESPAWN, 1);
	SAMDVehicles[11] = AddStaticVehicleEx(487, 1163.0469, -1297.5098, 31.5550, 269.6279, -1, 3, VEHICLE_RESPAWN, 1);
	
	for(new x;x<sizeof(SAMDVehicles);x++)
	{
	    format(strings, sizeof(strings), "SAMD-%d", SAMDVehicles[x]);
	    SetVehicleNumberPlate(SAMDVehicles[x], strings);
	    SetVehicleToRespawn(SAMDVehicles[x]);
	} */
	
	//-----[ SANA Vehicle ]-----	
	SANAVehicles[0] = AddStaticVehicleEx(582, 781.4338, -1337.5022, 13.9482, 91.0000, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[1] = AddStaticVehicleEx(582, 758.7664, -1336.1642, 13.9482, 179.0212, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[2] = AddStaticVehicleEx(582, 764.4276, -1336.1959, 13.9482, 179.0212, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[3] = AddStaticVehicleEx(582, 770.3247, -1335.9663, 13.9482, 179.0212, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[4] = AddStaticVehicleEx(418, 737.3025, -1334.3344, 14.1711, 246.6513, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[5] = AddStaticVehicleEx(413, 736.4621, -1338.6304, 13.7490, -113.0000, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[6] = AddStaticVehicleEx(405, 737.4107, -1343.0820, 13.7357, -113.0000, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[7] = AddStaticVehicleEx(461, 749.7194, -1334.2122, 13.2465, 178.0000, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[8] = AddStaticVehicleEx(461, 753.8127, -1334.2727, 13.2465, 178.0000, -1, -1, VEHICLE_RESPAWN);
	SANAVehicles[9] = AddStaticVehicleEx(488, 741.9925, -1371.2443, 25.8111, 0.0000, -1, -1, VEHICLE_RESPAWN);
	
	for(new x;x<sizeof(SANAVehicles);x++)
	{
	    format(strings, sizeof(strings), "SANA-%d", SANAVehicles[x]);
	    SetVehicleNumberPlate(SANAVehicles[x], strings);
	    SetVehicleToRespawn(SANAVehicles[x]);
	}
	printf("[Objects]: %d Loaded.", CountDynamicObjects());
	return 1;
}

public OnGameModeExit()
{
	new count = 0, count1 = 0;
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station]: %d Saved.", count);
	
	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	printf("[Farmer Plants]: %d Saved.", count1);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	UnloadTazerSAPD();
	//Audio_DestroyTCPServer();
	mysql_close(g_SQL);
	return 1;
}

/*public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	new
	    File:file = fopen("mysql_error.txt", io_append);

	if(file)
	{
	    new
	        string[2048];

		format(string, sizeof(string), "[%s]\r\nError ID: %i\r\nCallback: %s\r\nQuery: %s\r\n[!] %s\r\n\r\n", GetDate(), errorid, callback, query, error);
		fwrite(file, string);
		fclose(file);
	}

	SendStaffMessage(COLOR_RED, "[ERROR MySQL]:{ffffff} MySQL terjadi kesalahan (error %i). Detail ditulis di mysql_error.txt.", errorid);
	return 1;
}*/

//-----[ Button System ]-----	
function SAGSLobbyDoorClose()
{
	MoveDynamicObject(SAGSLobbyDoor[0], -2689.33, 807.425, 1499.95, 3);
	MoveDynamicObject(SAGSLobbyDoor[1], -2067.72, 2694.67, 1499.96, 3);
	MoveDynamicObject(SAGSLobbyDoor[2], -2062.2, 2693.16, 1499.98, 3);
	MoveDynamicObject(SAGSLobbyDoor[3], -2062.22, 2704.74, 1499.96, 3);
	return 1;
}

function SAMCLobbyDoorClose()
{
	MoveDynamicObject(SAMCLobbyDoor[0], -1786.8, -1997.48, 1499.77, 3);
	MoveDynamicObject(SAMCLobbyDoor[1], -1771.77, -1995.14, 1499.77, 3);
	MoveDynamicObject(SAMCLobbyDoor[2], -1757.91, -1997.48, 1499.76, 3);
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
    if(newstate)
    {
        ToggleVehicleLights(vehicleid, 1);
		pvData[vehicleid][vEmergencyLights] = 0;

		pvData[vehicleid][vELM] = true;
        pvData[vehicleid][vEmergencyLights] = 0;
		ToggleVehicleLights(vehicleid, pvData[vehicleid][vLights]);

		new panels, doors, lights, tires;
		GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
		pvData[vehicleid][vELM] = false;
    }
    return 1;
}

public OnPlayerPressButton(playerid, buttonid)
{
	if(buttonid == SAGSLobbyBtn[0] || buttonid == SAGSLobbyBtn[1])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[0], -2687.77, 807.428, 1499.95, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[2] || buttonid == SAGSLobbyBtn[3])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[1], -2067.73, 2696.24, 1499.96, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[4] || buttonid == SAGSLobbyBtn[5])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[2], -2062.2, 2691.63, 1499.98, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[6] || buttonid == SAGSLobbyBtn[7])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[3], -2062.21, 2703.22, 1499.96, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[0] || buttonid == SAMCLobbyBtn[1])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[0], -1786.79, -1995.97, 1499.77, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[2] || buttonid == SAMCLobbyBtn[3])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[1], -1770.25, -1995.13, 1499.77, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[4] || buttonid == SAMCLobbyBtn[5])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[2], -1757.87, -1995.95, 1499.76, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//RemovePlayerAttachedObject(playerid, BOX_INDEX);
	//angkatBox[playerid] = false;
	new engine, lights, alarm, doors, bonnet, boot, objective;
	pData[playerid][pLastCar] = vehicleid;
	if(!ispassenger)
	{
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAPD!");
			}
		}
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAMD!");
			}
		} 
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SANEWS!");
			}
		}
		if(IsABaggageVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 10 && pData[playerid][pJob2] != 10)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                Error(playerid, "Kamu tidak bekerja sebagai Baggage Airport");
			}
		}
		if(IsADmvVeh(vehicleid))
        {
            if(!pData[playerid][pDriveLicApp])
            {
                RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                Error(playerid, "Kamu tidak sedang mengikuti Tes Mengemudi");
			}
			else 
			{
				Info(playerid, "Silahkan ikuti Checkpoint yang ada di GPS mobil ini.");
				SetPlayerRaceCheckpoint(playerid, 1, dmvpoint1, dmvpoint1, 5.0);
			}
		}
		if(IsACourierVeh(vehicleid) && CourierJob[playerid])
		{
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, 0); // ONLY the engine param was changed to VEHICLE_PARAMS_ON (1)
			for(new i = 0; i < 2; i++) 
			{
				TextDrawShowForPlayer(playerid, PlayerCrateTD);
				PlayerTextDrawShow(playerid, PlayerCrate[playerid][i]);
			}
			new String2[212];
			format(String2,sizeof(String2),"Deliveries~n~%d/10", CourierCount[playerid]);
			PlayerTextDrawSetString(playerid, PlayerCrate[playerid][1], String2);
			return 1;
		}
		if (GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID) {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(playerid, x, y, z+9.0);
            GameTextForPlayer(playerid, "~r~DON`T CAR JACKING!", 5000, 3);
			SetPVarInt(playerid, "OldVW", GetPlayerVirtualWorld(playerid));
			SetPlayerVirtualWorld(playerid, 1);
            SetTimerEx("CJacking", 5000, false, "d", playerid);
        }
		/*foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(IsABike(vehicleid) && pvData[pv][cLocked] == 1)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					Error(playerid, "This bike is locked by owner.");
				}
			}
		}*/
	}
	return 1;
}

function CJacking(playerid)
{
	new oldvw = GetPVarInt(playerid, "OldVW");
	SetPlayerVirtualWorld(playerid, oldvw);
	return 1;
}


stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
    static
        Float:fX,
        Float:fY,
        Float:fZ;

    GetPlayerPos(targetid, fX, fY, fZ);

    return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

function StressBerkurang(playerid)
{
	new rand = RandomEx(1, 2);
	pData[playerid][pBladder] -= rand;
}


stock GetWeekDay(day=0, month=0, year=0)
{
	if(!day)
			getdate(year, month, day);
	new
		szWeekDay[17],
		j,
		e;

	if(month <= 2)
	{
		month += 12;
		--year;
	}

	j = year % 100;
	e = year / 100;

	switch((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
	{
		case 0: szWeekDay = "Sat";
		case 1: szWeekDay = "Sund";
		case 2: szWeekDay = "Mon";
		case 3: szWeekDay = "Tue";
		case 4: szWeekDay = "Wed";
		case 5: szWeekDay = "Thu";
		case 6: szWeekDay = "Fri";
	}
	return szWeekDay;
}


stock GetDay(Day)
{
	new str[12];
	switch(Day)
	{
		case 1: str = "01";
		case 2: str = "02";
		case 3: str = "03";
		case 4: str = "04";
		case 5: str = "05";
		case 6: str = "06";
		case 7: str = "07";
		case 8: str = "08";
		case 9: str = "09";
		case 10: str = "10";
		case 11: str = "11";
		case 12: str = "12";
		case 13: str = "13";
		case 14: str = "14";
		case 15: str = "15";
		case 16: str = "16";
		case 17: str = "17";
		case 18: str = "18";
		case 19: str = "19";
		case 20: str = "20";
		case 21: str = "21";
		case 22: str = "22";
		case 23: str = "23";
		case 24: str = "24";
		case 25: str = "25";
		case 26: str = "26";
		case 27: str = "27";
		case 28: str = "28";
		case 29: str = "29";
		case 30: str = "30";
		case 31: str = "31";
	}
	return str;
}

stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

stock SGetName(playerid)
{
    new name[ 64 ];
    GetPlayerName(playerid, name, sizeof( name ));
    return name;
}

public OnPlayerText(playerid, text[])
{
	if(isnull(text)) return 0;
	new str[150];
	format(str,sizeof(str),"[CHAT] %s: %s", GetRPName(playerid), text);
	LogServer("Chat", str);
	printf(str);
	
	if(pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	//-----[ Auto RP ]-----	
	if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s lepaskan senjatanya dari sabuk dan siap untuk menembak kapan saja.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kaget setelah kecelakaan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfish", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memancing dengan kedua tangannya.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfall", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s jatuh dan merasakan sakit.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpmad", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa kesal dan ingin mengeluarkan amarah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprob", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menggeledah sesuatu dan siap untuk merampok.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcj", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencuri kendaraan seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpwar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berperang dengan sesorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdie", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s pingsan dan tidak sadarkan diri.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfixmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memperbaiki mesin kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcheckmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memeriksa kondisi kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfight", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ribut dan memukul seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcry", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang bersedih dan menangis.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berlari dan kabur.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfear", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa ketakutan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdropgun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meletakkan senjata kebawah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rptakegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mengamnbil senjata.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpgivegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memberikan kendaraan kepada seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpshy", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa malu.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnusuk", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menusuk dan membunuh seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpharvest", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memanen tanaman.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockhouse", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci rumah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockcar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnodong", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memulai menodong seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpeat", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s makan makanan yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdrink", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meminum minuman yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(text[0] == '@')
	{
		if(pData[playerid][pSMS] != 0)
		{
			if(pData[playerid][pPhoneCredit] < 1)
			{
				Error(playerid, "Anda tidak memiliki Credit!");
				return 0;
			}
			if(pData[playerid][pInjured] != 0)
			{
				Error(playerid, "Tidak dapat melakukan saat ini.");
				return 0;
			}
			new tmp[512];
			foreach(new ii : Player)
			{
				if(text[1] == ' ')
				{
			 		format(tmp, sizeof(tmp), "%s", text[2]);
				}
				else
				{
				    format(tmp, sizeof(tmp), "%s", text[1]);
				}
				if(pData[ii][pPhone] == pData[playerid][pSMS])
				{
					if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
					{
						Error(playerid, "Nomor ini tidak aktif!");
						return 0;
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", pData[playerid][pSMS], tmp);
					SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], tmp);
					PlayerPlaySound(ii, 6003, 0,0,0);
					pData[ii][pSMS] = pData[playerid][pPhone];
					
					pData[playerid][pPhoneCredit] -= 1;
					return 0;
				}
			}
		}
	}
	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		format(lstr, sizeof(lstr), "[CellPhone] %s says: %s", ReturnName(playerid), text);
		ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "[CELLPHONE] "WHITE_E"%s.", text);
		return 0;
	}
	else
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		if(!IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(pData[playerid][pAdminDuty] == 1)
			{
				if(strlen(text) > 64)
				{
					SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), text);
					SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", text[64]);
					return 0;
				}
				else
				{
					SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), text);
					return 0;
				}
			}

			format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
			ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(pData[playerid][pAdmin] < 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: (( %s ))", ReturnName(playerid), text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else if(pData[playerid][pAdmin] > 1 || pData[playerid][pHelper] > 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: %s", pData[playerid][pAdminname], text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
		return 0;
	}
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        Error(playerid, "Unknown Command! Gunakan /help untuk info lanjut.");
        return 0;
    }
	new str[150];
	format(str,sizeof(str),"[CMD] %s: [%s] [%s]", GetRPName(playerid), cmd, params);
	LogServer("Command", str);
	printf(str);
    return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	return 1;
}

public OnPlayerConnect(playerid)
{	
	new PlayerIP[16], country[MAX_COUNTRY_LENGTH], city[MAX_CITY_LENGTH];
	g_MysqlRaceCheck[playerid]++;
	pemainic++;
	AntiBHOP[playerid] = 0;
	IsAtEvent[playerid] = 0;
	takingselfie[playerid] = 0;
	pData[playerid][pDriveLicApp] = 0;
	//ANTIAFK
	PlayerAFK[playerid] = -1;
    PlayerPause[playerid] = -1;
	//AntiCheat
	pData[playerid][pJetpack] = 0;
	pData[playerid][pLastUpdate] = 0;
	pData[playerid][pArmorTime] = 0;
	pData[playerid][pACTime] = 0;
	//Anim
	pData[playerid][pLoopAnim] = 0;
	//Rob
	pData[playerid][pLastChop] = 0;
	//Pengganti IsValidTimer
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pIsFitnessActive] = false;
    IsInCameraMode[playerid] = 0;
    KeyState[playerid] = 0;
    CameraLocked[playerid] = 0;
    FollowOn[playerid] = 0;
	PacketSent[playerid] = 0;
    PacketReceived[playerid] = 0;

	ResetVariables(playerid);
	RemoveMappingLevana(playerid);
	//RemoveMappingEnvl(playerid);
	RemoveHSPlayer(playerid);
	RemoveMappingWs(playerid);
	CreatePlayerTextDraws(playerid);

	/*LagiKerja[playerid] = false;
	Kurir[playerid] = false;
	angkatBox[playerid] = false;*/

	SetPlayerMapIcon(playerid, 12, 1001.29,-1356.507,12.992, 51 , 0, MAPICON_LOCAL); // ICON TRUCKER
	CancelSelectTextDraw(playerid);
	GetPlayerName(playerid, pData[playerid][pUCP], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	pData[playerid][pIP] = PlayerIP;
	pData[playerid][pID] = playerid;
	InterpolateCameraPos(playerid, -71.2403, 1198.73, 19.8937, -148.538, 1198.77, 23.8208, 50000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, -56.8921, 1198.46, 19.5885, -105.543, 1198.59, 19.8867, 50000, CAMERA_MOVE);
	/*foreach(new ii : Player)
	{
		if(pData[ii][pUCP] == pData[playerid][pUCP])
		{
			Info(playerid, "UCP mu terdeteksi sudah login!");
			KickEx(playerid);
		}
	}*/
	SetPlayerColor(playerid, COLOR_WHITE);
	
	GetPlayerCountry(playerid, country, MAX_COUNTRY_LENGTH);
	GetPlayerCity(playerid, city, MAX_CITY_LENGTH);
	
	SetTimerEx("SafeLogin", 1000, 0, "i", playerid);
	//Prose Load Data
	new query[103];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `playerucp` WHERE `ucp` = '%e' LIMIT 1", pData[playerid][pUCP]);
	mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	SetPlayerColor(playerid, COLOR_WHITE);
	/* Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 100, playerid);
	Streamer_SetRadiusMultiplier(STREAMER_TYPE_OBJECT, 0.1, playerid); */

	//activitybar
	pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 273.500000, 157.333541, 88.000000, 8.000000, 5930683, 100, 0);

    //modern
	//pData[playerid][hungrybar] = CreatePlayerProgressBar(playerid, 638.000000, 433.000000, 12.000000, 43.500000, 9109759, 100.0, 2);
    //pData[playerid][energybar] = CreatePlayerProgressBar(playerid, 619.000000, 433.000000, 12.000000, 43.500000, 9109759, 100.0, 2);
    pData[playerid][damagebar] = CreatePlayerProgressBar(playerid, 547.000000, 363.000000, 86.500000, 5.000000, 9109759, 1000.0, 0);
    pData[playerid][fuelbar] = CreatePlayerProgressBar(playerid, 549.000000, 418.000000, 51.500000, 8.000000, 9109759, 1000.0, 0);
	
	//newhbe
	pData[playerid][fuelnew] = CreatePlayerProgressBar(playerid, 585.000000, 386.000000,  33.000000, 6.000000, 16711935, 1000.0, 0);
	pData[playerid][damagenew] = CreatePlayerProgressBar(playerid, 585.000000, 400.000000,  33.000000, 6.000000, 16711935, 1000.0, 0);

	//injuredlabel
	pData[playerid][pInjuredLabel] = CreateDynamic3DTextLabel("", COLOR_ORANGE, 0.0, 0.0, -0.3, 10, .attachedplayer = playerid, .testlos = 1);

    if(pData[playerid][pHead] < 0) return pData[playerid][pHead] = 20;

    if(pData[playerid][pPerut] < 0) return pData[playerid][pPerut] = 20;

    if(pData[playerid][pRFoot] < 0) return pData[playerid][pRFoot] = 20;

    if(pData[playerid][pLFoot] < 0) return pData[playerid][pLFoot] = 20;

    if(pData[playerid][pLHand] < 0) return pData[playerid][pLHand] = 20;
   
    if(pData[playerid][pRHand] < 0) return pData[playerid][pRHand] = 20;
	PlayerPlaySound(playerid, 176, 0.0, 0.0, 0.0);

	//DevVinzz
	for(new i = 0; i < sizeof(TD_LOGINBYEXECUTIVE); i++)
    {
        TextDrawShowForPlayer(playerid, TD_LOGINBYEXECUTIVE[i]);
    }
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	//Pengganti IsValidTimer5555555555555

	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pMaskOn] = 0;
	pemainic--;

	DestroyDynamic3DTextLabel(pData[playerid][pInjuredLabel]);
	if(IsValidDynamic3DTextLabel(pData[playerid][pMaskLabel]))
       DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);
	pData[playerid][pDriveLicApp] = 0;
	pData[playerid][pSpawnList] = 0;
	takingselfie[playerid] = 0;
	
	if(IsPlayerInAnyVehicle(playerid))
	{
        RemovePlayerFromVehicle(playerid);
    }
	if(IsACourierVeh(GetPlayerVehicleID(playerid)) && CourierJob[playerid])
    {
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
    }

	for(new i; i <= 9; i++) // 9 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
		{
		    DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
		    DialogHauling[i] = false; // Jadi ga ada yang punya nih dialog
		    DestroyVehicle(TrailerHauling[playerid]);
		}
	}

	for(new i; i <= 9; i++)
	{
		if(MyBaggage[playerid][i] == true)
		{
		    MyBaggage[playerid][i] = false;
		    DialogBaggage[i] = false;
			if(IsValidVehicle(pData[playerid][pTrailerBaggage]))
		    	DestroyVehicle(pData[playerid][pTrailerBaggage]);  //jika player disconnect maka trailer akan kembali seperti awal
		}
    }
	//UpdateWeapons(playerid);
	g_MysqlRaceCheck[playerid]++;
	
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(IsAtEvent[playerid] == 0)
		{
			UpdatePlayerData(playerid);
		}
		RemovePlayerVehicle(playerid);
		Report_Clear(playerid);
		Ask_Clear(playerid);
		Player_ResetMining(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		Player_ResetDamageLog(playerid);
		KillTazerTimer(playerid);
		if(IsValidVehicle(pData[playerid][pTrailer]))
			DestroyVehicle(pData[playerid][pTrailer]);

		pData[playerid][pTrailer] = INVALID_VEHICLE_ID;
		if(IsAtEvent[playerid] == 1)
		{
			if(GetPlayerTeam(playerid) == 1)
			{
				if(EventStarted == 1)
				{
					RedTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 2)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 1)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							RedTeam = 0;
						}
					}
				}
			}
			if(GetPlayerTeam(playerid) == 2)
			{
				if(EventStarted == 1)
				{
					BlueTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 1)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 2)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
					}
				}
			}
			SetPlayerTeam(playerid, 0);
			IsAtEvent[playerid] = 0;
			pData[playerid][pInjured] = 0;
			pData[playerid][pSpawned] = 1;
			UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
		}
		if(pData[playerid][pRobLeader] == 1)
		{
			foreach(new ii : Player) 
			{
				if(pData[ii][pMemberRob] > 1)
				{
					Servers(ii, "* Pemimpin Perampokan anda telah keluar! [ MISI GAGAL ]");
					pData[ii][pMemberRob] = 0;
					RobMember = 0;
					pData[ii][pRobLeader] = 0;
					ServerMoney += robmoney;
				}
			}
		}
		if(pData[playerid][pMemberRob] == 1)
		{
			pData[playerid][pMemberRob] = 0;
			foreach(new ii : Player) 
			{
				if(pData[ii][pRobLeader] > 1)
				{
					Servers(ii, "* Member berkurang 1");
					pData[ii][pMemberRob] -= 1;
					RobMember -= 1;
				}
			}
		}
	}

	if(IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

    if(IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);
			
	if(IsValidDynamicObject(pData[playerid][pFlare]))
            DestroyDynamicObject(pData[playerid][pFlare]);
    
    if(pData[playerid][pMaskOn] == 1)
            DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);

    pData[playerid][pAdoActive] = false;

	if (pData[playerid][LoginTimer])
	{
		KillTimer(pData[playerid][LoginTimer]);
		pData[playerid][LoginTimer] = 0;
	}

	pData[playerid][IsLoggedIn] = false;
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessageEx(ii, COLOR_ARWIN, "SERVER: "YELLOW_E"%s "WHITE_E"disconnected from the server.{7fffd4}(FC/Crash/Timeout)", pData[playerid][pName]);
				}
				case 1:
				{
					SendClientMessageEx(ii, COLOR_ARWIN, "SERVER: "YELLOW_E"%s "WHITE_E"disconnected from the server.{7fffd4}(Disconnected)", pData[playerid][pName]);
				}
				case 2:
				{
					SendClientMessageEx(ii, COLOR_ARWIN, "SERVER: "YELLOW_E"%s "WHITE_E"disconnected from the server.{7fffd4}(Kick/Banned)", pData[playerid][pName]);
				}
			}
		}
	}
	new reasontext[526];
	switch(reason)
	{
	    case 0: reasontext = "Timeout/ Crash";
	    case 1: reasontext = "Quit";
	    case 2: reasontext = "Kicked/ Banned";
	}

	new dc[100];
	format(dc, sizeof(dc),  "```\n%s disconnected from the server(%s).```", pData[playerid][pName], reasontext);
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    if(pData[forplayerid][pMaskOn]) ShowPlayerNameTagForPlayer(playerid, forplayerid, 0);
    else ShowPlayerNameTagForPlayer(playerid, forplayerid, 1);
    return 1;
}

public OnPlayerSpawn(playerid)
{
	PlayerPlaySound(playerid, NO_SOUND_ID, 0.0, 0.0, 0.0);
	StopAudioStreamForPlayer(playerid);
	SetPlayerInterior(playerid, pData[playerid][pInt]);
	SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
	SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	SetPlayerFightingStyle(playerid, pData[playerid][pFightStyle]);
	SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 0);
	SetPlayerSpawn(playerid);
	//LoadAnims(playerid);
	
	SetPlayerSkillLevel(playerid, WEAPON_COLT45, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
	SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPON_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPON_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
	SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
	SetPlayerSkillLevel(playerid, WEAPON_RIFLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);

    for(new i = 0; i < sizeof(TD_LOGINBYEXECUTIVE); i++)
    {
        TextDrawHideForPlayer(playerid, TD_LOGINBYEXECUTIVE[i]);
    }

	return 1;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pGender] == 0)
		{
			TogglePlayerControllable(playerid,0);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPlayerVirtualWorld(playerid, 0);
			InterpolateCameraPos(playerid, -71.2403, 1198.73, 19.8937, -148.538, 1198.77, 23.8208, 25000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, -56.8921, 1198.46, 19.5885, -105.543, 1198.59, 19.8867, 25000, CAMERA_MOVE);
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir\n(Tgl/Bulan/Tahun)\nMisal : 15/04/1998", "Enter", "Batal");
		}
		else
		{
			SetPlayerColor(playerid, COLOR_WHITE);
			TextDrawShowForPlayer(playerid, NamaServerNew[0]);
			TextDrawShowForPlayer(playerid, NamaServerNew[1]);
			TextDrawShowForPlayer(playerid, NamaServerNew[2]);
			if(pData[playerid][pHBEMode] == 1) //HBE Modern
			{
				PlayerTextDrawShow(playerid, FOOD[playerid]);
				PlayerTextDrawShow(playerid, DRINK[playerid]);
				PlayerTextDrawShow(playerid, BLADDER[playerid]);
				PlayerTextDrawShow(playerid, hbeNew[playerid][0]);
				PlayerTextDrawShow(playerid, hbeNew[playerid][1]);
				PlayerTextDrawShow(playerid, hbeNew[playerid][2]);
				PlayerTextDrawShow(playerid, hbeNew[playerid][3]);
			}
			if(pData[playerid][pHBEMode] == 2) //HBE Simple
		    {
			    PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][0]);
                PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][2]);
                PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][3]);
                PlayerTextDrawShow(playerid, JGMHUNGER[playerid]);
                PlayerTextDrawShow(playerid, JGMTHIRST[playerid]);
			}
	
			for(new i = 0; i < 5; i++) 

			CheckPlayerSpawn3Titik(playerid);
			SetPlayerSkin(playerid, pData[playerid][pSkin]);
			if(pData[playerid][pOnDuty] >= 1)
			{
				SetPlayerSkin(playerid, pData[playerid][pFacSkin]);
				SetFactionColor(playerid);
			}
			if(pData[playerid][pAdminDuty] > 0)
			{
				SetPlayerColor(playerid, COLOR_RED);
			}
			SetTimerEx("SpawnTimer", 6000, false, "i", playerid);

			if(pData[playerid][pTimeAndDate] == 1)
			{
				TextDrawShowForPlayer(playerid, TextDate);
				TextDrawShowForPlayer(playerid, TextTime);
			}
			else
			{

			}

			if(pData[playerid][pMoneyDot] == 1)
			{
				TextDrawShowForPlayer(playerid, Cent[0]);
				TextDrawShowForPlayer(playerid, Cent[1]);
			}
			else
			{
			
			}
		}
	}
}

function SpawnTimer(playerid)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pData[playerid][pMoney]);
	SetPlayerScore(playerid, pData[playerid][pLevel]);
	SetPlayerHealth(playerid, pData[playerid][pHealth]);
	SetPlayerArmour(playerid, pData[playerid][pArmour]);
	pData[playerid][pSpawned] = 1;
	TogglePlayerControllable(playerid, 1);
	SetCameraBehindPlayer(playerid);
	AttachPlayerToys(playerid);
	SetWeapons(playerid);
	if(pData[playerid][pJail] > 0)
	{
		JailPlayer(playerid); 
	}
	if(pData[playerid][pArrestTime] > 0)
	{
		SetPlayerArrest(playerid, pData[playerid][pArrest]);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	InterpolateCameraPos(playerid, -71.2403, 1198.73, 19.8937, -148.538, 1198.77, 23.8208, 25000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, -56.8921, 1198.46, 19.5885, -105.543, 1198.59, 19.8867, 25000, CAMERA_MOVE);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	Info(playerid, "{ff0000}Jangan di pencet spawn bang!!!");
	KickEx(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	pData[playerid][pSpawned] = 0;
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	Player_ResetMining(playerid);
	Player_ResetHarvest(playerid);
	
	pData[playerid][CarryProduct] = 0;
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pDealerMission] = -1;
	
	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;
	
	pData[playerid][pMechDuty] = 0;
	pData[playerid][pTaxiDuty] = 0;
	pData[playerid][pMission] = -1;
	
	pData[playerid][pSideJob] = 0;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	foreach(new ii : Player)
    {
        if(pData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
			new dc[128];
			format(dc, sizeof(dc),  "%s :skull_crossbones: %s :gun: %s", GetRPName(playerid), GetRPName(killerid), ReturnWeaponName(reason));
			return 1;
        }
    }
    if(IsAtEvent[playerid] == 1)
    {
    	SetPlayerPos(playerid, 1474.65, -1736.36, 13.38);
    	SetPlayerVirtualWorld(playerid, 0);
    	SetPlayerInterior(playerid, 0);
    	ClearAnimations(playerid);
    	ResetPlayerWeaponsEx(playerid);
       	SetPlayerColor(playerid, COLOR_WHITE);
    	if(GetPlayerTeam(playerid) == 1)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		RedTeam -= 1;
    	}
    	else if(GetPlayerTeam(playerid) == 2)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		BlueTeam -= 1;
    	}
    	if(BlueTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 1)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 2)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    		}
    	}
    	if(RedTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 2)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 1)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				RedTeam = 0;
    			}
    		}
    	}
    	SetPlayerTeam(playerid, 0);
    	IsAtEvent[playerid] = 0;
    	pData[playerid][pInjured] = 0;
    	pData[playerid][pSpawned] = 1;
		UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
    }
    if(IsAtEvent[playerid] == 0)
    {
    	new asakit = RandomEx(0, 5);
    	new bsakit = RandomEx(0, 9);
    	new csakit = RandomEx(0, 7);
    	new dsakit = RandomEx(0, 6);
    	pData[playerid][pLFoot] -= dsakit;
    	pData[playerid][pLHand] -= bsakit;
    	pData[playerid][pRFoot] -= csakit;
    	pData[playerid][pRHand] -= dsakit;
    	pData[playerid][pHead] -= asakit;
    }
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 22, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            Servers(playerid, "You have successfully adjusted the position of your %s.", weaponname);
           
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", pData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	else
	{
		if(response == 1)
		{
			InfoTD_MSG(playerid, 4000, "~g~~h~Toy Position Updated~y~!");

			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;
			
			MySQL_SavePlayerToys(playerid);
		}
		else if(response == 0)
		{
			InfoTD_MSG(playerid, 4000, "~r~~h~Selection Cancelled~y~!");

			SetPlayerAttachedObject(playerid,
				index,
				modelid,
				boneid,
				pToys[playerid][index][toy_x],
				pToys[playerid][index][toy_y],
				pToys[playerid][index][toy_z],
				pToys[playerid][index][toy_rx],
				pToys[playerid][index][toy_ry],
				pToys[playerid][index][toy_rz],
				pToys[playerid][index][toy_sx],
				pToys[playerid][index][toy_sy],
				pToys[playerid][index][toy_sz]);
		}
		SetPVarInt(playerid, "UpdatedToy", 1);
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new String[10000];
    new idx = gymEditID[playerid];
	if(response == EDIT_RESPONSE_UPDATE)
	{
	    SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}
	else if(response == EDIT_RESPONSE_CANCEL)
	{
	    if(gymEditID[playerid] != 0)
	    {
		    SetDynamicObjectPos(objectid, gymObjectPos[playerid][0], gymObjectPos[playerid][1], gymObjectPos[playerid][2]);
			SetDynamicObjectRot(objectid, gymObjectRot[playerid][0], gymObjectRot[playerid][1], gymObjectRot[playerid][2]);
			gymObjectPos[playerid][0] = 0; gymObjectPos[playerid][1] = 0; gymObjectPos[playerid][2] = 0;
			gymObjectRot[playerid][0] = 0; gymObjectRot[playerid][1] = 0; gymObjectRot[playerid][2] = 0;
			gymEdit[playerid] = 0;
			gymEditID[playerid] = 0;
		}
	}
	else if(response == EDIT_RESPONSE_FINAL)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
		if(gymEdit[playerid] == 1)
		{
		    GYMInfo[idx][GYMOBJPos][0] = x;
	        GYMInfo[idx][GYMOBJPos][1] = y;
	        GYMInfo[idx][GYMOBJPos][2] = z;
	        GYMInfo[idx][GYMOBJPos][3] = rx;
	        GYMInfo[idx][GYMOBJPos][4] = ry;
	        GYMInfo[idx][GYMOBJPos][5] = rz;
	        GYMInfo[idx][GYMvw] = GetPlayerVirtualWorld(playerid);
        	GYMInfo[idx][GYMint] = GetPlayerInterior(playerid);
	        DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
   			format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
			GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
			SaveGYMObject();
		    gymEdit[playerid] = 0;
		    gymEditID[playerid] = 0;
		}
	}
	if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        TreeData[etid][treeX] = x;
	        TreeData[etid][treeY] = y;
	        TreeData[etid][treeZ] = z;
	        TreeData[etid][treeRX] = rx;
	        TreeData[etid][treeRY] = ry;
	        TreeData[etid][treeRZ] = rz;

	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_X, TreeData[etid][treeX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Y, TreeData[etid][treeY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Z, TreeData[etid][treeZ] + 1.5);

		    Tree_Save(etid);
	        pData[playerid][EditingTreeID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
	        pData[playerid][EditingTreeID] = -1;
	    }
	}
	if(pData[playerid][EditingBerryID] != -1 && Iter_Contains(Berrys, pData[playerid][EditingBerryID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingBerryID];
	        BerryData[etid][berryX] = x;
	        BerryData[etid][berryY] = y;
	        BerryData[etid][berryZ] = z;
	        BerryData[etid][berryRX] = rx;
	        BerryData[etid][berryRY] = ry;
	        BerryData[etid][berryRZ] = rz;

	        SetDynamicObjectPos(objectid, BerryData[etid][berryX], BerryData[etid][berryY], BerryData[etid][berryZ]);
	        SetDynamicObjectRot(objectid, BerryData[etid][berryRX], BerryData[etid][berryRY], BerryData[etid][berryRZ]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_X, BerryData[etid][berryX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_Y, BerryData[etid][berryY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_Z, BerryData[etid][berryZ] + 1.5);

		    Berry_Save(etid);
	        pData[playerid][EditingBerryID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingBerryID];
	        SetDynamicObjectPos(objectid, BerryData[etid][berryX], BerryData[etid][berryY], BerryData[etid][berryZ]);
	        SetDynamicObjectRot(objectid, BerryData[etid][berryRX], BerryData[etid][berryRY], BerryData[etid][berryRZ]);
	        pData[playerid][EditingBerryID] = -1;
	    }
	}
	if(pData[playerid][EditingOreID] != -1 && Iter_Contains(Ores, pData[playerid][EditingOreID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        OreData[etid][oreX] = x;
	        OreData[etid][oreY] = y;
	        OreData[etid][oreZ] = z;
	        OreData[etid][oreRX] = rx;
	        OreData[etid][oreRY] = ry;
	        OreData[etid][oreRZ] = rz;

	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_X, OreData[etid][oreX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Y, OreData[etid][oreY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Z, OreData[etid][oreZ] + 1.5);

		    Ore_Save(etid);
	        pData[playerid][EditingOreID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);
	        pData[playerid][EditingOreID] = -1;
	    }
	}
	if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ] + 0.3);

		    Atm_Save(etid);
	        pData[playerid][EditingATMID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        pData[playerid][EditingATMID] = -1;
	    }
	}
	if(pData[playerid][EditingVending] != -1 && Iter_Contains(Vendings, pData[playerid][EditingVending]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new venid = pData[playerid][EditingVending];
	        VendingData[venid][vendingX] = x;
	        VendingData[venid][vendingY] = y;
	        VendingData[venid][vendingZ] = z;
	        VendingData[venid][vendingRX] = rx;
	        VendingData[venid][vendingRY] = ry;
	        VendingData[venid][vendingRZ] = rz;

	        SetDynamicObjectPos(objectid, VendingData[venid][vendingX], VendingData[venid][vendingY], VendingData[venid][vendingZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][vendingRX], VendingData[venid][vendingRY], VendingData[venid][vendingRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_X, VendingData[venid][vendingX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_Y, VendingData[venid][vendingY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_Z, VendingData[venid][vendingZ] + 0.3);

		    Vending_Save(venid);
	        pData[playerid][EditingVending] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new venid = pData[playerid][EditingVending];
	        SetDynamicObjectPos(objectid, VendingData[venid][vendingX], VendingData[venid][vendingY], VendingData[venid][vendingZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][vendingRX], VendingData[venid][vendingRY], VendingData[venid][vendingRZ]);
	    	pData[playerid][EditingVending] = -1;
	    }
	}
	if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
	{
		new id = pData[playerid][gEditID];
		if(response == EDIT_RESPONSE_UPDATE)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
			SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
			gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
			gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
			Servers(playerid, " You have canceled editing gate ID %d.", id);
			Gate_Save(id);
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			if(pData[playerid][gEdit] == 1)
			{
				gData[id][gCX] = x;
				gData[id][gCY] = y;
				gData[id][gCZ] = z;
				gData[id][gCRX] = rx;
				gData[id][gCRY] = ry;
				gData[id][gCRZ] = rz;
				if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
				new str[64];
				format(str, sizeof(str), "Gate ID: %d", id);
				gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's closing position.", id);
				gData[id][gStatus] = 0;
				Gate_Save(id);
			}
			else if(pData[playerid][gEdit] == 2)
			{
				gData[id][gOX] = x;
				gData[id][gOY] = y;
				gData[id][gOZ] = z;
				gData[id][gORX] = rx;
				gData[id][gORY] = ry;
				gData[id][gORZ] = rz;
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's opening position.", id);

				gData[id][gStatus] = 1;
				Gate_Save(id);
			}
		}
	}
	localIdx = oEditID[playerid];
	if(response == EDIT_RESPONSE_UPDATE)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}
	else if(response == EDIT_RESPONSE_CANCEL)
	{
		if(oEditID[playerid] != 0)
		{
			SetDynamicObjectPos(objectid, oPos[playerid][0], oPos[playerid][1], oPos[playerid][2]);
			SetDynamicObjectRot(objectid, oRot[playerid][0], oRot[playerid][1], oRot[playerid][2]);
			oPos[playerid][0] = 0; oPos[playerid][1] = 0; oPos[playerid][2] = 0;
			oRot[playerid][0] = 0; oRot[playerid][1] = 0; oRot[playerid][2] = 0;
			format(String, sizeof(String), " Anda membatalkan Edit Object ID %d.", localIdx);
			SendClientMessage(playerid, COLOR_WHITE, String);
			oEdit[playerid] = 0;
			oEditID[playerid] = 0;
		}
	}
	else if(response == EDIT_RESPONSE_FINAL)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
		if(oEdit[playerid] == 1)
		{
			ObjectInfo[localIdx][oX] = x;
			ObjectInfo[localIdx][oY] = y;
			ObjectInfo[localIdx][oZ] = z;
			ObjectInfo[localIdx][oRX] = rx;
			ObjectInfo[localIdx][oRY] = ry;
			ObjectInfo[localIdx][oRZ] = rz;
			//ObjectInfo[localIdx][oText] = CreateDynamic3DTextLabel(String, COLOR_WHITE, ObjectInfo[localIdx][oX], ObjectInfo[localIdx][oY], ObjectInfo[localIdx][oZ], 10);
			oEdit[playerid] = 0;
			oEditID[playerid] = 0;
			format(String, sizeof(String), " Anda telah menyelesaikan Edit Posisi Object ID %d.", localIdx);
			SendClientMessage(playerid, COLOR_WHITE, String);
			SaveObj();
		}
	}
	if(pData[playerid][pEditingMode] == 2)
		{
			new index = pData[playerid][pEditRoadblock];
			BarricadeData[index][cadePos][0] = x;
			BarricadeData[index][cadePos][1] = y;
			BarricadeData[index][cadePos][2] = z;
			BarricadeData[index][cadePos][3] = rx;
			BarricadeData[index][cadePos][4] = ry;
			BarricadeData[index][cadePos][5] = rz;
			Barricade_Sync(index);
			pData[playerid][pEditRoadblock] = -1;
			pData[playerid][pEditingMode] = -1;
			return 1;
		}
	
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	foreach(new i : DoorBasement) if(checkpointid == Basement[i][dbCP][0] || checkpointid == Basement[i][dbCP][1]) GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR~n~~r~H~n~~w~TO ENTER/EXIT", 3000, 4);
	if(checkpointid == pData[playerid][LoadingPoint])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		return 1;
	}
	if(checkpointid == Disnaker)
	{
		//InfoMsg(playerid, "Otot ALT Untuk Ambil Job");
		ShowCylinderText(playerid, "Otot ALT Untuk Ambil Job");
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(CourierJob[playerid] && CourierCrate[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		DisablePlayerRaceCheckpoint(playerid);
		ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0 ,0,0,0,0,1);
		CourierCrate[playerid] = 2 ;
		SetPlayerAttachedObject(playerid, 9, 2912, 1,  0.223999, 0.209000, -0.023000,  -93.099914, 7.100001, 97.200004,  0.585000, 0.654999, 0.595000);
	 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	}
	if(CourierJob[playerid] && CourierCount[playerid] == 10 && IsACourierVeh(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
		for(new i = 0; i < 2; i++) 
		{
			TextDrawHideForPlayer(playerid, PlayerCrateTD);
			PlayerTextDrawHide(playerid, PlayerCrate[playerid][i]);
		}
		AddPlayerSalary(playerid, "San Andreas Express", 250);	
        SendClientMessageEx(playerid, COLOR_ARWIN, "COURIER: {ffffff}Courier sidejob completed, {3BBD44}$250 {ffffff}has been issued for your next paycheck");
        SendClientMessageEx(playerid, COLOR_ARWIN, "SALARY: {ffffff}Your salary statement has been updated, please check command {ffff00}'/mysalary'");
        TimerCourier[playerid] = 0;
        CourierJob[playerid] = false;
        CourierCount[playerid] = 0;
        RemovePlayerFromVehicle(playerid);
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		pData[playerid][pDelayCourier] = 2000;
		PlayerPlaySound(playerid, 183, 0.0, 0.0, 0.0);
    }
	//RACESTREET
	if(InRace[playerid] && RaceIndex[playerid] != -1) {
		RaceIndex[playerid]++;
		if(RaceIndex[playerid] < 9)SetPlayerRaceCheckpoint(playerid, 0, RacePos[RaceWith[playerid]][RaceIndex[playerid]][0], RacePos[RaceWith[playerid]][RaceIndex[playerid]][1], RacePos[RaceWith[playerid]][RaceIndex[playerid]][2], RacePos[RaceWith[playerid]][RaceIndex[playerid]+1][0], RacePos[RaceWith[playerid]][RaceIndex[playerid]+1][1], RacePos[RaceWith[playerid]][RaceIndex[playerid]+1][2], 5.0);
		else
		{
			for(new i = 0; i < MAX_ROUTE; i++) {
				RacePos[playerid][i][0] = 0;
				RacePos[playerid][i][1] = 0;
				RacePos[playerid][i][2] = 0;
			}
			InRace[playerid] = false;
			RaceIndex[playerid] = -1;
			RaceWith[playerid] = INVALID_PLAYER_ID;
			DisablePlayerRaceCheckpoint(playerid);	
			GameTextForPlayer(playerid, "Balapan Finish!", 3000, 5);	
		}
		return 1;
	}
	switch(pData[playerid][pCheckPoint])
	{
		case CHECKPOINT_BAGGAGE:
		{
			if(pData[playerid][pBaggage] > 0)
			{
				if(pData[playerid][pBaggage] == 1)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 2;
					SetPlayerRaceCheckpoint(playerid, 1, 1524.4792, -2435.2844, 13.2118, 1524.4792, -2435.2844, 13.2118, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 2)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 3;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2087.7998, -2392.8328, 13.2083, 2087.7998, -2392.8328, 13.2083, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2087.7998, -2392.8328, 13.2083, 179.9115, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 3)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 4;
					SetPlayerRaceCheckpoint(playerid, 1, 1605.2043, -2435.4360, 13.2153, 1605.2043, -2435.4360, 13.2153, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 4)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 5;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2006.6425, -2340.5103, 13.2045, 2006.6425, -2340.5103, 13.2045, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2006.6425, -2340.5103, 13.2045, 90.0068, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 5)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 6;
					SetPlayerRaceCheckpoint(playerid, 1, 1684.9463, -2435.2239, 13.2137, 1684.9463, -2435.2239, 13.2137, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 6)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 7;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2006.4136, -2273.7458, 13.2012, 2006.4136, -2273.7458, 13.2012, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2006.4136, -2273.7458, 13.2012, 92.4049, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 7)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 8;
					SetPlayerRaceCheckpoint(playerid, 1, 1765.8700, -2435.1189, 13.2090, 1765.8700, -2435.1189, 13.2090, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 8)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 9;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2056.9043, -2392.0959, 13.2038, 2056.9043, -2392.0959, 13.2038, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2056.9043, -2392.0959, 13.2038, 179.4666, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 9)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 10;
					SetPlayerRaceCheckpoint(playerid, 1, 1524.1018, -2435.0664, 13.2139, 1524.1018, -2435.0664, 13.2139, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 10)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 11;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint terakhir di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2099.8982, -2200.7234, 13.2042, 2099.8982, -2200.7234, 13.2042, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 11)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1000;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[0] = false;
					MyBaggage[playerid][0] = false;
					AddPlayerSalary(playerid, "Job(Baggage)", 200);
					Info(playerid, "Job(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				//RUTE BAGGGAGE 2
				else if(pData[playerid][pBaggage] == 12)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 13;
					SetPlayerRaceCheckpoint(playerid, 1, 1891.7626, -2638.8113, 13.2074, 1891.7626, -2638.8113, 13.2074, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 13)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 14;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2007.5886, -2406.7236, 13.2065, 2007.5886, -2406.7236, 13.2065, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2007.5886, -2406.7236, 13.2065, 85.9836, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 14)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 15;
					SetPlayerRaceCheckpoint(playerid, 1, 1822.6267, -2637.9224, 13.2049, 1822.6267, -2637.9224, 13.2049, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 15)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 16;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2007.2054, -2358.0920, 13.2030, 2007.2054, -2358.0920, 13.2030, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2007.2054, -2358.0920, 13.2030, 89.7154, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 16)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 17;
					SetPlayerRaceCheckpoint(playerid, 1, 1617.9980, -2638.5725, 13.2034, 1617.9980, -2638.5725, 13.2034, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 17)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 18;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1874.9221, -2348.8616, 13.2039, 1874.9221, -2348.8616, 13.2039, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1874.9221, -2348.8616, 13.2039, 274.8172, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 18)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 19;
					SetPlayerRaceCheckpoint(playerid, 1, 1681.0703, -2638.5410, 13.2045, 1681.0703, -2638.5410, 13.2045, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 19)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 20;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1424.8074, -2415.5378, 13.2094, 1424.8074, -2415.5378, 13.2094, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 1424.8074, -2415.5378, 13.2094, 268.7459, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 20)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 21;
					SetPlayerRaceCheckpoint(playerid, 1, 1755.4872, -2639.1306, 13.2014, 1755.4872, -2639.1306, 13.2014, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 21)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 22;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
							
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint terakhir di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2110.0212, -2211.1377, 13.2008, 2110.0212, -2211.1377, 13.2008, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 22)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1000;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[1] = false;
					MyBaggage[playerid][1] = false;
					AddPlayerSalary(playerid, "Job(Baggage)", 170);
					Info(playerid, "Job(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				//RUTE BAGGAGE 3
				else if(pData[playerid][pBaggage] == 23)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 24;
					SetPlayerRaceCheckpoint(playerid, 1, 1509.5022, -2431.4277, 13.2163, 1509.5022, -2431.4277, 13.2163, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 24)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 25;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
							
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1913.4680, -2678.1877, 13.2135, 1913.4680, -2678.1877, 13.2135, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 1913.4680, -2678.1877, 13.2135, 358.3546, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 25)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 26;
					SetPlayerRaceCheckpoint(playerid, 1, 1591.0934, -2432.3208, 13.2094, 1591.0934, -2432.3208, 13.2094, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 26)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 27;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
							
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1593.1262, -2685.6423, 13.2016, 1593.1262, -2685.6423, 13.2016, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1593.1262, -2685.6423, 13.2016, 359.1027, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 27)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 28;
					SetPlayerRaceCheckpoint(playerid, 1, 1751.1523, -2432.6274, 13.2132, 1751.1523, -2432.6274, 13.2132, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 28)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 29;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
							
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1706.6799, -2686.6472, 13.2031, 1706.6799, -2686.6472, 13.2031, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1706.6799, -2686.6472, 13.2031, 358.5210, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 29)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 30;
					SetPlayerRaceCheckpoint(playerid, 1, 1892.2029, -2344.9568, 13.2069, 1892.2029, -2344.9568, 13.2069, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 30)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 31;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
							
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2160.3184, -2390.0625, 13.2055, 2160.3184, -2390.0625, 13.2055, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2160.3184, -2390.0625, 13.2055, 157.5291, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 31)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 32;
					SetPlayerRaceCheckpoint(playerid, 1, 1891.8900, -2261.1121, 13.2071, 1891.8900, -2261.1121, 13.2071, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 32)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 33;
						if(IsValidVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
							DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));

						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2087.1458, -2192.2161, 13.2047, 2087.1458, -2192.2161, 13.2047, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 33)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1000;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[2] = false;
					MyBaggage[playerid][2] = false;
					AddPlayerSalary(playerid, "Job(Baggage)", 150);
					Info(playerid, "Job(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}	
			}
		}
		case CHECKPOINT_DRIVELIC:
		{
			if(pData[playerid][pDriveLicApp] > 0)
			{
				if(pData[playerid][pDriveLicApp] == 1)
				{
					pData[playerid][pDriveLicApp] = 2;
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint2, dmvpoint2, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 2)
				{
					pData[playerid][pDriveLicApp] = 3;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint3, dmvpoint3, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 3)
				{
					pData[playerid][pDriveLicApp] = 4;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint4, dmvpoint4, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 4)
				{
					pData[playerid][pDriveLicApp] = 5;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint5, dmvpoint5, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 5)
				{
					pData[playerid][pDriveLicApp] = 6;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint6, dmvpoint6, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 6)
				{
					pData[playerid][pDriveLicApp] = 7;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint7, dmvpoint7, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 7)
				{
					pData[playerid][pDriveLicApp] = 8;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint8, dmvpoint8, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 8)
				{
					pData[playerid][pDriveLicApp] = 9;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint9, dmvpoint9, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 9)
				{
					pData[playerid][pDriveLicApp] = 10;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint10, dmvpoint10, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 10)
				{
					pData[playerid][pDriveLicApp] = 11;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint11, dmvpoint11, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 11)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					pData[playerid][pDriveLicApp] = 0;
					pData[playerid][pDriveLic] = 1;
					pData[playerid][pDriveLicTime] = gettime() + (30 * 86400);
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DisablePlayerRaceCheckpoint(playerid);
					GivePlayerMoneyEx(playerid, -5000);
					Server_AddMoney(700);
					Info(playerid, "Selamat kamu telah berhasil membuat SIM");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				
			}
		}
		case CHECKPOINT_BUS:
		{
			if(pData[playerid][pSideJob] == 2)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 431)
				{
					if(pData[playerid][pBus] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint2, buspoint2, 5.0);
					}
					else if(pData[playerid][pBus] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint3, buspoint3, 5.0);
					}
					else if(pData[playerid][pBus] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint4, buspoint4, 5.0);
					}
					else if(pData[playerid][pBus] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint5, buspoint5, 5.0);
					}
					else if(pData[playerid][pBus] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint6, buspoint6, 5.0);
					}
					else if(pData[playerid][pBus] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint7, buspoint7, 5.0);
					}
					else if(pData[playerid][pBus] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint8, buspoint8, 5.0);
					}
					else if(pData[playerid][pBus] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint9, buspoint9, 5.0);
					}
					else if(pData[playerid][pBus] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint10, buspoint10, 5.0);
					}
					else if(pData[playerid][pBus] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint11, buspoint11, 5.0);
					}
					else if(pData[playerid][pBus] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 12;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint12, buspoint12, 5.0);
					}
					else if(pData[playerid][pBus] == 12)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 13;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint13, buspoint13, 5.0);
					}
					else if(pData[playerid][pBus] == 13)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 14;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint14, buspoint14, 5.0);
					}
					else if(pData[playerid][pBus] == 14)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 15;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint15, buspoint15, 5.0);
					}
					else if(pData[playerid][pBus] == 15)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 16;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint16, buspoint16, 5.0);
					}
					else if(pData[playerid][pBus] == 16)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 17;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint17, buspoint17, 5.0);
					}
					else if(pData[playerid][pBus] == 17)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 18;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint18, buspoint18, 5.0);
					}
					else if(pData[playerid][pBus] == 18)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 19;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint19, buspoint19, 5.0);
					}
					else if(pData[playerid][pBus] == 19)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 20;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint20, buspoint20, 5.0);
					}
					else if(pData[playerid][pBus] == 20)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 21;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint21, buspoint21, 5.0);
					}
					else if(pData[playerid][pBus] == 21)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 22;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint22, buspoint22, 5.0);
					}
					else if(pData[playerid][pBus] == 22)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 23;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint23, buspoint23, 5.0);
					}
					else if(pData[playerid][pBus] == 23)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 24;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint24, buspoint24, 5.0);
					}
					else if(pData[playerid][pBus] == 24)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 25;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint25, buspoint25, 5.0);
					}
					else if(pData[playerid][pBus] == 25)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 26;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint26, buspoint26, 5.0);
					}
					else if(pData[playerid][pBus] == 26)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 27;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint27, buspoint27, 5.0);
					}
					else if(pData[playerid][pBus] == 27)
					{
						pData[playerid][pBus] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pBusTime] = 1000;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Bus)", 650);
						Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
					else if(pData[playerid][pBus] == 28)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 29;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus3, cpbus3, 5.0);
					}
					else if(pData[playerid][pBus] == 29)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 30;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus4, cpbus4, 5.0);
					}
					else if(pData[playerid][pBus] == 30)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 31;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus5, cpbus5, 5.0);
					}
					else if(pData[playerid][pBus] == 31)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 32;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus6, cpbus6, 5.0);
					}
					else if(pData[playerid][pBus] == 32)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 33;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus7, cpbus7, 5.0);
					}
					else if(pData[playerid][pBus] == 33)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 34;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus8, cpbus8, 5.0);
					}
					else if(pData[playerid][pBus] == 34)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 35;
						SetPlayerRaceCheckpoint(playerid, 1, cpbus9, cpbus9, 5.0);
					}
					else if(pData[playerid][pBus] == 35)
					{
						pData[playerid][pBus] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pBusTime] = 600;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Bus)", 750);
						Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_SWEEPER:
		{
			if(pData[playerid][pSideJob] == 1)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 574)
				{
					if(pData[playerid][pSweeper] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint2, sweperpoint2, 5.0);
					}
					else if(pData[playerid][pSweeper] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint3, sweperpoint3, 5.0);
					}
					else if(pData[playerid][pSweeper] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint4, sweperpoint4, 5.0);
					}
					else if(pData[playerid][pSweeper] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint5, sweperpoint5, 5.0);
					}
					else if(pData[playerid][pSweeper] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint6, sweperpoint6, 5.0);
					}
					else if(pData[playerid][pSweeper] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint7, sweperpoint7, 5.0);
					}
					else if(pData[playerid][pSweeper] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint8, sweperpoint8, 5.0);
					}
					else if(pData[playerid][pSweeper] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint9, sweperpoint9, 5.0);
					}
					else if(pData[playerid][pSweeper] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint10, sweperpoint10, 5.0);
					}
					else if(pData[playerid][pSweeper] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint11, sweperpoint11, 5.0);
					}
					else if(pData[playerid][pSweeper] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 12;
						SetPlayerRaceCheckpoint(playerid, 1, sweperpoint12, sweperpoint12, 5.0);
					}
					else if(pData[playerid][pSweeper] == 12)
					{
						pData[playerid][pSweeper] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pSweeperTime] = 700 ;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Sweeper)", 300);
						Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
					else if(pData[playerid][pSweeper] == 13)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 14;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep3, cpswep3, 5.0);
					}
					else if(pData[playerid][pSweeper] == 14)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 15;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep4, cpswep4, 5.0);
					}
					else if(pData[playerid][pSweeper] == 15)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 16;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep5, cpswep5, 5.0);
					}
					else if(pData[playerid][pSweeper] == 16)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 17;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep6, cpswep6, 5.0);
					}
					else if(pData[playerid][pSweeper] == 17)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 18;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep7, cpswep7, 5.0);
					}
					else if(pData[playerid][pSweeper] == 18)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 19;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep8, cpswep8, 5.0);
					}
					else if(pData[playerid][pSweeper] == 19)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 20;
						SetPlayerRaceCheckpoint(playerid, 1, cpswep9, cpswep9, 5.0);
					}
					else if(pData[playerid][pSweeper] == 20)
					{
						pData[playerid][pSweeper] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pSweeperTime] = 600;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Sweeper)", 350);
						Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_FORKLIFTER:
		{
			if(pData[playerid][pSideJob] == 3)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 530)
				{
					if(pData[playerid][pForklifter] == 1)
					{
						pData[playerid][pForklifter] = 2;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 2)
					{
						pData[playerid][pForklifter] = 3;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 3)
					{
						pData[playerid][pForklifter] = 4;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 4)
					{
						pData[playerid][pForklifter] = 5;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 5)
					{
						pData[playerid][pForklifter] = 6;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 6)
					{
						pData[playerid][pForklifter] = 7;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 7)
					{
						pData[playerid][pForklifter] = 8;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 8)
					{
						pData[playerid][pForklifter] = 9;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 9)
					{
						pData[playerid][pForklifter] = 10;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pForklifter] = 11;
						DestroyDynamicObject(VehicleObject[vehicleid]);
						VehicleObject[vehicleid] = INVALID_OBJECT_ID;
						SetPlayerRaceCheckpoint(playerid, 1, forpoint3, forpoint3, 4.0);
					}
					else if(pData[playerid][pForklifter] == 11)
					{
						pData[playerid][pSideJob] = 0;
						pData[playerid][pForklifterTime] = 1000;
						DisablePlayerRaceCheckpoint(playerid);
						GivePlayerMoneyEx(playerid, 950);
						Info(playerid, "Sidejob(Forklift) telah memberikan anda Gaji sebesar $950!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
						return 1;
					}
				}
			}
		}
		case CHECKPOINT_MOWER:
		{
			if(pData[playerid][pSideJob] == 4)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 572)
				{
					if(pData[playerid][pMower] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint2, mowerpoint2, 5.0);
					}
					else if(pData[playerid][pMower] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint3, mowerpoint3, 5.0);
					}
					else if(pData[playerid][pMower] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint4, mowerpoint4, 5.0);
					}
					else if(pData[playerid][pMower] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint5, mowerpoint5, 5.0);
					}
					else if(pData[playerid][pMower] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint6, mowerpoint6, 5.0);
					}
					else if(pData[playerid][pMower] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint7, mowerpoint7, 5.0);
					}
					else if(pData[playerid][pMower] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint8, mowerpoint8, 5.0);
					}
					else if(pData[playerid][pMower] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint9, mowerpoint9, 5.0);
					}
					else if(pData[playerid][pMower] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint10, mowerpoint10, 5.0);
					}
					else if(pData[playerid][pMower] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint11, mowerpoint11, 5.0);
					}
					else if(pData[playerid][pMower] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 12;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint12, mowerpoint12, 5.0);
					}
					else if(pData[playerid][pMower] == 12)
					{
						pData[playerid][pSideJob] = 0;
						pData[playerid][pMower] = 0;
						pData[playerid][pMowerTime] += 700;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Mower)", 200);
						Info(playerid, "Sidejob(Mower) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_MISC:
		{
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			DisablePlayerRaceCheckpoint(playerid);
		}
	}
	if(pData[playerid][pGpsActive] == 1)
	{
		pData[playerid][pGpsActive] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackCar] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan kendaraan anda!");
		pData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackHouse] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan rumah anda!");
		pData[playerid][pTrackHouse] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackVending] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan mesin vending anda!");
		pData[playerid][pTrackVending] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackBisnis] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan bisnis!");
		pData[playerid][pTrackBisnis] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pMission] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "/buy , /gps(My Mission) , /storeproduct.");
	}
	if(pData[playerid][pHauling] > -1)
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "'/storegas' untuk menyetor GasOilnya!");
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 335.66, 861.02, 21.01))
			{
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 336.70, 895.54, 20.40, 5.5);
				Info(playerid, "Silahkan ambil trailer dan menuju ke checkpoint untuk membeli GasOil!");
			}
			else
			{
				Error(playerid, "Kamu tidak membawa Trailer Gasnya, Silahkan ambil kembali trailernnya!");
			}
		}
	}
	if(pData[playerid][pDealerMission] > -1)
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "/gps(My Mission) , /storeveh.!");
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 335.66, 861.02, 21.01))
			{
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 336.70, 895.54, 20.40, 5.5);
				Info(playerid, "Silahkan ambil trailer dan menuju ke checkpoint untuk membeli dealership!");
			}
			else
			{
				Error(playerid, "Kamu tidak membawa Trailer Gasnya, Silahkan ambil kembali trailernnya!");
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(pData[playerid][pHauling] > -1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.5, 336.70, 895.54, 20.40))
		{
			DisablePlayerCheckpoint(playerid);
			Info(playerid, "/buy, /gps(My Hauling), /storegas.");
		}
	}
	/*if(pData[playerid][pCP] == 1)
	{
		pData[playerid][pJobTime] = 120;
		DisablePlayerCheckpoint(playerid);
		AddPlayerSalary(playerid, "Job (Kurir)", 120);
        pData[playerid][pKurirEnd] = 0;
        pData[playerid][pCP] = 0;
		Info(playerid, "Job (Kurir) telah masuk ke pending salary anda!");
		RemovePlayerFromVehicle(playerid);
		SetTimerEx("RespawnPV", 3000, false, "d", GetPlayerVehicleID(playerid));
	}*/
	if(pData[playerid][CarryingLog] != -1)
	{
		if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	if(pData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		pData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
	if(pData[playerid][pSideJob] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 574)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint1))
			{
				SetPlayerCheckpoint(playerid, sweperpoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint2))
			{
				SetPlayerCheckpoint(playerid, sweperpoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint3))
			{
				SetPlayerCheckpoint(playerid, sweperpoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint4))
			{
				SetPlayerCheckpoint(playerid, sweperpoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint5))
			{
				SetPlayerCheckpoint(playerid, sweperpoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint6))
			{
				SetPlayerCheckpoint(playerid, sweperpoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint7))
			{
				SetPlayerCheckpoint(playerid, sweperpoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint8))
			{
				SetPlayerCheckpoint(playerid, sweperpoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint9))
			{
				SetPlayerCheckpoint(playerid, sweperpoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint10))
			{
				SetPlayerCheckpoint(playerid, sweperpoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint11))
			{
				SetPlayerCheckpoint(playerid, sweperpoint12, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint12))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pSweeperTime] = 600;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Sweeper)", 9000);
				Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint1))
			{
				SetPlayerCheckpoint(playerid, buspoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint2))
			{
				SetPlayerCheckpoint(playerid, buspoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint3))
			{
				SetPlayerCheckpoint(playerid, buspoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint4))
			{
				SetPlayerCheckpoint(playerid, buspoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint5))
			{
				SetPlayerCheckpoint(playerid, buspoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint6))
			{
				SetPlayerCheckpoint(playerid, buspoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint7))
			{
				SetPlayerCheckpoint(playerid, buspoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint8))
			{
				SetPlayerCheckpoint(playerid, buspoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint9))
			{
				SetPlayerCheckpoint(playerid, buspoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint10))
			{
				SetPlayerCheckpoint(playerid, buspoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint11))
			{
				SetPlayerCheckpoint(playerid, buspoint12, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint12))
			{
				SetPlayerCheckpoint(playerid, buspoint13, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint13))
			{
				SetPlayerCheckpoint(playerid, buspoint14, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint14))
			{
				SetPlayerCheckpoint(playerid, buspoint15, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint15))
			{
				SetPlayerCheckpoint(playerid, buspoint16, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint16))
			{
				SetPlayerCheckpoint(playerid, buspoint17, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint17))
			{
				SetPlayerCheckpoint(playerid, buspoint18, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint18))
			{
				SetPlayerCheckpoint(playerid, buspoint19, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint19))
			{
				SetPlayerCheckpoint(playerid, buspoint20, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint20))
			{
				SetPlayerCheckpoint(playerid, buspoint21, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint21))
			{
				SetPlayerCheckpoint(playerid, buspoint22, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint22))
			{
				SetPlayerCheckpoint(playerid, buspoint23, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint23))
			{
				SetPlayerCheckpoint(playerid, buspoint24, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint24))
			{
				SetPlayerCheckpoint(playerid, buspoint25, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint25))
			{
				SetPlayerCheckpoint(playerid, buspoint26, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint26))
			{
				SetPlayerCheckpoint(playerid, buspoint27, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,buspoint27))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pBusTime] = 600;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Bus)", 750);
				Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	//DisablePlayerCheckpoint(playerid);
	return 1;
}

forward JobForklift(playerid);
public JobForklift(playerid)
{
	TogglePlayerControllable(playerid, 1);
	GameTextForPlayer(playerid, "~w~SELESAI!", 5000, 3);
}

function Untogle(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	/*//anticbug
	if((newkeys & (KEY_FIRE | KEY_CROUCH)) == (KEY_FIRE | KEY_CROUCH) && (oldkeys & (KEY_FIRE | KEY_CROUCH)) != (KEY_FIRE | KEY_CROUCH))
	{
		new gun = GetPlayerWeapon(playerid);
		if(gun == 24 || gun == 23 || gun == 25)
		{
//			if (GetPlayerAnimationIndex(playerid) != 0)
			{
			cbugwarn[playerid]++;
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "WARNING", "Kamu telah menggunakan cbug, Peringatan ke 5 Anda akan Terkena kick", "Close", "");
			}

			if (cbugwarn[playerid] >= 5) 
			{
				Kick(playerid);
				return 0; 
			}
		}
		return 1; 
	}*/
	if((newkeys & KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 358.3517,178.7152,1008.3828))
		{
		    if(pData[playerid][pIDCard] == 0) return Error(playerid, "Anda tidak memiliki ID Card!");
			PlayerPlaySound(playerid, 5202, 0,0,0);
			new string[1000];
		    format(string, sizeof(string), "Pekerjaan\t\tSedang Bekerja\n{ffffff}Lumberjack\t\t{FFFF00}%d Orang\n{ffffff}Taxi\t\t{FFFF00}%d Orang\n{ffffff}Trucker\t\t{FFFF00}%d Orang\n{ffffff}Miner\t\t{FFFF00}%d Orang\n{ffffff}Production\t\t{FFFF00}%d Orang\n{ffffff}Farmer\t\t{FFFF00}%d Orang\n{ffffff}Baggage Airport\t\t{FFFF00}%d Orang\n"RED_E"Keluar dari pekerjaan",
			tukangtebang,
			taxikontol,
			Trucker,
		 	minerkntol,
		 	product,
			farmeranjing,
			baggage
		    );
	    	ShowPlayerDialog(playerid, DIALOG_DISNAKER, DIALOG_STYLE_TABLIST_HEADERS, "Dinas Tenaga Kerja Kota One Pride", string, "Pilih", "Batal");
		}
	}
	//Vehicle
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER  && IsPlayerInAnyVehicle(playerid)) 
	{
		if(IsKeyJustDown(KEY_CROUCH, newkeys, oldkeys))
		{	
			foreach(new i : DoorBasement)
			{
				if(IsPlayerInDynamicCP(playerid, Basement[i][dbCP][0]))
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SetVehiclePosEx(GetPlayerVehicleID(playerid), Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2], Basement[i][dbIntInPos][3], Basement[i][dbIntvw], Basement[i][dbIntint]);
						SetPlayerInterior(playerid, Basement[i][dbIntint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbIntvw]);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, false, "i", playerid);
					}
					else
					{
						SetPlayerPos(playerid, Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2]);
						SetPlayerFacingAngle(playerid, Basement[i][dbIntInPos][3]);
						SetPlayerInterior(playerid, Basement[i][dbIntint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbIntvw]);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, false, "i", playerid);
					}    
				}
				if(IsPlayerInDynamicCP(playerid, Basement[i][dbCP][1])) {
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SetVehiclePosEx(GetPlayerVehicleID(playerid), Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2], Basement[i][dbExtOutPos][3], Basement[i][dbExtvw], Basement[i][dbExtint]);
						SetPlayerInterior(playerid, Basement[i][dbExtint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbExtvw]);
					}
					else
					{
						SetPlayerPos(playerid, Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2]);
						SetPlayerFacingAngle(playerid, Basement[i][dbExtOutPos][3]);
						SetPlayerInterior(playerid, Basement[i][dbExtint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbExtvw]);
					}    
				}
			}
		}
		if(PRESSED( KEY_FIRE ))
		{
			foreach(new i : DoorBasement)
			{
				if(IsPlayerInDynamicCP(playerid, Basement[i][dbCP][0]))
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SetVehiclePosEx(GetPlayerVehicleID(playerid), Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2], Basement[i][dbIntInPos][3], Basement[i][dbIntvw], Basement[i][dbIntint]);
						SetPlayerInterior(playerid, Basement[i][dbIntint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbIntvw]);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, false, "i", playerid);
					}
					else
					{
						SetPlayerPos(playerid, Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2]);
						SetPlayerFacingAngle(playerid, Basement[i][dbIntInPos][3]);
						SetPlayerInterior(playerid, Basement[i][dbIntint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbIntvw]);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, false, "i", playerid);
					}    
				}
				if(IsPlayerInDynamicCP(playerid, Basement[i][dbCP][1])) {
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SetVehiclePosEx(GetPlayerVehicleID(playerid), Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2], Basement[i][dbExtOutPos][3], Basement[i][dbExtvw], Basement[i][dbExtint]);
						SetPlayerInterior(playerid, Basement[i][dbExtint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbExtvw]);
					}
					else
					{
						SetPlayerPos(playerid, Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2]);
						SetPlayerFacingAngle(playerid, Basement[i][dbExtOutPos][3]);
						SetPlayerInterior(playerid, Basement[i][dbExtint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbExtvw]);
					}    
				}
			}
		}
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT ) 
	{
		if((newkeys & KEY_SECONDARY_ATTACK))
		{
			foreach(new i : DoorBasement)
			{
				if(IsPlayerInDynamicCP(playerid, Basement[i][dbCP][0]))
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SetVehiclePosEx(GetPlayerVehicleID(playerid), Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2], Basement[i][dbIntInPos][3], Basement[i][dbIntvw], Basement[i][dbIntint]);
						SetPlayerInterior(playerid, Basement[i][dbIntint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbIntvw]);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, false, "i", playerid);
					}
					else
					{
						SetPlayerPos(playerid, Basement[i][dbIntInPos][0], Basement[i][dbIntInPos][1], Basement[i][dbIntInPos][2]);
						SetPlayerFacingAngle(playerid, Basement[i][dbIntInPos][3]);
						SetPlayerInterior(playerid, Basement[i][dbIntint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbIntvw]);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("Untogle", 3000, false, "i", playerid);
					}    
				}
				if(IsPlayerInDynamicCP(playerid, Basement[i][dbCP][1])) {
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SetVehiclePosEx(GetPlayerVehicleID(playerid), Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2], Basement[i][dbExtOutPos][3], Basement[i][dbExtvw], Basement[i][dbExtint]);
						SetPlayerInterior(playerid, Basement[i][dbExtint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbExtvw]);
					}
					else
					{
						SetPlayerPos(playerid, Basement[i][dbExtOutPos][0], Basement[i][dbExtOutPos][1], Basement[i][dbExtOutPos][2]);
						SetPlayerFacingAngle(playerid, Basement[i][dbExtOutPos][3]);
						SetPlayerInterior(playerid, Basement[i][dbExtint]);
						SetPlayerVirtualWorld(playerid, Basement[i][dbExtvw]);
					}    
				}
			}
		}
		if((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP) && !pData[playerid][pAdminDuty]) {
			CallLocalFunction("OnPlayerJump", "i", playerid);
		}
	}
    if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
        AntiBHOP[playerid] ++;
        if(pData[playerid][pRFoot] <= 70 || pData[playerid][pLFoot] <= 70)
        {
        	SetTimerEx("AppuiePasJump", 1700, false, "i", playerid);
        	if(AntiBHOP[playerid] == 3)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
        if(pData[playerid][pRFoot] <= 90 || pData[playerid][pLFoot] <= 90)
        {
        	SetTimerEx("AppuiePasJump", 700, false, "i", playerid);
        	if(AntiBHOP[playerid] == 3)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
        if(pData[playerid][pRFoot] <= 40 || pData[playerid][pLFoot] <= 40)
        {
        	SetTimerEx("AppuiePasJump", 3200, false, "i", playerid);
        	if(AntiBHOP[playerid] == 3)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
    }
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_NO))
	{
	    if(pData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
		else if(pData[playerid][CarryingBox])
		{
			Player_DropBox(playerid);
		}
		else if(pData[playerid][CarryingLog] == 0)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping metal ore.");
			DisablePlayerCheckpoint(playerid);
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping coal ore.");
			DisablePlayerCheckpoint(playerid);
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return Error(playerid, "This entrance is locked at the moment.");
					
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != pData[playerid][pFamily])
						return Error(playerid, "This door only for family.");
				}
				
				if(dData[did][dVip] > pData[playerid][pVip])
					return Error(playerid, "Your VIP level not enough to enter this door.");
				
				if(dData[did][dAdmin] > pData[playerid][pAdmin])
					return Error(playerid, "Your admin level not enough to enter this door.");
					
				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
					
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				
				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				pData[playerid][pInDoor] = -1;
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "This bisnis is locked!");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			pData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			pData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				pData[playerid][pInFamily] = fid;	
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
			new difamily = pData[playerid][pInFamily];
			if(pData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, fData[difamily][fIntposX], fData[difamily][fIntposY], fData[difamily][fIntposZ]))
			{
				pData[playerid][pInFamily] = -1;	
				SetPlayerPositionEx(playerid, fData[difamily][fExtposX], fData[difamily][fExtposY], fData[difamily][fExtposZ], fData[difamily][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		foreach(new vid : Vendings)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]) && strcmp(VendingData[vid][vendingOwner], "-"))
			{
				SetPlayerFacingAngle(playerid, VendingData[vid][vendingA]);
				ApplyAnimation(playerid, "VENDING", "VEND_USE", 10.0, 0, 0, 0, 0, 0, 1);
				SetTimerEx("VendingNgentot", 3000, false, "i", playerid);
			}
		}
	}
	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == 0 && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
  		TaserData[playerid][TaserCharged] = false;

	    new Float: x, Float: y, Float: z, Float: health;
     	GetPlayerPos(playerid, x, y, z);
	    PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
	    ApplyAnimation(playerid, "KNIFE", "KNIFE_3", 4.1, 0, 1, 1, 0, 0, 1);
		pData[playerid][pActivityTime] = 0;
	    TaserData[playerid][ChargeTimer] = SetTimerEx("ChargeUp", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Recharge...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

	    for(new i, maxp = GetPlayerPoolSize(); i <= maxp; ++i)
		{
	        if(!IsPlayerConnected(i)) continue;
          	if(playerid == i) continue;
          	if(TaserData[i][TaserCountdown] != 0) continue;
          	if(IsPlayerInAnyVehicle(i)) continue;
			if(GetPlayerDistanceFromPoint(i, x, y, z) > 2.0) continue;
			ClearAnimations(i, 1);
			TogglePlayerControllable(i, false);
   			ApplyAnimation(i, "CRACK", "crckdeth2", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(i, 6003, 0.0, 0.0, 0.0);

			GetPlayerHealth(i, health);
			TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
   			Info(i, "You got tased for %d secounds!", TaserData[i][TaserCountdown]);
			TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
			break;
	    }
	}
	//----[ Vehicle ]-----	
	if((newkeys & KEY_NO ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::light(playerid, "");
		}
	}
	if((newkeys & KEY_YES ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{	
			return callcmd::engine(playerid, "");
		}
	}
	if(newkeys == KEY_LOOK_BEHIND)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::lock(playerid, "");
		}
	}
	//-----[ Toll System ]-----	
	if(newkeys & KEY_CROUCH)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			new forcount = MuchNumber(sizeof(BarrierInfo));
			for(new i;i < forcount;i ++)
			{
				if(i < sizeof(BarrierInfo))
				{
					if(IsPlayerInRangeOfPoint(playerid,8,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]))
					{
						if(BarrierInfo[i][brOrg] == TEAM_NONE)
						{
							if(!BarrierInfo[i][brOpen])
							{
								if(pData[playerid][pMoney] < 50)
								{
									Toll(playerid, "Uangmu tidak cukup untuk membayar toll");
								}
								else
								{
									MoveDynamicObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
									SetTimerEx("BarrierClose",5000,0,"i",i);
									BarrierInfo[i][brOpen] = true;
									Toll(playerid, "Toll akan segera menutup kembali pembatas dalam 5 detik");
									GivePlayerMoneyEx(playerid, -50);
									if(BarrierInfo[i][brForBarrierID] != -1)
									{
										new barrierid = BarrierInfo[i][brForBarrierID];
										MoveDynamicObject(gBarrier[barrierid],BarrierInfo[barrierid][brPos_X],BarrierInfo[barrierid][brPos_Y],BarrierInfo[barrierid][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[barrierid][brPos_A]+180);
										BarrierInfo[barrierid][brOpen] = true;

									}
								}
							}
						}
						else Toll(playerid, "Kamu tidak bisa membuka pintu Toll ini!");
						break;
					}
				}
			}
		}
		return true;		
	}
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(pData[playerid][pEnergy] >= 100 )
		{
  			Info(playerid, " Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
		    pData[playerid][pEnergy] += 5;
		}
	}
	// STREAMER MASK SYSTEM
	if(PRESSED( KEY_WALK ))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(pData[playerid][pAdmin] < 2)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetEngineStatus(vehicleid))
				{
					if(GetVehicleSpeed(vehicleid) <= 40)
					{
						new playerState = GetPlayerState(playerid);
						if(playerState == PLAYER_STATE_DRIVER)
						{
							SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s have been auto kicked for vehicle engine hack!", pData[playerid][pName]);
							KickEx(playerid);
						}
					}
				}
			}	
		}
	}
	if(PRESSED( KEY_YES ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return Error(playerid, "This entrance is locked at the moment.");
							
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != pData[playerid][pFamily])
								return Error(playerid, "This door only for family.");
						}
						
						if(dData[did][dVip] > pData[playerid][pVip])
							return Error(playerid, "Your VIP level not enough to enter this door.");
						
						if(dData[did][dAdmin] > pData[playerid][pAdmin])
							return Error(playerid, "Your admin level not enough to enter this door.");
							
						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
							
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
					}
				}
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
					
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						pData[playerid][pInDoor] = -1;
						SetPlayerInterior(playerid, dData[did][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
					}
				}
			}
		}
	}
	if(PRESSED( KEY_CTRL_BACK ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pData[playerid][pCuffed] == 0)
		{
			if(pData[playerid][pLoopAnim])
	    	{	
	        	pData[playerid][pLoopAnim] = 0;

				ClearAnimations(playerid, 1);
				StopLoopingAnim(playerid);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		    	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
		    	TextDrawHideForPlayer(playerid, AnimationTD);
			}
			
		}
    }
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	if(takingselfie[playerid] == 1)
	{
		if(PRESSED(KEY_ANALOG_RIGHT))
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] += Speed;
		    n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		    n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		    SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		    SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		    SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		if(PRESSED(KEY_ANALOG_LEFT))
		{
		    GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] -= Speed;
		    n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		    n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		    SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		    SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		    SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
	}
	//-F
	/*if(StatusCrateTerangkat == true)
    {
        if(PRESSED (KEY_JUMP))
        {
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
        }
    }*/
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	//JOB KURIR
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		if(IsABaggageVeh(GetPlayerVehicleID(playerid)))
		{
			InfoTD_MSG(playerid, 8000, "/~g~startbg");
		}
	}
	if(newstate == PLAYER_STATE_WASTED && pData[playerid][pJail] < 1)
    {	
		if(pData[playerid][pInjured] == 0)
        {
            pData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 99999);

            pData[playerid][pInt] = GetPlayerInterior(playerid);
            pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
        }
        else
        {
            pData[playerid][pHospital] = 1;
        }
	}
	//Spec Player
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(pData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(pData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					Servers(ii, ,"%s(%i) is now on foot.", pData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(pData[playerid][pInjured] == 1)
        {
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
        }
		foreach (new ii : Player) if(pData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		//TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
    {	
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);/*RemoveFromVehicle(playerid);*/

		//hbe modern
        HidePlayerProgressBar(playerid, pData[playerid][damagebar]);
		PlayerTextDrawHide(playerid, hbeNew[playerid][4]);
        PlayerTextDrawHide(playerid, hbeNew[playerid][5]);
		PlayerTextDrawHide(playerid, hbeNew[playerid][6]);
    	PlayerTextDrawHide(playerid, MPH[playerid]);
        PlayerTextDrawHide(playerid, BENSIN[playerid]);
		PlayerTextDrawHide(playerid, NAMEVEH[playerid]);

		PlayerTextDrawHide(playerid, HbeJgrpCuy[playerid][1]);
		PlayerTextDrawHide(playerid, HbeJgrpCuy[playerid][4]);
		PlayerTextDrawHide(playerid, HbeJgrpCuy[playerid][5]);
		PlayerTextDrawHide(playerid, HbeJgrpCuy[playerid][6]);
		PlayerTextDrawHide(playerid, HbeJgrpCuy[playerid][7]);
	    PlayerTextDrawHide(playerid, JGMVSPEED[playerid]);
		PlayerTextDrawHide(playerid, JGMVHP[playerid]);
		PlayerTextDrawHide(playerid, JGMVFUEL[playerid]);
		
		if(pData[playerid][pTaxiDuty] == 1)
		{
			pData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "You are no longer on taxi duty!");
		}
		if(pData[playerid][pFare] == 1)
		{
			KillTimer(pData[playerid][pFareTimer]);
			Info(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
			pData[playerid][pFare] = 0;
			pData[playerid][pTotalFare] = 0;
		}
		if(pData[playerid][pIsStealing] == 1)
		{
			pData[playerid][pIsStealing] = 0;
			pData[playerid][pLastChopTime] = 0;
			Info(playerid, "Kamu gagal mencuri kendaraan ini, di karenakan kamu keluar kendaraan saat proses pencurian!");
			KillTimer(MalingKendaraan);

		}
		if(CourierJob[playerid])
		{
			TimerCourier[playerid] = 61;
			new Float:x1, Float:y1, Float:z1;
			GetVehiclePartPos(pData[playerid][pLastCar], VEHICLE_PART_TRUNK, x1, y1, z1);
			pData[playerid][pCourierCP] = SetPlayerRaceCheckpoint(playerid, 1, x1, y1, z1, x1, y1, z1, 1);
			CourierCrate[playerid] = 1;
			SetVehicleParamsForPlayer(pData[playerid][pLastCar],playerid,1,0);
			return 1;
		}
        
		HidePlayerProgressBar(playerid, pData[playerid][fuelnew]);
        HidePlayerProgressBar(playerid, pData[playerid][damagenew]);
		HidePlayerProgressBar(playerid, pData[playerid][fuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][damagebar]);
	}
	else if(newstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER)
    {
		/*if(IsSRV(vehicleid))
		{
			new tstr[128], price = GetVehicleCost(GetVehicleModel(vehicleid));
			format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleName(vehicleid), FormatMoney(price));
			ShowPlayerDialog(playerid, DIALOG_BUYPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
		}
		else if(IsVSRV(vehicleid))
		{
			new tstr[128], price = GetVipVehicleCost(GetVehicleModel(vehicleid));
			if(pData[playerid][pVip] == 0)
			{
				Error(playerid, "Kendaraan Khusus VIP Player.");
				RemovePlayerFromVehicle(playerid);
				//SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
			else
			{
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d Coin", GetVehicleName(vehicleid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYVIPPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
		}*/
		
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
				{
					if(pvData[pv][cLocked] == 1)
					{
						RemovePlayerFromVehicle(playerid);
						//new Float:slx, Float:sly, Float:slz;
						//GetPlayerPos(playerid, slx, sly, slz);
						//SetPlayerPos(playerid, slx, sly, slz);
						Error(playerid, "This bike is locked by owner.");
						return 1;
					}
				}
			}
		}
		
		if(IsASweeperVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "Side Job - Sweeper", "Anda akan bekerja sweeper", "Start Job", "Close");
		}
		if(IsABusVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_MSGBOX, "Side Job - Bus", "Anda akan bekerja supir bus", "Start Job", "Close");
		}
		if(IsAForVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Anda akan bekerja forlift {7fff00}$950 ", "Start Job", "Close");
		}
		if(IsAMowerVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_MOWER, DIALOG_STYLE_MSGBOX, "Side Job - Mower", "Anda akan bekerja sebagai Mower  {7fff00}$200", "Start Job", "Close");
		}
		if(IsABaggageVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 10 && pData[playerid][pJob2] != 10)
			{
				RemovePlayerFromVehicle(playerid);
                Error(playerid, "Kamu tidak bekerja sebagai Baggage Airport");
			}
		}
		if(IsACourierVeh(GetPlayerVehicleID(playerid)) && !CourierJob[playerid]) Dialog_Show(playerid, CourierSidejob, DIALOG_STYLE_MSGBOX, "{ffffff}Sidejob: Courier", "Are you ready to start working sidejob as a Courier?", "Start", "Cancel");
		if(IsADmvVeh(vehicleid))
        {
            if(!pData[playerid][pDriveLicApp])
            {
                RemovePlayerFromVehicle(playerid);
                Error(playerid, "Kamu tidak sedang mengikuti Tes Mengemudi");
			}
			else 
			{
				Info(playerid, "Silahkan ikuti Checkpoint yang ada di GPS mobil ini.");
				SetPlayerRaceCheckpoint(playerid, 1, dmvpoint1, dmvpoint1, 5.0);
			}
		}
		/*if(IsAKurirVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
			{
				RemovePlayerFromVehicle(playerid);
                Error(playerid, "Kamu tidak bekerja sebagai Courier");
			}
		}*/
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SAPD!");
			}
		} 
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SANEWS!");
			}
		}
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }
		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] <= 0)
        {
            Info(playerid, "Anda tidak memiliki surat izin mengemudi, berhati-hatilah.");
        }
		if(pData[playerid][pHBEMode] == 1) //HBE Modern
		{
            //HBE Modern
            ShowPlayerProgressBar(playerid, pData[playerid][damagebar]);
			PlayerTextDrawShow(playerid, hbeNew[playerid][4]);
            PlayerTextDrawShow(playerid, hbeNew[playerid][5]);
			PlayerTextDrawShow(playerid, hbeNew[playerid][6]);
            PlayerTextDrawShow(playerid, MPH[playerid]);
            PlayerTextDrawShow(playerid, BENSIN[playerid]);
			PlayerTextDrawShow(playerid, NAMEVEH[playerid]);
		}
		if(pData[playerid][pHBEMode] == 2) //HBE Simple
		{	
			PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][1]);
		    PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][4]);
		    PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][5]);
		    PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][6]);
		    PlayerTextDrawShow(playerid, HbeJgrpCuy[playerid][7]);
		    PlayerTextDrawShow(playerid, JGMVSPEED[playerid]);
		    PlayerTextDrawShow(playerid, JGMVHP[playerid]);
		    PlayerTextDrawShow(playerid, JGMVFUEL[playerid]);
		}
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;
		
		if(pData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(pData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    Servers(ii, "%s(%i) is now driving a %s(%d).", pData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid){ case 0..18, 39..54: return 1;} //invalid weapons
	if(1 <= weaponid <= 46 && pData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
	{
		pData[playerid][pAmmo][g_aWeaponSlots[weaponid]]--;
		if(pData[playerid][pGuns][g_aWeaponSlots[weaponid]] != 0 && !pData[playerid][pAmmo][g_aWeaponSlots[weaponid]])
		{
			pData[playerid][pGuns][g_aWeaponSlots[weaponid]] = 0;
		}
		if(hittype == 1 && GetDamageID[hitid] == INVALID_PLAYER_ID)
		{
			GetDamageID[hitid] = playerid;
		}
	}
	return 1;
}

//ANTICBUG
stock IsACBUGWeapon(playerid)
{
	if (IsPlayerConnected(playerid))
	{
	    new Lenzwp = GetPlayerWeapon ( playerid ) ;
	    if (Lenzwp == 24 || Lenzwp == 25 || Lenzwp == 27 || Lenzwp == 34 ) return 1 ;
	}
	return 0 ;
}

stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health = GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);
    if(pData[playerid][pSeatBelt] == 0 || pData[playerid][pHelmetOn] == 0)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 2);
    		new bsakit = RandomEx(0, 2);
    		new csakit = RandomEx(0, 2);
    		new dsakit = RandomEx(0, 2);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		new csakit = RandomEx(0, 3);
    		new dsakit = RandomEx(0, 3);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -3);
    		return 1;
    	}
    	return 1;
    }
    if(pData[playerid][pSeatBelt] == 1 || pData[playerid][pHelmetOn] == 1)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -3);
    		return 1;
    	}
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	CreateDamageLog(playerid, Float:amount, weaponid, bodypart);
	if(IsAtEvent[playerid] == 0)
	{
		new sakit = RandomEx(1, 4);
		new asakit = RandomEx(1, 5);
		new bsakit = RandomEx(1, 7);
		new csakit = RandomEx(1, 4);
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			pData[playerid][pHead] -= 20;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 3)
		{
			pData[playerid][pPerut] -= sakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 6)
		{
			pData[playerid][pRHand] -= bsakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 5)
		{
			pData[playerid][pLHand] -= asakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 8)
		{
			pData[playerid][pRFoot] -= csakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 7)
		{
			pData[playerid][pLFoot] -= bsakit;
		}
	}
	else if(IsAtEvent[playerid] == 1)
	{
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			GivePlayerHealth(playerid, -90);
			SendClientMessage(issuerid, -1,"{7fffd4}[ TDM ]{ffffff} Headshot!");
		}
	}
	//PlayerLabelHit(playerid);
    return 1;
}

public OnPlayerUpdate(playerid)
{
	/* if (gPlayerFlybreak[playerid])
    {
        ApplyFlybreak(playerid);
    } */

	//pocketloss
	PacketSent[playerid]++;

	//afk system
	p_tick[playerid]++;
	
	//SAPD Tazer/Taser
	UpdateTazer(playerid);
	
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);

	//Report ask
	//GetPlayerName(playerid, g_player_name[playerid], MAX_PLAYER_NAME);

	//AntiCheat
	pData[playerid][pLastUpdate] = gettime();

	//SpeedCam
	static id;
	new vehicled = Vehicle_Nearest2(playerid), query[326];
	if ((id = SpeedCam_Nearest(playerid)) != -1 && GetPlayerSpeedCam(playerid) > CamData[id][CamLimit] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && pvData[vehicled][cOwner] == pData[playerid][pID] && GetEngineStatus(vehicled) && !pData[playerid][pSpeedTime])
	{
	    if (!IsACruiser(vehicled) && !IsABoat(vehicled) && !IsAPlane(vehicled) && !IsAHelicopter(vehicled))
	    {
	 		new price = 20 + floatround(GetPlayerSpeedCam(playerid) - CamData[id][CamLimit]);
			new str[500];
	   		format(str, sizeof(str), "Kecepatan (%.0f/%.0f mph)", GetPlayerSpeedCam(playerid), CamData[id][CamLimit]);
	        SetTimerEx("HidePlayerBox", 500, false, "dd", playerid, _:ShowPlayerBox(playerid, 0xFFFFFF66));
    		format(str, sizeof(str), "{ff0000}[SpeedCam]: {ffffff}Kamu telah melebihi kecepatan dan mendapatkan denda sebesar {3BBD44}%s", FormatMoney(price));
     		SendClientMessage(playerid, -1, str);
			pvData[vehicled][cTicket] += price;

			mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET ticket = '%d' WHERE id = '%d'", pvData[vehicled][cTicket], pvData[vehicled][cID]);
			mysql_tquery(g_SQL, query);
			pData[playerid][pSpeedTime] = 5;
		}
	}
	
	return 1;
}

task VehicleUpdate[40000]()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 15);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 200)
            {
               Info(GetVehicleDriver(i), "Kendaraan ingin habis bensin, Harap pergi ke SPBU ( Gas Station )");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
	foreach(new ii : PVehicles)
	{
		if(IsValidVehicle(pvData[ii][cVeh]))
		{
			if(pvData[ii][cPlateTime] != 0 && pvData[ii][cPlateTime] <= gettime())
			{
				format(pvData[ii][cPlate], 32, "NoHave");
				SetVehicleNumberPlate(pvData[ii][cVeh], pvData[ii][cPlate]);
				pvData[ii][cPlateTime] = 0;
			}
			if(pvData[ii][cRent] != 0 && pvData[ii][cRent] <= gettime())
			{
				pvData[ii][cRent] = 0;
				new query[128], xuery[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, query);

				mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, xuery);
				if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
				pvData[ii][cVeh] = INVALID_VEHICLE_ID;
				Iter_SafeRemove(PVehicles, ii, ii);
			}
		}
		if(pvData[ii][cClaimTime] != 0 && pvData[ii][cClaimTime] <= gettime())
		{
			pvData[ii][cClaimTime] = 0;
		}
	}
}

public OnVehicleSpawn(vehicleid)
{
	foreach(new ii : PVehicles)
	{
		if(vehicleid == pvData[ii][cVeh] && pvData[ii][cRent] == 0)
		{
			pvData[ii][cInsu] = 0;
			pvData[ii][cClaim] = 1;
			pvData[ii][cClaimTime] = 0;
			foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
			{
				Info(pid, "Kendaraan anda hancur, silahkan ambil di kantor insuransi.");
			}
			if(IsValidVehicle(pvData[ii][cVeh]))
				DestroyVehicle(pvData[ii][cVeh]);
			
			pvData[ii][cVeh] = INVALID_VEHICLE_ID;
			return 1;
		}
	}
	//System Vehicle Admin
	if(AdminVehicle{vehicleid})
	{
	    DestroyVehicle(vehicleid);
	    AdminVehicle{vehicleid} = false;
	}
	return 1;
}

ptask PlayerVehicleUpdate[200](playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{	
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				SetValidVehicleHealth(vehicleid, 300.0);
				SwitchVehicleEngine(vehicleid, false);
				InfoTD_MSG(playerid, 2500, "~r~Totalled");
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pHBEMode] == 1) //HBE Modern
			{
				new Float:fDamage, fFuel, color1, color2;
				new tstr[1000], vehname[62];
				GetVehicleColor(vehicleid, color1, color2);
				GetVehicleHealth(vehicleid, fDamage);
				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000) fDamage = 1000;

				fFuel = GetVehicleFuel(vehicleid);

 				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				SetPlayerProgressBarValue(playerid, pData[playerid][damagebar], fDamage);
				SetPlayerProgressBarColour(playerid, pData[playerid][damagebar], ConvertDamageVehicleColor(fDamage));

				format(tstr, sizeof(tstr), "%.0f", GetVehicleSpeed(vehicleid) / 1);
				PlayerTextDrawSetString(playerid, MPH[playerid], tstr);

				format(tstr, sizeof(tstr), "%dL", fFuel);
                PlayerTextDrawSetString(playerid, BENSIN[playerid], tstr);

				format(vehname, sizeof(vehname), "%s", GetVehicleName(vehicleid));
				PlayerTextDrawSetString(playerid, NAMEVEH[playerid], vehname);
			}
			if(pData[playerid][pHBEMode] == 2) //HBE Simple
			{
				new Float:fDamage, fFuel;
				new fuelstr[64], damagestr[62], speedstr[62], vehh[20], veh[20];

				GetVehicleHealth(vehicleid, fDamage);

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;

				if(fDamage <= 600) vehh = "~r~";
				else if(fDamage <= 1000) vehh = "~g~";
				else if(fDamage <= 800) vehh = "~y~";

				fFuel = GetVehicleFuel(vehicleid);

				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				if(fFuel <= 1000) veh = "~g~";
				else if(fFuel <= 700) veh = "~y~";
				else if(fFuel <= 450) veh = "~r~";

				format(speedstr, sizeof(speedstr), "%.0f", GetVehicleSpeed(vehicleid) / 2);
				PlayerTextDrawSetString(playerid, JGMVSPEED[playerid], speedstr);

				format(fuelstr, sizeof(fuelstr), "%s%d%", veh, fFuel / 10);
				PlayerTextDrawSetString(playerid, JGMVFUEL[playerid], fuelstr);

				format(damagestr, sizeof(damagestr), "%s%.0f%", veh, fDamage / 10);
				PlayerTextDrawSetString(playerid, JGMVHP[playerid], damagestr);
			}
		}
	}
}

ptask PlayerUpdate[999](playerid)
{
	//Anti-Cheat Vehicle health hack
	if(pData[playerid][pAdmin] < 2)
	{
		for(new v, j = GetVehiclePoolSize(); v <= j; v++) if(GetVehicleModel(v))
		{
			new Float:health;
			GetVehicleHealth(v, health);
			if( (health > VehicleHealthSecurityData[v]) && VehicleHealthSecurity[v] == false)
			{
				if(GetPlayerVehicleID(playerid) == v)
				{
					new playerState = GetPlayerState(playerid);
					if(playerState == PLAYER_STATE_DRIVER)
					{
						SetValidVehicleHealth(v, VehicleHealthSecurityData[v]);
						SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s have been auto kicked for vehicle health hack!", pData[playerid][pName]);
						KickEx(playerid);
					}
				}
			}
			if(VehicleHealthSecurity[v] == true)
			{
				VehicleHealthSecurity[v] = false;
			}
			VehicleHealthSecurityData[v] = health;
		}
	}	
	//Anti-Money Hack
	if(GetPlayerMoney(playerid) > pData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pData[playerid][pMoney]);
		//SendAdminMessage(COLOR_RED, "Possible money hacks detected on %s(%i). Check on this player. "LG_E"($%d).", pData[playerid][pName], playerid, GetPlayerMoney(playerid) - pData[playerid][pMoney]);
	}
	if(pData[playerid][TempatHealing])
    {
        stresstimer[playerid] = SetTimerEx("StressBerkurang", 25000, true, "d", playerid);
    }
    if(pData[playerid][pBladder] <= 15)
    {
        pData[playerid][TempatHealing] = false;
        KillTimer(stresstimer[playerid]);
    }
	//Anti Armour Hacks
	new Float:A;
	GetPlayerArmour(playerid, A);
	if(pData[playerid][pAdmin] < 2 && IsAtEvent[playerid] == 0)
	{
		if(A > 98)
		{
			SetPlayerArmourEx(playerid, 0);
			SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s(%i) has been auto kicked for armour hacks!", pData[playerid][pName], playerid);
			KickEx(playerid);
		}
	}
	//Weapon AC
	if(pData[playerid][pAdmin] < 2 && IsAtEvent[playerid] == 0)
	{
		if(pData[playerid][pSpawned] == 1)
		{
			if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
			{
				pData[playerid][pWeapon] = GetPlayerWeapon(playerid);

				if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 40 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
				{
					pData[playerid][pACWarns]++;

					if(pData[playerid][pACWarns] < MAX_ANTICHEAT_WARNINGS)
					{
						new dc[128];
						SendAnticheat(COLOR_RED, "%s(%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
						SetWeapons(playerid); 
						format(dc, sizeof(dc),  "```\n<!> %s kemungkinan Weapon hacks (%s) ```", ReturnName(playerid), ReturnWeaponName(pData[playerid][pWeapon]));					
					}
					else
					{
						new dc[128], PlayerIP[16];
						SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: %s"WHITE_E" telah dibanned otomatis oleh %s, Alasan: Weapon hacks", pData[playerid][pName], SERVER_BOT);
						format(dc, sizeof(dc),  "```\n<!> %s telah diban oleh %s\nAlasan: Weapon Hack```", ReturnName(playerid), SERVER_BOT);

						GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
						new query[300], tmp[40], ban_time = 0;
						format(tmp, sizeof (tmp), "Weapon Hack (%s)", ReturnWeaponName(pData[playerid][pWeapon]));
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", pData[playerid][pUCP], PlayerIP, SERVER_BOT, tmp, gettime(), ban_time);
						mysql_tquery(g_SQL, query);
						KickEx(playerid);
					}
				}
			}
		}
	}	
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static weaponid, ammo, objectslot, count, index;
 
		for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
		{
			GetPlayerWeaponData(playerid, i, weaponid, ammo);
			index = weaponid - 22;
		   
			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);
 
				if (GetPlayerWeapon(playerid) != weaponid)
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
 
				else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;
 
			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
				count++;
 
			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	
	//Player Update Online Data
	//GetPlayerHealth(playerid, pData[playerid][pHealth]);
    //GetPlayerArmour(playerid, pData[playerid][pArmour]);
	
	if(pData[playerid][pJail] <= 0)
	{
		if(pData[playerid][pHunger] > 100)
		{
			pData[playerid][pHunger] = 100;
		}
		if(pData[playerid][pHunger] < 0)
		{
			pData[playerid][pHunger] = 0;
		}
		if(pData[playerid][pEnergy] > 100)
		{
			pData[playerid][pEnergy] = 100;
		}
		if(pData[playerid][pEnergy] < 0)
		{
			pData[playerid][pEnergy] = 0;
		}
		if(pData[playerid][pBladder] > 100)
		{
			pData[playerid][pBladder] = 100;
		}
		if(pData[playerid][pBladder] < 0)
		{
			pData[playerid][pBladder] = 0;
		}
		/*if(pData[playerid][pHealth] > 100)
		{
			SetPlayerHealthEx(playerid, 100);
		}*/
	}

	if(pData[playerid][pHBEMode] == 1 && pData[playerid][IsLoggedIn] == true) //HBE Modern
	{
		new Float:hunger, Float:energy, Float:stress;
	 	hunger = pData[playerid][pHunger] * 60.0/100;
		PlayerTextDrawTextSize(playerid,FOOD[playerid], hunger, 7.0); //Seusain in aja size nya sama di textdraw nya
	 	PlayerTextDrawShow(playerid, FOOD[playerid]);
	 	
	 	energy = pData[playerid][pEnergy] * 60.0/100;
		PlayerTextDrawTextSize(playerid,DRINK[playerid], energy, 7.0); //Seusain in aja size nya sama di textdraw nya
	 	PlayerTextDrawShow(playerid,DRINK[playerid]);
	 	
	 	stress = pData[playerid][pBladder] * 60.0/100;
		PlayerTextDrawTextSize(playerid,BLADDER[playerid], stress, 7.0);
	 	PlayerTextDrawShow(playerid,BLADDER[playerid]);
	}
	if(pData[playerid][pHBEMode] == 2 && pData[playerid][IsLoggedIn] == true) //HBE Simple
	{
		new Float:hunger, Float:energy;
	 	hunger = pData[playerid][pHunger] * 60.0/100;
		PlayerTextDrawTextSize(playerid, JGMHUNGER[playerid], hunger, 7.0); //Seusain in aja size nya sama di textdraw nya
	 	PlayerTextDrawShow(playerid, JGMHUNGER[playerid]);
	 	
	 	energy = pData[playerid][pEnergy] * 60.0/100;
		PlayerTextDrawTextSize(playerid, JGMTHIRST[playerid], energy, 7.0); //Seusain in aja size nya sama di textdraw nya
	 	PlayerTextDrawShow(playerid, JGMTHIRST[playerid]);
	}
	if(pData[playerid][pHospital] == 1)
    {
		if(pData[playerid][pInjured] == 1)
		{
			SetPlayerPosition(playerid, 1839.21, -1104.38, 42.26, 270.52, 1);
		
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, playerid + 100);

			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pInjured] = 0;
			UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
			if(pData[playerid][pWeaponLic] != 1)
			{
				ResetPlayerWeaponsEx(playerid);
			}
		}
		pData[playerid][pHospitalTime]++;
		new mstr[64];
		format(mstr, sizeof(mstr), "~n~~n~~n~~w~Recovering... %d", 15 - pData[playerid][pHospitalTime]);
		InfoTD_MSG(playerid, 1000, mstr);

		ApplyAnimation(playerid, "CRACK", "crckdeth5", 4.0, 1, 0, 0, 0, 0);
		ApplyAnimation(playerid, "CRACK", "crckdeth5", 4.0, 1, 0, 0, 0, 0);
        if(pData[playerid][pHospitalTime] >= 15)
        {
            pData[playerid][pHospitalTime] = 0;
            pData[playerid][pHospital] = 0;
			pData[playerid][pHunger] = 50;
			pData[playerid][pEnergy] = 50;
			pData[playerid][pBladder] = 50;
			SetPlayerHealthEx(playerid, 50);
			pData[playerid][pSick] = 0;
			GivePlayerMoneyEx(playerid, -1000);
			SetPlayerHealthEx(playerid, 50);

            for (new i; i < 20; i++)
            {
                SendClientMessage(playerid, -1, "");
            }

            SendClientMessage(playerid, COLOR_WHITE, "Kamu telah keluar dari rumah sakit dan membayar {7fff00}$1000 ");
			
			SetPlayerPosition(playerid, 2028.3990,-1406.8951,17.1969,180.1153);

            TogglePlayerControllable(playerid, 1);
            SetCameraBehindPlayer(playerid);

            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			ClearAnimations(playerid);
			pData[playerid][pSpawned] = 1;
			SetPVarInt(playerid, "GiveUptime", -1);
		}
    }
	if(pData[playerid][pInjured] == 1 && pData[playerid][pHospital] != 1)
    {
		new mstr[64];
		format(mstr, sizeof(mstr), "/death for spawn to hospital");
		InfoTD_MSG(playerid, 1000, mstr);
		if(GetPVarInt(playerid, "GiveUptime") == -1)
		{
			SetPVarInt(playerid, "GiveUptime", gettime());
		}
		
		if(GetPVarInt(playerid,"GiveUptime"))
        {
            if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 100)
            {
                Info(playerid, "Gunakan '/death' Untuk Spawn Ke ASGH.");
                SetPVarInt(playerid, "GiveUptime", 0);
            }
        }
        ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 1, 0, 0, 0, 0);
        SetPlayerHealthEx(playerid, 99999);
    }
	if(pData[playerid][pInjured] == 0 && pData[playerid][pGender] != 0) //Pengurangan Data
	{
		if(++ pData[playerid][pHungerTime] >= 150)
        {
            if(pData[playerid][pHunger] > 0)
            {
                pData[playerid][pHunger]--;
            }
            else if(pData[playerid][pHunger] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pHungerTime] = 0;
        }
        if(++ pData[playerid][pEnergyTime] >= 120)
        {
            if(pData[playerid][pEnergy] > 0)
            {
                pData[playerid][pEnergy]--;
            }
            else if(pData[playerid][pEnergy] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pEnergyTime] = 0;
        }
		if (pData[playerid][pBladder] == 80)
		{
			Info(playerid, "Hati-hati! Kamu mulai stress.");
		}
		else if (pData[playerid][pBladder] == 100)
		{
			new Float:hp;
			GetPlayerHealth(playerid, hp);
			SetPlayerHealth(playerid, hp - 1);
			ShowCylinderText(playerid, "Anda sedang stress.");
			SetPlayerDrunkLevel(playerid, 8000);
			pData[playerid][pSick] = 1;
		}
		if(pData[playerid][pSick] == 1)
		{
			if(++ pData[playerid][pSickTime] >= 200)
			{
				if(pData[playerid][pSick] >= 1)
				{
					new Float:hp;
					GetPlayerHealth(playerid, hp);
					SetPlayerDrunkLevel(playerid, 8000);
					ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,0,1,1,1,1,1);
					Info(playerid, "Sepertinya anda sakit, segeralah pergi ke dokter.");
					SetPlayerHealth(playerid, hp - 3);
					pData[playerid][pSickTime] = 0;
				}
			}
		}
	}
	if (pData[playerid][pSpeedTime] > 0)
	{
	    pData[playerid][pSpeedTime]--;
	}
	if(pData[playerid][pLastChopTime] > 0)
    {
		pData[playerid][pLastChopTime]--;
		new mstr[64];
        format(mstr, sizeof(mstr), "Waktu Pencurian ~r~%d ~w~detik", pData[playerid][pLastChopTime]);
        InfoTD_MSG(playerid, 1000, mstr);
	}
	//Jail Player
	if(pData[playerid][pJail] > 0)
	{
		if(pData[playerid][pJailTime] > 0)
		{
			pData[playerid][pJailTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be unjail in ~w~%d ~b~~h~seconds.", pData[playerid][pJailTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pJail] = 0;
			pData[playerid][pJailTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1552.78, -1675.67, 16.4953, 88.7673);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E" %s(%d) have been un-jailed by the server. (times up)", pData[playerid][pName], playerid);
		}
	}
	//Arreset Player
	if(pData[playerid][pArrest] > 0)
	{
		if(pData[playerid][pArrestTime] > 0)
		{
			pData[playerid][pArrestTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be released in ~w~%d ~b~~h~seconds.", pData[playerid][pArrestTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pArrest] = 0;
			pData[playerid][pArrestTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1552.78, -1675.67, 16.4953, 88.7673);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			Info(playerid, "You have been auto release. (times up)");
		}
	}
}

forward AppuieJump(playerid);
public AppuieJump(playerid)
{
    AntiBHOP[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}
forward AppuiePasJump(playerid);
public AppuiePasJump(playerid)
{
    AntiBHOP[playerid] = 0;
    return 1;
}
/*
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (dialogid == 0) 
	{
        if (response) 
		{
            SetPlayerSkin(playerid, listitem);
            GameTextForPlayer(playerid, "~g~Skin Changed!", 3000, 3);
        }
    }
	if(dialogid == 1) 
	{
		if (response) 
		{
			if (GetPlayerMoney(playerid) < WEAPON_SHOP[listitem][WEAPON_PRICE]) 
			{
				SendClientMessage(playerid, 0xAA0000FF, "Not enough money to purchase this gun!");
				return callcmd::weapons(playerid);
			}
			
			GivePlayerMoney(playerid, -WEAPON_SHOP[listitem][WEAPON_PRICE]);
			GivePlayerWeapon(playerid, WEAPON_SHOP[listitem][WEAPON_ID], WEAPON_SHOP[listitem][WEAPON_AMMO]);
			
			GameTextForPlayer(playerid, "~g~Gun Purchased!", 3000, 3);
		}
	}
    return 1;
} */

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(pData[playerid][pDriveLicApp] > 0)
	{
		//new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 602)
		{
		    DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
		    Info(playerid, "Anda Dengan Sengaja Keluar Dari Mobil Latihan, Anda Telah "RED_E"DIDISKUALIFIKASI.");
		    RemovePlayerFromVehicle(playerid);
		    pData[playerid][pDriveLicApp] = 0;
		    SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if (pData[playerid][pAdminDuty])
    if (pData[playerid][pAdmin] >= 1)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
                SetVehiclePos(vehicleid, fX, fY, fZ+10);
        }
        else
        {
                SetPlayerPosFindZ(playerid, fX, fY, 999.0);
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerInterior(playerid, 0);
        }
        Info(playerid, "Kamu Telah Berhasil Teleport Ke Marker Di Peta di peta.");
    }
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == zahl1)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "1");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "1");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "1");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "1");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == zahl2)
	{
	    if(rrechnung[playerid] == 0)
	    {
	    	strcat(zahl[playerid], "2");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "2");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "2");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid],"2");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == zahl3)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "3");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "3");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "3");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "3");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == zahl4)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "4");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "4");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "4");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "4");
			TextDrawSetString(rechnung, rechi[playerid]);

		}
	}
	if(clickedid == zahl5)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "5");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "5");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "5");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "5");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == zahl6)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "6");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "6");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "6");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "6");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == zahl7)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "7");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "7");
			TextDrawSetString(rechnung, rechi[playerid]);

		}
		else
		{
            strcat(azahl[playerid], "7");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "7");
			TextDrawSetString(rechnung, rechi[playerid]);

		}
	}
	if(clickedid == zahl8)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "8");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "8");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "8");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "8");
			TextDrawSetString(rechnung, rechi[playerid]);

		}
	}
	if(clickedid == zahl9)
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "9");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "9");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "9");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "9");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == plus)
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 1;
			strcat(rech[playerid], "+");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "+");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == minus)
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 2;
			strcat(rech[playerid], "-");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "-");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == mal)
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 3;
			strcat(rech[playerid], "x");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], "x");
			TextDrawSetString(rechnung, rechi[playerid]);

		}
	}
	if(clickedid == geteilt)
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 4;
			strcat(rech[playerid], ":");
			TextDrawShowForPlayer(playerid, rechnung);
			strcat(rechi[playerid], ":");
			TextDrawSetString(rechnung, rechi[playerid]);
		}
	}
	if(clickedid == gleich)
	{
	    new string[128];
		if(rrechnung[playerid] >= 1)
		{
			if(rrechnung[playerid] == 1)
			{
				ergeb[playerid] = strval(zahl[playerid]) + strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss, string);
			}
			if(rrechnung[playerid] == 2)
			{
				ergeb[playerid] = strval(zahl[playerid]) - strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss, string);
			}
			if(rrechnung[playerid] == 3)
			{
				ergeb[playerid] = strval(zahl[playerid]) * strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss, string);
			}
			if(rrechnung[playerid] == 4)
			{
				ergeb[playerid] = strval(zahl[playerid]) / strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss, string);
			}

		}
	}
	if(clickedid == exxit)
	{
		HideTextDrawKalkulator(playerid);
	}
	return 1;
}

stock HideTextDrawKalkulator(playerid)
{
    TogglePlayerControllable(playerid, 1);
	CancelSelectTextDraw(playerid);
	TextDrawHideForPlayer(playerid, boxlator[0]);
	TextDrawHideForPlayer(playerid, Line1);
	TextDrawHideForPlayer(playerid, Line2);
	TextDrawHideForPlayer(playerid, Line3);
	TextDrawHideForPlayer(playerid, Line4);
	TextDrawHideForPlayer(playerid, zahl1);
	TextDrawHideForPlayer(playerid, zahl2);
	TextDrawHideForPlayer(playerid, zahl3);
	TextDrawHideForPlayer(playerid, zahl4);
	TextDrawHideForPlayer(playerid, zahl5);
	TextDrawHideForPlayer(playerid, zahl6);
	TextDrawHideForPlayer(playerid, zahl7);
	TextDrawHideForPlayer(playerid, zahl8);
	TextDrawHideForPlayer(playerid, zahl9);
	TextDrawHideForPlayer(playerid, plus);
	TextDrawHideForPlayer(playerid, minus);
	TextDrawHideForPlayer(playerid, mal);
	TextDrawHideForPlayer(playerid, geteilt);
	TextDrawHideForPlayer(playerid, gleich);
	TextDrawHideForPlayer(playerid, rechnung);
	TextDrawHideForPlayer(playerid, ergebniss);
	PlayerTextDrawHide(playerid, neu[playerid][0]);
	TextDrawHideForPlayer(playerid, exxit);
	TextDrawHideForPlayer(playerid, Logo);
	for(new i = 0; i< sizeof(tdbox);i++)
	{
		TextDrawHideForPlayer(playerid, tdbox[i]);
	}
}

stock RefreshVModel(playerid)
{
	PlayerTextDrawSetPreviewModel(playerid, VModelTD[playerid], GetVehicleModel(GetPlayerVehicleID(playerid)));
	PlayerTextDrawShow(playerid, VModelTD[playerid]);
    return 1;
}

forward OnPlayerClickDynamicTextdraw(playerid, PlayerText:playertextid);
public OnPlayerClickDynamicTextdraw(playerid, PlayerText:playertextid)
{
    if(playertextid == neu[playerid][0])
	{
		TextDrawSetString(ergebniss, "");
		TextDrawShowForPlayer(playerid, ergebniss);
		TextDrawSetString(rechnung, "");
		TextDrawShowForPlayer(playerid, rechnung);
		rechi[playerid] = "";
		rrechnung[playerid] = 0;
		zahl[playerid] = "";
		azahl[playerid] = "";
	}
	return 1;
}

public OnPlayerSelectionMenuResponse(playerid, extraid, response, listitem, modelid)
{
	switch(extraid)
	{
	    case MODEL_SELECTION_Barricade:
	    {
	        if(response)
	        {
                static
				Float:fX,Float:fY,Float:fZ;
			
                new index;
                if((index = Barricade_Create(playerid, 2, modelid, "-")) != -1) 
                {
                    SendFactionMessage(pData[playerid][pFaction], COLOR_RADIO, "[SAPD Radio] %s(%d) %s: has dropped a roadblock at %s. ((ID %d))", GetFactionRank(playerid), pData[playerid][pFactionRank], ReturnName(playerid), GetLocation(fX, fY, fZ), index);
                    pData[playerid][pEditRoadblock] = index;
                    EditDynamicObject(playerid, BarricadeData[index][cadeObject]);
                }
                else 
                {
                    Error(playerid, "Roadblock sudah mencapai batas maksimal ("#MAX_DYNAMIC_ROADBLOCK" roadblock).");
                }
			}
	    }
		case SPAWN_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1744.3411, -1862.8655, 13.3983, 270.0000, 0, 0, 0, 0, 0, 0);
				SpawnPlayer(playerid);
				UpdatePlayerData(playerid);
			}
		}
		case SPAWN_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1744.3411, -1862.8655, 13.3983, 270.0000, 0, 0, 0, 0, 0, 0);
				SpawnPlayer(playerid);
				UpdatePlayerData(playerid);			}
		}
		case GOCAR_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case GOCAR_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
				
			}	
		}
		case SHOP_SKIN_MALE:
	    {
	        if(response)
	        {
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				GivePlayerMoneyEx(playerid, -price);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);

				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");	
		}	
		case SHOP_SKIN_FEMALE:
	    {
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				GivePlayerMoneyEx(playerid, -price);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);

				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");	
		}
		case VIP_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");
		}
		case VIP_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");
		}
		case SAPD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAPD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAPD_SKIN_WAR:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAPD_SKIN_03DL:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAGS_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAGS_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAMD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAMD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SANA_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SANA_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case TOYS_MODEL:
		{
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][1];
				
				GivePlayerMoneyEx(playerid, -price);
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
				pToys[playerid][pData[playerid][toySelected]][toy_status] = 1;
				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli object ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);

				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);
			}
			else 
				return Servers(playerid, "Canceled buy toys");
		}
		case VIPTOYS_MODEL:
		{
			if(response)
			{
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
				pToys[playerid][pData[playerid][toySelected]][toy_status] = 1;
				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengambil object ID %d dilocker.", ReturnName(playerid), modelid);
			}
			else
				return Servers(playerid, "Canceled toys");
		}
	}
	return 1;
}

public OnPlayerStatsUpdate(playerid)
{
    PacketReceived[playerid]++;
    return 1;
}

ptask AfkCheck[1000](playerid)  {
	new str[300];
    if(p_tick[playerid] > 0) {
        p_tick[playerid] = 0, p_afktime[playerid] = 0;
        return 1;
    }
    if(p_tick[playerid] == 0) {
        p_afktime[playerid]++;
    }
    /*if(p_afktime[playerid] > 0) {
        format(str, sizeof str,"[ATIP] %d Second(s)",p_afktime[playerid]);
        SetPlayerChatBubble(playerid, str, COLOR_YELLOW, 10.0, 1000);
    }*/
    new afk_minutes = ConvertUnixTime(p_afktime[playerid], CONVERT_TIME_TO_MINUTES);
	new afk_seconds = ConvertUnixTime(p_afktime[playerid]);

	if(afk_minutes > 0)
	{
		format(str, sizeof str, "[Melamun] %d:%02d Menit(s).", afk_minutes, afk_seconds);
	}
	else format(str, sizeof str, "[Melamun] %d Detik(s).", afk_seconds);
	SetPlayerChatBubble(playerid, str, COLOR_GREEN, 10.0, 1000);
    return 1;
}
stock ConvertUnixTime(unix_time, type = CONVERT_TIME_TO_SECONDS)
{
	switch(type)
	{
		case CONVERT_TIME_TO_SECONDS:
		{
			unix_time %= 60;
		}
		case CONVERT_TIME_TO_MINUTES:
		{
			unix_time = (unix_time / 60) % 60;
		}
		case CONVERT_TIME_TO_HOURS:
		{
			unix_time = (unix_time / 3600) % 24;
		}
		case CONVERT_TIME_TO_DAYS:
		{
			unix_time = (unix_time / 86400) % 30;
		}
		case CONVERT_TIME_TO_MONTHS:
		{
			unix_time = (unix_time / 2629743) % 12;
		}
		case CONVERT_TIME_TO_YEARS:
		{
			unix_time = (unix_time / 31556926) + 1970;
		}
		default:
			unix_time %= 60;
	}
	return unix_time;
}

IsGovCar(carid)
{
	for(new v = 0; v < sizeof(SAGSVehicles); v++)
	{
	    if(carid == SAGSVehicles[v]) return 1;
	}
	return 0;
}

IsSAPDCar(carid)
{
	foreach(new i : Player)
	{
		if(!IsPlayerConnected(i)) continue;
		//if(pData[i][pFaction] != SAPD) continue;
		if(pData[i][pSpawnPD] != carid) continue;

		return 1;
	}
	return 0;
}
IsSAMDCar(carid)
{
	foreach(new i : Player)
	{
		if(!IsPlayerConnected(i)) continue;
		//if(pData[i][pFaction] != SAMD) continue;
		if(pData[i][pSpawnMD] != carid) continue;

		return 1;
	}
	return 0;
}

IsSANACar(carid)
{
	for(new v = 0; v < sizeof(SANAVehicles); v++)
	{
	    if(carid == SANAVehicles[v]) return 1;
	}
	return 0;
}

// Fungsi untuk menangani ketika pemain mengklik ID pemain di tab list
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    if (source == CLICK_SOURCE_SCOREBOARD)
    {
        new otherid = clickedplayerid;

        if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

        // Menghitung packet loss sebagai persen
        new packetLoss = 0;
        if (PacketSent[otherid] > 0)
        {
            packetLoss = 100 - (PacketReceived[otherid] * 100 / PacketSent[otherid]);
        }

        Servers(playerid,"%s(ID: %d) (%s) - Ping: (%d) - Level: (%d) - Packet Loss: (%d%%)", pData[otherid][pName], otherid, pData[otherid][pUCP], GetPlayerPing(otherid), pData[otherid][pLevel], packetLoss);
    }
    return 1;
}

