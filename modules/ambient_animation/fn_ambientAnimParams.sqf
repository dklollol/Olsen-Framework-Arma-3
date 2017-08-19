/*
	Author: Jiri Wainar
	Modified: TinfoilHate

	Description:
	Feeds params of given animset to ambientAnimMonitor.
*/

if (_this == "") exitWith {[]};

private["_azimutFix","_attachSnap","_attachOffset","_noBackpack","_noWeapon","_randomGear","_canInterpolate","_anims"];

//defaults
_azimutFix 	= 0;				//unit direction adjustment; some anims can be wrongly configured
_attachSnap 	= 0.75;
_attachOffset 	= 0;
_noBackpack 	= false;
_noWeapon 	= false;
_randomGear 	= ["MEDIUM","MEDIUM","LIGHT"];
_canInterpolate = false;

//setup ambient animations
switch (_this) do
{
	/*------------------------------------------------------------------------------------------

		STANDING

	------------------------------------------------------------------------------------------*/

	//generic standing with weapon
	case "STAND";
	case "STAND1":
	{
		_anims 	= ["HubStanding_idle1","HubStanding_idle2","HubStanding_idle3"];
		_canInterpolate = true;
	};

	case "STAND_IA";
	case "STAND2":
	{
		_anims 	=
		[
			"amovpercmstpslowwrfldnon",
			"amovpercmstpslowwrfldnon",
			"aidlpercmstpslowwrfldnon_g01",
			"aidlpercmstpslowwrfldnon_g02",
			"aidlpercmstpslowwrfldnon_g03",
			"aidlpercmstpslowwrfldnon_g05"
		];
		_canInterpolate = true;
	};

	//generic standing without weapon
	case "STAND_U1":
	{
		_anims 	= ["HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3","HubStandingUA_move1","HubStandingUA_move2"];
		_noWeapon = true;
	};
	case "STAND_U2":
	{
		_anims 	= ["HubStandingUB_idle1","HubStandingUB_idle2","HubStandingUB_idle3","HubStandingUB_move1"];
		_noWeapon = true;
		_randomGear = ["MEDIUM","MEDIUM","FULL"];
	};
	case "STAND_U3":
	{
		_anims 	= ["HubStandingUC_idle1","HubStandingUC_idle2","HubStandingUC_idle3","HubStandingUC_move1","HubStandingUC_move2"];
		_noWeapon = true;
	};


	//on watch, turning and looking around
	case "WATCH";
	case "WATCH1":
	{
		_anims = ["inbasemoves_patrolling1"];
		_randomGear = ["MEDIUM","FULL","FULL"];
		_canInterpolate = true;
	};
	case "WATCH2":
	{
		_anims = ["inbasemoves_patrolling2"];
		_randomGear = ["MEDIUM","FULL","FULL"];
		_canInterpolate = true;
	};

	//on guard, hands behind back
	case "GUARD":
	{
		_anims = ["inbasemoves_handsbehindback1","inbasemoves_handsbehindback2"];
		_randomGear = ["MEDIUM","MEDIUM","FULL"];
		_noBackpack = true;
		_noWeapon = true;
	};

	//hands behind back
	case "LISTEN_BRIEFING":
	{
		_anims = ["unaercposlechvelitele1","unaercposlechvelitele2","unaercposlechvelitele3","unaercposlechvelitele4"];
		_noWeapon = true;
		_noBackpack = true;
	};

	//leaning
	case "LEAN_ON_TABLE":
	{
		_anims = ["inbasemoves_table1"];
		_attachOffset = -0.8;
		_attachSnap = 2;
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","NONE","NONE","LIGHT","LIGHT","MEDIUM"];
	};
	case "LEAN":
	{
		_azimutFix = -45;
		_anims = ["inbasemoves_lean1"];
		_attachSnap = 2;
		_noBackpack = true;
	};

	/*------------------------------------------------------------------------------------------

		SITTING

	------------------------------------------------------------------------------------------*/

	//sitting @ table
	case "SIT_AT_TABLE":
	{
		_anims = ["HubSittingAtTableU_idle1","HubSittingAtTableU_idle2","HubSittingAtTableU_idle3"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
		_noWeapon = true;
	};

	//sitting with weapon
	// -"- ... rifle between legs
	case "SIT1":
	{
		_anims = ["HubSittingChairA_idle1","HubSittingChairA_idle2","HubSittingChairA_idle3","HubSittingChairA_move1"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
	};
	// -"- ... rifle rested on legs
	case "SIT";
	case "SIT2":
	{
		_anims = ["HubSittingChairB_idle1","HubSittingChairB_idle2","HubSittingChairB_idle3","HubSittingChairB_move1"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
	};
	// -"- ... relaxed
	case "SIT3":
	{
		_anims = ["HubSittingChairC_idle1","HubSittingChairC_idle2","HubSittingChairC_idle3","HubSittingChairC_move1"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
	};

	//sitting without weapon
	case "SIT_U1":
	{
		_anims = ["HubSittingChairUA_idle1","HubSittingChairUA_idle2","HubSittingChairUA_idle3","HubSittingChairUA_move1"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
		_noWeapon = true;
	};
	case "SIT_U2":
	{
		_anims = ["HubSittingChairUB_idle1","HubSittingChairUB_idle2","HubSittingChairUB_idle3","HubSittingChairUB_move1"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
		_noWeapon = true;
	};
	case "SIT_U3":
	{
		_anims = ["HubSittingChairUC_idle1","HubSittingChairUC_idle2","HubSittingChairUC_idle3","HubSittingChairUC_move1"];
		_attachOffset = -0.5;
		_attachSnap = 2;
		_noBackpack = true;
		_noWeapon = true;
	};

	//todo: fix params
	//sitting on high object like h-barrier or wall
	case "SIT_HIGH1":
	{
		_anims = ["HubSittingHighA_idle1"];
		_attachOffset = -0.60;
		_attachSnap = 2;
		_azimutFix = 140;
	};
	case "SIT_HIGH";
	case "SIT_HIGH2":
	{
		_anims = ["HubSittingHighB_move1"/*,"HubSittingHighB_idle1","HubSittingHighB_idle2","HubSittingHighB_idle3"*/];
		_attachOffset = -0.9;
		_attachSnap = 1.5;
		_azimutFix = -20;
	};

	//sitting on ground with weapon
	case "SIT_LOW":
	{
		_anims = ["amovpsitmstpslowwrfldnon","amovpsitmstpslowwrfldnon_smoking","amovpsitmstpslowwrfldnon_weaponcheck1","amovpsitmstpslowwrfldnon_weaponcheck2"];
		_canInterpolate = true;
	};

	//sitting on ground without weapon
	case "SIT_LOW_U":
	{
		_anims = ["aidlpsitmstpsnonwnondnon_ground00","amovpsitmstpsnonwnondnon_ground"];
		_noWeapon = true;
		_noBackpack = true;
	};

	//sitting, looking sad and nervous
	case "SIT_SAD1":
	{
		_anims = ["c5efe_michalloop"];
		_attachOffset = -0.5;
		_attachSnap = 2;
	};
	case "SIT_SAD2":
	{
		_anims = ["c5efe_honzaloop"];
		_attachOffset = -0.5;
		_attachSnap = 2;
	};

	/*------------------------------------------------------------------------------------------

		KNEEL

	------------------------------------------------------------------------------------------*/

	case "KNEEL":
	{
		_anims = ["amovpknlmstpslowwrfldnon","aidlpknlmstpslowwrfldnon_ai","aidlpknlmstpslowwrfldnon_g01","aidlpknlmstpslowwrfldnon_g02","aidlpknlmstpslowwrfldnon_g03","aidlpknlmstpslowwrfldnon_g0s"];
		_canInterpolate = true;
	};

	/*------------------------------------------------------------------------------------------

		FIXING VEHICLE

	------------------------------------------------------------------------------------------*/

	//repairing vehicle
	case "REPAIR_VEH_PRONE":
	{
		_anims = ["hubfixingvehicleprone_idle1"];
		_azimutFix = 180;
		_attachSnap = 2;
		_noBackpack = true;
		_noWeapon = true;
		_randomGear = ["NONE"];
	};
	case "REPAIR_VEH_KNEEL":
	{
		_anims = ["inbasemoves_repairvehicleknl"];
		_attachSnap = 2;
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","LIGHT"];
	};
	case "REPAIR_VEH_STAND":
	{
		_anims = ["inbasemoves_assemblingvehicleerc"];
		_attachSnap = 2;
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","LIGHT"];
	};

	/*------------------------------------------------------------------------------------------

		WOUNDED

	------------------------------------------------------------------------------------------*/

	//prone, wounded, unarmed
	case "PRONE_INJURED_U1":
	{
		_anims = ["ainjppnemstpsnonwnondnon"];
		_azimutFix = 180;
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["MEDIUM"];
	};
	case "PRONE_INJURED_U2":
	{
		_anims = ["hubwoundedprone_idle1","hubwoundedprone_idle2"];
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["MEDIUM"];
	};

	//prone, wounded, weapon lying on ground
	case "PRONE_INJURED":
	{
		_anims = ["acts_injuredangryrifle01","acts_injuredcoughrifle02","acts_injuredlookingrifle01","acts_injuredlookingrifle02","acts_injuredlookingrifle03","acts_injuredlookingrifle04","acts_injuredlookingrifle05","acts_injuredlyingrifle01"];
		_noBackpack = true;
		_randomGear = ["MEDIUM"];
	};

	//kneeling, treating wounded soldier lying on ground
	case "KNEEL_TREAT":
	{
		_anims = ["ainvpknlmstpsnonwnondnon_medic","ainvpknlmstpsnonwnondnon_medic0","ainvpknlmstpsnonwnondnon_medic1","ainvpknlmstpsnonwnondnon_medic2","ainvpknlmstpsnonwnondnon_medic3","ainvpknlmstpsnonwnondnon_medic4","ainvpknlmstpsnonwnondnon_medic5"];
		_noWeapon = true;
		_randomGear = ["MEDIUM"];
	};

	case "KNEEL_TREAT2":
	{
		_anims = ["acts_treatingwounded01","acts_treatingwounded02","acts_treatingwounded03","acts_treatingwounded04","acts_treatingwounded05","acts_treatingwounded06"];
		_noWeapon = true;
		_randomGear = ["MEDIUM"];
	};

	/*------------------------------------------------------------------------------------------

		BRIEFING

	------------------------------------------------------------------------------------------*/

	//generic ambient briefing loop with occasional random moves
	case "BRIEFING":
	{
		_anims = ["hubbriefing_loop","hubbriefing_loop","hubbriefing_loop","hubbriefing_lookaround1","hubbriefing_lookaround2","hubbriefing_scratch","hubbriefing_stretch","hubbriefing_talkaround"];
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","NONE","NONE","LIGHT","LIGHT","MEDIUM"];
	};
	case "BRIEFING_POINT_LEFT":
	{
		_anims = ["hubbriefing_loop","hubbriefing_loop","hubbriefing_loop","hubbriefing_lookaround1","hubbriefing_lookaround2","hubbriefing_pointleft","hubbriefing_scratch","hubbriefing_stretch","hubbriefing_talkaround"];
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","NONE","NONE","LIGHT","LIGHT","MEDIUM"];
	};
	case "BRIEFING_POINT_RIGHT":
	{
		_anims = ["hubbriefing_loop","hubbriefing_loop","hubbriefing_loop","hubbriefing_lookaround1","hubbriefing_lookaround2","hubbriefing_pointright","hubbriefing_scratch","hubbriefing_stretch","hubbriefing_talkaround"];
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","NONE","NONE","LIGHT","LIGHT","MEDIUM"];
	};
	case "BRIEFING_POINT_TABLE":
	{
		_anims = ["hubbriefing_loop","hubbriefing_loop","hubbriefing_loop","hubbriefing_lookaround1","hubbriefing_lookaround2","hubbriefing_pointattable","hubbriefing_scratch","hubbriefing_stretch","hubbriefing_talkaround"];
		_noWeapon = true;
		_noBackpack = true;
		_randomGear = ["NONE","NONE","NONE","LIGHT","LIGHT","MEDIUM"];
	};

	default
	{
		["Animation set not recognized!",_unit,_animset] call BIS_fnc_error;

		_anims = [];
	};
};

//convert all anims to lowercase
{
	_anims set [_forEachIndex,toLower _x];
}
forEach _anims;

[_anims,_azimutFix,_attachSnap,_attachOffset,_noBackpack,_noWeapon,_randomGear,_canInterpolate]