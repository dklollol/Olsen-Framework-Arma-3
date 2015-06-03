// Module by Starfox64 (STEAM_0:1:37636871) //

if (!isDedicated) then {

private ["_info"];

player createDiarySubject ["FW_Menu", "Olsen Framework"];

_info = "
<font size='18'>Welcome to the Olsen Framework!</font><br/>
The Olsen Framework is a simple framework designed for ArmA 3. It supports modules and is easy to configure.<br/>
<br/>
Find out more about the framework on GitHub.<br/>
github.com/dklollol/Olsen-Framework-Arma-3
";

player createDiaryRecord ["FW_Menu", ["Framework Info", _info]];

};


FW_Modules = [];

FNC_RegisterModule = {

	private ["_name", "_description", "_author"];

	_name = _this select 0;
	_description = _this select 1;
	_author = _this select 2;

	FW_Modules set [count FW_Modules, [_name, _description, _author]];

};

["Framework Menu", "Adds a new subject to the logs and fills it with useful information.", "Starfox64"] call FNC_RegisterModule;