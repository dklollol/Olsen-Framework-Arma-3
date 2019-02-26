 /*
 * Author: Jords & Drofseh
 *
 * Add random item to unit based on relative weighting.
 *
 * Arguments:
 * 0: unit <object> and loadout name <string> <array>
 * 1: items <array>, chance <array>
 *
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

params ["_unit", "_loadoutType", "_items", "_randomPick", "_valuesArray", "_weightsArray", "_badLoadout"];
_itemCount = count _items;

if (_itemCount % 2 != 0 ) exitWith { // If array has to few or too many elements
	(format ["AddItemRandomPercent: Warning Random Percentage Array wrong size for unit %1 , in loadout %2", _unit, _loadoutType]) call FNC_DebugMessage;
};

_valuesArray = [];
_weightsArray = [];
_badLoadout = false;

for "_i" from 1 to _itemCount step 2 do {

	_itemWeight = _items select _i select 0;
	_itemValue = _items select (_i - 1);

	if (typeName _itemWeight != "SCALAR") exitWith {
		_badLoadout = true;
		(format ["AddItemRandomPercent: Warning Random Percentage Array item weight (%3) must be a number for unit %1 , in loadout %2", _unit, _loadoutType, _itemWeight]) call FNC_DebugMessage;
	};
	{
		if (typeName _x != "ARRAY") exitWith {
			_badLoadout = true;
			(format ["AddItemRandomPercent: Warning Random Percentage Array item value (%3) must be an array with a string for unit %1 , in loadout %2", _unit, _loadoutType, _x]) call FNC_DebugMessage;
		};
	} forEach _itemValue;

	_weightsArray pushBack _itemWeight;
	_valuesArray pushBack _itemValue;
};

if (_badLoadout) exitWith {
	_badLoadout = false;
	(format ["AddItemRandomPercent: Warning Random Percentage Array is not valid for unit %1 , in loadout %2", _unit, _loadoutType]) call FNC_DebugMessage;
};

_randomPick = _valuesArray selectRandomWeighted _weightsArray;
{ ([_unit, _loadoutType] + _x) call FNC_AddItemOrg; } forEach _randomPick;
