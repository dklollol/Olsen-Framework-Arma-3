_dialog = _this select 0;
_cam = vip_asp_obj_cl_cam;
_unit = vip_asp_var_cl_unit;

_Q1 = _dialog displayCtrl 1;
_Q2 = _dialog displayCtrl 2;
_Q3 = _dialog displayCtrl 3;
_Q4 = _dialog displayCtrl 4;
_qOrder = [];

_RESUNITS_X = safeZoneW / 100;
_CENTRE = safeZoneX + safeZoneW / 2;
_COMPASS_W = _RESUNITS_X * 20;
_COMPASS_H = _COMPASS_W / 15;
_COMPASS_X = _CENTRE - _COMPASS_W / 2;
_y = safeZoneY;
_ARC_W = _COMPASS_W / 2;
_degUnit = _COMPASS_W / 180;

_dir = if (vip_asp_var_cl_cameraOn) then {getDir _cam} else {getDir _unit};
_angleFromCentre = _dir - floor(_dir / 90) * 90;
_leftEdgePos = _angleFromCentre * _degUnit;

_positions = [
	[_CENTRE - _leftEdgePos - _ARC_W, _y],
	[_CENTRE - _leftEdgePos, _y],
	[_CENTRE - _leftEdgePos + _ARC_W, _y],
	[0, _y - 1]
];

switch (true) do {

	case ((_dir >= 0) && (_dir < 90)): {_qOrder = [_Q4, _Q1, _Q2, _Q3]};
	case ((_dir >= 90) && (_dir < 180)): {_qOrder = [_Q1, _Q2, _Q3, _Q4]};
	case ((_dir >= 180) && (_dir < 270)): {_qOrder = [_Q2, _Q3, _Q4, _Q1]};
	case (_dir >= 270): {_qOrder = [_Q3, _Q4, _Q1, _Q2]};
};

{
	_x ctrlSetPosition (_positions select _forEachIndex);
	_x ctrlCommit 0;
} forEach _qOrder;