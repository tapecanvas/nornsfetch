--        norns x neofetch
--     ------------------------
--      nnn  ooo rrr nnn  ss
--      n  n o o r   n  n  s
--      n  n ooo r   n  n ss
--     ------------------------
--         by @tapecanvas
--                v1.0

function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

-- handles uptime output whether its just minutes, or days, hours, and minutes. 
function parseUptime(uptimeStr)
    local uptime = {days = 0, hours = 0, minutes = 0}
    for num, unit in string.gmatch(uptimeStr, "(%d+)%s(%a+)") do
        if unit == "day" or unit == "days" then
            uptime.days = num
        elseif unit == "hour" or unit == "hours" then
            uptime.hours = num
        elseif unit == "minute" or unit == "minutes" then
            uptime.minutes = num
        end
    end
return uptime
end

-- encoder 2 changes the ascii art between factory and shield norns
function enc(n, delta)
  if n == 2 then
    params:delta("ascii_art", delta)   
    redraw()
  end
end

function init()

    -- param to switch ascii norns
    params:add{type = "option", id = "ascii_art", name = "ASCII Art", options = {"norns", "shield"}, default = 1}

    params:bang()

    -- initialize scroll index
    scrollIndex = 1 -- scroll is not used currently, but could be used later to scroll through sys info if the list grows

    -- builds formatted uptime string
    local uptimeStr = os.capture("uptime -p")
    local uptime = parseUptime(uptimeStr)
    local uptimeDisplay = string.format("up %dd %dh %dm", uptime.days, uptime.hours, uptime.minutes)

    -- run commands and capture information
    sysInfo = {
        os.capture("whoami") .. "@" .. os.capture("uname -n"),
        os.capture("hostname -I"),
        uptimeDisplay,
        "pkgs " .. os.capture("dpkg-query -f '.\n' -W | wc -l"),
        "scripts " .. os.capture("ls /home/we/dust/code | wc -l"),
        "res 128x64",
        "ver " .. os.capture("cat ~/version.txt")
    }

    redraw()
end

function redraw()
    screen.clear()
    screen.font_size(5)
    screen.font_face(1)

    -- ascii norns text
    screen.level(15)
    screen.move(0,5)
    screen.text("nnn  ooo rrr nnn   ss")
    screen.move(0,10)
    screen.text("n  n o o r   n  n  s")
    screen.move(0,15)
    screen.text("n  n ooo r   n  n ss ")
    screen.font_size(8)

    -- factory norns ascii art
    if params:get("ascii_art") == 1 then
        screen.move(3,30)
        screen.text("+------------+") -- top
        screen.move(4,36)
        screen.text("|") -- left side 1
        screen.move(56,36)
        screen.text("|") -- right side 1
        screen.move(4,42)
        screen.text("|") -- left side 2
        screen.move(56,42)
        screen.text("|") -- right side 2
        screen.move(4,48)
        screen.text("|") -- left side 3
        screen.move(56,48)
        screen.text("|") -- right side 3
        screen.move(4,54)
        screen.text("|") -- left side 4
        screen.move(56,54)
        screen.text("|") -- right side 4
        screen.move(12,43)
        screen.text(".___.") -- screen top
        screen.move(11,49)
        screen.text("|") -- screen left
        screen.move(30,49)
        screen.text("|") -- screen right
        screen.move(12,52)
        screen.text(".___.") -- screen bottom
        screen.move(16,40)
        screen.text("°") -- e1
        screen.move(11,37)
        screen.text(".") -- k1
        screen.move(39,49)
        screen.text("° °") -- e2 and e3
        screen.move(38,51)
        screen.text(". .") -- e2 and k3
        screen.move(3,60)
        screen.text("+------------+") -- bottom

    -- norns shield ascii art
    else
        screen.move(11,26)
        screen.text("+---------+") -- top
        screen.move(43,33)
        screen.text("°") -- e1
        screen.move(38,30)
        screen.text(".") -- k1
        screen.move(12,31)
        screen.text("|") -- left side 1
        screen.move(52,31)
        screen.text("|") -- right side 1
        screen.move(12,37)
        screen.text("|") -- left side 2
        screen.move(52,37)
        screen.text("|") -- right side 2
        screen.move(12,43)
        screen.text("|") -- left side 3
        screen.move(52,43)
        screen.text("|") -- right side 3
        screen.move(12,49)
        screen.text("|") -- left side 4
        screen.move(52,49)
        screen.text("|") -- right side 4
        screen.move(12,55)
        screen.text("|") -- left side 5
        screen.move(52,55)
        screen.text("|") -- right side 5
        screen.move(23,36)
        screen.text("____") -- screen top
        screen.move(20,40)
        screen.text("|") -- left screen 1
        screen.move(20,47)
        screen.text("|") -- left screen 2
        screen.move(44,40)
        screen.text("|") -- right screen 1
        screen.move(44,47)
        screen.text("|") -- right screen 2
        screen.move(23,47)
        screen.text("____") -- screen bottom
        screen.move(35,56)
        screen.text("° °") -- e2 and e3
        screen.move(20,53)
        screen.text(". .") -- k2 and k3
        screen.move(11,60)
        screen.text("+---------+") -- bottom
    end

-- vertical separator to split ascii art and sys info
-- screen.level(15)
-- screen.move(66, 0)
-- screen.line_rel(0, 64)
-- screen.stroke()

    -- display sys info
    local infoStart = 70 -- starts drawing sys info at x = 70 (right side of screen)
    for i = scrollIndex, scrollIndex + 8 do
        if sysInfo[i] then
            screen.font_size(8)
            screen.move(infoStart, (i - scrollIndex +1) * 8)
            screen.text(sysInfo[i]) 
        end
    end

    screen.update()

end
