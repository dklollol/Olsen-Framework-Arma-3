deadbody = (player getVariable "FW_Body");

setAperture -1;
sleep 1;
camera = "camconstruct" camcreate [(getPos deadbody select 0), (getPos deadbody select 1), (getPos deadbody select 2)];
camera camConstuctionSetParams [getPos deadbody, 20000, 10000];
camera setpos [((position deadbody) select 0) + ((sin (getdir deadbody)) * ( - 10)), ((position deadbody) select 1) + ((cos (getdir deadbody)) * (- 10)), ((position deadbody) select 2) + 2];
camera setdir getdir deadbody;
camera cameraeffect ["internal","back"];

call BIS_fnc_VRFadeIn;

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [6];
"dynamicBlur" ppEffectCommit 0;

"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 5;

oldPos = position camera;
oldDir = getdir camera;

viewMode = 0;

targets = [];

{
	if (!(_x getVariable "FW_Dead")) then {
	
		targets set [count targets, _x];
		
	}
	
} forEach playableUnits;

selection = 0;

maxIndex = count targets - 1;

target = deadbody;

thirdPerson = true;
mapOn = false;

_keyDown_camConstruct = (finddisplay 12) displayaddeventhandler ["keydown", "

	if ((_this select 1) == 1 && mapOn) then {
	
		forceMap false;
		
		if (thirdPerson) then {
			
			camera cameraeffect ['internal', 'back'];
			camera setpos oldPos;
			camera setdir oldDir;
			
		} else {
			
			_target = (vehicle (targets select selection));
		
			if (!(count targets > 0)) then {

				_target = deadbody;
				
			};
			
			camera cameraeffect ['Terminate', 'back'];
			_target switchCamera 'EXTERNAL';
			
		};
		
		mapOn = false;
		
	};
"];

_keyDown_camConstruct = (finddisplay 46) displayaddeventhandler ["MouseButtonDown", "

	if (((_this select 1) == 0) && (!thirdPerson) && !mapOn) then {
	
		camera cameraeffect ['internal', 'back'];
		camera setpos [((position target) select 0) + ((sin (getdir target)) * ( - 10)), ((position target) select 1) + ((cos (getdir target)) * (- 10)), ((position target) select 2) + 2];
		camera setdir getdir target;
		
		if (target == deadbody) then {
			
			cutText ['Your body', 'PLAIN DOWN'];
			
		} else {
		
			cutText [format ['%1', name target], 'PLAIN DOWN'];
		
		};
		
		thirdPerson = true;
		
	};
"];
	
_keyDown_switchCamera = (finddisplay 46) displayaddeventhandler ["MouseButtonDown", "

	if (((_this select 1) == 1) && thirdPerson && !mapOn) then {
			
		if (target == deadbody) then {
			
			camera cameraeffect ['internal', 'back'];
			camera setpos [((position target) select 0) + ((sin (getdir target)) * ( - 10)), ((position target) select 1) + ((cos (getdir target)) * (- 10)), ((position target) select 2) + 2];
			camera setdir getdir target;
			
			cutText ['Your body', 'PLAIN DOWN'];
			
		} else {
		
			camera cameraeffect ['Terminate', 'back'];
			target switchCamera 'EXTERNAL';
			
			cutText [format ['%1', name target], 'PLAIN DOWN'];
		
			thirdPerson = false;
			
		};		
	};
"];

_keyDown_showMap = (finddisplay 46) displayaddeventhandler ["keydown", "

	if ((_this select 1) in (actionkeys 'ShowMap')) then {
	
		if (!mapOn) then {
		
			if (visibleMap) then {
			
				forceMap false;
				
			};
			
			oldPos = position camera;
			oldDir = getdir camera;
			camera cameraeffect ['Terminate', 'back'];
			player switchCamera 'EXTERNAL';
			
			openMap true;
			mapOn = true;
			
			if (thirdPerson) then {
			
				mapAnimAdd [0, 0.5, oldPos];
			
			} else {
			
				mapAnimAdd [0, 0.5, getPos target];
				
			};
			
			mapAnimCommit;
			
		} else {
		
			forceMap false;
			
			if (thirdPerson) then {
				
				camera cameraeffect ['internal', 'back'];
				camera setpos oldPos;
				camera setdir oldDir;
				
			} else {
				
				_target = (vehicle (targets select selection));
			
				if (!(count targets > 0)) then {

					_target = deadbody;
					
				};
				
				camera cameraeffect ['Terminate', 'back'];
				_target switchCamera 'EXTERNAL';
				
			};
			
			mapOn = false;
		
		};

	};
"];

_keyDown_nightVision = (finddisplay 46) displayaddeventhandler ["keydown", "

	if ((_this select 1) in (actionkeys 'NightVision')) then {
	
		switch (viewMode) do {
		
			case 0: {
			
				camUseNVG true;
				
			};
			
			case 1: {
			
				camUseNVG false;
				true setCamUseTi 0;
				
			};
			
			case 2: {
			
				false setCamUseTi 0;
				true setCamUseTi 1;
				
			};
			
			case 3: {
			
				false setCamUseTi 1;
				
			};
		};
		
		viewMode = viewMode + 1;
		
		if (viewMode > 3) then {
		
			viewMode = 0;
			
		};
	};
"];

_keydown_mouseZ = (findDisplay 46) displayAddEventHandler ["mousezchanged", "

	if (!mapOn) then {

		if (count targets > 0) then {
		
			_z = _this select 1;
			
			if (_z  < 0) then {
			
				selection = selection - 1;
				
				if (selection < 0) then {
				
					selection = maxIndex;
					
				};
				
			} else {
			
				selection = selection + 1;
				
				if (selection > maxIndex) then {
				
					selection = 0;
					
				};
			};
			
			target = vehicle (targets select selection);
			
		} else {
		
			target = deadbody;
			
		};
		
		if (thirdPerson) then {
			
			camera setpos [((position target) select 0) + ((sin (getdir target)) * ( - 10)), ((position target) select 1) + ((cos (getdir target)) * (- 10)), ((position target) select 2) + 2];
			camera setdir getdir target;
			
		} else {
		
			target switchCamera 'EXTERNAL';
			
		};
		
		if (target == deadbody) then {
			
			cutText ['Your body', 'PLAIN DOWN'];
			
		} else {
		
			cutText [format ['%1', name target], 'PLAIN DOWN'];
		
		};
		
	};
"];

while {(player getVariable ["FW_Spectating", false])} do {

	targets = [];
	
	{
	
		if (!(_x getVariable ["FW_Dead", false])) then {
		
			targets set [count targets, _x];
			
		}
		
	} forEach playableUnits;
	
	maxIndex = count targets - 1;
	
	player setOxygenRemaining 1;
	
	sleep 0.25;
};