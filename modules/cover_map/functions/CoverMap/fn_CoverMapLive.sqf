//Covers Map outside marker and centers map on marker center in game map
if (!hasinterface) exitwith {};
params ["_marker",["_centered",true],["_zoomlevel",0.4],["_name","AO"],["_AOnumber",1]];

//delete old markers if present
if (count FW_map_cover > 0) then {
	{deletemarker _x} foreach FW_map_cover; 
	FW_map_cover = [];
};

//for self interact options and logging
FW_map_currentAO = _AOnumber;

private _sx = (getMarkerSize _marker) select 0;
private _sy = (getMarkerSize _marker) select 1;
private _p = getMarkerPos _marker;
private _px = _p select 0;
private _py = _p select 1;
private _a = markerDir _marker;
private _sxo = _sx;
private _syo = _sy;
private _mainS = 20000;
private _mainBS = 50;

if ((_a > 0 && _a <= 90) || (_a >180 && _a <=270)) then {
	private _temp = _sx;
	_sx = _sy;
	_sy = _temp;
};

private _colorForest = "colorKhaki";
private _colors = ["colorBlack","colorBlack",_colorForest,"colorGreen",_colorForest,/**/"colorBlack"/**/,_colorForest,_colorForest];

{
	_x params ["_a"];
	private _i = _forEachIndex;
	
	_a = _a mod 360;
	if (_a < 0) then {_a = _a + 360};

	private _s = _sx;
	private _w = 2*_mainS+_sy;
	private _bw = _sy + _mainBS;
	if !((_a > 0 && _a <= 90) || (_a >180 && _a <=270)) then {
		_s = _sy;
		_w = _sx + 2*_mainBS;
		_bw = _sx + _mainBS;
	};
	_pos_x = _px + (sin _a) * (_mainS + _s + _mainBS);
	_pos_y = _py + (cos _a) * (_mainS + _s + _mainBS);
	
	{
		_x params ["_color"];
	
		private _marker = createMarkerLocal ["ao_" + str _i + str _forEachIndex, [_pos_x, _pos_y]];
		FW_map_cover pushBack _marker;
		
		_marker setMarkerSizeLocal [_w,_mainS];
		_marker setMarkerDirLocal _a;
		_marker setMarkerShapeLocal "rectangle";
		_marker setMarkerBrushLocal "solid";
		_marker setMarkerColorLocal _color;
		
		if (_forEachIndex == 5) then {
			_marker setMarkerBrushLocal "grid";
		};
		
	} forEach _colors;
	
	
	_pos_x = _px + (sin _a) * (_mainBS/2 + _s);
	_pos_y = _py + (cos _a) * (_mainBS/2 + _s);
	
	for "_m" from 0 to 7 do {
		_marker = createMarkerLocal ["ao_w_" + str _i + str _m,[_pos_x, _pos_y]];
		FW_map_cover pushBack _marker;
		
		_marker setMarkerSizeLocal [_bw, _mainBS/2];
		_marker setMarkerDirLocal _a;
		_marker setMarkerShapeLocal "rectangle";
		_marker setMarkerBrushLocal "solid";
		_marker setMarkerColorLocal "colorwhite";
	};
	
} forEach [_a, _a+90, _a+180, _a+270];

_marker = createMarkerLocal ["ao_b_1", [_px, _py]];
FW_map_cover pushBack _marker;

_marker setMarkerSizeLocal [_sxo, _syo];
_marker setMarkerDirLocal _a;
_marker setMarkerShapeLocal "rectangle";
_marker setMarkerBrushLocal "border";
_marker setMarkerColorLocal "colorBlack";

_marker = createMarkerLocal ["ao_b_2", [_px, _py]];
FW_map_cover pushBack _marker;

_marker setMarkerSizeLocal [_sxo+_mainBS, _syo+_mainBS];
_marker setMarkerDirLocal _a;
_marker setMarkerShapeLocal "rectangle";
_marker setMarkerBrushLocal "border";
_marker setMarkerColorLocal "colorBlack";

[_zoomlevel,_p] spawn {
	params [["_zoomlevel",0.4],"_p"];
	disableSerialization;
	waitUntil{visibleMap};
	MapAnimAdd [0, _zoomlevel, _p];
	MapAnimCommit;
	waitUntil{mapAnimDone};
};