["Ambient Effects", "Fire and Particles!", "TinfoilHate"] call FNC_RegisterModule;

	FNC_hideHelperObject = {
		_this hideObject true
	};

	FNC_hideHelperObjects = {
		{_x hideObject true} forEach _this;
	};

	FNC_audio_carBurning1 = {
		_handle = [{(_this select 0) say3D "burning_car_loop1"},5.9,_this] call CBA_fnc_addPerFrameHandler;
	};

	FNC_audio_carBurning2 = {
		_handle = [{(_this select 0) say3D "burning_car_loop2"},11.75,_this] call CBA_fnc_addPerFrameHandler;
	};

	FNC_particleEffect = {
		//Parameters
		private ["_object", "_effects"];
		_object		= [_this, 0, objNull, [objNull]] call BIS_fnc_param;
		_effects	= [_this, 1, [], [[]]] call BIS_fnc_param;

		//The effects container
		private "_container";
		_container = [];

		//Loop classes and start effects
		{
			//Parameters
			private ["_class", "_attachTo"];
			_class 		= [_x, 0, "AmmoSmokeParticles2", [""]] call BIS_fnc_param;
			_attachTo 	= [_x, 1, [], [[]]] call BIS_fnc_param;

			//Particle effect
			private "_effect";
			_effect = "#particlesource" createVehicleLocal position _object;
			_effect setParticleClass _class;
			_li = "#lightpoint" createVehicleLocal position _object;
			_li setLightAmbient[0.8, 0.6, 0.2];
			_li setLightColor[1, 0.5, 0.4];
			_li setLightBrightness 0.1;

			//Should effect be attached to object?
			if (count _attachTo > 0) then {
				_effect attachto [_object, _attachTo];
				_li lightAttachObject [_object, _attachTo];
			};

			//Store in container
			_container set [count _container, _effect];

		} forEach _effects;

		//Return
		_container
	};

	FNC_processHelpers = {
		private ["_hideArray"];

		_hideArray = [];

		{	//Large Pink Arrows - Burning Vehicle
			_delay = random 1; 
			[[_x,[
				["FireSparks", [0,-2,0]],
				["AmmoSmokeParticles2", [0,-2,-1]],
				["FireSparks", [0,1,0]],
				["AmmoSmokeParticles2", [0,2,-1]],
				["AmmoSmokeParticles2", [0,0,-1]]
			]],"FNC_particleEffect",true,true] spawn BIS_fnc_MP;
			[{[_this,"FNC_audio_carBurning2",true,true] spawn BIS_fnc_MP},_x,_delay] call CBA_fnc_waitAndExecute;	
			
			_hideArray set [count _hideArray,_x];
		} forEach (allMissionObjects "Sign_Arrow_Large_Pink_F");

		{	//Pink Arrows - Small Fire
			_delay = random 1;
			[[_x,[
				["FireSparks", [0,0,0]],
				["FuelFire1", [0,0,0]],
				["AmmoSmokeParticles2", [0,0,-1]]
			]],"FNC_particleEffect",true,true] spawn BIS_fnc_MP;
			[{[_this,"FNC_audio_carBurning1",true,true] spawn BIS_fnc_MP},_x,_delay] call CBA_fnc_waitAndExecute;
			_hideArray set [count _hideArray,_x];
		} forEach (allMissionObjects "Sign_Arrow_Pink_F");

		[_hideArray,"FNC_hideHelperObjects",true,true] spawn BIS_fnc_MP;

		//Return Complete
		true
	};