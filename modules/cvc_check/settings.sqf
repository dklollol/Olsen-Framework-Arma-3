//Author:		TinfoilHate
//
//Description: 	Checks if the unit is the pilot or copilot of a tank or APC,
//				and swaps their hat for a CVC while retaining the original
//				headgear class, and swaps it back when they exit or go to cargo.
//
//Comments: 	Assigned to individual units, not the vehicles. UNIT need only
//				be the unit the EH is local to, and CVC is the class of the
//				CVC to add.
//
//Syntax:		[UNIT,CVC CLASS] call FNC_CVCCHECK;
//Example: 		[player, "rhsusf_cvc_green_helmet"] call FNC_CVCCHECK;

//West CVC Class
#define WESTCVC "rhsusf_cvc_green_alt_helmet"

//East CVC Class
#define EASTCVC "RHS_TSH4_ESS"

//Resistance CVC Class
#define GUERCVC "rhsusf_cvc_green_alt_helmet"

//Civilian CVC Class
#define CIVCVC "rhsusf_cvc_green_alt_helmet"

//AI Units to Handle [GUY1,GUY2,..] (Optional)
#define AIUNITLIST [];