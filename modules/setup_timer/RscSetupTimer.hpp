class RscSetupTimer
{
	onLoad="_this call FNC_SetupTimerInit;";
	idd=-1;
	duration=1200;
	movingEnable=0;
	class Controls
	{
		class TitleBackground
		{
			colorBackground[]=
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"
			};
			idc=1002;
			x="13.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y="30.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w="13 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h="1.5 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			style=0;
			type = 0;
			shadow=1;
			colorShadow[]={0,0,0,0.5};
			text="Setup Timer";
			font="PuristaMedium";
			SizeEx="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			colorText[]={1,1,1,1};
			linespacing=1;
			tooltipColorText[]={1,1,1,1};
			tooltipColorBox[]={1,1,1,1};
			tooltipColorShade[]={0,0,0,0.64999998};
		};
		class Title
		{
			idc=1001;
			x="13.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y="30.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w="13 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h="1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[]={0,0,0,0.5};
			style=0;
			type = 0;
			shadow=1;
			colorShadow[]={0,0,0,0.5};
			text="Setup Timer";
			font="PuristaMedium";
			SizeEx="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			colorText[]={1,1,1,1};
			linespacing=1;
			tooltipColorText[]={1,1,1,1};
			tooltipColorBox[]={1,1,1,1};
			tooltipColorShade[]={0,0,0,0.64999998};
		};
		class SetupTimeLeft
		{
			idc=1003;
			text="  --:--.---";
			x="19 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y="30.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w="7 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h="1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx="1.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			style=0;
			type = 0;
			shadow=1;
			colorShadow[]={0,0,0,0.5};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			colorBackground[]={0,0,0,0};
			linespacing=1;
			tooltipColorText[]={1,1,1,1};
			tooltipColorBox[]={1,1,1,1};
			tooltipColorShade[]={0,0,0,0.64999998};
		};
	};
};
