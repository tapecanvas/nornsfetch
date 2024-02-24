--         norns x neofetch
--      ------------------------
--      nnn  ooo rrr nnn   ss
--      n  n o o r   n  n  s
--      n  n ooo r   n  n ss
--      ------------------------
--          by @tapecanvas
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

-- system info
local sysInfo = {
    os.capture("whoami") .. "@" .. os.capture("uname -n"),
    os.capture("hostname -I"),
    "up " .. os.capture("uptime | awk -F'( |,|:)+' '{print $6\"h \"$7\"m\"}'"),
    "pkgs " .. os.capture("dpkg-query -f '.\n' -W | wc -l"),
    "scripts " .. os.capture("ls /home/we/dust/code | wc -l"),
    "res 128x64",
    "ver " .. os.capture("cat ~/version.txt")
}

local scrollIndex = 1

function redraw()

    screen.clear()
    screen.font_size(5)
    screen.font_face(1) 

    -- ascii norns
    screen.level(15)
    screen.move(0,5)
    screen.text("nnn  ooo rrr nnn   ss")
    screen.move(0,10)
    screen.text("n  n o o r   n  n  s")
    screen.move(0,15)
    screen.text("n  n ooo r   n  n ss ")
    screen.font_size(8)
    screen.move(3,30)
    screen.text("+------------+")
    screen.move(4,35)
    screen.text("|")
    screen.move(56,35)
    screen.text("|")
    screen.move(4,40)
    screen.text("| . °")
    screen.move(56,40)
    screen.text("|")
    screen.move(4,45)
    screen.text("|")
    screen.move(56,45)
    screen.text("|")
    screen.move(12,44)
    screen.text("___")
    screen.move(40,50)
    screen.text("° °")
    screen.move(4,50)
    screen.text("| |    |  . .  ")
    screen.move(12,52)
    screen.text("___")
    screen.move(56,50)
    screen.text("|")
    screen.move(4,55)
    screen.text("|")
    screen.move(56,55)
    screen.text("|")
    screen.move(3,60)
    screen.text("+------------+")
 
    -- vertical separator
    -- screen.level(15)
    -- screen.move(66, 0)
    -- screen.line_rel(0, 64)
    -- screen.stroke()

    -- display sys info
    local infoStart = 70
    for i = scrollIndex, scrollIndex + 8 do
        if sysInfo[i] then
            screen.font_size(8)
            screen.move(infoStart, (i - scrollIndex +1) * 8)
            screen.text(sysInfo[i]) 
        end
    end

    screen.update()
end

redraw()