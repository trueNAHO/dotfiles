# vim: fdm=marker tw=79

#                     ██████╗ ████████╗██╗██╗     ███████╗
#                    ██╔═══██╗╚══██╔══╝██║██║     ██╔════╝
#                    ██║   ██║   ██║   ██║██║     █████╗
#                    ██║▄▄ ██║   ██║   ██║██║     ██╔══╝
#                    ╚██████╔╝   ██║   ██║███████╗███████╗
#                     ╚══▀▀═╝    ╚═╝   ╚═╝╚══════╝╚══════╝
#                                       Tool: http://patorjk.com/software/taag/
#                                       Font: ANSI Shadow

#                                   ███████
#                               ████       ████
#                             ██   █       █   ██
#                             ██   ██      █   ██
#                           ██     █ █     █     ██
#                           ██     █  █    █     ██ GitHub:
#                           ██     █   █   █     ██ https://github.com/trueNAHO
#                           ██     █    █  █     ██
#                             ██   █     █ █   ██
#                             ██   █      ██   ██
#                               ████       ████
#                                   ███████

#{{{ Importing
#------------------------------------------------------------------------------
#                                  Importing
#------------------------------------------------------------------------------

import os
import socket
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.core.manager import Qtile
#}}}

#{{{ Settings object
#------------------------------------------------------------------------------
#                               Settings object
#------------------------------------------------------------------------------

class Personal_settings:

    #{{{ Functions
    #------------------------------- Functions --------------------------------

    def iconed_widget(self, *current_widget, icon, icon_fontsize, foreground,
                      background):

        return (
            widget.Spacer(
                background = background,
                width = self.widgetTheme["padding_iconed_widget"]
                ),
            widget.TextBox(
                text = icon,
                font = self.widgetTheme["icon_font"],
                background = background,
                foreground = foreground,
                fontsize = icon_fontsize
                ),
            *current_widget,
            widget.Spacer(
                background = background,
                width = self.widgetTheme["padding_iconed_widget"]
                ),
            )

    @staticmethod
    def chooseOptions(options, choices):

        # Returns all 'choices' from 'options'.
        # 1. options (List): contains options to be selected.
        # 2. choices (List/Tuple > Integers): contains index(es) matching
        #    corresponding items in 'options'.

        assert isinstance(options, (tuple, list)) and \
               isinstance(choices, (tuple, list, int)) and \
               all(
                   type(choice)==int and 0<=choice<=len(options) - 1
                   for choice in choices
                   ) \
                   if type(choices)!=int else \
                   True, \
               f"<options>: {options}. <choices>: {choices}."

        if type(choices)==int:
            return options[choices]
        elif len(choices)==1:
            return options[choices[0]]
        else:
            return [options[choice] for choice in choices]
    #}}}

    #{{{ Global variabels
    #--------------------------- Global variabels ----------------------------

    all_colors = [
         # [<Darkest>, <2nd darkest>, <3rd darkest>, <Brightest>, <Warning>]
         ["#0d0d0d", "#262626", "#333333", "#c5c5c5", "#e06c75"],
         ["#1a1b29", "#6b6e94", "#817494", "#c5c5c5", "#e06c75"],
         ["#1a1b29", "#61afef", "#56b6c2", "#c5c5c5", "#e06c75"]
         ]
    #}}}

    #{{{ __init__
    #-------------------------------- __init__ ---------------------------------

    def __init__(self,
                 mod,
                 terminal,
                 choose_colorTheme,
                 choose_layoutTheme,
                 choose_layoutTypes,
                 choose_widgetTheme,
                 choose_widgetPreset,
                 files_startupOnce,
                 rule_autoFullscreen,
                 settings_audioIncrement,
                 settings_brightnessIncrement,
                 settings_floatingLayoutRules):

        #{{{ Startup
        #------------------------------ Startup -------------------------------

        @hook.subscribe.startup_once
        def startupOnce():
            for file in self.files_startupOnce:
                subprocess.call([os.path.expanduser(file)])
        #}}}

        #{{{ Colors and Layout
        #------------------------- Colors and Layout --------------------------

        self.colorTheme = self.chooseOptions(__class__.all_colors, [choose_colorTheme])
        self.all_layoutThemes = [
                {
                    "border_focus": self.colorTheme[3],
                    "border_normal": self.colorTheme[0],
                    "border_width": 1,
                    "margin": 3
                    },
                {
                    "border_focus": self.colorTheme[2],
                    "border_normal": self.colorTheme[0],
                    "border_width": 3,
                    "margin": 3
                    }
                ]
        self.layoutTheme = self.chooseOptions(self.all_layoutThemes, [choose_layoutTheme])
        self.all_layoutTypes = [
                layout.Bsp(**self.layoutTheme),
                layout.Columns(**self.layoutTheme),
                layout.Floating(**self.layoutTheme),
                layout.Matrix(**self.layoutTheme),
                layout.Max(**self.layoutTheme),
                layout.MonadTall(**self.layoutTheme),
                layout.MonadWide(**self.layoutTheme),
                layout.RatioTile(**self.layoutTheme),
                layout.Slice(**self.layoutTheme),
                layout.Stack(**self.layoutTheme),
                layout.Tile(**self.layoutTheme),
                layout.TreeTab(**self.layoutTheme),
                layout.VerticalTile(**self.layoutTheme),
                layout.Zoomy(**self.layoutTheme)
                ]
        self.layoutTypes = self.chooseOptions(self.all_layoutTypes, choose_layoutTypes)
        #}}}

        #{{{ Widgets
        #------------------------------ Widgets -------------------------------

        self.all_widgetThemes = [
            # icon_fontsizes (List/Tuple): index 0 represents rightmost widget
            # and highest index represents leftmost widget.
            {
                "bar_edges_width_left": 3,
                "bar_edges_width_right": -3,
                "bar_size": 20,
                "font": "Ubuntu Mono",
                "fontsize": 12,
                "icon_font": "FiraCode Nerd Font Mono",
                "icon_fontsizes": (18, 16, 10, 16, 19),
                "padding": 0,
                "padding_iconed_widget": 8,
                "seperator_size": 30,
                "seperator_size_fixer_left": 3
                }
            ]
        self.widgetTheme = self.chooseOptions(self.all_widgetThemes, [choose_widgetTheme])
        self.all_widgetSeperators = {
                "left": widget.TextBox(
                    text = "",
                    font = "Fira Code",
                    background = self.colorTheme[0],
                    foreground = self.colorTheme[1],
                    padding = 0,
                    fontsize = self.widgetTheme["seperator_size"]
                    ),
                "even": [
                    widget.Spacer(
                        background = self.colorTheme[1],
                        width = self.widgetTheme["seperator_size_fixer_left"]
                        ),
                    widget.TextBox(
                        text = "",
                        font = "Fira Code",
                        background = self.colorTheme[1],
                        foreground = self.colorTheme[2],
                        padding = 0,
                        fontsize = self.widgetTheme["seperator_size"]
                        )
                    ],
                "odd": [
                    widget.Spacer(
                        background = self.colorTheme[2],
                        width = self.widgetTheme["seperator_size_fixer_left"]
                        ),
                    widget.TextBox(
                        text = "",
                        font = "Fira Code",
                        background = self.colorTheme[2],
                        foreground = self.colorTheme[1],
                        padding = 0,
                        fontsize = self.widgetTheme["seperator_size"]
                        ),
                    ],
                "right": [
                    widget.Spacer(
                        background = self.colorTheme[1],
                        width = self.widgetTheme["seperator_size_fixer_left"]
                        ),
                    widget.TextBox(
                        text = "",
                        font = "Fira Code",
                        background = self.colorTheme[1],
                        foreground = self.colorTheme[0],
                        padding = 0,
                        fontsize = self.widgetTheme["seperator_size"]
                        )
                    ]
            }
        self.all_widgetPresets = [
                [
                    widget.Spacer(
                        background = self.colorTheme[0],
                        width = self.widgetTheme["bar_edges_width_left"]
                        ),
                    widget.GroupBox(
                        background = self.colorTheme[0],
                        foreground = self.colorTheme[3],
                        active = self.colorTheme[3],
                        disable_drag = True,
                        font = "Ubuntu Bold",
                        fontsize = 10,
                        padding_x = 3,
                        padding_y = 5,
                        margin_x = 0,
                        margin_y = 4,
                        highlight_method="block",
                        inactive = self.colorTheme[2],
                        rounded = False,
                        this_current_screen_border = self.colorTheme[1],
                        urgent_border = self.colorTheme[4],
                        urgent_text = self.colorTheme[4]
                        ),
                    widget.Spacer(background = self.colorTheme[0]),
                    self.all_widgetSeperators["left"],
                    *self.iconed_widget(
                        widget.Backlight(
                            background = self.colorTheme[1],
                            foreground = self.colorTheme[3],
                            backlight_name = "intel_backlight",
                            fmt = " {}"
                            ),
                        icon = "盛",
                        icon_fontsize = self.widgetTheme["icon_fontsizes"][4],
                        background = self.colorTheme[1],
                        foreground = self.colorTheme[3]
                        ),
                    *self.all_widgetSeperators["even"],
                    *self.iconed_widget(
                        widget.Volume(
                            background = self.colorTheme[2],
                            foreground = self.colorTheme[3],
                            fmt = " {}"
                            ),
                        icon = "墳",
                        icon_fontsize = self.widgetTheme["icon_fontsizes"][3],
                        background = self.colorTheme[2],
                        foreground = self.colorTheme[3]
                        ),
                    *self.all_widgetSeperators["odd"],
                    *self.iconed_widget(
                            widget.Battery(
                                background = self.colorTheme[1],
                                foreground = self.colorTheme[3],
                                charge_char = "",
                                discharge_char = "",
                                full_char = "",
                                fontsize = self.widgetTheme["icon_fontsizes"][2],
                                format = "{char}",
                                low_foreground = self.colorTheme[4],
                                low_percentage = 0.33,
                                show_short_text = False,
                                unknown_char = ""
                                ),
                            widget.Battery(
                                background = self.colorTheme[1],
                                foreground = self.colorTheme[3],
                                charge_char = "",
                                discharge_char = "",
                                full_char = "",
                                format = " {percent:.0%}",
                                low_foreground = self.colorTheme[4],
                                low_percentage = 0.33,
                                show_short_text = False,
                                unknown_char = ""
                                ),
                            icon = "",
                            icon_fontsize = 0,
                            background = self.colorTheme[1],
                            foreground = self.colorTheme[3]
                            ),
                    *self.all_widgetSeperators["even"],
                    *self.iconed_widget(
                        widget.Clock(
                            background = self.colorTheme[2],
                            foreground = self.colorTheme[3],
                            format = " %A, %d-%m-%Y",
                            update_interval = 60
                            ),
                        icon = "",
                        icon_fontsize = self.widgetTheme["icon_fontsizes"][1],
                        background = self.colorTheme[2],
                        foreground = self.colorTheme[3],
                        ),
                    *self.all_widgetSeperators["odd"],
                    *self.iconed_widget(
                        widget.Clock(
                            background = self.colorTheme[1],
                            foreground = self.colorTheme[3],
                            format = " %H:%M",
                            update_interval = 60
                            ),
                        icon = "",
                        icon_fontsize = self.widgetTheme["icon_fontsizes"][0],
                        background = self.colorTheme[1],
                        foreground = self.colorTheme[3],
                        ),
                    *self.all_widgetSeperators["right"],
                        widget.Spacer(
                        background = self.colorTheme[0],
                        width = self.widgetTheme["bar_edges_width_right"]
                        )
                ],
            [
                    widget.Spacer(
                        background = self.colorTheme[0],
                        width = self.widgetTheme["bar_edges_width_left"]
                        ),
                    widget.Prompt(
                        background = self.colorTheme[0],
                        foreground = self.colorTheme[3],
                        font = "Ubuntu Mono",
                        ignore_dups_history = True,
                        prompt = "[{}@{}]: ".format(os.environ["USER"], socket.gethostname())
                        )
                    ]
            ]
        self.widgetPreset = self.chooseOptions(self.all_widgetPresets, [choose_widgetPreset])
        #}}}

        #{{{ Groups
        #------------------------------ Groups --------------------------------

        self.groups = [Group(i) for i in "123456789"]
        #}}}

        #{{{ Keybinds
        #----------------------------- Keybinds -------------------------------

        self.keys = [

                # Fundamental keybinds.
                Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
                Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
                Key([mod], "b", lazy.function(Qtile.cmd_hide_show_bar), desc="Toggle visibility of a given bar"),
                Key([mod], "q", lazy.window.kill(), desc="Quit/kill window"),
                Key([mod], "s", lazy.spawn("systemctl suspend"), desc="Run command 'systemctl suspend'"),
                Key([mod], "r", lazy.spawn("dmenu_run -i -l {} -p {} -fn '{}' -nb {} -nf {} -sb {} -sf {}".format(17, "Run", self.widgetTheme["icon_font"], self.colorTheme[0], self.colorTheme[3], self.colorTheme[1], self.colorTheme[3])), desc="Run dmenu_run"),
                Key([mod], "p", lazy.spawn("passmenu -i -l {} -p {} -fn '{}' -nb {} -nf {} -sb {} -sf {}".format(17, "Pass", self.widgetTheme["icon_font"], self.colorTheme[0], self.colorTheme[3], self.colorTheme[1], self.colorTheme[3])), desc="Run passmenu"),

                # Managing brightness and audio.
                Key([mod], "Down", lazy.spawn("xbacklight -dec {}".format(settings_brightnessIncrement)), desc="Decrease hardware brightness"),
                Key([mod], "Up", lazy.spawn("xbacklight -inc {}".format(settings_brightnessIncrement)), desc="Increase hardware brightness"),
                Key([mod], "Left", lazy.spawn("amixer -q sset Master {}%-".format(settings_audioIncrement)), desc="Decrease master volume"),
                Key([mod], "Right", lazy.spawn("amixer -q sset Master {}%+".format(settings_audioIncrement)), desc="Increase master volume"),

                # Moving windows.
                Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
                Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
                Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
                Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
                Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

                # Moving windows.
                Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
                Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
                Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
                Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
                Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

                # Changing widow sizes.
                Key([mod, "control"], "l", lazy.layout.grow(), desc="Increase window size"),
                Key([mod, "control"], "h", lazy.layout.shrink(), desc="Decrease window size"),
                Key([mod, "control"], "j", lazy.layout.normalize(), desc="Reset all window sizes in current group"),
                Key([mod, "control"], "k", lazy.layout.normalize(), desc="Reset all window sizes in current group"),
                ####Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
                ####Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
                ####Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
                ####Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

                # Special keybinds.
                Key([mod, "control", "shift"], "r", lazy.restart(), desc="Restart Qtile"),
                Key([mod, "control", "shift"], "q", lazy.shutdown(), desc="Quit/kill Qtile")

                ]

        # Extra keybinds for each group.
        for i in self.groups:
            self.keys.extend([
                Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
                Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
                Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc="Move focused window to group {}".format(i.name))
                ])

        # Drag floating layouts.
        self.mouse = [
                Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
                Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()), Click([mod], "Button2", lazy.window.bring_to_front())
                ]
        #}}}

        #{{{ More stuff
        #---------------------------- More stuff ------------------------------

        self.mod                = mod
        self.terminal           = terminal
        self.auto_fullscreen    = rule_autoFullscreen
        self.extension_defaults = self.widgetTheme.copy()
        self.floating_layout    = layout.Floating(
                float_rules=settings_floatingLayoutRules
                )
        self.screens            = [
                Screen(top = bar.Bar(self.widgetPreset,
                                     self.widgetTheme["bar_size"],
                                     background=self.colorTheme[0]))
                ]
        #}}}
        #}}}
#}}}

#{{{ Creating settings
#------------------------------------------------------------------------------
#                              Creating settings
#------------------------------------------------------------------------------

settings = Personal_settings(
        mod                          = "mod4",
        terminal                     = "alacritty",
        choose_colorTheme            = 1,
        choose_layoutTheme           = 1,
        choose_layoutTypes           = (5, 6, 4),
        choose_widgetTheme           = 0,
        choose_widgetPreset          = 0,
        files_startupOnce            = ['~/p/scripts/redshift.sh'],
        rule_autoFullscreen          = False,
        settings_audioIncrement      = 5,
        settings_brightnessIncrement = 5,
        settings_floatingLayoutRules = []
        )
#}}}

#{{{ Calling settings
#------------------------------------------------------------------------------
#                              Calling settings
#------------------------------------------------------------------------------

mod             = settings.mod
terminal        = settings.terminal
keys            = settings.keys
mouse           = settings.mouse
groups          = settings.groups
layouts         = settings.layoutTypes
widget_defaults = settings.extension_defaults
screens         = settings.screens
auto_fullscreen = settings.auto_fullscreen
floating_layout = settings.floating_layout

del settings
#}}}

#{{{ To Do List
#------------------------------------------------------------------------------
#                                 Do To List
#------------------------------------------------------------------------------

# To DO: Add more buttons more reseizing windwos with the Monad Layout. Change
# what items are all being imported. That way we could potentially decrease
# memory usage :smile:.

dgroups_key_binder=None
dgroups_app_rules=[] # type: List
main=None # WARNING: this is deprecated and will be removed soon
follow_mouse_focus=True
bring_front_click=False
cursor_warp=False

focus_on_window_activation="smart"

#XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
#string besides java UI toolkits; you can see several discussions on the
#mailing lists, GitHub issues, and other WM documentation that suggest setting
#this string if your java app doesn't work correctly. We may as well just lie
#and say that we're a working one by default.
#
#We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
#java that happens to be on java's whitelist.
wmname="LG3D"
#}}}
