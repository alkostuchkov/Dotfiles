//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/ /*Command*/	 	                            /*Update Interval*/	/*Update Signal*/
	{"", "~/Programs/DWM/dwmblocks/scripts/updates",      10800, 1},
	{"", "~/Programs/DWM/dwmblocks/scripts/weather",  	  180,   1},
	{"", "~/Programs/DWM/dwmblocks/scripts/cpu",	        1,     1},
	{"", "~/Programs/DWM/dwmblocks/scripts/memory",     	1,     1},
	{"", "~/Programs/DWM/dwmblocks/scripts/keyboard", 	  1,     1},
	{"", "~/Programs/DWM/dwmblocks/scripts/clock",	      60,    0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
