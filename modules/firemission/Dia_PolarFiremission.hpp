////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_POLARFIREMISSION
{
	idd = POFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	 scriptName = "Dialog_PolarFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {POFM_BACKGROUND,POFM_DESCRIPTIONTEXT,POFM_SELECTEDGUNTEXT,POFM_SELECTEDSHELLTEXT,POFM_GRIDTEXT,POFM_MILSTEXT,POFM_DISTANCETEXT,POFM_DISPERSIONTEXT,POFM_BURSTNUMBERTEXT,POFM_BURSTROUNDSTEXT,
		POFM_DELAYTEXT,POFM_SPOTDISTTEXT,POFM_SELECTEDGUNEDIT,POFM_SELECTEDSHELLEDIT,POFM_GRIDEDIT,POFM_MILSEDIT,POFM_DISTANCEEDIT,POFM_DISPERSIONEDIT,POFM_BURSTNUMBEREDIT,POFM_BURSTROUNDSEDIT,
		POFM_BURSTDELAYEDIT,POFM_SPOTTINGDISTANCEDIT,POFM_FIREBUTTON,POFM_CANCELBUTTON};
		class POFM_BACKGROUND: RscText
		{
		    idc = -1;
			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX - ARTIBORDERTHICKNESS;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY - ARTIBORDERTHICKNESS;
			w =  ( ARTILAYOUTWIDTH +  ARTILAYOUTWIDTHSPACE) *  safezoneW  + ARTIBORDERTHICKNESS * 2 ;
			h = ARTILAYOUTHEIGHTSPACE * 12 * safezoneH + ARTIBORDERTHICKNESS * 2 ;
		    	shadow = 0;
		    colorBackground[] = {0.65,0.65,0.65,0.7};
		};
		class POFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Polar Firemission"; //--- ToDo: Localize;

			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY;
			w = ARTILAYOUTWIDTH * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};

	shadow = 0;

		};
	class POFM_SELECTEDGUNTEXT: RscText
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
	class POFM_SELECTEDSHELLTEXT: RscText
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
	class POFM_GRIDTEXT: RscText
	{
		idc = -1;
		text = "Caller Grid:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_MILSTEXT: RscText
	{
		idc = -1;
		text = "Mils:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_DISTANCETEXT: RscText
	{
		idc = -1;
		text = "Distance:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_DISPERSIONTEXT: RscText
	{
		idc = -1;
		text = "Dispersion:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_BURSTNUMBERTEXT: RscText
	{
		idc = -1;
		text = "Number of bursts:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_BURSTROUNDSTEXT: RscText
	{
		idc = -1;
		text = "Number of rounds per burst:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_DELAYTEXT: RscText
	{
		idc = -1;
		text = "Delay between bursts:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_SPOTDISTTEXT: RscText
	{
		idc = -1;
		text = "Minimum spotting round distance:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 10) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_FIREBUTTON: RscButton
	{
		idc = 1430;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 11) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	shadow = 0;
			onMouseButtonDown = "[] call FNC_DIA_PolarFiremissionFire;";
	};
	class POFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = POFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//
		shadow = 0;
		onLBSelChanged = "(_this select 1) call FNC_DIA_PolarFiremissionSetArtillery;";
	};
	class POFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = POFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 2) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
			shadow = 0;
	};
	class POFM_GRIDEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_GRID;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_MILSEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_MILS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_DISTANCEEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_DISTANCE;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_DISPERSIONEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_DISPERSION;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = POFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_BURSTDELAYEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};


	shadow = 0;
	};
	class POFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_SPOTTING;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 10) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class POFM_CANCELBUTTON: RscButton
	{
		idc = 1600;
		text = "Cancel"; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 11) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	shadow = 0;
			onMouseButtonDown = "[] call FNC_DIA_PolarFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
