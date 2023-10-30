// {{{ ---- XMOUSELESS ----

//           ██╗  ██╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗███████╗
//           ╚██╗██╔╝████╗ ████║██╔═══██╗██║   ██║██╔════╝██╔════╝
//            ╚███╔╝ ██╔████╔██║██║   ██║██║   ██║███████╗█████╗
//            ██╔██╗ ██║╚██╔╝██║██║   ██║██║   ██║╚════██║██╔══╝
//           ██╔╝ ██╗██║ ╚═╝ ██║╚██████╔╝╚██████╔╝███████║███████╗
//           ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
//                     ██╗     ███████╗███████╗███████╗
//                     ██║     ██╔════╝██╔════╝██╔════╝
//                     ██║     █████╗  ███████╗███████╗
//                     ██║     ██╔══╝  ╚════██║╚════██║
//                     ███████╗███████╗███████║███████║
//                     ╚══════╝╚══════╝╚══════╝╚══════╝
//                                      Tool: http://patorjk.com/software/taag/
//                                      Font: ANSI Shadow

//                                  ███████
//                              ████       ████
//                            ██   █       █   ██
//                            ██   ██      █   ██
//                          ██     █ █     █     ██
//                          ██     █  █    █     ██ GitHub:
//                          ██     █   █   █     ██ https://github.com/trueNAHO
//                          ██     █    █  █     ██
//                            ██   █     █ █   ██
//                            ██   █      ██   ██
//                              ████       ████
//                                  ███████
//

// }}}

// This configuration file is a "C" header file. Every time you edit this file,
// you MUST recompile the 'xmouseless' binary (by running the "make" command).
// A List of all keysym names with their associatoed codes can be found in the
// following path: "/usr/include/X11/keysymdef.h".

// The rate at which the mouse moves in Hz. Does not change its speed.
static const unsigned int move_rate = 120;

// Default speed of the mouse pointer in pixels per second.
static const unsigned int default_speed = 400;

// Default scroll speed.
int const default_scroll = 40;

// Changes the speed of the mouse pointer.
static SpeedBinding speed_bindings[] = {
    // key             speed
    { XK_w,            default_speed / 5 },
    { XK_Control_L,    default_speed / 5 },
    { XK_Control_R,    default_speed / 5 },
    { XK_r,            default_speed * 5 },
    { XK_Shift_L,      default_speed * 5 },
    { XK_Shift_R,      default_speed * 5 },
};

// Moves the mouse pointer. You can also add any other direction
// (e.g. diagonals).
static MoveBinding move_bindings[] = {
    // key          x      y
    { XK_h,        -1,     0 },
    { XK_Left,     -1,     0 },
    { XK_j,         0,     1 },
    { XK_Down,      0,     1 },
    { XK_k,         0,    -1 },
    { XK_Up,        0,    -1 },
    { XK_l,         1,     0 },
    { XK_Right,     1,     0 },
};

// 1: left
// 2: middle
// 3: right
static ClickBinding click_bindings[] = {
    // key          button
    { XK_f,         1 },
    { XK_Return,    1 },
    { XK_d,         2 },
    { XK_s,         3 },
};

// Scrolls up, down, left and right. A higher value scrolls faster.
static ScrollBinding scroll_bindings[] = {
    // key        x                    y
    { XK_z,       -default_scroll,     0              },
    { XK_u,        0,                  default_scroll },
    { XK_i,        0,                 -default_scroll },
    { XK_o,        default_scroll,     0              },
};

// Executes shell commands.
static ShellBinding shell_bindings[] = {
    // key         command
    { XK_m,        "xdotool mousemove 0 0" },
    { XK_comma,    "xdotool mousemove 0 $(xrandr | gawk 'BEGIN {FPAT=\"[0-9]+\"} $0 ~ \"*\" {print $2}')" },
    { XK_period,   "xdotool mousemove $(xrandr | gawk 'BEGIN {FPAT=\"[0-9]+\"} $0 ~ \"*\" {print $1}') 0" },
    { XK_slash,    "xdotool mousemove $(xrandr | gawk 'BEGIN {FPAT=\"[0-9]+\"} $0 ~ \"*\" {print $1, $2}')" },
};

// Exits on key release which allows click and exit with one key.
static KeySym exit_keys[] = {
    XK_Escape, XK_q, XK_c
};
