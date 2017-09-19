////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_POINTFIREMISSION
{
	idd = PFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	 scriptName = "Dialog_PointFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {PFM_DESCRIPTIONTEXT,PFM_SELECTEDGUNTEXT,PFM_SELECTEDSHELLTEXT,PFM_GRIDTEXT,PFM_DISPERSIONTEXT,PFM_BURSTNUMBERTEXT,PFM_BURSTROUNDSTEXT,
		PFM_DELAYTEXT,PFM_SPOTDISTTEXT,PFM_SELECTEDGUNEDIT,PFM_SELECTEDSHELLEDIT,PFM_GRIDEDIT,PFM_DISPERSIONEDIT,PFM_BURSTNUMBEREDIT,PFM_BURSTROUNDSEDIT,PFM_BURSTDELAYEDIT,PFM_SPOTTINGDISTANCEDIT,PFM_FIREBUTTON};
		class PFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Point Firemission"; //--- ToDo: Localize;

			x = 0.2375 * safezoneW + safezoneX;
			y = (0.15 + ARTILAYOUTHEIGHT * 0) * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};

			colorActive[] = {0,1,0,1};
		};
	class PFM_SELECTEDGUNTEXT: RscText
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
	class PFM_SELECTEDSHELLTEXT: RscText
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
	class PFM_GRIDTEXT: RscText
	{
		idc = -1;
		text = "Grid:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 3) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_DISPERSIONTEXT: RscText
	{
		idc = -1;
		text = "Dispersion:"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 4) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_BURSTNUMBERTEXT: RscText
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
	class PFM_BURSTROUNDSTEXT: RscText
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
	class PFM_DELAYTEXT: RscText
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
	class PFM_SPOTDISTTEXT: RscText
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
	class PFM_FIREBUTTON: RscButton
	{
		idc = 1430;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = 0.2375 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 9) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_PointFiremissionFire;";
	};
	class PFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = PFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 1) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//colorBackground[] = {1,1,1,1};
		//colorActive[] = {0,1,0,1};
		onLBSelChanged = "(_this select 1) call FNC_DIA_PointFiremissionSetArtillery;"
	};
	class PFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = PFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 2) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	};
	class PFM_GRIDEDIT: RscEdit
	{
		idc = PFM_DIA_IDC_GRID;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 3) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_DISPERSIONEDIT: RscEdit
	{
		idc = PFM_DIA_IDC_DISPERSION;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 4) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = PFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 5) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = PFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 6) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_BURSTDELAYEDIT: RscEdit
	{
		idc = PFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 7) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = PFM_DIA_IDC_SPOTTING;
		text = ""; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 8) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		colorActive[] = {0,1,0,1};
	};
	class PFM_CANCELBUTTON: RscButton
	{
		idc = 1600;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.4 * safezoneW + safezoneX;
		y = (0.15 + ARTILAYOUTHEIGHT * 9) * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_PointFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
