////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_LINEFIREMISSION
{
	idd = LFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	 scriptName = "Dialog_LineFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {LFM_DESCRIPTIONTEXT,LFM_SELECTEDGUN,LFM_SELECTEDSHELLTEXT,LFM_STARTGRID,LFM_ENDGRID,LFM_BURSTNUMBERTEXT,LFM_BURSTROUNDSTEXT,
		LFM_DELAYTEXT,LFM_SPOTDISTTEXT,LFM_SELECTEDGUNEDIT,LFM_SELECTEDSHELLEDIT,LFM_STARTGRIDEDIT,LFM_ENDGRIDEDIT,LFM_BURSTNUMBEREDIT,LFM_BURSTROUNDSEDIT,LFM_BURSTDELAYEDIT,LFM_SPOTTINGDISTANCEDIT,LFM_FIREBUTTON};
		class LFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Line Firemission"; //--- ToDo: Localize;

			x = 0.2375 * safezoneW + safezoneX;
			y = (0.15 + ARTILAYOUTHEIGHT * 0) * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};

			colorActive[] = {0,1,0,1};
		};
	class LFM_SELECTEDGUN: RscText
	{
		idc = -1;
		text = "Selected gun:"; //--- ToDo: Localize;

		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 1) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;

		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};

		colorActive[] = {0,1,0,1};
	};
	class LFM_SELECTEDSHELLTEXT: RscText
	{
		idc = -1;
		text = "Selected ammunition:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 2) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_STARTGRID: RscText
	{
		idc = -1;
		text = "Start Grid:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 3) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_ENDGRID: RscText
	{
		idc = -1;
		text = "End Grid:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 4) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_BURSTNUMBERTEXT: RscText
	{
		idc = -1;
		text = "Number of bursts:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 5) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_BURSTROUNDSTEXT: RscText
	{
		idc = -1;
		text = "Number of rounds per burst:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 6) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_DELAYTEXT: RscText
	{
		idc = -1;
		text = "Delay between bursts:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 7) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_SPOTDISTTEXT: RscText
	{
		idc = -1;
		text = "Minimum spotting round distance:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 8) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_FIREBUTTON: RscButton
	{
		idc = -1;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 9) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_LineFiremissionFire;";
	};
	class LFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = LFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 1) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//colorBackground[] = {1,1,1,1};
		//colorActive[] = {0,1,0,1};
		onLBSelChanged = "(_this select 1) call FNC_DIA_LineFiremissionSetArtillery;"
	};
	class LFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = LFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 2) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	};
	class LFM_STARTGRIDEDIT: RscEdit
	{
		idc = DLM_DIA_IDC_STARTGRID;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 3) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_ENDGRIDEDIT: RscEdit
	{
		idc = DLM_DIA_IDC_ENDGRID;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 4) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = LFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 5) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 6) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_BURSTDELAYEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 7) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class LFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_SPOTTING;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 8) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class CANCELBUTTON: RscButton
	{
		idc = 1600;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 9) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_LineFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
