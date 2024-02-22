/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx       = 3;   /* border pixel of windows */
static const unsigned int snap           = 32;  /* snap pixel */
static const unsigned int gappih         = 4;  /* horiz inner gap between windows */
static const unsigned int gappiv         = 4;  /* vert inner gap between windows */
static const unsigned int gappoh         = 4;  /* horiz outer gap between windows and screen edge */
static const unsigned int gappov         = 4;  /* vert outer gap between windows and screen edge */
static const int smartgaps_fact          = 1;   /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */
static const char autostartblocksh[]     = "autostart_blocking.sh";
static const char autostartsh[]          = "autostart.sh";
static const char dwmdir[]               = "dwm";
static const char localshare[]           = ".local/share";
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon               = 'A';
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int showsystray             = 1;   /* 0 means no systray */



/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype              = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype            = INDICATOR_NONE;
static int floatindicatortype            = INDICATOR_TOP_LEFT_SQUARE;
static const char *fonts[]               = {
    "Sarasa Mono SC Nerd:style=Regular:size=13",
    "Ubuntu Nerd Font:style=Regular:size=12",
    "JetBrainsMono Nerd Font:style=Regular:size=12",
    "Symbols Nerd Font:size=12" };        /* шрифт бара*/

static const char dmenufont[]            = "monospace:size=12";

static char c000000[]                    = "#000000"; // placeholder value

static char normfgcolor[]                = "#dbdcd5";
static char normbgcolor[]                = "#263238";
static char normbordercolor[]            = "#1d2330";
static char normfloatcolor[]             = "#1d2330";

static char selfgcolor[]                 = "#dbdcd5";
static char selbgcolor[]                 = "#263238";
static char selbordercolor[]             = "#2eb398";
static char selfloatcolor[]              = "#2eb398";

static char titlenormfgcolor[]           = "#dbdcd5";
static char titlenormbgcolor[]           = "#263238";
static char titlenormbordercolor[]       = "#263238";
static char titlenormfloatcolor[]        = "#263238";

static char titleselfgcolor[]            = "#e4c962";
static char titleselbgcolor[]            = "#2eb398";
static char titleselbordercolor[]        = "#263238";
static char titleselfloatcolor[]         = "#263238";

static char tagsnormfgcolor[]            = "#dbdcd5";
static char tagsnormbgcolor[]            = "#263238";
static char tagsnormbordercolor[]        = "#1d2330";
static char tagsnormfloatcolor[]         = "#1d2330";

static char tagsselfgcolor[]             = "#e4c962";
static char tagsselbgcolor[]             = "#2eb398";
static char tagsselbordercolor[]         = "#ff0000";
static char tagsselfloatcolor[]          = "#00ff00";

static char hidnormfgcolor[]             = "#dbdcd5";
static char hidselfgcolor[]              = "#dbdcd5";
static char hidnormbgcolor[]             = "#1d2330";
static char hidselbgcolor[]              = "#1d2330";

static char urgfgcolor[]                 = "#bbbbbb";
static char urgbgcolor[]                 = "#222222";
static char urgbordercolor[]             = "#ff0000";
static char urgfloatcolor[]              = "#db8fd9";


static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */
static char *tagicons[][NUMTAGS] =
{
  [DEFAULT_TAGS]        = { "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 " },
  // [DEFAULT_TAGS]        = { "1  ", "2  ", "3  ", "4  ", "5  ", "6  ", "7  ", "8  ", "9  " },

	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>", "<8>", "<9>" },
};


/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
	RULE(.class = "VirtualBox Manager", .tags = 1 << 4)
	RULE(.class = "TelegramDesktop", .tags = 1 << 5)
	RULE(.class = "ViberPC", .tags = 1 << 5)
	RULE(.class = "Gimp", .tags = 1 << 6)
	RULE(.class = "thunderbird", .title = "Password Required - Mozilla Thunderbird", .isfloating = 1, .tags = 1 << 8)
	RULE(.class = "thunderbird", .tags = 1 << 8)
	RULE(.class = "Arandr", .isfloating = 1)
	RULE(.class = "Deadbeef", .isfloating = 1)
	RULE(.class = "Galculator", .isfloating = 1)
	RULE(.class = "kcalc", .isfloating = 1)
	RULE(.class = "BreakTimer", .isfloating = 1)
	RULE(.class = "Tor Browser", .isfloating = 1)
	RULE(.class = "gnome-font-viewer", .isfloating = 1)
	RULE(.class = "xfce4-power-manager-settings", .isfloating = 1)
	RULE(.class = "Pavucontrol", .isfloating = 1)
	RULE(.class = "Gcolor3", .isfloating = 1)
	RULE(.class = "qt5ct", .isfloating = 1)
	RULE(.class = "Volumeicon", .isfloating = 1)
	RULE(.class = "Lxappearance", .isfloating = 1)
	RULE(.class = "Blueman-manager", .isfloating = 1)
	RULE(.class = "gdebi-gtk", .isfloating = 1)
	RULE(.class = "firefox", .title = "About Mozilla Firefox", .isfloating = 1)
	RULE(.class = "firefox", .title = "О Mozilla Firefox", .isfloating = 1)
	RULE(.class = "Terminator", .title = "Terminator Preferences", .isfloating = 1)
	RULE(.class = "Terminator", .title = "Терминатор Параметры", .isfloating = 1)
	RULE(.class = "Nm-connection-editor", .isfloating = 1)
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{  0,        0,     BAR_ALIGN_RIGHT,  width_systray,            draw_systray,           click_systray,           NULL,                    "systray" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status2d,           draw_status2d,          click_status2d,          NULL,                    "status2d" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_awesomebar,         draw_awesomebar,        click_awesomebar,        NULL,                    "awesomebar" },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */



static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};


/* key definitions */
#define SUPER Mod4Mask
#define ALT Mod1Mask
#define CTRL ControlMask
#define SHFT ShiftMask
#define TAGKEYS(KEY,TAG) \
	{ SUPER,           KEY, view,       {.ui = 1 << TAG} }, \
	{ SUPER|CTRL,      KEY, toggleview, {.ui = 1 << TAG} }, \
	{ SUPER|SHFT,      KEY, tag,        {.ui = 1 << TAG} }, \
	{ SUPER|CTRL|SHFT, KEY, toggletag,  {.ui = 1 << TAG} },



/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define RUNINTERM(cmd) { .v = (const char*[]){ "alacritty", "-e", "/usr/bin/fish", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
/* static const char *имя_команды[] = { "команда", "aргумент", NULL }; */
static const char *dmenucmd[] = {
  "dmenu_run",
  "-i", "-l", "10",
  "-nb", "#263238",
  "-nf", "#24d2af",
  "-sb", "#009185",
  "-fn", "Iosevka-17:normal",
  NULL
};
static const char *rofi[] = { "rofi", "run", "-show", "drun", "-show-icons", NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static const char *flamegui[]  = { "flameshot gui", NULL };
static const char *firefox[]  = { "firefox", NULL };
static const char *qutebrowser[]  = { "qutebrowser", NULL };
static const char *dolphin[]  = { "dolphin", NULL };
static const char *thunar[]  = { "thunar", NULL };
static const char *code[]  = { "code", NULL };
static const char *goldendict[]  = { "goldendict", NULL };
static const char *gvim[]  = { "gvim", NULL };
static const char *brave[]  = { "brave", NULL };
// static const char *reboot[] =    { "reboot", NULL };
// static const char *poweroff[] =  { "poweroff", NULL };


static const Key keys[] = {
	/* modifier           key           function                             argument */
	{ SUPER,              XK_Return,  spawn,                              {.v = termcmd } },
// Personal keybindings
// My dmenu scripts <CTRL + ALT> + KEY
  { CTRL|ALT,           XK_c,  spawn, SHCMD("~/.myScripts/dmscripts/dm-edit-configs.sh") },
  { CTRL|ALT,           XK_p,  spawn, SHCMD("~/.myScripts/dmscripts/dm-run-programs.sh") },
  { CTRL|ALT,           XK_s,  spawn, SHCMD("~/.myScripts/dmscripts/dm-run-scripts.sh") },
  { CTRL|ALT,           XK_x,  spawn, SHCMD("~/.myScripts/dmscripts/dm-system-exit.sh") },
// My applications <SUPER + ALT> + KEY
	{ SUPER|ALT,          XK_d,      spawn,                           {.v = dmenucmd }},
	{ SUPER|ALT,          XK_r,      spawn,                           {.v = rofi } },
	{ SUPER|ALT,          XK_Print,  spawn,                           {.v = flamegui } },
	{ SUPER|ALT,          XK_w,      spawn,                           {.v = firefox } },
	{ SUPER|ALT,          XK_u,      spawn,                           {.v = qutebrowser } },
	{ SUPER|ALT,          XK_e,      spawn,                           {.v = dolphin } },
	{ SUPER|ALT,          XK_n,      spawn,                           {.v = thunar } },
  { SUPER|ALT,          XK_a,      spawn, RUNINTERM("ranger") },
  // { SUPER|ALT,          XK_a,      spawn, SHCMD("$TERMINAL -e $SHELL -c ranger") },
  { SUPER|ALT,          XK_v,      spawn, RUNINTERM("~/.config/vifm/scripts/vifmrun") },
  { SUPER|ALT,          XK_t,      spawn, SHCMD("~/Programs/Telegram/Telegram -workdir ~/.local/share/TelegramDesktop/ -- %u") },
  { SUPER|ALT,          XK_p,      spawn, SHCMD("/Programs/PyCharm-Community/bin/pycharm.sh") },
	{ SUPER|ALT,          XK_c,      spawn,                           {.v = code } },
	{ SUPER|ALT,          XK_g,      spawn,                           {.v = goldendict } },
	{ SUPER|ALT,          XK_m,      spawn,                           {.v = gvim } },
	{ SUPER|ALT,          XK_b,      spawn,                           {.v = brave } },
  { CTRL|SHFT,          XK_Escape, spawn, RUNINTERM("htop") },
// My applications as Root <SUPER + SHIFT + ALT> + KEY
  { SUPER|SHFT|ALT,     XK_v,      spawn, SHCMD("~/.myScripts/runVifmAsRoot.sh") },
  { SUPER|SHFT|ALT,     XK_a,      spawn, SHCMD("~/.myScripts/runRangerAsRoot.sh") },
  { SUPER|SHFT|ALT,     XK_n,      spawn, SHCMD("~/.myScripts/runThunarAsRoot.sh") },
//Hotkeys DWM
	{ SUPER,              XK_b,          togglebar,                        {0} },
	{ SUPER,              XK_j,          focusstack,                       {.i = +1 } },
	{ SUPER,              XK_k,          focusstack,                       {.i = -1 } },
	{ SUPER,              XK_h,          focusstack,                       {.i = +1 } },
	{ SUPER,              XK_l,          focusstack,                       {.i = -1 } },
	{ SUPER|SHFT,         XK_j,          rotatestack,                      {.i = +1 } },
	{ SUPER|SHFT,         XK_k,          rotatestack,                      {.i = -1 } },
	{ SUPER,              XK_s,          incnmaster,                       {.i = +1 } },
	{ SUPER|SHFT,         XK_s,          incnmaster,                       {.i = -1 } },
	// { SUPER,              XK_i,          incnmaster,                       {.i = +1 } },
	// { SUPER,              XK_o,          incnmaster,                       {.i = -1 } },
	{ SUPER|CTRL,         XK_h,          setmfact,                         {.f = -0.05} },
	{ SUPER|CTRL,         XK_l,          setmfact,                         {.f = +0.05} },
	// { SUPER,                       XK_Return,     zoom,                   {0} }, //сделать мастер окном
	// { SUPER|Mod4Mask,              XK_u,          incrgaps,               {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_u,          incrgaps,               {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_i,          incrigaps,              {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_i,          incrigaps,              {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_o,          incrogaps,              {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_o,          incrogaps,              {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_6,          incrihgaps,             {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_6,          incrihgaps,             {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_7,          incrivgaps,             {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_7,          incrivgaps,             {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_8,          incrohgaps,             {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_8,          incrohgaps,             {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_9,          incrovgaps,             {.i = +1 } },
	// { SUPER|Mod4Mask|SHFT,    XK_9,          incrovgaps,             {.i = -1 } },
	// { SUPER|Mod4Mask,              XK_0,          togglegaps,             {0} },
	// { SUPER|Mod4Mask|SHFT,    XK_0,          defaultgaps,            {0} },
 
  { SUPER,                  XK_Escape,        view,                   {0} },

// переключение между двумя последними использованными воркспэйсами 
	// { SUPER|CTRL,             XK_z,          showhideclient,         {0} },
	{ ALT,                    XK_n,          showhideclient,         {0} },
	{ SUPER|SHFT,             XK_c,          killclient,             {0} },
	{ SUPER|SHFT,             XK_r,          quit,                   {1} }, //quit dwm
	{ SUPER|SHFT,             XK_q,          quit,                   {0} },
	{ SUPER,                  XK_t,          setlayout,              {.v = &layouts[0]} }, //tile layout
	{ SUPER,                  XK_f,          setlayout,              {.v = &layouts[1]} }, //floating layout
	{ SUPER,                  XK_m,          setlayout,              {.v = &layouts[2]} }, //monocle layout
	// { SUPER|SHFT              XK_f,      setlayout,              {0} }, //floating window
	{ SUPER|SHFT,             XK_f,      togglefloating,         {0} },
	// { SUPER,                       XK_0,          view,                   {.ui = ~0 } },
	// { SUPER|SHFT,             XK_0,          tag,                    {.ui = ~0 } },
  // focus next/prev monitor
	// { SUPER,                       XK_comma,      focusmon,               {.i = -1 } },
	// { SUPER,                       XK_period,     focusmon,               {.i = +1 } },
	// { SUPER|SHFT,             XK_comma,      tagmon,                 {.i = -1 } },
	// { SUPER|SHFT,             XK_period,     tagmon,                 {.i = +1 } },
	{ SUPER,                        XK_Tab,            cyclelayout,            {.i = -1 } },
	{ SUPER|SHFT,                   XK_Tab,            cyclelayout,            {.i = +1 } },
	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
	TAGKEYS(                        XK_6,                                  5)
	TAGKEYS(                        XK_7,                                  6)
	TAGKEYS(                        XK_8,                                  7)
	TAGKEYS(                        XK_9,                                  8)
};


/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
	{ ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,                   Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,                   Button3,        showhideclient, {0} },
	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },
	{ ClkStatusText,        0,                   Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         SUPER,              Button1,        movemouse,      {0} },
	{ ClkClientWin,         SUPER,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         SUPER,              Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            SUPER,              Button1,        tag,            {0} },
	{ ClkTagBar,            SUPER,              Button3,        toggletag,      {0} },
};


