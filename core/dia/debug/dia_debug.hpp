//Do not edit unless you know what you are doing
//because you are on the highway to the danger zone!

class DIA_DEBUG {

	idd = 400;
	fadeout = 0;
	fadein = 0;
	duration = 180;
	onLoad = "uiNamespace setVariable ['FW_Debug', _this select 0];";

	class controlsBackground {

		class SOME_TEXT: RscStructuredText
		{

			idc = 4001;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 1 * safezoneH;

		};
	};
};
