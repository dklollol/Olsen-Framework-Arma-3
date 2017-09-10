

/*
Author:		Sacher
How to Use:
Place down a unit and name it. Give him waypoints on how you want the ai to attack. Then register the path to the attack system use ["Path Identifier as String",unit which has the waypoints] call FNC_AtkRegisterPath;
On mission start the path will be cached and the ai unit deleted;

To register Ai units for spawning use ["Unit Identifier","Classname of unit to spawn","Olsen framework Gearscript name"] call FNC_AtkRegisterUnit;
You can register as many units and paths as you want but try to keep it low as it will increase computation and memory.

To start the attack use [paths as array,units as array,side of unit classname,min ammount of units to spawn,maxUnits to spawn,max ammount of units in field,delay from mission start,delay between spawns,should clean corpses] call FNC_AtkStart;
Example: [["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],resistance,3,5,20,10,60,true] call FNC_AtkStart;

Units will be spawned randomly at the first waypoint and then follow them.

//functions
Register Unit:
  Example: ["Ins_Rif","B_Soldier_F"] call FNC_AtkRegisterUnit;
  [ident,classname,gearscript] call FNC_AtkRegisterUnit;
  Params:
    ident - String - unique identifier for the Unit
    classname - String - classname of the unit to spawn
    gearscript -String - olsen framework gearscript identifier

    Notes:  for standard west use     "B_Soldier_F"
            for standard guer use     "I_G_Soldier_F"
            for standard guer use     "O_G_Soldier_F"
    Do not mix standard classname side with the spawned side as they will shoot each other. Example which is wrong    B_Soldier_F and resistance. This will make shoot them each other;
    ["Ins_Rif","B_Soldier_F"] call FNC_AtkRegisterUnit; WRONG if used together
    [["path1"],["Ins_Rif"],resistance,3,5,20,10,60,true] call FNC_AtkStart; WRONG if used together




Register Path:
  Example: ["path1",inf1] call FNC_AtkRegisterPath;
  [ident,groupLeader] call FNC_AtkRegisterPath;
  Params:

  ident - String - unique identifier for the Path
  groupLeader - unit - groupleader of the group with waypoints

Start Attack:
    Example: [["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],resistance,3,5,20,10,60,true] call FNC_AtkStart;
    [paths,units,side,minSpawn,maxSpawn,maxUnits,delay,spawnDelay,cleanUp] call FNC_AtkStart;
    Params:
      paths - Array String - unqie identifer on where the units should move
      units - Array String - unique identifier of units to spawn
      side  - Side - side of the units spawned
      minSpawn - integer - min ammount of units spawned on a path
      maxSpawn - integer - max ammount of units spawned on a path
      maxUnits - integer - max ammount of units spawned on all paths together
      delay - integer - delay from mission start till spawning
      spawnDelay - integer - delay between each spawning
      cleanUp - bool - true if bodies should be removed
    Notes: Don't turn off cleanup or you will make people sad

//Example
["path1",inf1] call FNC_AtkRegisterPath;
["path2",inf2] call FNC_AtkRegisterPath;
["path3",inf3] call FNC_AtkRegisterPath;


["Ins_Rif","rhsgref_nat_rifleman"] call FNC_AtkRegisterUnit;
[["path1","path2","path3"],["Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif","Ins_Rif"],resistance,3,5,20,10,60,true] call FNC_AtkStart;




*/
