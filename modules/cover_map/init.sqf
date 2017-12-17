["Cover map", "Covers map except specified area.", "BlackHawk"] call FNC_RegisterModule;

#include "settings.sqf"

#define S 20000
#define BS 50

if (!isDedicated) then {
	_marker setMarkerAlphaLocal 0;
	
	FW_map_cover = [];
	
	private _sx = (getMarkerSize _marker) select 0;
	private _sy = (getMarkerSize _marker) select 1;
	private _px = (getMarkerPos _marker) select 0;
	private _py = (getMarkerPos _marker) select 1;
	private _a = markerDir _marker;
	
	private _sxo = _sx;
	private _syo = _sy;
	
	
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
		private _w = 2*S+_sy;
		private _bw = _sy + BS;
		if !((_a > 0 && _a <= 90) || (_a >180 && _a <=270)) then {
			_s = _sy;
			_w = _sx + 2*BS;
			_bw = _sx + BS;
		};
		_pos_x = _px + (sin _a) * (S + _s + BS);
		_pos_y = _py + (cos _a) * (S + _s + BS);
		
		{
			_x params ["_color"];
		
			private _marker = createMarkerLocal ["ao_" + str _i + str _forEachIndex, [_pos_x, _pos_y]];
			FW_map_cover pushBack _marker;
			
			_marker setMarkerSizeLocal [_w,S];
			_marker setMarkerDirLocal _a;
			_marker setMarkerShapeLocal "rectangle";
			_marker setMarkerBrushLocal "solid";
			_marker setMarkerColorLocal _color;
			
			if (_forEachIndex == 5) then {
				_marker setMarkerBrushLocal "grid";
			};
			
		} forEach _colors;
		
		
		_pos_x = _px + (sin _a) * (BS/2 + _s);
		_pos_y = _py + (cos _a) * (BS/2 + _s);
		
		for "_m" from 0 to 7 do {
			_marker = createMarkerLocal ["ao_w_" + str _i + str _m,[_pos_x, _pos_y]];
			FW_map_cover pushBack _marker;
			
			_marker setMarkerSizeLocal [_bw, BS/2];
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
	
	_marker setMarkerSizeLocal [_sxo+BS, _syo+BS];
	_marker setMarkerDirLocal _a;
	_marker setMarkerShapeLocal "rectangle";
	_marker setMarkerBrushLocal "border";
	_marker setMarkerColorLocal "colorBlack";
};
