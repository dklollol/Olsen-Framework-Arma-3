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
	controls[] = {LFM_BACKGROUND,LFM_DESCRIPTIONTEXT,LFM_SELECTEDGUN,LFM_SELECTEDSHELLTEXT,LFM_STARTGRID,LFM_ENDGRID,LFM_BURSTNUMBERTEXT,LFM_BURSTROUNDSTEXT,
		LFM_DELAYTEXT,LFM_SPOTDISTTEXT,LFM_SELECTEDGUNEDIT,LFM_SELECTEDSHELLEDIT,LFM_STARTGRIDEDIT,LFM_ENDGRIDEDIT,LFM_BURSTNUMBEREDIT,LFM_BURSTROUNDSEDIT,LFM_BURSTDELAYEDIT,LFM_SPOTTINGDISTANCEDIT,LFM_FIREBUTTON,LFM_CANCELBUTTON};
		class LFM_BACKGROUND: RscText
		{
			idc = -1;
			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX - ARTIBORDERTHICKNESS;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY - ARTIBORDERTHICKNESS;
			w =  ( ARTILAYOUTWIDTH +  ARTILAYOUTWIDTHSPACE) *  safezoneW  + ARTIBORDERTHICKNESS * 2 ;
			h = ARTILAYOUTHEIGHTSPACE * 10 * safezoneH + ARTIBORDERTHICKNESS * 2 ;
			shadow = 0;
			colorBackground[] = {0.65,0.65,0.65,0.7};
		};
		class LFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "Line Firemission"; //--- ToDo: Localize;

			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY;
			w = ARTILAYOUTWIDTH * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;

		};
	class LFM_SELECTEDGUN: RscText
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
	class LFM_SELECTEDSHELLTEXT: RscText
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
	class LFM_STARTGRID: RscText
	{
		idc = -1;
		text = "Start Grid:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_ENDGRID: RscText
	{
		idc = -1;
		text = "End Grid:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_BURSTNUMBERTEXT: RscText
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
	class LFM_BURSTROUNDSTEXT: RscText
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
	class LFM_DELAYTEXT: RscText
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
	class LFM_SPOTDISTTEXT: RscText
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
	class LFM_FIREBUTTON: RscButton
	{
		idc = -1;
		text = "Fire Artillery"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_LineFiremissionFire;";
	};
	class LFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = LFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		//colorText[] = {0,1,1,1};
		//colorBackground[] = {1,1,1,1};
		//colorActive[] = {0,1,0,1};
		onLBSelChanged = "(_this select 1) call FNC_DIA_LineFiremissionSetArtillery;";
	};
	class LFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = LFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 2) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
	};
	class LFM_STARTGRIDEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_STARTGRID;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_ENDGRIDEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_ENDGRID;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 4) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_BURSTNUMBEREDIT: RscEdit
	{
		idc = LFM_DIA_IDC_BURSTNUMBER;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 6) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_BURSTDELAYEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_BURSTDELAY;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_SPOTTINGDISTANCEDIT: RscEdit
	{
		idc = LFM_DIA_IDC_SPOTTING;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};
		shadow = 0;

	};
	class LFM_CANCELBUTTON: RscButton
	{

		shadow = 0;
		idc = 1600;
		text = "Cancel"; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;

			onMouseButtonDown = "[] call FNC_DIA_LineFiremissionCloseDialog;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
