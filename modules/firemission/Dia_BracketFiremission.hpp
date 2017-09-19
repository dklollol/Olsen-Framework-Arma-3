////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_BRACKETFIREMISSION
{
	idd = BFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	 scriptName = "Dialog_BracketFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {BFM_DESCRIPTIONTEXT,BFM_SELECTEDGUN,BFM_SELECTEDSHELLTEXT,BFM_STARTGRID,BFM_ENDGRID,BFM_BURSTNUMBERTEXT,BFM_BURSTROUNDSTEXT,
		BFM_DELAYTEXT,BFM_SPOTDISTTEXT,BFM_SELECTEDGUNEDIT,BFM_SELECTEDSHELLEDIT,BFM_STARTGRIDEDIT,BFM_ENDGRIDEDIT,BFM_BURSTNUMBEREDIT,BFM_BURSTROUNDSEDIT,BFM_BURSTDELAYEDIT,BFM_SPOTTINGDISTANCEDIT,BFM_FIREBUTTON};
		class BFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Bracket Firemission"; //--- ToDo: Localize;

			x = 0.2375 * safezoneW + safezoneX;
			y = (0.15 + ARTILAYOUTHEIGHT * 0) * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};

			colorActive[] = {0,1,0,1};
		};
	class BFM_SELECTEDGUN: RscText
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
	class BFM_SELECTEDSHELLTEXT: RscText
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
	class BFM_STARTGRID: RscText
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
	class BFM_ENDGRID: RscText
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
	class BFM_BURSTNUMBERTEXT: RscText
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
	class BFM_BURSTROUNDSTEXT: RscText
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
	class BFM_DELAYTEXT: RscText
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
	class BFM_SPOTDISTTEXT: RscText
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
	class BFM_FIREBUTTON: RscButton
	{
		idc = -1;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 9) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_BracketFiremissionFire;";
	};
	class BFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = BFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 1) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//colorBackground[] = {1,1,1,1};
		//colorActive[] = {0,1,0,1};
		onLBSelChanged = "(_this select 1) call FNC_DIA_BracketFiremissionSetArtillery;"
	};
	class BFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = BFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 2) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	};
	class BFM_STARTGRIDEDIT: RscEdit
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
	class BFM_ENDGRIDEDIT: RscEdit
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
	class BFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = BFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 5) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class BFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = BFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 6) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class BFM_BURSTDELAYEDIT: RscEdit
	{
		idc = BFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 7) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class BFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = BFM_DIA_IDC_SPOTTING;
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

			onMouseButtonDown = "[] call FNC_DIA_BracketFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
