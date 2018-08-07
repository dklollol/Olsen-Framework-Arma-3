
//Function usage:
//FNC_RADIO_CHECKFREQ: [5] call FNC_RADIO_CHECKFREQ will return true if the player is on preset 5 for the PRC117F/PRC148/PRC152
/*FNC_RADIO_RADIOMESSAGE/FNC_RADIO_RADIOMESSAGEALT/FNC_RADIO_RADIOMESSAGEFS: Will deliver strings to all users on the PRC117F/PRC148/PRC152 preset given on the SystemChat channel with a predetermined delay based on text length (0.05s per message character)
	FNC_RADIO_RADIOMESSAGE: Logs to Radio Log. Will replace the text mapPosGrid in the string given with the 6-digit grid reference of the triggering player.
	FNC_RADIO_RADIOMESSAGEALT: Does not log to Radio or Fires Log. Does not handle mapPosGrid replacement. Just used for general text.
	FNC_RADIO_RADIOMESSAGEFS: Logs to Fires Log. Does not handle mapPosGrid replacement.

	["FW_RADIO_RADIOMESSAGEFS",
		[
			[5,"Hello 1'0 this is 1'B, radio check, over."],
			[5,"1'B this is 1'0, lima charlie, out."]
		]
	] call CBA_fnc_globalEvent;
*/

//////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTIONS BELOW // //////////////////////////////////////////////////////// DON'T FUCK WITH THIS //
//////////////////////////////////////////////////////////////////////////////////////////////////////

if (isNil "VAR_RADIO_NETBUSYBLU") then {VAR_RADIO_NETBUSYBLU = false};

if (isServer) then {
	["FW_RADIO_RADIOFLAGS", {
		[_this] spawn {
			params ["_flag"];
			private ["_actions","_sleepTime"];

			_actions = VAR_RADIO_RADIOACTIONSBLU select _flag;
			_msgArray = VAR_RADIO_RADIOMESSAGESBLU select _flag;

			_sleepTime = 2;

			{
				_msgChan = _x select 0;
				_msgText = _x select 1;

				_sleepTime = _sleepTime + ((count _msgText) * 0.05);
			} forEach _msgArray;

			sleep _sleepTime;
			call compile _actions;
		};
	}] call CBA_fnc_addEventHandler;
};

if (!isDedicated && hasInterface) then {
	FNC_RADIO_RADIOMESSAGE = {
		_this spawn {
			params ["_msg","_pos"];
			private ["_sleepTime"];

			_msgArray = VAR_RADIO_RADIOMESSAGESBLU select _msg;
			_sleepTime = 0;

			VAR_RADIO_NETBUSYBLU = true;

			{
				enableRadio true;
				sleep 0.05;

				_msgChan = _x select 0;
				_msgText = _x select 1;
				_msgText = [_msgText,"mapPosGrid",_pos] call CBA_fnc_replace;

				_sleepTime = (count _msgText) * 0.05;

				[_msgChan,_msgText] call FNC_RADIO_SYSCHAT;


				enableRadio false;
				sleep _sleepTime;

			} forEach _msgArray;

			VAR_RADIO_NETBUSYBLU = false;

		};
	};
	["FW_RADIO_RADIOMESSAGE", FNC_RADIO_RADIOMESSAGE] call CBA_fnc_addEventHandler;

	FNC_RADIO_RADIOMESSAGEALT = {	//Format: ["FW_RADIO_RADIOMESSAGEALT", [[1,"MESSAGE"],[1,"MESSAGE TOO"]]] call CBA_fnc_globalEvent;
		[_this] spawn {
			params ["_msgArray"];
			private ["_sleepTime"];

			_sleepTime = 0;

			VAR_RADIO_NETBUSYBLU = true;

			{
				enableRadio true;
				sleep 0.05;

				_msgChan = _x select 0;
				_msgText = _x select 1;

				_sleepTime = (count _msgText) * 0.05;

				[_msgChan,_msgText] call FNC_RADIO_SYSCHAT;


				enableRadio false;
				sleep _sleepTime;

			} forEach _msgArray;

			VAR_RADIO_NETBUSYBLU = false;

		};
	};
	["FW_RADIO_RADIOMESSAGEALT", FNC_RADIO_RADIOMESSAGEALT] call CBA_fnc_addEventHandler;

	FNC_RADIO_RADIOMESSAGEFS = {	//Format: ["FW_RADIO_RADIOMESSAGEFS", [[1,"MESSAGE"],[1,"MESSAGE TOO"]]] call CBA_fnc_globalEvent;
		[_this] spawn {
			params ["_msgArray"];
			private ["_sleepTime"];

			_sleepTime = 0;

			VAR_RADIO_NETBUSYBLU = true;

			{
				enableRadio true;
				sleep 0.05;

				_msgChan = _x select 0;
				_msgText = _x select 1;

				_sleepTime = (count _msgText) * 0.05;

				[_msgChan,_msgText] call FNC_RADIO_SYSCHATFS;


				enableRadio false;
				sleep _sleepTime;

			} forEach _msgArray;

			VAR_RADIO_NETBUSYBLU = false;

		};
	};
	["FW_RADIO_RADIOMESSAGEFS", FNC_RADIO_RADIOMESSAGEFS] call CBA_fnc_addEventHandler;

	FNC_RADIO_CHECKFREQ = {
		_pre = param [0,1];
		_ret = false;

		_radioList = [] call acre_api_fnc_getCurrentRadioList;
		{
			if (([_x, "ACRE_PRC148"] call acre_api_fnc_isKindOf || [_x, "ACRE_PRC152"] call acre_api_fnc_isKindOf || [_x, "ACRE_PRC117F"] call acre_api_fnc_isKindOf) && !_ret) then {
				if ([_x] call acre_api_fnc_getRadioChannel == _pre) then {
					_ret = true
				};
			};
		} forEach _radioList;

		_ret
	};

	FNC_RADIO_SYSCHAT = {
		_pre = param [0,1];
		_msg = param [1,""];

		if ([_pre] call FNC_RADIO_CHECKFREQ) then {systemChat _msg};
		_coyhq = player createDiaryRecord ["radiolog",["GENERAL",_msg]];
	};


	FNC_RADIO_SYSCHATFS = {
		_pre = param [0,1];
		_msg = param [1,""];

		if ([_pre] call FNC_RADIO_CHECKFREQ) then {systemChat _msg};
		_coyhq = player createDiaryRecord ["radiolog",["FIRE SUPPORT",_msg]];
	};
};