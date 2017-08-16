//This module shares target information between AI groups based on their radios.
//Written by TinfoilHate
//Updated: June 06, 2017
//
//The script shares target information regarding playableUnits using knowsAbout if tin_aiLink_needRadio is false, or if both units have long or short range radios.


	tin_aiLink_startDelay 	= 30;		//Delay in seconds when starting the mission until the first loop runs.
	tin_aiLink_shareDelay	= 15;		//Delay in seconds  between loops after the first.
	tin_aiLink_transDelay	= 10;		//Delay in seconds, maximum randomized, for target information to be transmitted. No effect if set higher than tin_aiLink_shareDelay.

	tin_aiLink_longRange 	= 800;		//Range if both groups have long-range radios, also used if tin_aiLink_needRadio is false.
	tin_aiLink_shortRange 	= 400;		//Range if both groups have short-range radios.

	tin_aiLink_needRadio	= false;	//Controls if both AI groups need radios. If false, it will work regardless of radios. Will also perform somewhat better.
	tin_aiLink_maxKnows		= 3.5;		//The maximum amount that knowsAbout will be set to via this script.
	
	tin_aiLink_debug 		= false;	//Debug Information; Very spammy.	