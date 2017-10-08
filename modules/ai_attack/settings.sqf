
/*
Author:		Sacher

Mission Parameters:
See params.cpp for clear definition
https://community.bistudio.com/wiki/Arma_3_Mission_Parameters

4 Params are preset:
AIAttackStrength_Param
AIAttackSkill_Param
AIAttackCleanUp_Param
AIAttackPrepTime_Param

These are sqf variables so you can just use them like this:
["Attack1",["infpath1"],["Rus_MG"],east,5,8,AIAttackStrength_Param,AIAttackPrepTime_Param,180,AIAttackCleanUp_Param] call FNC_AtkRandomStart;
["Rus_Crew","rhs_msv_emr_armoredcrew","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;

For changes edit the params.cpp file
For adding additional custom parameters follow the same schema as the params.cpp file and the init.sqf at the bottom (Or consult Sacher).

How to Use:
Place down a unit and name it. Give him waypoints on how you want the ai to attack. Then register the path to the attack system use ["Path Identifier as String",unit which has the waypoints] call FNC_AtkRegisterPath;
On mission start the path will be cached and the ai unit deleted;

To register Ai units for spawning use ["Unit Identifier","Classname of unit to spawn","Olsen framework Gearscript name"] call FNC_AtkRegisterUnit;
You can register as many units and paths as you want but try to keep it low as it will increase computation and memory.

To start the attack use [paths as array,units as array,side of unit classname,min ammount of units to spawn,maxUnits to spawn,max ammount of units in field,delay from mission start,delay between spawns,should clean corpses] call FNC_AtkRandomStart;
Example: [["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],resistance,3,5,20,10,60,true] call FNC_AtkRandomStart;

Units will be spawned randomly at the first waypoint and then follow them.

//functions
Register Unit:
  Example: ["Ins_Rif","B_Soldier_F","Tal_AK47",1] call FNC_AtkRegisterUnit;
  [ident,classname,gearscript,skill] call FNC_AtkRegisterUnit;
  Params:
    ident - String - unique identifier for the Unit
    classname - String - classname of the unit to spawn
    gearscript -String - olsen framework gearscript identifier : "" for none
    skill - float(0,1) - skill level of unit

    Notes:  for standard west use     "B_Soldier_F"
            for standard guer use     "I_G_Soldier_F"
            for standard guer use     "O_G_Soldier_F"
    Do not mix standard classname side with the spawned side as they will shoot each other. Example which is wrong    B_Soldier_F and resistance. This will make shoot them each other;
    ["Ins_Rif","B_Soldier_F"] call FNC_AtkRegisterUnit; WRONG if used together
    [["path1"],["Ins_Rif"],resistance,3,5,20,10,60,true] call FNC_AtkRandomStart; WRONG if used together


Register Vehicle:
Example: ["BMP1","rhs_bmp1p_msv",["Ins_Rif","Ins_Rif","Ins_Rif"]]  call FNC_AtkRegisterVehicle;
[ident,classname,crew] call FNC_AtkRegisterVehicle;

Params:
ident - String - unique identifier for the Unit
classname - String - classname of the vehicle to spawn
crew - Array String - list of units registered with FNC_AtkRegisterUnit


Register Path:
  Example: ["path1",inf1] call FNC_AtkRegisterPath;
  [ident,groupLeader] call FNC_AtkRegisterPath;
  Params:

  ident - String - unique identifier for the Path
  groupLeader - unit - groupleader of the group with waypoints

  Start Attack:
      Example: ["Attack1",["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],["BMP1"],resistance,3,5,10,60,true] call FNC_AtkStart;
      [ident,paths,units,side,minSpawn,maxSpawn,delay,spawnDelay,cleanUp] call FNC_AtkRandomStart;
      Params:
        ident - String - identifier for attack so you can stop it
        paths - Array String - unqie identifer on where the units should move
        units - Array String - unique identifier of units to spawn
        vehicles - Array String - unique identifier of units to spawn
        side  - Side - side of the units spawned
        minSpawn - integer - min ammount of groups spawned
        maxSpawn - integer - max ammount of groups spawned
        delay - integer - delay from mission start till spawning
        spawnDelay - integer - delay between each spawning
        cleanUp - bool - true if bodies should be removed
      Notes: Don't turn off cleanup or you will make people sad

Start Random Attack:
    Example: ["Attack1",["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],["BMP1"],resistance,3,5,20,10,60,true] call FNC_AtkRandomStart;
    [ident,paths,units,side,minSpawn,maxSpawn,maxUnits,delay,spawnDelay,cleanUp] call FNC_AtkRandomStart;
    Params:
      ident - String - identifier for attack so you can stop it
      paths - Array String - unqie identifer on where the units should move
      units - Array String - unique identifier of units to spawn
      vehicles - Array String - unique identifier of units to spawn
      side  - Side - side of the units spawned
      minSpawn - integer - min ammount of units spawned on a path
      maxSpawn - integer - max ammount of units spawned on a path
      maxUnits - integer - max ammount of units spawned on all paths together
      delay - integer - delay from mission start till spawning
      spawnDelay - integer - delay between each spawning
      cleanUp - bool - true if bodies should be removed
    Notes: Don't turn off cleanup or you will make people sad

StartVehicleAttack:
Example: ["VehicleAttack1",["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],["BMP1"],resistance,3,5,20,10,60,true] call FNC_AtkVehicleStart;
[ident,paths,vehicles,side,minSpawn,maxSpawn,delay,spawnDelay,cleanUp] call FNC_AtkVehicleStart;
Params:
  ident - String - identifier for attack so you can stop it
  paths - Array String - unqie identifer on where the units should move
  vehicles - Array String - unique identifier of vehicles to spawn
  side  - Side - side of the units spawned
  minSpawn - integer - min ammount of vehicles spawned in wave
  maxSpawn - integer - max ammount of vehicles spawned in wave
  delay - integer - delay from mission start till spawning
  spawnDelay - integer - delay between each spawning
  cleanUp - bool - true if bodies should be removed

//Example
["infpath1",inf1] call FNC_AtkRegisterPath;
["infpath2",inf2] call FNC_AtkRegisterPath;
["infpath3",inf3] call FNC_AtkRegisterPath;
["infpath4",inf4] call FNC_AtkRegisterPath;
["infpath5",inf5] call FNC_AtkRegisterPath;
["infpath6",inf6] call FNC_AtkRegisterPath;
["infpath7",inf7] call FNC_AtkRegisterPath;

["vehpath1",veh1] call FNC_AtkRegisterPath;
["vehpath2",veh2] call FNC_AtkRegisterPath;
["vehpath3",veh3] call FNC_AtkRegisterPath;
["vehpath4",veh4] call FNC_AtkRegisterPath;


["Rus_Rif","rhs_msv_emr_RShG2","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;
["Rus_Gren","rhs_msv_emr_grenadier","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;
["Rus_At","rhs_msv_emr_at","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;
["Rus_Rif2","rhs_msv_emr_arifleman","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;
["Rus_RPG","rhs_msv_emr_grenadier_rpg","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;
["Rus_MG","rhs_msv_emr_machinegunner","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;
["Rus_Crew","rhs_msv_emr_armoredcrew","",AIAttackSkill_Param] call FNC_AtkRegisterUnit;


["BMP1","rhs_bmp1p_msv",["Rus_Crew","Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["BTR70","rhs_btr70_msv",["Rus_Crew","Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["BTR80","rhs_btr80_msv",["Rus_Crew","Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["GAZZU23","rhs_gaz66_zu23_msv",["Rus_Crew","Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["BRDM2","rhsgref_BRDM2_msv",["Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["URALZU23","RHS_Ural_Zu23_MSV_01",["Rus_Crew","Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["UAZDS","rhsgref_cdf_reg_uaz_dshkm",["Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;
["UAZSPG","rhsgref_cdf_reg_uaz_spg9",["Rus_Crew","Rus_Crew"]]  call FNC_AtkRegisterVehicle;

["Attack1",["infpath1","infpath2","infpath3","infpath4","infpath5","infpath6","infpath7"],["Rus_Rif","Rus_Gren","Rus_At","Rus_Rif2","Rus_RPG","Rus_MG"],east,5,8,AIAttackStrength_Param,AIAttackPrepTime_Param * 60,180,AIAttackCleanUp_Param] call FNC_AtkRandomStart;
["VehicleAttack1",["vehpath1","vehpath2","vehpath3","vehpath4"],["BMP1","BTR70","BTR80","GAZZU23","BRDM2","URALZU23","UAZDS","UAZSPG"],east,2,5,(AIAttackPrepTime_Param * 1.5) * 60,360,AIAttackCleanUp_Param] call FNC_AtkVehicleStart;

//extend the timelimit because variable prep time
FW_TimeLimit = FW_TimeLimit + AIAttackPrepTime_Param;




*/
