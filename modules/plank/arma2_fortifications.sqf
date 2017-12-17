// These are the available fortifications. Add or take as you wish.

// Action text	  - The text displayed by the action.
// Classname		- The classname of the object to be placed.
// Distance		 - Minimum distance of the object from the player, in metres.
// Direction		- Direction the object will be rotated initially, in degrees (minimum 0, maximum 360).
// Direction range  - The range you can turn the object, in degrees (minimum 0, maximum 360).
//					This means that the player will be able to set the direction of the object between `direction - direction_range / 2` and `direction + direction_range / 2` degrees.
//					For example given 180 direction and 60 direction range, player will be able turn the object between 150 and 210 degrees.
// Code			 - A piece of code that will be executed when the object placement is confirmed.
//					Set it to {}, if you don't want to use it. The unit who confirmed the placement and the object placed, are passed as arguments to the code.
//					An example code that hints the players name could look like {hint str (_this select 0);}.

plank_deploy_fortData = [

// Action text					  |  Classname							|  Distance	 |  Direction	 |  Direction Range  |  Code
//--------------------------------------------------------------------------------------------------------------------------------------
["Small bunker",						"Land_fortified_nest_small",			6,			  180,				360,			{}],
["Bunker",							  "Land_fortified_nest_big_EP1",		  8.5,			180,				60,			 {}],
["Wide Sandbag fence",				  "Land_fort_bagfence_long",			  4,			  0,				  360,			{}],
["Wide Sandbag half circle fence",	  "Land_fort_bagfence_round",			 7,			  0,				  360,			{}],
["Narrow Sandbag fence",				"Land_BagFenceLong",					3,			  0,				  360,			{}],
["Razor Wire",						  "Fort_RazorWire",					   6,			  0,				  360,			{}],
["Rampart",							 "Land_fort_rampart_EP1",				8,			  0,				  360,			{}],
["Artillery Nest",					  "Land_fort_artillery_nest",			 6,			  0,				  60,			 {}]

];