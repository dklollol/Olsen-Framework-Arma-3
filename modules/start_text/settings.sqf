//_area text displayed at the start showing what area of the map you spawned in.
//_map text displayed at the start showing what map your playing.

switch (side player) do { //Checks what team the player is on

	case west: { //If player is west he receives this message
		
		_area = "Assualt point BRAVO";
		_map = "Chernarus";
		
	}; //End of west case
}; //End of switch
