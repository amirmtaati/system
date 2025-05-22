awful.spawn.with_shell("picom")
awful.spawn.with_shell("nitrogen --restore")
beautiful.init("~/.config/awesome/themes/custom/theme.lua")

-- Global keys section in rc.lua
globalkeys = gears.table.join(
    -- Vim-style window navigation
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Vim-style client focus
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

    -- Vim-style window swapping
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    -- Vim-style layout manipulation
    awful.key({ modkey, "Shift" }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift" }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    -- Applications
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "d", function () awful.spawn("rofi -show drun") end,
              {description = "application launcher", group = "launcher"}),
    awful.key({ modkey,           }, "w", function () awful.spawn("firefox") end,
              {description = "open web browser", group = "launcher"}),
    awful.key({ modkey,           }, "e", function () awful.spawn("thunar") end,
              {description = "open file manager", group = "launcher"}),

    -- Layout selection
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Restart awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"})
)

-- Client keys (window-specific)
clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"})
)

-- Add these widget definitions after the existing widget definitions in rc.lua

-- CPU Usage Widget
local cpu_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
}

local function update_cpu()
    awful.spawn.easy_async("bash -c \"grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)\"%\"}'\"", 
        function(stdout)
            cpu_widget:set_text("CPU: " .. stdout:gsub("%s+", ""))
        end
    )
end

local cpu_timer = gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = update_cpu
})

-- Memory Usage Widget
local mem_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
}

local function update_mem()
    awful.spawn.easy_async("bash -c \"free | grep Mem | awk '{printf \"%.0f%%\", $3/$2 * 100.0}'\"",
        function(stdout)
            mem_widget:set_text("MEM: " .. stdout)
        end
    )
end

local mem_timer = gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = update_mem
})

-- Volume Widget
local volume_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
}

local function update_volume()
    awful.spawn.easy_async("bash -c \"amixer get Master | grep -oP '\\[\\d+%\\]' | head -1 | tr -d '[]'\"",
        function(stdout)
            if stdout:match("%S") then
                volume_widget:set_text("VOL: " .. stdout:gsub("%s+", ""))
            else
                volume_widget:set_text("VOL: N/A")
            end
        end
    )
end

local volume_timer = gears.timer({
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = update_volume
})

-- Battery Widget (if you have a laptop)
local battery_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
}

local function update_battery()
    awful.spawn.easy_async("bash -c \"cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A'\"",
        function(stdout)
            if stdout:match("N/A") then
                battery_widget:set_text("")
            else
                battery_widget:set_text("BAT: " .. stdout:gsub("%s+", "") .. "%")
            end
        end
    )
end

local battery_timer = gears.timer({
    timeout = 30,
    call_now = true,
    autostart = true,
    callback = update_battery
})

-- Network Widget
local network_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
}

local function update_network()
    awful.spawn.easy_async("bash -c \"ip route | grep default | awk '{print $5}' | head -1\"",
        function(stdout)
            if stdout:match("%S") then
                local interface = stdout:gsub("%s+", "")
                awful.spawn.easy_async("bash -c \"cat /sys/class/net/" .. interface .. "/operstate\"",
                    function(state)
                        if state:match("up") then
                            network_widget:set_text("NET: ✓")
                        else
                            network_widget:set_text("NET: ✗")
                        end
                    end
                )
            else
                network_widget:set_text("NET: ✗")
            end
        end
    )
end

local network_timer = gears.timer({
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = update_network
})

-- Separator widget
local separator = wibox.widget {
    widget = wibox.widget.textbox,
    text = " | ",
}

-- Update the wibar creation section to include these widgets
-- Find the section that creates s.mywibox and modify the setup to include:

-- In the wibar setup, replace the right widgets section with:
--[[
right = {
    layout = wibox.layout.fixed.horizontal,
    cpu_widget,
    separator,
    mem_widget,
    separator,
    volume_widget,
    separator,
    network_widget,
    separator,
    battery_widget,  -- This will be empty on desktop systems
    separator,
    wibox.widget.systray(),
    separator,
    mytextclock,
    s.mylayoutbox,
},
--]]