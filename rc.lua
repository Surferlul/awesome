-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local capi = {awesome = awesome}
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
menubar.geometry_override = { width = 200, x = 20 }

--local hotkeys_popup = require("awful.hotkeys_popup")
local hotkeys = require("awful.hotkeys_popup");
--local hotkeys = require("awful.hotkeys_popup")
--local hotkeys_popup = hotkeys_popup.widget.new({ width = 100, height = 100 })
--hotkeys_popup.show_help = hotkeys_popup.widget.show_help
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
--vim = require("awful.hotkeys_popup.keys.vim")
local my_hotkeys_popup = hotkeys.widget.new({ width = 1870, height = 1050});


local vim_rule_any = {name={"vim", "VIM"}}
for group_name, group_data in pairs({
    ["VIM: motion"] =             { color="#009F00", rule_any=vim_rule_any },
    ["VIM: command"] =            { color="#aFaF00", rule_any=vim_rule_any },
    ["VIM: command (insert)"] =   { color="#cF4F40", rule_any=vim_rule_any },
    ["VIM: operator"] =           { color="#aF6F00", rule_any=vim_rule_any },
    ["VIM: find"] =               { color="#65cF9F", rule_any=vim_rule_any },
    ["VIM: scroll"] =             { color="#659FdF", rule_any=vim_rule_any },
}) do
    my_hotkeys_popup:add_group_rules(group_name, group_data)
end


local vim_keys = {

    ["VIM: motion"] = {{
        modifiers = {},
        keys = {
            ['`']="goto mark",
            ['0']='"hard" BOL',
            ['-']="prev line",
            w="next word",
            e="end word",
            ['[']=". misc",
            [']']=". misc",
            ["'"]=". goto mk. BOL",
            b="prev word",
            ["|"]='BOL/goto col',
            ["$"]='EOL',
            ["%"]='goto matching bracket',
            ["^"]='"soft" BOL',
            ["("]='sentence begin',
            [")"]='sentence end',
            ["_"]='"soft" BOL down',
            ["+"]='next line',
            W='next WORD',
            E='end WORD',
            ['{']="paragraph begin",
            ['}']="paragraph end",
            G='EOF/goto line',
            H='move cursor to screen top',
            M='move cursor to screen middle',
            L='move cursor to screen bottom',
            B='prev WORD',
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            u="half page up",
            d="half page down",
            b="page up",
            f="page down",
            o="prev mark",
        }
    }},

    ["VIM: operator"] = {{
        modifiers = {},
        keys = {
            ['=']="auto format",
            y="yank",
            d="delete",
            c="change",
            ["!"]='external filter',
            ['&lt;']='unindent',
            ['&gt;']='indent',
        }
    }},

    ["VIM: command"] = {{
        modifiers = {},
        keys = {
            ['~']="toggle case",
            q=". record macro",
            r=". replace char",
            u="undo",
            p="paste after",
            gg="go to the top of file",
            gf="open file under cursor",
            x="delete char",
            v="visual mode",
            m=". set mark",
            ['.']="repeat command",
            ["@"]='. play macro',
            ["&amp;"]='repeat :s',
            Q='ex mode',
            Y='yank line',
            U='undo line',
            P='paste before cursor',
            D='delete to EOL',
            J='join lines',
            K='help',
            [':']='ex cmd line',
            ['"']='. register spec',
            ZZ='quit and save',
            ZQ='quit discarding changes',
            X='back-delete',
            V='visual lines selection',
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            w=". window operations",
            r="redo",
            ["["]="normal mode",
            a="increase number",
            x="decrease number",
            g="file/cursor info",
            z="suspend",
            c="cancel/normal mode",
            v="visual block selection",
        }
    }},

    ["VIM: command (insert)"] = {{
        modifiers = {},
        keys = {
            i="insert mode",
            o="open below",
            a="append",
            s="subst char",
            R='replace mode',
            I='insert at BOL',
            O='open above',
            A='append at EOL',
            S='subst line',
            C='change to EOL',
        }
    }},

    ["VIM: find"] = {{
        modifiers = {},
        keys = {
            [';']="repeat t/T/f/F",
            [',']="reverse t/T/f/F",
            ['/']=". find",
            ['?']='. reverse find',
            n="next search match",
            N='prev search match',
            f=". find char",
            F='. reverse find char',
            t=". 'till char",
            T=". reverse 'till char",
            ["*"]='find word under cursor',
            ["#"]='reverse find under cursor',
        }
    }},

    ["VIM: scroll"] = {{
        modifiers = {},
        keys = {
            zt="scroll cursor to the top",
            zz="scroll cursor to the center",
            zb="scroll cursor to the bottom",
        }
    },{
        modifiers = {"Ctrl"},
        keys = {
            e="scroll line up",
            y="scroll line down",
        }
    }},
}

my_hotkeys_popup:add_hotkeys(vim_keys)

--my_hotkeys_popup.keys.vim = vim
--local cairo = require("lgi").cairo
 
-- My custom libs
local vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Startup Commands
do
    local cmds = 
    {
        string.format("%s/.config/awesome/startup.sh", os.getenv("HOME")),
    }

    for _,i in pairs(cmds) do
        awful.util.spawn(i)
    end
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "zenburn")
beautiful.init(theme_path)
beautiful.font = "Indie Flower Bold 12"
--local cr = cairo.Context()
--beautiful.hotkeys_shape = gears.shape.rect(cr, 10, 10, 10)
--beautiful.useless_gap = 3


-- This is used later as the default terminal and editor to run.
terminal = "konsole"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() my_hotkeys_popup:show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
--mykeyboardlayout.widget.forced_height = 20
--mykeyboardlayout.widget.text = mykeyboardlayout.widget.text:gsub("%s+", "")
--mykeyboardlayout.widget.forced_width = 20
local clean_textbox = function(w)
	w.text = w.text:sub(2)
	w.text = w.text:sub(1, -2)
end
capi.awesome.connect_signal("xkb::map_changed",
                            function () clean_textbox(mykeyboardlayout.widget) end)
capi.awesome.connect_signal("xkb::group_changed",
                            function () clean_textbox(mykeyboardlayout.widget) end)
clean_textbox(mykeyboardlayout.widget)
-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

--[[local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end--]]

--[[local function set_wallpaper(s)
	wallpaper_safety =	function(arg)	if 	type(arg) == "table" then	return tostring( arg[s.index] or "" )
						elseif	type(arg) == "string" then	return arg
						else 					return ""
						end
				end
	gears.wallpaper.maximized( wallpaper_safety( beautiful.wallpaper ), s, true )
end--]]

local function set_wallpaper(s)
	if s.geometry["width"] == 1920 and s.geometry["height"] == 1080 then
		gears.wallpaper.maximized( beautiful.wallpaper[1], s, true )
	else                                
		gears.wallpaper.maximized( beautiful.wallpaper[2], s, true )
        end
end

----
local dw = {}
for i=1,5 do
    dw[i] = wibox.widget.textbox()
end
vicious.register(dw[1], vicious.widgets.date, "%m")
vicious.register(dw[2], vicious.widgets.date, "%d")
vicious.register(dw[3], vicious.widgets.date, "%H")
vicious.register(dw[4], vicious.widgets.date, "%M", 1)
vicious.register(dw[5], vicious.widgets.date, "%S", 1)
local spacer = {
    {
        {
            color  = '#dddddd',
            shape  = function (cr, width, height) gears.shape.powerline(cr, width/2, height, height/8) end,
       	    widget = wibox.widget.separator,
        },
        layout = wibox.container.rotate,
        direction = "east",
    },
    layout = wibox.layout.constraint,
    strategy = "max",
    height = 8,
}
local datewidget = {
    spacing = -8,
    layout = wibox.layout.fixed.vertical,
}
for k, v in pairs(dw) do
    datewidget[k + 1] = {
        spacer,
	{
		widget = wibox.container.margin,
		left = -2,
		{
			widget=v,
			align = "center",
		}
	},
        layout = wibox.layout.fixed.vertical,
	spacing = -4,
    }
end

--memwidget = wibox.widget.textbox()
--vicious.cache(vicious.widgets.mem)
--vicious.register(memwidget, vicious.widgets.mem, "  $2/$3 $1% $6/$7 $5% ", 1)

-- Create wibox with batwidget
batwidget = wibox.widget.progressbar()
batbox = wibox.layout.margin(
    wibox.widget{ { max_value = 1, widget = batwidget,
                    border_width = 0, border_color = "#000000",
                    color = "#FFFFFF",
		    background_color = "#000000"
	    },
		    --color = { type = "linear",
                    --          from = { 0, 0 },
                    --          to = { 0, 30 },
                    --          stops = { { 0, "#FFFFFF" },
                    --                    { 1, "#000000" } } } },
                  forced_height = 1, forced_width = 1,
                  direction = 'south', color = beautiful.fg_widget,
                  layout = wibox.container.rotate },
    0, 0, 0, 0)

-- Register battery widget
vicious.register(batwidget, vicious.widgets.bat, "$2", 1, "BAT1")


cpuwidget = awful.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_background_color"#4A3F9800"
cpuwidget:set_color{ type = "linear", from = { 0, 0 }, to = { 50, 0 },
                     stops = { { 0, "#4A3F9800" },
                               { 0.1, "#FF5656" },
                               { 0.95, "#4A3F9800" } } }
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 1)

memwidget = awful.widget.graph()
memwidget:set_width(50)
memwidget:set_background_color"#4A3F9800"
memwidget:set_color{ type = "linear", from = { 0, 0 }, to = { 50, 0 },
                     stops = { { 0, "#4A3F9800" },
                               { 0.1, "#FF5656" },
                               { 0.95, "#4A3F9800" } } }
vicious.register(memwidget, vicious.widgets.mem, "$1", 1)

swapwidget = awful.widget.graph()
swapwidget:set_width(50)
swapwidget:set_background_color"#4A3F9800"
swapwidget:set_color{ type = "linear", from = { 0, 0 }, to = { 50, 0 },
                     stops = { { 0, "#4A3F9800" },
                               { 0.1, "#FF5656" },
                               { 0.95, "#4A3F9800" } } }
vicious.register(swapwidget, vicious.widgets.mem, "$5", 1)

----

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    --s.mytaglist = awful.widget.taglist {
    --    screen  = s,
    --    filter  = awful.widget.taglist.filter.all,
    --    buttons = taglist_buttons
    --}
s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    style   = {
        shape = function (cr, width, height) gears.shape.powerline(cr, width*8/10, height, height/4) end
    },
    layout   = {
        spacing = -14,
        spacing_widget = {
            color  = '#dddddd',
            shape  = function (cr, width, height) gears.shape.powerline(cr, width/2, height, height/4) end,
            widget = wibox.widget.separator,
        },
        layout  = wibox.layout.fixed.horizontal
    },
    widget_template = {
        {
            {
                {
                    {
                        --{
			    {
                                id     = 'index_role',
				font   = "Indie Flower Bold 11",
                                widget = wibox.widget.textbox,
                            },
                            
                            widget  = wibox.container.place,
                        --},
                        --bg     = '#55000044',
                        --shape  = gears.shape.circle,
                        --widget = wibox.container.background,
                    },
		    layout = wibox.container.rotate,
		    direction = "east",
	        },
		--{
                --    {
                --        id     = 'icon_role',
                --        widget = wibox.widget.imagebox,
                --    },
                --    margins = 2,
                --    widget  = wibox.container.margin,
                --},
                --{
                --    id     = 'text_role',
                --    widget = wibox.widget.textbox,
                --},
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 5,
            right = 9,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
        -- Add support for hover colors and an index label
        create_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('index_role')[1].markup = '<b>'..index..'</b>'
            --self:connect_signal('mouse::enter', function()
            --    if self.bg ~= '#ff000033' then
            --        self.backup     = self.bg
            --        self.has_backup = true
            --    end
            --    self.bg = '#ff00ff55'
            --end)
            --self:connect_signal('mouse::leave', function()
            --    if self.has_backup then self.bg = self.backup end
            --end)
        end,
        --update_callback = function(self, c3, index, objects) --luacheck: no unused args
        --    self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
        --end,
    },
    buttons = taglist_buttons
}

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "left", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.container.rotate,
	direction = "west",
	{
	    layout = wibox.layout.align.vertical,
	    {
		layout = wibox.layout.constraint,
		strategy = "max",
		height = 18,
		{
	            layout = wibox.layout.align.horizontal,
                    { -- Left widgets
                        layout = wibox.layout.fixed.horizontal,
			{
			    layout = wibox.container.rotate,
			    direction = "east",
			    mylauncher,
			},
                        s.mytaglist,
                        s.mypromptbox,
                    },
                    s.mytasklist, -- Middle widget
                    { -- Right widgets
                        layout = wibox.layout.fixed.horizontal,
                        wibox.widget.systray(),
                        memwidget,
                        swapwidget,
                        cpuwidget,
			{
			    {
                                layout = wibox.container.rotate,
                                direction = "east",
                                mykeyboardlayout.widget,
		            },
			    {
                                layout = wibox.container.rotate,
			        direction = "east",
                                datewidget,
		            },
			    layout = wibox.layout.fixed.horizontal,
			    spacing = -5,
                        },
                        s.mylayoutbox,
                    },
                },
	    },
	    {
		layout = wibox.layout.constraint,
		{
		    layout = wibox.layout.flex.horizontal,
                    {
                        layout = wibox.container.rotate,
			direction = "north",
			batbox,
		    },
		    {
                        layout = wibox.container.rotate,
			direction = "south",
                        batbox,
		    }
		}
	    }
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",
    		function ()
			my_hotkeys_popup:show_help(nil, awful.screen.focused())
		end,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Control" }, "s",
        function (c)
	    awful.titlebar.toggle(c)
        end,
	{description = "toggle titlebar", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
		     maximized_horizontal = false,
                     maximized_vertical = false,
                     maximized = false,
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = false }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    c.shape = beautiful.shape
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )
    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

--client.connect_signal("property::floating", function(c)
--    if c.floating then
--        awful.titlebar.show(c)
--    else
--        awful.titlebar.hide(c)
--    end
-- end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
--beautiful.border_normal = "#00000055"
--beautiful.border_focus = "#00000000"
client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
	c.border_width = beautiful.border_width_focus
end)
client.connect_signal("unfocus", function(c) 
	c.border_color = beautiful.border_normal
	c.border_width = beautiful.border_width
	c.useless_gap = 0
end)
 
-- }}}
