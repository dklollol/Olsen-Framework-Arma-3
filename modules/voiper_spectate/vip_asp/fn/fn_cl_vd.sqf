_mode = _this select 0;
_this = _this select 1;

private ["_dialog", "_dist"];

switch _mode do {

	case "Init": {
	
		_dialog = _this select 0;
		_dist = -1;
		_text = _dialog displayCtrl 1;
		_slider = _dialog displayCtrl 2;
		_slider slidersetRange [1000,20000];
		_slider sliderSetSpeed [1000,1000,1000];
		_slider sliderSetPosition viewDistance;
		_text ctrlSetText str viewDistance;
	};
	
	case "Slider": {
		
		_dialog = ctrlParent (_this select 0);
		_dist = _this select 1;
		_text = _dialog displayCtrl 1;
		setViewDistance _dist;
		_text ctrlSetText str viewDistance;
	};
};

