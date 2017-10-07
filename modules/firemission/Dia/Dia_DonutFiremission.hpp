////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_DONUTFIREMISSION
{
	idd = DFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	 scriptName = "Dialog_DonutFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {DFM_BACKGROUND,DFM_DESCRIPTIONTEXT,DFM_SELECTEDGUNTEXT,DFM_SELECTEDSHELLTEXT,DFM_GRIDTEXT,DFM_INNERRADIUSTEXT,DFM_OUTERRADIUSTEXT,DFM_BURSTNUMBERTEXT,DFM_BURSTROUNDSTEXT,
		DFM_DELAYTEXT,DFM_SPOTDISTTEXT,DFM_SELECTEDGUNEDIT,
		DFM_SELECTEDSHELLEDIT,DFM_GRIDEDIT,DFM_INNERRADIUSEDIT,DFM_OUTERRADIUSEDIT,DFM_BURSTNUMBEREDIT,DFM_BURSTROUNDSEDIT,DFM_BURSTDELAYEDIT,DFM_SPOTTINGDISTANCEDIT,DFM_FIREBUTTON,DFM_CANCELBUTTON};
		class DFM_BACKGROUND: RscText
		{
			idc = -1;
			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX - ARTIBORDERTHICKNESS;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY - ARTIBORDERTHICKNESS;
			w =  ( ARTILAYOUTWIDTH +  ARTILAYOUTWIDTHSPACE) *  safezoneW  + ARTIBORDERTHICKNESS * 2 ;
			h = ARTILAYOUTHEIGHTSPACE * 11 * safezoneH + ARTIBORDERTHICKNESS * 2 ;
			shadow = 0;
			colorBackground[] = {0.65,0.65,0.65,0.7};
		};
		class DFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Donut Firemission"; //--- ToDo: Localize;

			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY;
			w = ARTILAYOUTWIDTH * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};
	class DFM_SELECTEDGUNTEXT: RscText
	{
		idc = -1;
		text = "Selected gun:"; //--- ToDo: Localize;

		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_SELECTEDSHELLTEXT: RscText
	{
		idc = -1;
		text = "Aviable ammunition:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 2) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_GRIDTEXT: RscText
	{
		idc = -1;
		text = "Targetgrid:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_INNERRADIUSTEXT: RscText
	{
		idc = -1;
		text = "Inner radius:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_OUTERRADIUSTEXT: RscText
	{
		idc = -1;
		text = "Outer radius:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_BURSTNUMBERTEXT: RscText
	{
		idc = -1;
		text = "Number of bursts:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_BURSTROUNDSTEXT: RscText
	{
		idc = -1;
		text = "Number of rounds per burst:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_DELAYTEXT: RscText
	{
		idc = -1;
		text = "Delay between bursts:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_SPOTDISTTEXT: RscText
	{
		idc = -1;
		text = "Minimum spotting round distance:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_FIREBUTTON: RscButton
	{
		idc = 1430;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 10) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
			onMouseButtonDown = "[] call FNC_DIA_DonutFiremissionFire;";
	};
	class DFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = DFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//colorBackground[] = {1,1,1,1};
		//colorActive[] = {0,1,0,1};
		onLBSelChanged = "(_this select 1) call FNC_DIA_DonutFiremissionSetArtillery;";
	};
	class DFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = DFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 2) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	};
	class DFM_GRIDEDIT: RscEdit
	{
		idc = DFM_DIA_IDC_GRID;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_INNERRADIUSEDIT: RscEdit
	{
		idc = DFM_DIA_IDC_INNERRADIUS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_OUTERRADIUSEDIT: RscEdit
	{
		idc = DFM_DIA_IDC_OUTERRADIUS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = DFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = DFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_BURSTDELAYEDIT: RscEdit
	{
		idc = DFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = DFM_DIA_IDC_SPOTTING;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;
	};
	class DFM_CANCELBUTTON: RscButton
	{
		idc = 1600;
		text = "Cancel"; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 10) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_DonutFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
