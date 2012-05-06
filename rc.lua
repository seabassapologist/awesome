-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--Widgets library
require("vicious")
--colors.lua file for widgets
require('colors')


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
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
     names = {"main", "chrome", "game", "video", "term", "office"},
     layout = { layouts[1], layouts[2], layouts[2], layouts[10], layouts[6], layouts[2]}
       }

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu

accmenu = {
	{ "calculator",	"gcalctool"		},
	{ "gedit",	"gedit"			},
	{ "gvim",	"gvim"			},
	{ "nautilus",	"nautilus"		},
	{ "pcmanfm",	"pcmanfm"		},
	{ "ranger",	terminal .. "-e ranger"	},
	{ "spacefm",	"spacefm"		}
}

gamesmenu = {
	{ "cave story plus",	"cave-story-plus" 	},
	{ "gens/gs",		"gens"			},
	{ "pcsx",		"pcsx"			},
	{ "scummvm",		"scummvm"		},
	{ "snes9x",		"snes9x-gtk"		},
	{ "vba-m",		"gvbam"			}
}

graphicsmenu = {
	{ "gimp", 		"gimp"	},
	{ "eye of gnome",	"eog"	}
}

internetmenu = {
	{ "chromium",		"chromium" 		},
	{ "dropbox",		"dropboxd"		},
	{ "filezilla",		"filezilla"		},
	{ "rtorrent",	terminal .. "-e rtorrent"	},
	{ "transmission", 	"transmission"		}
}

mediamenu = {
	{ "audacious",	"audacious"			},
	{ "brasero",	"brasero"			},
	{ "cheese",	"cheese"			},
	{ "pitivi",	"pitivi"			},
	{ "vlc",	"vlc"				}
}

officemenu = {
	{ "base",		"libreoffice --base"	},
	{ "calc",		"libreoffice --calc"	},
	{ "impress",		"libreoffice --impress"	},
	{ "libreoffice",	"libreoffice"		},
	{ "writer",		"libreoffice --writer"	}
}

progmenu = {
	{ "cmake gui",	"cmake-gui"		},
	{ "eclipse",	"eclipse"		},
	{ "geany",	"geany"			},
	{ "meld",	"meld"			},
	{ "netbeans",	"netbeans"		},
	{ "xemacs",	"xemacs"		}
}

settingsmenu = {
	{ "dconf",		"dconf-editor"			},
	{ "gdm3 setup",		"gdm3setup.py"			},
	{ "lxappearance",	"lxappearance"			},
	{ "system monitor",	"gnome-system-monitor"		}
}

	
  myawesomemenu = {
     { "manual", terminal .. " -e man awesome"},
     { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
     { "restart", awesome.restart},
     { "quit", awesome.quit}
  }

mymainmenu = awful.menu({ items = {	
		{ "awesome", myawesomemenu	},
		{ "accesories", accmenu		},
		{ "games", gamesmenu		},
		{ "graphics", graphicsmenu	},
		{ "internet", internetmenu	},
		{ "media", mediamenu		},
		{ "office", officemenu		},
		{ "programming", progmenu	},
		{ "settings", settingsmenu	},
		{ "open terminal", terminal	},
		{ "chromium", "chromium"   }}, 
		width = 120
})




mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

--Volume widget
volwidget = widget({ type = "textbox" })
	vicious.register(volwidget, vicious.widgets.volume,
		function (widget, args)
			if args[1] == 0 or args[2] == "♩" then
				return "" .. colbcya .. "vol " .. coldef .. colbmag .. "mute" .. coldef .. "" 
			else
				return "" .. colbcya .. "vol " .. coldef .. colbwhi .. args[1] .. "% " .. coldef .. ""
			end
		end, 2, "Master" )
	volwidget:buttons(
		awful.util.table.join(
			awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle &")   end),
			awful.button({ }, 3, function () awful.util.spawn( terminal .. " -e alsamixer")   end),
			awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1%+ &") end),
			awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1%- &") end)
		)
	)

--Battery Widget
batwidget = widget({ type = "textbox" })
	vicious.register(batwidget, vicious.widgets.bat,"" .. colcya .. "bat " .. coldef .. colbwhi .. "$1" .. " " .. "$2" .. "% " .. coldef .. "", 236, "BAT1" )

-- Weather widget
weatherwidget = widget({ type = "textbox" })
	vicious.register(weatherwidget, vicious.widgets.weather,
	function (widget, args)
		if args["{tempc}"] == "N/A" then
			return ""
		else
			return "" .. colbgre .. " weather " .. coldef .. colwhi .. string.lower(args["{sky}"]) .. ", " .. args["{tempf}"] .. "°F" .. coldef .. " "
		end
	end, 1200, "KCMH" )

--Wifi Widget
--wifiwidget = widget({ type = "textbox" })
	--vicious.register(wifiwidget, vicious.widgets.wifi, "" .. colbyel .. " wlan " .. coldef .. colwhi .. "${ssid}" .. ": " .. "${linp}" .. "%" .. coldef, refresh_delay, "wlan0")

wifiwidget = widget({ type = "textbox" })
	vicious.register(wifiwidget, vicious.widgets.wifi, 
	function(widget, args)
		if args["{linp}"] == 100 then
			return "" .. colbyel .. " wlan " .. coldef .. colwhi .. args["{ssid}"] .. ": " .. args["{linp}"] .. "%" .. coldef
		elseif args["{linp}"] < 10 then
			return "" .. colbyel .. " wlan " .. coldef .. colwhi .. args["{ssid}"] .. ":   " .. args["{linp}"] .. "%" .. coldef
		else
			return "" .. colbyel .. " wlan " .. coldef .. colwhi .. args["{ssid}"] .. ":  " .. args["{linp}"] .. "%" .. coldef
		end	
	end, refresh_delay, "wlan0")
	


--Pacman Widget
--pacwidget = widget({ type = "textbox"})
--	vicious.register(pacwidget, vicious.widgets.pkg,"" .. colred .. " pacman " .. coldef .. colwhi .. "$1 updates" .. coldef, 1200, "Arch")

pacwidget = widget({ type = "textbox"})
	vicious.register(pacwidget, vicious.widgets.pkg,
	function(widget, args)
		if args[1] == 1 then
			return "" .. colred .. " pacman " .. coldef .. colwhi .. args[1] .. " update" .. coldef
		elseif args[1] == 0 then
			return "" .. colred .. " pacman " .. coldef .. colwhi .. "zilch" .. coldef
		else
			return "" .. colred .. " pacman " .. coldef .. colwhi .. args[1] .. " updates" .. coldef
		end
	end, 1200, "Arch")
	

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
--    mytasklist[s] = awful.widget.tasklist(function(c)
 --                                             return awful.widget.tasklist.label.currenttags(c, s)
--                                          end, mytasklist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(function(c)
		--remove tasklist-icon without modifying the original tasklist.lua
		local tmptask = { awful.widget.tasklist.label.currenttags(c, s) }
		return tmptask[1], tmptask[2], tmptask[3], nil
	end, mytasklist.buttons)


    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
	volwidget,
	batwidget,
	weatherwidget,
	wifiwidget,
	pacwidget,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({}, "Print", function () awful.util.spawn("scrot -e") end)
                  )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
      
    { rule = { class = "Chromium"},
	  properties = { tag = tags[1][2]} },
	{ rule = { },
	  properties = { size_hints_honor = false} },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--awful.util.spawn_with_shell("compton -cCGfF -o 0.38 -O 200 -I 200 -t 0.02 -l 0.02 -r 3.2 -D2")
