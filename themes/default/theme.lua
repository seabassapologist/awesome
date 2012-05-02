---------------------------
-- Default awesome theme --
---------------------------
theme = {}

theme.font          = "terminus 8"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#000000"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#eeeeee"
theme.fg_focus      = "#1793d1"
theme.fg_urgent     = "#0099FF"
theme.fg_minimize   = "#888888"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
theme.border_marked = "#1793d1"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
--theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"
theme.menu_bg_normal = "#000000"
theme.menu_bg_focus = "#000000"
theme.menu_border_width = "0"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
--theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/default/background.png" }
theme.wallpaper_cmd = { "awsetbg -f /home/matt/Pictures/Desktops/1600x900/beach.png" }
--theme.wallpaper_cmd = { "nitrogen --restore &" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/matt/.config/awesome/themes/default/layouts/fairh.png"
theme.layout_fairv = "/home/matt/.config/awesome/themes/default/layouts/fairv.png"
theme.layout_floating  = "/home/matt/.config/awesome/themes/default/layouts/floating.png"
theme.layout_magnifier = "/home/matt/.config/awesome/themes/default/layouts/magnifier.png"
theme.layout_max = "/home/matt/.config/awesome/themes/default/layouts/max.png"
theme.layout_fullscreen = "/home/matt/.config/awesome/themes/default/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/matt/.config/awesome/themes/default/layouts/tilebottom.png"
theme.layout_tileleft   = "/home/matt/.config/awesome/themes/default/layouts/tileleft.png"
theme.layout_tile = "/home/matt/.config/awesome/themes/default/layouts/tile.png"
theme.layout_tiletop = "/home/matt/.config/awesome/themes/default/layouts/tiletop.png"
theme.layout_spiral  = "/home/matt/.config/awesome/themes/default/layouts/spiral.png"
theme.layout_dwindle = "/home/matt/.config/awesome/themes/default/layouts/dwindle.png"

theme.awesome_icon = "/home/matt/.config/awesome/themes/default/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
