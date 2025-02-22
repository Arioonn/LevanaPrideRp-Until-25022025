//======== Pizza ===========
#define pizzapoint1		2362.84, -1643.14, 14.35
#define pizzapoint2		2451.98, -1641.40, 14.06
#define pizzapoint3		2498.52, -1642.25, 14.11
#define pizzapoint4		2524.70, -1658.48, 15.82
#define pizzapoint5		2402.49, -1714.94, 14.13
#define pizzapoint6		2326.87, -1716.70, 14.23
#define pizzapoint7		2309.01, -1714.70, 14.64
#define pizzapoint8		2229.91, -1721.26, 13.56
#define pizzapoint9		2139.14, -1697.50, 15.08
#define pizzapoint10	2112.99, -1778.69, 13.39

new PizzaVeh[4];

AddPizzaVehicle()
{
	PizzaVeh[0] = CreateVehicle(448, 2113.4700,-1784.5083,12.9872, 355.4538, 3, 3, VEHICLE_RESPAWN);
	PizzaVeh[1] = CreateVehicle(448, 2117.5247,-1784.9316,12.9872, 1.1392, 3, 3, VEHICLE_RESPAWN);
	PizzaVeh[2] = CreateVehicle(448, 2120.4673,-1784.8541,12.9858, 358.8643,3, 3, VEHICLE_RESPAWN);
	PizzaVeh[3] = CreateVehicle(448, 2123.2676,-1784.8853,12.9871, 356.8564,-3, 3, VEHICLE_RESPAWN);
}

IsAPizzaVeh(carid)
{
	for(new v = 0; v < sizeof(PizzaVeh); v++) {
	    if(carid == PizzaVeh[v]) return 1;
	}
	return 0;
}