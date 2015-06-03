#ifdef framework

private ["_modules", "_module"];

_modules = "<font size='18'>Olsen Framework Modules</font><br/><br/>";

for "_i" from 0 to count FW_Modules -1 do {
	_module = FW_Modules select _i;

	_modules = _modules + "<font size='16'>" + (_module select 0) + "</font><br/>Description: " + (_module select 1) + "<br/>by " + (_module select 2);

	if (_i < count FW_Modules) then {
		_modules = _modules + "<br/><br/>";
	};
};

player createDiaryRecord ["FW_Menu", ["Modules", _modules]];

#endif