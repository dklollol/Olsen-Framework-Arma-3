class vip_asp_dlg_overlay {

	idd = 12200;
	enableSimulation = 1;
	movingEnable = 1;
	enableDisplay = 1;
	onLoad = "uiNamespace setVariable ['vip_asp_dlg_overlay', _this select 0]; ['OverlayList', _this select 0] call vip_asp_fnc_cl_newCamera";
	onUnload = "";
	
	class controls {
	
		class Unitlist {
			
			access = 0;
			idc = 0;
			type = CT_TREE; 
			style = ST_LEFT;  
			default = 0;
			blinkingPeriod = 0;

			x = Q(safeZoneX);
			y = Q(safeZoneY + RESUNITS_X * 4/3);
			w = Q(RESUNITS_X * 30);
			h = Q(RESUNITS_Y * 50);

			colorBorder[] = {1,1,1,1};

			colorBackground[] = {0.1,0.1,0.1,1};
			colorSelect[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 0)
			colorMarked[] = {1,0.5,0,0.5}; // Marked item fill color (when multiselectEnabled is 1)
			colorMarkedSelected[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 1)

			sizeEx = GUI_GRID_CENTER_H;
			font = GUI_FONT_NORMAL;
			shadow = 1;
			colorText[] = {1,1,1,1};
			colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)
			colorMarkedText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 1)

			tooltip = "";
			tooltipColorShade[] = {0,0,0,1};
			tooltipColorText[] = {1,1,1,1};
			tooltipColorBox[] = {1,1,1,1};

			multiselectEnabled = 0;
			expandOnDoubleclick = 0;
			hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa"; // Expand icon
			expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa"; // Collapse icon
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it

			class ScrollBar {
				width = 0;
				height = 0;
				scrollSpeed = 0.01;

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";

				color[] = {1,1,1,1};
			};

			colorDisabled[] = {0,0,0,0};
			colorArrow[] = {0,0,0,0};

			//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
			onDestroy = "vip_asp_var_cl_mouseBusy = false; false";
			onMouseEnter = "vip_asp_var_cl_mouseBusy = true; false";
			onMouseExit = "vip_asp_var_cl_mouseBusy = false; false";
			//onSetFocus = "systemChat str ['onSetFocus',_this]; false";
			//onKillFocus = "systemChat str ['onKillFocus',_this]; false";
			//onKeyDown = "systemChat str ['onKeyDown',_this]; false";
			//onKeyUp = "systemChat str ['onKeyUp',_this]; false";
			//onMouseButtonDown = "vip_asp_mouseUse = true";
			//onMouseButtonUp = "";
			//onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
			//onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
			//onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
			//onMouseMoving = "";
			//onMouseHolding = "";

			//onTreeSelChanged = "['OverlaySelect', _this] call vip_asp_fnc_cl_newCamera; false";
			//onTreeSelChanged = "systemChat str (_this select 1)";
			onTreeDblClick = "['OverlaySelect', _this] call vip_asp_fnc_cl_newCamera; false";
			//onTreeSelChanged = "systemChat str ['onTreeSelChanged',_this]; false";
			//onTreeLButtonDown = "systemChat str ['onTreeLButtonDown',_this]; true";
			//onTreeDblClick = "systemChat str ['onTreeDblClick',_this]; false";
			//onTreeExpanded = "systemChat str ['onTreeExpanded',_this]; false";
			//onTreeCollapsed = "systemChat str ['onTreeCollapsed',_this]; false";
			//onTreeMouseExit = "systemChat str ['onTreeMouseExit',_this]; false";
		};	
	};
};

class vip_asp_dlg_vd {
	idd = 12201;
	enableSimulation = 1;
	enableDisplay = 0;
	movingEnable = true;

	onLoad = "uiNamespace setVariable ['vip_asp_dlg_vd', _this select 0]; ['ViewDistance', _this] call vip_asp_fnc_cl_newCamera; false";
	onUnload = "";
	
	class ControlsBackground {
		class TextWindowTitle {
			access = 0;
			idc = -1;
			type = CT_STATIC;
			style = ST_CENTER;
			moving = 1;
			default = 0;
			blinkingPeriod = 0;

			x = 9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = -1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 6 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			colorBackground[] = {0.2,0.2,0.2,1};

			text = "View Distance";
			sizeEx = 1 * GUI_GRID_CENTER_H;
			font = GUI_FONT_NORMAL;
			shadow = 1;
			lineSpacing = 1;
			fixedWidth = 0;
			colorText[] = {1,1,1,1};
			colorShadow[] = {0,0,0,0.5};
			onMouseEnter = "vip_asp_var_cl_mouseBusy = true; false";
			onMouseExit = "vip_asp_var_cl_mouseBusy = false; false";
		};
		
		class Background: vip_rsc_box {
			idc = -1;
			moving = 1;
			x = 9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y;
			w = 22 * GUI_GRID_CENTER_W;
			h = 5 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorText[] = {0,0,0,0};
			onDestroy = "vip_asp_var_cl_mouseBusy = false; false";
			onMouseEnter = "vip_asp_var_cl_mouseBusy = true; false";
			onMouseExit = "vip_asp_var_cl_mouseBusy = false; false";
		};
	};
	
	class Controls {
	
		class ButtonExit: vip_rsc_button {

			idc = 0;

			x = 25 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			text = "Exit";

			onButtonClick = "closeDialog 0; false";
			onMouseEnter = "vip_asp_var_cl_mouseBusy = true; false";
			onMouseExit = "vip_asp_var_cl_mouseBusy = false; false";
		};
		
		class VDText: vip_rsc_text {
			idc = 1;
			
			x = 25 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;
			font = GUI_FONT_NORMAL;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {1,1,1,1};
			
			text = "";
		};
		
		class Slider {
			idc = 2;
		
			type = CT_XSLIDER;
			style = SL_HORZ;
			shadow = 2;
			
			x = 10 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 14 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.2};
			arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
			thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
			
			text = "";
			onSliderPosChanged = "['ViewDistance', _this] call vip_asp_fnc_cl_newCamera";
			onMouseEnter = "vip_asp_var_cl_mouseBusy = true; false";
			onMouseExit = "vip_asp_var_cl_mouseBusy = false; false";
		};
	};
};

class vip_asp_dlg_map {

	idd = 12202;
	enableSimulation = 1; 
	enableDisplay = 0;
	onLoad = "uiNameSpace setVariable ['vip_asp_dlg_map', _this select 0]; ['MapInit', _this select 0] call vip_asp_fnc_cl_newCamera";
	onUnload = "['MapClose', _this select 0] call vip_asp_fnc_cl_newCamera";
	onKeyDown = "['MapKeyDown', _this] call vip_asp_fnc_cl_newCamera";
	
	class controls {
	
		class Map {
			access = 0;
			idc = 1; 
			type = CT_MAP_MAIN;
			style = ST_PICTURE;
			default = 0;
			blinkingPeriod = 0; 

			x = safeZoneXAbs;
			y = safeZoneY;
			w = safeZoneWAbs;
			h = safeZoneH;

			sizeEx = GUI_GRID_CENTER_H;
			font = GUI_FONT_NORMAL;
			colorText[] = {0,0,0,1};
			text = "#(argb,8,8,3)color(1,1,1,1)"; 

			moveOnEdges = 1;

			ptsPerSquareSea =	5;
			ptsPerSquareTxt =	20;
			ptsPerSquareCLn =	10;
			ptsPerSquareExp =	10;
			ptsPerSquareCost =	10;

			ptsPerSquareFor =	9;
			ptsPerSquareForEdge =	9;
			ptsPerSquareRoad =	6;
			ptsPerSquareObj =	9;

			scaleMin = 0.001;
			scaleMax = 1.0;
			scaleDefault = 0.16;

			alphaFadeStartScale = 2;
			alphaFadeEndScale = 2;
			maxSatelliteAlpha = 0.85;
		
			colorBackground[] = {1,1,1,1}; 
			colorOutside[] = {0,0,0,1};
			colorSea[] = {0.4,0.6,0.8,0.5}; 
			colorForest[] = {0.6,0.8,0.4,0.5};
			colorForestBorder[] = {0.6,0.8,0.4,1}; 
			colorRocks[] = {0,0,0,0.3};
			colorRocksBorder[] = {0,0,0,1};
			colorLevels[] = {0.3,0.2,0.1,0.5}; 
			colorMainCountlines[] = {0.6,0.4,0.2,0.5};
			colorCountlines[] = {0.6,0.4,0.2,0.3}; 
			colorMainCountlinesWater[] = {0.5,0.6,0.7,0.6};
			colorCountlinesWater[] = {0.5,0.6,0.7,0.3};
			colorPowerLines[] = {0.1,0.1,0.1,1};
			colorRailWay[] = {0.8,0.2,0,1};
			colorNames[] = {1.1,0.1,1.1,0.9};
			colorInactive[] = {1,1,0,0.5};
			colorTracks[] = {0.8,0.8,0.7,0.2};
			colorTracksFill[] = {0.8,0.7,0.7,1};
			colorRoads[] = {0.7,0.7,0.7,1};
			colorRoadsFill[] = {1,1,1,1};
			colorMainRoads[] = {0.9,0.5,0.3,1};
			colorMainRoadsFill[] = {1,0.6,0.4,1};
			colorGrid[] = {0.1,0.1,0.1,0.6};
			colorGridMap[] = {0.1,0.1,0.1,0.6};

			fontLabel="PuristaMedium";
			sizeExLabel="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			fontGrid="TahomaB";
			sizeExGrid=0.02;
			fontUnits="TahomaB";
			sizeExUnits="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			fontNames="EtelkaNarrowMediumPro";
			sizeExNames="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
			fontInfo="PuristaMedium";
			sizeExInfo="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			fontLevel="TahomaB";
			sizeExLevel=0.02;
			showCountourInterval = 1;

			class Task {
				icon = "#(argb,8,8,3)color(1,1,1,1)";
				color[] = {1,1,0,1};

				iconCreated = "#(argb,8,8,3)color(1,1,1,1)";
				colorCreated[] = {0,0,0,1};

				iconCanceled = "#(argb,8,8,3)color(1,1,1,1)";
				colorCanceled[] = {0,0,0,0.5};

				iconDone = "#(argb,8,8,3)color(1,1,1,1)";
				colorDone[] = {0,1,0,1};

				iconFailed = "#(argb,8,8,3)color(1,1,1,1)";
				colorFailed[] = {1,0,0,1};

				size = 8;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};
			class ActiveMarker { //includes icons spawned by drawIcon
				color[] = {0,0,0,1};
				size = 2;
				coefMin = 1; //make sure icon doesnt scale
			};
			class Waypoint {
				coefMax = 1;
				coefMin = 4;
				color[] = {0,0,0,1};
				icon = "#(argb,8,8,3)color(0,0,0,1)";
				importance = 1;
				size = 2;
			};
			class WaypointCompleted: Waypoint{};
			class CustomMark: Waypoint{};
			class Command: Waypoint{};
			class Bush: Waypoint{color[]={0.45,0.64,0.33,0.4}; importance="0.2 * 14 * 0.05 * 0.05";};
			class Rock: Waypoint{color[]={0.45,0.64,0.33,0.4}; importance="0.5 * 12 * 0.05";};
			class SmallTree: Waypoint{color[]={0.45,0.64,0.33,0.4}; importance="0.6 * 12 * 0.05";};
			class Tree: Waypoint{color[]={0.45,0.64,0.33,0.4}; importance="0.9 * 16 * 0.05";};
			class BusStop: Waypoint{};
			class FuelStation: Waypoint{};
			class Hospital: Waypoint{};
			class Church: Waypoint{};
			class Lighthouse: Waypoint{};
			class Power: Waypoint{};
			class PowerSolar: Waypoint{};
			class PowerWave: Waypoint{};
			class PowerWind: Waypoint{};
			class Quay: Waypoint{};
			class Transmitter: Waypoint{};
			class Watertower: Waypoint{};
			class Cross: Waypoint{};
			class Chapel: Waypoint{};
			class Shipwreck: Waypoint{};
			class Bunker: Waypoint{};
			class Fortress: Waypoint{};
			class Fountain: Waypoint{};
			class Ruin: Waypoint{};
			class Stack: Waypoint{};
			class Tourism: Waypoint{};
			class ViewTower: Waypoint{};
		};
	};
};