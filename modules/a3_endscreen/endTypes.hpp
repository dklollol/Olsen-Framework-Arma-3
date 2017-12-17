// EndTypes
class CfgDebriefing {

	// EndTypes Templates
	class OPFOREliminated {
		subtitle = "OPFOR took too many casualties";
		pictureBackground = "";
		picture = "o_inf";
		pictureColor[] = {0.5,0.0,0.0,1};
	};

	class BLUFOREliminated {
		subtitle = "BLUFOR took too many casualties";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};

	class INDFOREliminated {
		subtitle = "INDFOR took too many casualties";
		pictureBackground = "";
		picture = "n_inf";
		pictureColor[] = {0.0,0.5,0.0,1};
	};

	class CIVEliminated {
		subtitle = "Too many civilians were killed";
		pictureBackground = "";
		picture = "KIA";
		pictureColor[] = {0.4,0.0,0.5,1};
	};

	class TimeLimit {
		subtitle = "Time-limit reached";
		pictureBackground = "";
		picture = "mil_circle";
		pictureColor[] = {0.7,0.6,0.0,1};
	};
	
	// Default call_mission EndTypes
	class MissionCalled {
		subtitle = "The mission was called by a CO";
		pictureBackground = "";
		picture = "hd_objective";
		pictureColor[] = {0.7,0.6,0.0,1};
	};
	
	class AdminCalled {
		subtitle = "The mission was called by the Admin";
		pictureBackground = "";
		picture = "mil_objective";
		pictureColor[] = {0.7,0.6,0.0,1};
	};

};
