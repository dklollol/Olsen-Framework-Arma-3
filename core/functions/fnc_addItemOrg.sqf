/*
 * Author: Olsen
 *
 * Add item to unit.
 *
 * Arguments:
 * 0: unit to add item to <object>
 * 1: name of loadout <string>
 * 2: item classname <string>
 * 3: amount <number> (optional)
 * 4: container ("uniform"/"vest"/"backpack") <string> (optional)
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

params ["_unit", "_loadoutType", "_item"];
private ["_succes", "_parents", "_type", "_message"];
private _amount = 1;
private _position = "none";

if !([_item, _unit] call FNC_checkClassname) exitWith {};

if (count _this > 3) then {
	_amount = _this select 3;
};

if (count _this > 4) then {
	_position = toLower (_this select 4);
};

for "_x" from 1 to _amount do {
	_succes = false;
	_parents = [configFile >> "CFGweapons" >> _item, true] call BIS_fnc_returnParents;
	_type = (_item call BIS_fnc_itemType) select 1;

	if (_position == "none") then {
		if (!_succes && "Rifle" in _parents) then {
			if (primaryWeapon _unit == "") then {
				_unit addWeaponGlobal _item;
				_succes = true;
			};
		};
		if (!_succes && "Pistol" in _parents) then {
			if (handgunWeapon _unit == "") then {
				_unit addWeaponGlobal _item;
				_succes = true;
			};
		};
		if (!_succes && "Launcher" in _parents) then {
			if (secondaryWeapon _unit == "") then {
				_unit addWeaponGlobal _item;
				_succes = true;
			};
		};
		if (!_succes && _type in ["Map", "GPS", "Compass", "Watch", "NVGoggles"]) then {
			if ([_unit, _type] call FNC_CanLinkItem) then {
				_unit linkItem _item;
				_succes = true;
			};
		};
		if (!_succes && _type == "uniform") then {
			if (uniform _unit == "") then {
				_unit forceAddUniform _item;
				_succes = true;
			};
		};
		if (!_succes && _type == "vest") then {
			if (vest _unit == "") then {
				_unit addVest _item;
				_succes = true;
			};
		};
		if (!_succes && _type == "backpack") then {
			if (backpack _unit == "") then {
				_unit addBackpackGlobal _item;
				_succes = true;
			};
		};
		if (!_succes && _type == "Headgear") then {
			if (headgear _unit == "") then {
				_unit addHeadgear _item;
				_succes = true;
			};
		};
		if (!_succes && _type == "Glasses") then {
			if (goggles _unit == "") then {
				_unit addGoggles _item;
				_succes = true;
			};
		};
		if (!_succes && _type == "Binocular") then {
			if (binocular _unit == "") then {
				_unit addWeaponGlobal _item;
				_succes = true;
			};
		};
		if (!_succes && _type in ["AccessoryMuzzle", "AccessoryPointer", "AccessorySights", "AccessoryBipod"]) then {
			if ([primaryWeapon _unit, _item] call FNC_CanAttachItem) then {
				if (!(_type in primaryWeaponItems _unit)) then {
					_unit addPrimaryWeaponItem _item;
					_succes = true;
				};
			}
			else {
				if ([handgunWeapon _unit, _item] call FNC_CanAttachItem) then {
					if (!(_type in handgunItems _unit)) then {
						_unit addHandgunItem _item;
						_succes = true;
					};
				}
				else {
					if ([secondaryWeapon _unit, _item] call FNC_CanAttachItem) then {
						if (!(_type in secondaryWeaponItems _unit)) then {
							_unit addSecondaryWeaponItem _item;
							_succes = true;
						};
					};
				}
			}
		};
	} else {
		if (!_succes) then {
			switch (_position) do {
				case "backpack": {
					if (_unit canAddItemToBackpack _item || FW_enableOverfill) then {
						if (FW_enableOverfill) then {
							(backpackContainer _unit) addItemCargoGlobal [_item, 1];
						}
						else {
							_unit addItemToBackpack _item;
						};
						_succes = true;
					};
				};
				case "vest": {
					if (_unit canAddItemToVest _item || FW_enableOverfill) then {
						if (FW_enableOverfill) then {
							(vestContainer _unit) addItemCargoGlobal [_item, 1];
						}
						else {
							_unit addItemToVest _item;
						};
						_succes = true;
					};
				};
				case "uniform": {
					if (_unit canAddItemToUniform _item || FW_enableOverfill) then {
						if (FW_enableOverfill) then {
							(uniformContainer _unit) addItemCargoGlobal [_item, 1];
						}
						else {
							_unit addItemToUniform _item;
						};
						_succes = true;
					};
				};
			};
			if (!_succes) then {
				(format ["FNC_AddItem: Warning %1 overflown from %2, in %3, case %4", _item, _position, _unit, _loadoutType]) call FNC_DebugMessage;
			};
		};
	};

	if (!_succes) then {
		if (_unit canAdd _item && _type != "Backpack") then {
			_unit addItem _item;
			_succes = true;
		} else {
			_message = "FNC_AddItem: Warning couldn't fit %1 anywhere, originally intended for %2, in %3, case %4";

			if (_position == "none") then {
				_message = "FNC_AddItem: Warning couldn't fit %1 anywhere, in %3, case %4";
			};
			(format [_message, _item, _position, _unit, _loadoutType]) call FNC_DebugMessage;
		};
	};
};