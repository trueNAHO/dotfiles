-- Standard awesome library
-- @since 1.0
local beautiful = require("beautiful")
local gears = require("gears")

-- Standard awesome library
-- @since 1.0
local dpi = beautiful.xresources.apply_dpi
local theme_assets = beautiful.theme_assets
local themes_path = gears.filesystem.get_themes_dir()

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local colors = require(require_table.colors)
local config = require(require_table.config)

return {

    --{{{ Default Variables

    font      = config.font.mono .. " " .. config.font.size,
    wallpaper = themes_path .. "sky/sky-background.png",

    --}}}

    --{{{ Arcchart

    ----arcchart_border_color = nil
    ----arcchart_border_width = nil
    ----arcchart_color        = nil
    ----arcchart_paddings     = nil
    ----arcchart_thickness    = nil

    --}}}

    --{{{ awesome

    awesome_icon = theme_assets.awesome_icon(dpi(15), colors.black.normal, colors.white.normal),

    --}}}

    --{{{ Background

    bg_focus    = colors.white.dim,
    bg_minimize = colors.white.normal,
    bg_normal   = colors.black.normal,
    bg_systray  = colors.red.normal,
    bg_urgent   = colors.red.normal,

    --}}}

    --{{{ Border

    border_focus  = colors.blue.normal,
    border_marked = colors.red.normal,
    border_normal = colors.black.normal,
    border_width  = dpi(1),

    --}}}

    --{{{ Calendar

    ----calendar_font          = nil
    ----calendar_long_weekdays = nil
    ----calendar_spacing       = nil
    ----calendar_start_sunday  = nil
    ----calendar_style         = nil
    ----calendar_week_numbers  = nil

    --}}}

    --{{{ Checkbox

    ----checkbox_bg                 = nil
    ----checkbox_border_color       = nil
    ----checkbox_border_width       = nil
    ----checkbox_check_border_color = nil
    ----checkbox_check_border_width = nil
    ----checkbox_check_color        = nil
    ----checkbox_check_shape        = nil
    ----checkbox_color              = nil
    ----checkbox_paddings           = nil
    ----checkbox_shape              = nil

    --}}}

    --{{{ Column

    ----column_count = nil

    --}}}

    --{{{ Cursor

    ----cursor_mouse_move   = nil
    ----cursor_mouse_resize = nil

    --}}}

    --{{{ Enable

    ----enable_spawn_cursor = nil

    --}}}

    --{{{ Foreground

    fg_focus    = colors.white.normal,
    fg_minimize = colors.white.normal,
    fg_normal   = colors.white.normal,
    fg_urgent   = colors.white.bright,

    --}}}

    --{{{ Fullscreen

    ----fullscreen_hide_border = nil

    --}}}

    --{{{ Gap

    ----gap_single_client = nil

    --}}}

    --{{{ Graph

    ----graph_bg           = nil
    ----graph_border_color = nil
    ----graph_fg           = nil

    --}}}

    --{{{ Hotkeys

    ----hotkeys_bg               = nil
    hotkeys_border_color     = colors.blue.normal,
    ----hotkeys_border_width     = nil
    hotkeys_description_font = "fira code 9",
    ----hotkeys_fg               = nil
    hotkeys_font             = "fira code bold 9",
    hotkeys_group_margin     = dpi(20),
    hotkeys_label_bg         = colors.blue.normal,
    hotkeys_label_fg         = colors.black.dim,
    hotkeys_modifiers_fg     = colors.white.dim,
    ----hotkeys_opacity          = nil
    ----hotkeys_shape            = nil

    --}}}

    --{{{ Icon

    ----icon_theme = nil

    --}}}

    --{{{ Layout

    layout_cornerne   = themes_path .. "default/layouts/cornernew.png",
    layout_cornernw   = themes_path .. "default/layouts/cornernww.png",
    layout_cornerse   = themes_path .. "default/layouts/cornersew.png",
    layout_cornersw   = themes_path .. "default/layouts/cornersww.png",
    layout_dwindle    = themes_path .. "default/layouts/dwindlew.png",
    layout_fairh      = themes_path .. "default/layouts/fairhw.png",
    layout_fairv      = themes_path .. "default/layouts/fairvw.png",
    layout_floating   = themes_path .. "default/layouts/floatingw.png",
    layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png",
    layout_magnifier  = themes_path .. "default/layouts/magnifierw.png",
    layout_max        = themes_path .. "default/layouts/maxw.png",
    layout_spiral     = themes_path .. "default/layouts/spiralw.png",
    layout_tile       = themes_path .. "default/layouts/tilew.png",
    layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png",
    layout_tileleft   = themes_path .. "default/layouts/tileleftw.png",
    layout_tiletop    = themes_path .. "default/layouts/tiletopw.png",

    --}}}

    --{{{ Layoutlist

    ----layoutlist_align                       = nil
    ----layoutlist_bg_normal                   = nil
    ----layoutlist_bg_selected                 = nil
    ----layoutlist_disable_icon                = nil
    ----layoutlist_disable_name                = nil
    ----layoutlist_fg_normal                   = nil
    ----layoutlist_fg_selected                 = nil
    ----layoutlist_font                        = nil
    ----layoutlist_font_selected               = nil
    ----layoutlist_shape                       = nil
    ----layoutlist_shape_border_color          = nil
    ----layoutlist_shape_border_color_selected = nil
    ----layoutlist_shape_border_width          = nil
    ----layoutlist_shape_border_width_selected = nil
    ----layoutlist_shape_selected              = nil
    ----layoutlist_spacing                     = nil

    --}}}

    --{{{ Master

    ----master_count        = nil
    ----master_fill_policy  = nil
    ----master_width_factor = nil

    --}}}

    --{{{ Maximized

    ----maximized_hide_border   = nil
    ----maximized_honor_padding = nil

    --}}}

    --{{{ Menu

    ----menu_bg_focus     = nil
    ----menu_bg_normal    = nil
    ----menu_border_color = nil
    ----menu_border_width = nil
    ----menu_fg_focus     = nil
    ----menu_fg_normal    = nil
    ----menu_font         = nil
    ----menu_height       = nil
    ----menu_submenu      = nil
    ----menu_submenu_icon = nil
    ----menu_width        = nil

    --}}}

    --{{{ Menubar

    ----menubar_bg_normal    = nil
    ----menubar_bg_normal    = nil
    ----menubar_border_color = nil
    ----menubar_border_width = nil
    ----menubar_fg_normal    = nil
    ----menubar_fg_normal    = nil

    --}}}

    --{{{ Mouse

    ----mouse_finder_animate_timeout = nil
    ----mouse_finder_color           = nil
    ----mouse_finder_factor          = nil
    ----mouse_finder_radius          = nil
    ----mouse_finder_timeout         = nil

    --}}}

    --{{{ Notification

    ----notification_bg           = nil
    notification_border_color = colors.red.normal,
    ----notification_border_width = nil
    ----notification_fg           = nil
    ----notification_font         = nil
    ----notification_height       = nil
    ----notification_icon_size    = nil
    ----notification_margin       = nil
    ----notification_max_height   = nil
    ----notification_max_width    = nil
    ----notification_opacity      = nil
    notification_shape        = gears.shape.rounded_rect,
    notification_width        = 500,

    --}}}

    --{{{ Piechart

    ----piechart_border_color = nil
    ----piechart_border_width = nil
    ----piechart_colors       = nil

    --}}}

    --{{{ Progressbar

    ----progressbar_bar_border_color = nil
    ----progressbar_bar_border_width = nil
    ----progressbar_bar_shape        = nil
    ----progressbar_bg               = nil
    ----progressbar_border_color     = nil
    ----progressbar_border_width     = nil
    ----progressbar_fg               = nil
    ----progressbar_margins          = nil
    ----progressbar_paddings         = nil
    ----progressbar_shape            = nil

    --}}}

    --{{{ Prompt

    ----prompt_bg        = nil
    ----prompt_bg_cursor = nil
    ----prompt_fg        = nil
    ----prompt_fg_cursor = nil
    ----prompt_font      = nil

    --}}}

    --{{{ Radialprogressbar

    ----radialprogressbar_border_color = nil
    ----radialprogressbar_border_width = nil
    ----radialprogressbar_color        = nil
    ----radialprogressbar_paddings     = nil

    --}}}

    --{{{ Separator

    ----separator_border_color = nil
    ----separator_border_width = nil
    ----separator_color        = nil
    ----separator_shape        = nil
    ----separator_span_ratio   = nil
    ----separator_thickness    = nil

    --}}}

    --{{{ Slider

    ----slider_bar_border_color    = nil
    ----slider_bar_border_width    = nil
    ----slider_bar_color           = nil
    ----slider_bar_height          = nil
    ----slider_bar_margins         = nil
    ----slider_bar_shape           = nil
    ----slider_handle_border_color = nil
    ----slider_handle_border_width = nil
    ----slider_handle_color        = nil
    ----slider_handle_margins      = nil
    ----slider_handle_shape        = nil
    ----slider_handle_width        = nil

    --}}}

    --{{{ Snap

    ----snap_bg           = nil
    snap_border_width = dpi(2),
    ----snap_shape        = nil

    --}}}

    --{{{ Snapper

    ----snapper_gap = nil

    --}}}

    --{{{ Systray

    ----systray_icon_spacing = nil

    --}}}

    --{{{ Taglist

    ----taglist_bg_empty                    = nil
    ----taglist_bg_focus                    = nil
    ----taglist_bg_occupied                 = nil
    ----taglist_bg_urgent                   = nil
    ----taglist_bg_volatile                 = nil
    ----taglist_disable_icon                = nil
    ----taglist_fg_empty                    = nil
    ----taglist_fg_focus                    = nil
    ----taglist_fg_occupied                 = nil
    ----taglist_fg_urgent                   = nil
    ----taglist_fg_volatile                 = nil
    ----taglist_font                        = nil
    ----taglist_shape                       = nil
    ----taglist_shape_border_color          = nil
    ----taglist_shape_border_color_empty    = nil
    ----taglist_shape_border_color_focus    = nil
    ----taglist_shape_border_color_urgent   = nil
    ----taglist_shape_border_color_volatile = nil
    ----taglist_shape_border_width          = nil
    ----taglist_shape_border_width_empty    = nil
    ----taglist_shape_border_width_focus    = nil
    ----taglist_shape_border_width_urgent   = nil
    ----taglist_shape_border_width_volatile = nil
    ----taglist_shape_empty                 = nil
    ----taglist_shape_focus                 = nil
    ----taglist_shape_urgent                = nil
    ----taglist_shape_volatile              = nil
    ----taglist_spacing                     = nil
    ----taglist_squares_resize              = nil
    taglist_squares_sel                 = theme_assets.taglist_squares_sel(dpi(3), colors.white.normal),
    ----taglist_squares_sel_empty           = nil
    taglist_squares_unsel               = theme_assets.taglist_squares_unsel(dpi(3), colors.white.normal),
    ----taglist_squares_unsel_empty         = nil

    --}}}

    --{{{ Tasklist

    ----tasklist_align                        = nil
    ----tasklist_bg_focus                     = nil
    ----tasklist_bg_image_focus               = nil
    ----tasklist_bg_image_minimize            = nil
    ----tasklist_bg_image_normal              = nil
    ----tasklist_bg_image_urgent              = nil
    ----tasklist_bg_minimize                  = nil
    ----tasklist_bg_normal                    = nil
    ----tasklist_bg_urgent                    = nil
    ----tasklist_disable_icon                 = nil
    ----tasklist_disable_task_name            = nil
    ----tasklist_fg_focus                     = nil
    ----tasklist_fg_minimize                  = nil
    ----tasklist_fg_normal                    = nil
    ----tasklist_fg_urgent                    = nil
    ----tasklist_font                         = nil
    ----tasklist_font_focus                   = nil
    ----tasklist_font_minimized               = nil
    ----tasklist_font_urgent                  = nil
    ----tasklist_plain_task_name              = nil
    ----tasklist_shape                        = nil
    ----tasklist_shape_border_color           = nil
    ----tasklist_shape_border_color_focus     = nil
    ----tasklist_shape_border_color_minimized = nil
    ----tasklist_shape_border_color_urgent    = nil
    ----tasklist_shape_border_width           = nil
    ----tasklist_shape_border_width_focus     = nil
    ----tasklist_shape_border_width_minimized = nil
    ----tasklist_shape_border_width_urgent    = nil
    ----tasklist_shape_focus                  = nil
    ----tasklist_shape_minimized              = nil
    ----tasklist_shape_urgent                 = nil
    ----tasklist_spacing                      = nil

    --}}}

    --{{{ Titlebar

    ----titlebar_bg                                     = nil
    ----titlebar_bg_focus                               = nil
    ----titlebar_bg_focus                               = nil
    ----titlebar_bg_normal                              = nil
    ----titlebar_bgimage                                = nil
    ----titlebar_bgimage_focus                          = nil
    ----titlebar_bgimage_normal                         = nil
    titlebar_close_button_focus                     = themes_path .. "default/titlebar/close_focus.png",
    ----titlebar_close_button_focus_hover               = nil
    ----titlebar_close_button_focus_press               = nil
    titlebar_close_button_normal                    = themes_path .. "default/titlebar/close_normal.png",
    ----titlebar_close_button_normal_hover              = nil
    ----titlebar_close_button_normal_press              = nil
    ----titlebar_fg                                     = nil
    ----titlebar_fg_focus                               = nil
    ----titlebar_fg_focus                               = nil
    ----titlebar_fg_normal                              = nil
    ----titlebar_floating_button_focus                  = nil
    titlebar_floating_button_focus_active           = themes_path .. "default/titlebar/floating_focus_active.png",
    ----titlebar_floating_button_focus_active_hover     = nil
    ----titlebar_floating_button_focus_active_press     = nil
    titlebar_floating_button_focus_inactive         = themes_path .. "default/titlebar/floating_focus_inactive.png",
    ----titlebar_floating_button_focus_inactive_hover   = nil
    ----titlebar_floating_button_focus_inactive_press   = nil
    ----titlebar_floating_button_normal                 = nil
    titlebar_floating_button_normal_active          = themes_path .. "default/titlebar/floating_normal_active.png",
    ----titlebar_floating_button_normal_active_hover    = nil
    ----titlebar_floating_button_normal_active_press    = nil
    titlebar_floating_button_normal_inactive        = themes_path .. "default/titlebar/floating_normal_inactive.png",
    ----titlebar_floating_button_normal_inactive_hover  = nil
    ----titlebar_floating_button_normal_inactive_press  = nil
    ----titlebar_maximized_button_focus                 = nil
    titlebar_maximized_button_focus_active          = themes_path .. "default/titlebar/maximized_focus_active.png",
    ----titlebar_maximized_button_focus_active_hover    = nil
    ----titlebar_maximized_button_focus_active_press    = nil
    titlebar_maximized_button_focus_inactive        = themes_path .. "default/titlebar/maximized_focus_inactive.png",
    ----titlebar_maximized_button_focus_inactive_hover  = nil
    ----titlebar_maximized_button_focus_inactive_press  = nil
    ----titlebar_maximized_button_normal                = nil
    titlebar_maximized_button_normal_active         = themes_path .. "default/titlebar/maximized_normal_active.png",
    ----titlebar_maximized_button_normal_active_hover   = nil
    ----titlebar_maximized_button_normal_active_press   = nil
    titlebar_maximized_button_normal_inactive       = themes_path .. "default/titlebar/maximized_normal_inactive.png",
    ----titlebar_maximized_button_normal_inactive_hover = nil
    ----titlebar_maximized_button_normal_inactive_press = nil
    titlebar_minimize_button_focus                  = themes_path .. "default/titlebar/minimize_focus.png",
    ----titlebar_minimize_button_focus_hover            = nil
    ----titlebar_minimize_button_focus_press            = nil
    titlebar_minimize_button_normal                 = themes_path .. "default/titlebar/minimize_normal.png",
    ----titlebar_minimize_button_normal_hover           = nil
    ----titlebar_minimize_button_normal_press           = nil
    ----titlebar_ontop_button_focus                     = nil
    titlebar_ontop_button_focus_active              = themes_path .. "default/titlebar/ontop_focus_active.png",
    ----titlebar_ontop_button_focus_active_hover        = nil
    ----titlebar_ontop_button_focus_active_press        = nil
    titlebar_ontop_button_focus_inactive            = themes_path .. "default/titlebar/ontop_focus_inactive.png",
    ----titlebar_ontop_button_focus_inactive_hover      = nil
    ----titlebar_ontop_button_focus_inactive_press      = nil
    ----titlebar_ontop_button_normal                    = nil
    titlebar_ontop_button_normal_active             = themes_path .. "default/titlebar/ontop_normal_active.png",
    ----titlebar_ontop_button_normal_active_hover       = nil
    ----titlebar_ontop_button_normal_active_press       = nil
    titlebar_ontop_button_normal_inactive           = themes_path .. "default/titlebar/ontop_normal_inactive.png",
    ----titlebar_ontop_button_normal_inactive_hover     = nil
    ----titlebar_ontop_button_normal_inactive_press     = nil
    ----titlebar_sticky_button_focus                    = nil
    titlebar_sticky_button_focus_active             = themes_path .. "default/titlebar/sticky_focus_active.png",
    ----titlebar_sticky_button_focus_active_hover       = nil
    ----titlebar_sticky_button_focus_active_press       = nil
    titlebar_sticky_button_focus_inactive           = themes_path .. "default/titlebar/sticky_focus_inactive.png",
    ----titlebar_sticky_button_focus_inactive_hover     = nil
    ----titlebar_sticky_button_focus_inactive_press     = nil
    ----titlebar_sticky_button_normal                   = nil
    titlebar_sticky_button_normal_active            = themes_path .. "default/titlebar/sticky_normal_active.png",
    ----titlebar_sticky_button_normal_active_hover      = nil
    ----titlebar_sticky_button_normal_active_press      = nil
    titlebar_sticky_button_normal_inactive          = themes_path .. "default/titlebar/sticky_normal_inactive.png",
    ----titlebar_sticky_button_normal_inactive_hover    = nil
    ----titlebar_sticky_button_normal_inactive_press    = nil

    --}}}

    --{{{ Tooltip

    ----tooltip_align        = nil
    ----tooltip_bg           = nil
    ----tooltip_bg_color     = nil
    ----tooltip_border_color = nil
    ----tooltip_border_width = nil
    ----tooltip_fg           = nil
    ----tooltip_fg_color     = nil
    ----tooltip_font         = nil
    ----tooltip_opacity      = nil
    ----tooltip_shape        = nil

    --}}}

    --{{{ Useless

    useless_gap = dpi(2),

    --}}}

    --{{{ Wibar

    ----wibar_bg           = nil
    ----wibar_bgimage      = nil
    ----wibar_border_color = nil
    ----wibar_border_width = nil
    ----wibar_cursor       = nil
    ----wibar_fg           = nil
    ----wibar_height       = nil
    ----wibar_ontop        = nil
    ----wibar_opacity      = nil
    ----wibar_shape        = nil
    ----wibar_stretch      = nil
    ----wibar_type         = nil
    ----wibar_width        = nil

    --}}}

}
