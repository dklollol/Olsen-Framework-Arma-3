
	class AIAttackStrength {
		title = "Max attacking AI on the map at the same time!";
		values[] = {60,75,90,105,125,150};
		texts[] = {"Easy(60 AI)","Doable(75 AI)","Allright(90 AI)","Good (105 AI)","Much Fun(125 AI)","This might be hard (150 AI)"};
		default = 90;
	};

	class AIAttackSkill {
		title = "Skill level of the attacking AI!";
		values[] = {50,60,70,80,90,100};
		texts[] = {"Weak(50)","HereAndThere(60)","Medium(70)","UO-Level(80)","Gulag-Level(90)","Russian Community(100)"};
		default = 70;
	};

	class AIAttackCleanUp {
		title = "Cleanup of dead AI! Don't turn off if lots of AI are attacking!";
		values[] = {0,1};
		texts[] = {"Off","On"};
		default = 1;
	};

	class AIAttackPrepTime {
		title = "Time for the attack to begin!";
		values[] = {5,10};
		texts[] = {"5 mins","10 mins"};
		default = 5;
	};
