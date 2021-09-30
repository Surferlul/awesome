----------------------------------------
--    "idk what yet" awesome theme    --
--       By Lukas B. (Surferlul)      --
--  based on "Zenburn" awesome theme  --
--        By Adrian C. (anrxc)        --
----------------------------------------

local themes_path = "/home/surferlul/.config/awesome/themes/"
local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local gears = require("gears")


-- {{{ Main
local theme = {}
theme.dir = themes_path.."blueish/"
theme.wallpaper = { theme.dir .. "dreams_1920x1080.png" , theme.dir .. "dreams.png" }
-- }}}


-- {{{ Styles
theme.font      = "sans 8"

-- {{{ Colors
theme.fg_normal  = "#EDEDDD"
theme.fg_focus   = "#F0DFAF"
theme.fg_urgent  = "#CC9393"
theme.bg_normal  = "#4A3F9877"
theme.bg_focus   = "#080811BB"
theme.bg_urgent  = "#916A9D77"
theme.bg_systray = theme.bg_normal
-- }}}

theme.hotkeys_bg        = "#111122"
theme.hotkeys_fg        = "#EEEEFF"
theme.hotkeys_label_fg  = "#111122"
theme.hotkeys_modifiers_fg = "#DD7777"
theme.hotkeys_description_font = "Indie Flower Bold 10"
theme.hotkeys_border_width = 2
theme.hotkeys_border_color = "#6f6f6f55"
theme.hotkeys_shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end
theme.menubar_bg_normal = "#111122" --CC"
theme.menubar_tag_bg_normal = "#00000000"
theme.menubar_fg_normal = "#FFBBBB"
theme.menubar_bg_focus  = "#333344FF"
theme.menubar_fg_focus  = "#BBBBFF"

theme.menu_bg_normal = "#11112299"
theme.menu_fg_normal = "#FFBBBB"
theme.menu_bg_focus  = "#333344FF"
theme.menu_fg_focus  = "#BBBBFF"

-- {{{ Borders
theme.shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end
theme.useless_gap   = 2
theme.border_width  = 1
theme.border_width_focus = 1
--theme.border_normal = "#00000077" -- basically no border
--theme.border_focus = "#00000000" -- slightly more lit up than the shadow
theme.border_normal = "#554477"
theme.border_focus = "#332244"
theme.border_marked = "#CC939355"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme.dir .. "taglist/squarefz.png"
theme.taglist_squares_unsel = theme.dir .. "taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = theme.dir .. "awesome-icon.png"
theme.menu_submenu_icon      = theme.dir .. "submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme.dir .. "layouts/tile.png"
theme.layout_tileleft   = theme.dir .. "layouts/tileleft.png"
theme.layout_tilebottom = theme.dir .. "layouts/tilebottom.png"
theme.layout_tiletop    = theme.dir .. "layouts/tiletop.png"
theme.layout_fairv      = theme.dir .. "layouts/fairv.png"
theme.layout_fairh      = theme.dir .. "layouts/fairh.png"
theme.layout_spiral     = theme.dir .. "layouts/spiral.png"
theme.layout_dwindle    = theme.dir .. "layouts/dwindle.png"
theme.layout_max        = theme.dir .. "layouts/max.png"
theme.layout_fullscreen = theme.dir .. "layouts/fullscreen.png"
theme.layout_magnifier  = theme.dir .. "layouts/magnifier.png"
theme.layout_floating   = theme.dir .. "layouts/floating.png"
theme.layout_cornernw   = theme.dir .. "layouts/cornernw.png"
theme.layout_cornerne   = theme.dir .. "layouts/cornerne.png"
theme.layout_cornersw   = theme.dir .. "layouts/cornersw.png"
theme.layout_cornerse   = theme.dir .. "layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
