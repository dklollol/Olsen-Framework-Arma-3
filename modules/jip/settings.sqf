//This module allows people who join in progress to teleport to their squad members.

//JIPDENYTIME
//After how many seconds should a player be considered JIP (this only applies if you are using JIPTYPE "DENY").
FW_JIPDENYTIME = 300;

switch (side player) do {

	case west: {
		//JIPTYPE
		//How should JIPs be handled, options are: DENY: Player is killed and put in spectator. TELEPORT: Player can teleport to his squad. TRANSPORT: Player can send a hint to all group leaders requesting transport.
		FW_JIPTYPE = "TELEPORT";

		//JIPDISTANCE
		//When you spawn, if your squad members are more then JIPDISTANCE away, you get the option to teleport or request transport.
		FW_JIPDISTANCE = 50;

		//SPAWNDISTANCE
		//If you move SPAWNDISTANCE away from your spawn position you loose the option to teleport or request transport.
		FW_SPAWNDISTANCE = 200;
	};

	case east: {
		//JIPTYPE
		//How should JIPs be handled, options are: DENY: Player is killed and put in spectator. TELEPORT: Player can teleport to his squad. TRANSPORT: Player can send a hint to all group leaders requesting transport.
		FW_JIPTYPE = "TELEPORT";

		//JIPDISTANCE
		//When you spawn, if your squad members are more then JIPDISTANCE away, you get the option to teleport or request transport.
		FW_JIPDISTANCE = 50;

		//SPAWNDISTANCE
		//If you move SPAWNDISTANCE away from your spawn position you loose the option to teleport or request transport.
		FW_SPAWNDISTANCE = 200;
	};

	case independent: {
		//JIPTYPE
		//How should JIPs be handled, options are: DENY: Player is killed and put in spectator. TELEPORT: Player can teleport to his squad. TRANSPORT: Player can send a hint to all group leaders requesting transport.
		FW_JIPTYPE = "TELEPORT";

		//JIPDISTANCE
		//When you spawn, if your squad members are more then JIPDISTANCE away, you get the option to teleport or request transport.
		FW_JIPDISTANCE = 50;

		//SPAWNDISTANCE
		//If you move SPAWNDISTANCE away from your spawn position you loose the option to teleport or request transport.
		FW_SPAWNDISTANCE = 200;
	};
    
    	case civilian: {
		//JIPTYPE
		//How should JIPs be handled, options are: DENY: Player is killed and put in spectator. TELEPORT: Player can teleport to his squad. TRANSPORT: Player can send a hint to all group leaders requesting transport.
		FW_JIPTYPE = "TELEPORT";

		//JIPDISTANCE
		//When you spawn, if your squad members are more then JIPDISTANCE away, you get the option to teleport or request transport.
		FW_JIPDISTANCE = 50;

		//SPAWNDISTANCE
		//If you move SPAWNDISTANCE away from your spawn position you loose the option to teleport or request transport.
		FW_SPAWNDISTANCE = 200;
	};

};