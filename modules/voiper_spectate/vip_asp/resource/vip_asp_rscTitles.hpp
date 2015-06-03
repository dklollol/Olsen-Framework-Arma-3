#define PIXEL_X (safeZoneWAbs / (getResolution select 0))
#define PIXEL_Y (safeZoneH / (getResolution select 1))
#define XHAIR RESUNITS_X * 4
#define COMPASS_W RESUNITS_X * 20
#define COMPASS_H COMPASS_W / 15
#define COMPASS_X RESCENTRE_X - COMPASS_W / 2
#define HELP_W RESUNITS_X * 75
#define HELP_H RESUNITS_Y * 75

class vip_asp_rsc_crosshair {

	onLoad = "uiNamespace setVariable ['vip_asp_rsc_crosshair', _this select 0]";
	idd=-1;
	movingEnable=0;
	fadein=0;
	fadeout=0;
	duration=1e+011;

	class controls {
	
		class X: vip_rsc_picture {
			idc = 0;
			x = Q(RESCENTRE_X - XHAIR / 2);
			y = Q(RESCENTRE_Y - XHAIR * 4/3 / 2);
			w = Q(XHAIR);
			h = Q(XHAIR * 4/3);
			text = "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa";
			colorText[] = {1,1,1,0.8};
		};
	};
};

class vip_asp_rsc_status {

	onLoad = "uiNamespace setVariable ['vip_asp_rsc_status', _this select 0]; ['Status', _this select 0] call vip_asp_fnc_cl_camera";
	idd = -1;
	movingEnable=0;
	fadein=0;
	fadeout=0;
	duration=1e+011;

	class controls {
	
		class BGRight: vip_rsc_box {
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 30);
			y = Q(safeZoneY);
			w = Q(RESUNITS_X * 30);
			h = Q(COMPASS_H);
			colorBackground[] = {0.1,0.1,0.1,1};
		};
		
		class BGLeft: BGRight {
			x = Q(safeZoneX);
		};
		
		class SpeedFrame: vip_rsc_frame {
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 5);
			y = Q(safeZoneY);
			w = Q(RESUNITS_X * 5);
			h = Q(COMPASS_H);
			shadow = 2;
			colorText[]={1,1,1,1};
		};
		
		class Speed: vip_rsc_text {
			idc = 0;
			style = ST_CENTER;
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 5);
			y = Q(safeZoneY);
			w = Q(RESUNITS_X * 5);
			h = Q(COMPASS_H);
			colorText[]={1,1,1,1};
			sizeEx = Q(RESUNITS_Y * 2);
			font = GUI_FONT_NORMAL;
			text = "";
		};
		
		class FovFrame: SpeedFrame {
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 10.5);
		};
		
		class Fov: Speed {
			idc = 4;
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 10.5);
		};
		
		class TimeAccFrame: SpeedFrame {
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 21.5);
		};
		
		class TimeAcc: Speed {
			idc = 5;
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 21.5);
		};
		
		class FocusFrame: SpeedFrame {
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 16);
		};
		
		class Focus: Speed {
			idc = 6;
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 16);
		};
		
		class NameFrame: SpeedFrame {	
			x = Q(safeZoneX);
			w = Q(RESUNITS_X * 24.5);
		};
		
		class Name: Speed {
			idc = 1;
			x = Q(safeZoneX);
			w = Q(RESUNITS_X * 24.5);
		};
		
		class ModeFrame: SpeedFrame {
			x = Q(safeZoneX + RESUNITS_X * 25);
		};
		
		class Mode: Speed {
			idc = 2;
			x = Q(safeZoneX + RESUNITS_X * 25);	
		};
		
		class TimeFrame: SpeedFrame {
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 30);
			w = Q(RESUNITS_X * 8);
		};
		
		class Time: Speed {
			idc = 3;
			x = Q(safeZoneX + safeZoneW - RESUNITS_X * 30);
			w = Q(RESUNITS_X * 8);
		};
	};
};

class vip_asp_rsc_compass {

	onLoad = "uiNamespace setVariable ['vip_asp_rsc_compass', _this select 0]";
	onUnload = "";
	idd=-1;
	movingEnable=0;
	fadein=0;
	fadeout=0;
	duration=1e+011;

	class controls {
		
		class BG: vip_rsc_box {
			x = Q(COMPASS_X);
			y = Q(safeZoneY);
			w = Q(COMPASS_W);
			h = Q(COMPASS_H);
			colorBackground[] = {0.1,0.1,0.1,1};
		};
		
		class 0_90: vip_rsc_picture {
			idc = 1;
			x = Q(RESCENTRE_X);
			y = Q(safeZoneY);
			w = Q(COMPASS_W / 2);
			h = Q(COMPASS_H);
			text = "A3\ui_f_curator\data\cfgIngameUI\compass\texture180_ca.paa";
		};
		
		class 90_180: 0_90 {
			idc = 2;
			x = Q(RESCENTRE_X + COMPASS_W / 2);
			text = "A3\ui_f_curator\data\cfgIngameUI\compass\texture270_ca.paa";
		};
		
		class 180_270: 0_90 {
			idc = 3;
			x = Q(RESCENTRE_X + COMPASS_W);
			text = "A3\ui_f_curator\data\cfgIngameUI\compass\texture0_ca.paa";
		};
		
		class 270_0: 0_90 {
			idc = 4;
			x = Q(RESCENTRE_X + COMPASS_W * 1.5);
			text = "A3\ui_f_curator\data\cfgIngameUI\compass\texture90_ca.paa";
		};
		
		class Post: vip_rsc_box {
			x = Q(COMPASS_X + COMPASS_W / 2);
			y = Q(safeZoneY);
			w = Q(PIXEL_X * 2);
			h = Q(COMPASS_H);
			colorBackground[]={1,0,0,1};
		};
		
		class LeftBlocker: vip_rsc_box {
			x = Q(COMPASS_X - COMPASS_W / 2);
			y = Q(safeZoneY);
			w = Q(COMPASS_W / 2);
			h = Q(COMPASS_H);
			colorBackground[] = {0.1,0.1,0.1,1};
		};
		
		class RightBlocker: LeftBlocker {
			x = Q(COMPASS_X + COMPASS_W);
		};
		
		class Frame: vip_rsc_frame {
			x = Q(COMPASS_X);
			y = Q(safeZoneY);
			w = Q(COMPASS_W);
			h = Q(COMPASS_H);
			shadow=2;
			colorText[]={1,1,1,1};
		};
	};
};

class vip_asp_rsc_help {
	onLoad = "uiNamespace setVariable ['vip_asp_rsc_help', _this select 0]; ['Help', _this select 0] call vip_asp_fnc_cl_camera";
	idd = -1;
	movingEnable=0;
	fadein=0;
	fadeout=0;
	duration=1e+011;

	class controls {
	
		class BG: vip_rsc_box {
			idc = -1;
			x = Q(RESCENTRE_X - HELP_W / 2);
			y = Q(RESCENTRE_Y - HELP_H / 2);
			w = Q(HELP_W);
			h = Q(HELP_H);
			colorBackground[] = {0.1,0.1,0.1,1};
		};
		
		class Title: vip_rsc_text {
			idc = 0;
			style = ST_CENTER;
			x = Q(RESCENTRE_X - RESUNITS_X * 25);
			y = Q(RESCENTRE_Y - (HELP_H / 2) + RESUNITS_Y * 3);
			w = Q(RESUNITS_X * 50);
			h = Q(RESUNITS_Y * 4);
			colorText[]={1,1,1,1};
			sizeEx = Q(RESUNITS_Y * 4);
			font = GUI_FONT_NORMAL;
			text = "ASP Camera Controls";
		};
		
		class LeftColumn1 {
			idc = 1;
			type = CT_STRUCTURED_TEXT;
			style = ST_LEFT;
			x = Q(RESCENTRE_X - HELP_W / 2 + RESUNITS_X * 3);
			y = Q(RESCENTRE_Y - (HELP_H / 2) + RESUNITS_Y * 12);
			w = Q(RESUNITS_X * 14.75);
			h = Q(RESUNITS_Y * 63);
			text = "";
			size = Q(RESUNITS_Y * 2.5);
			colorBackground[] = {0,0,0,0};
		};
		
		class LeftColumn2: LeftColumn1 {
			idc = 2;
			x = Q(RESCENTRE_X - HELP_W / 2 + RESUNITS_X * 17.75);
		};
		
		class RightColumn1: LeftColumn1 {
			idc = 3;
			x = Q(RESCENTRE_X + HELP_W / 2 - RESUNITS_X * 3 - RESUNITS_X * 29.5);
		};
		
		class RightColumn2: LeftColumn1 {
			idc = 4;
			x = Q(RESCENTRE_X + HELP_W / 2 - RESUNITS_X * 3 - RESUNITS_X * 11.75);
		};
	};
};