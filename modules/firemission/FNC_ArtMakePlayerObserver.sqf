#include "Dia\defs.hpp"

FNC_ArtMakePlayerObserver =
{
	_this spawn
	{
		while{time <= 0} do
		{
			sleep(1);
		};
		if (local (_this select 0)) exitWith
		{
			["Event_ArtPlayerJipped",_this] call CBA_fnc_serverEvent;
		};

	};

};

FNC_ArtMakePlayerObserverServer =
{

		private _unit = _this select 0;
		private	_guns = _this select 1;
		if (isServer) then
		{


				_unit setVariable [VAR_SART_OBSGUNS,_guns,true];
				["Event_ReceiveFoGuns",_guns,_unit] call CBA_fnc_targetEvent;

		};


};
