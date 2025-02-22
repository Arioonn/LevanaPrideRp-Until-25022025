#define MAX_DOOR_BASEMENT 100
enum doorbasement
{
	dbID,
    dbName[52],
	dbExtvw,
	dbExtint,
	Float:dbExtInPos[4],
    Float:dbExtOutPos[4],
	dbIntvw,
	dbIntint,
	Float:dbIntInPos[4],
    Float:dbIntOutPos[4],
	//NotSave
	Text3D:dbLabelext,
	dbPickupext,
	dbCP[2]
};

new Basement[MAX_DOOR_BASEMENT][doorbasement],
	Iterator:DoorBasement<MAX_DOOR_BASEMENT>;