////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_MARKERFIREMISSION
{
	idd = MFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	 scriptName = "Dialog_MarkerFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {MFM_BACKGROUND,MFM_DESCRIPTIONTEXT,MFM_SELECTEDGUNTEXT,MFM_SELECTEDSHELLTEXT,MFM_MARKERTEXT,MFM_DISPERSIONTEXT,MFM_BURSTNUMBERTEXT,MFM_BURSTROUNDSTEXT,
		MFM_DELAYTEXT,MFM_SPOTDISTTEXT,MFM_SELECTEDGUNEDIT,MFM_SELECTEDSHELLEDIT,MFM_NAMEEDIT,MFM_DISPERSIONEDIT,MFM_BURSTNUMBEREDIT,MFM_BURSTROUNDSEDIT,
		MFM_BURSTDELAYEDIT,MFM_SPOTTINGDISTANCEDIT,MFM_FIREBUTTON,MFM_CANCELBUTTON};
		class MFM_BACKGROUND: RscText
		{
		    idc = -1;
			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX - ARTIBORDERTHICKNESS;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY - ARTIBORDERTHICKNESS;
			w =  ( ARTILAYOUTWIDTH +  ARTILAYOUTWIDTHSPACE) *  safezoneW  + ARTIBORDERTHICKNESS * 2 ;
			h = ARTILAYOUTHEIGHTSPACE * 10 * safezoneH + ARTIBORDERTHICKNESS * 2 ;
		    	shadow = 0;
		    colorBackground[] = {0.65,0.65,0.65,0.7};
		};
		class MFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Marker Firemission"; //--- ToDo: Localize;

			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY;
			w = ARTILAYOUTWIDTH * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};

	shadow = 0;

		};
	class MFM_SELECTEDGUNTEXT: RscText
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
	class MFM_SELECTEDSHELLTEXT: RscText
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
	class MFM_MARKERTEXT: RscText
	{
		idc = -1;
		text = "Marker name:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_DISPERSIONTEXT: RscText
	{
		idc = -1;
		text = "Dispersion:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_BURSTNUMBERTEXT: RscText
	{
		idc = -1;
		text = "Number of bursts:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_BURSTROUNDSTEXT: RscText
	{
		idc = -1;
		text = "Number of rounds per burst:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_DELAYTEXT: RscText
	{
		idc = -1;
		text = "Delay between bursts:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_SPOTDISTTEXT: RscText
	{
		idc = -1;
		text = "Minimum spotting round distance:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_FIREBUTTON: RscButton
	{
		idc = 1430;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	shadow = 0;
			onMouseButtonDown = "[] call FNC_DIA_MarkerFiremissionFire;";
	};
	class MFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = MFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//
		shadow = 0;
		onLBSelChanged = "(_this select 1) call FNC_DIA_MarkerFiremissionSetArtillery;";
	};
	class MFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = MFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 2) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
			shadow = 0;
	};
	class MFM_NAMEEDIT: RscEdit
	{
		idc = MFM_DIA_IDC_NAME;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_DISPERSIONEDIT: RscEdit
	{
		idc = MFM_DIA_IDC_DISPERSION;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = MFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = MFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_BURSTDELAYEDIT: RscEdit
	{
		idc = MFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};


	shadow = 0;
	};
	class MFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = MFM_DIA_IDC_SPOTTING;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

	shadow = 0;
	};
	class MFM_CANCELBUTTON: RscButton
	{
		idc = 1600;
		text = "Cancel"; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	shadow = 0;
			onMouseButtonDown = "[] call FNC_DIA_MarkerFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
