{
	_unit = _x;
	_pos = getPos _unit;
	_pos resize 2;
	
	_index = -1;

	{if ((_x select 0) == _unit) then {_index = _forEachIndex}} forEach vip_asp_var_cl_trackingArray;
	if (_index == -1) then {
		vip_asp_var_cl_trackingArray pushBack [_unit, [_pos]]
	} else {
		_unitArray = vip_asp_var_cl_trackingArray select _index;
		_trackingArray = _unitArray select 1;
		_latestIndex = (count _trackingArray) - 1;
		_latestPos = _trackingArray select _latestIndex;
		_diffX = abs((_latestPos select 0) - (_pos select 0));
		_diffY = abs((_latestPos select 1) - (_pos select 1));
		
		if !((_diffX < 20) && (_diffY < 20)) then {
			_trackingArray pushBack _pos;		
			_unitArray set [1, _trackingArray];
			vip_asp_var_cl_trackingArray set [_index, _unitArray];
		};
	};
	
} forEach vip_asp_var_cl_units;