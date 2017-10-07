//Do not edit unless you know what you are doing
//because you are on the highway to the danger zone!

class DIA_ENDSCREEN {
	idd = 300;
	movingEnable = false;
	enableSimulation = true;
	controlsBackground[] = {BACKGROUND};
	objects[] = {};
	controls[] = {TEXT_TITLE, TEXT_LEFT, TEXT_RIGHT, TEXT_BOTTOM_LEFT,TEXT_BOTTOM_MIDDLE, TEXT_BOTTOM_RIGHT};

	class BACKGROUND: RscBackground
	{
		idc = 3000;
		x = -1;
		y = -1;
		w = 4;
		h = 4;
	};
	class TEXT_TITLE: RscStructuredText
	{
		idc = 3001;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.149922 * safezoneH + safezoneY;
		w = 0.525 * safezoneW;
		h = 0.140031 * safezoneH;
	};
	class TEXT_LEFT: RscStructuredText
	{
		idc = 3002;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.289953 * safezoneH + safezoneY;
		w = 0.2625 * safezoneW;
		h = 0.560125 * safezoneH;
	};
	class TEXT_RIGHT: RscStructuredText
	{
		idc = 3003;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.289953 * safezoneH + safezoneY;
		w = 0.2625 * safezoneW;
		h = 0.560125 * safezoneH;
	};
	class TEXT_BOTTOM_LEFT: RscStructuredText
	{
		idc = 3004;
		x = 0.25 * safezoneW + safezoneX;
		y = 0.6 * safezoneH + safezoneY;
		w = 0.8 * safezoneW;
		h = 0.5 * safezoneH;
	};
	class TEXT_BOTTOM_MIDDLE: RscStructuredText
	{
		idc = 3005;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.6 * safezoneH + safezoneY;
		w = 0.8 * safezoneW;
		h = 0.5 * safezoneH;
	};
	class TEXT_BOTTOM_RIGHT: RscStructuredText
	{
		idc = 3006;
		x = 0.75 * safezoneW + safezoneX;
		y = 0.6 * safezoneH + safezoneY;
		w = 0.8 * safezoneW;
		h = 0.5 * safezoneH;
	};
};