/*
	Author: voiper
	
	Description: Find all 8 corners of the bounding box of an object.
	
	Parameters:
		0: Object; object for which to find corners.

	Returns:
		Array: 8 corners in world position.

	Example:
		_corners = [object] call vip_cmn_fnc_cl_3DModelEdges;
*/

_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _obj) exitWith {["Inputted null object."] call BIS_fnc_error};

_bb = boundingBoxReal _obj;
_min = _bb select 0;
_max = _bb select 1;

_x1y1z1 = _obj modeltoworldVisual [_min select 0, _min select 1, _min select 2];
_x1y2z1 = _obj modeltoworldVisual [_min select 0, _max select 1, _min select 2];

_x2y1z1 = _obj modeltoworldVisual [_max select 0, _min select 1, _min select 2];
_x2y2z1 = _obj modeltoworldVisual [_max select 0, _max select 1, _min select 2];

_x1y1z2 = _obj modeltoworldVisual [_min select 0, _min select 1, _max select 2];
_x1y2z2 = _obj modeltoworldVisual [_min select 0, _max select 1, _max select 2];

_x2y1z2 = _obj modeltoworldVisual [_max select 0, _min select 1, _max select 2];
_x2y2z2 = _obj modeltoworldVisual [_max select 0, _max select 1, _max select 2];

[_x1y1z1, _x1y2z1, _x2y1z1, _x2y2z1, _x1y1z2, _x1y2z2, _x2y1z2, _x2y2z2]