// Params: https://community.bistudio.com/wiki/Arma_3_Mission_Parameters

class TimeOfDay {
	title = "Time";
	texts[] = {"0600", "1200", "1800", "0000"};
	values[] = {6, 12, 18, 0};
	default = 12;
};

class Weather {
	title = "Weather";
	texts[] = {"Clear", "Cloudy", "Overcast", "Rain", "Storm"};
	values[] = {1, 3, 5, 7, 9};
	default = 1;
};

class Wind {
	title = "Wind";
	texts[] = {"No Wind", "Light breeze", "Moderate breeze", "Strong breeze", "Strong gale", "Violent storm"};
	values[] = {0, 2, 4, 6, 8, 10};
	default = 2;
};

class Fog {
	title = "Fog";
	texts[] = {"No Fog", "Slightly Foggy", "Foggy", "Very Foggy", "No Visibility"};
	values[] = {0, 2.5, 5, 7.5, 10};
	default = 0;
};