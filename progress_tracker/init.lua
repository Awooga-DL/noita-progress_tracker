dofile_once("mods/progress_tracker/ui.lua")

local show_ui = false

function OnWorldPostUpdate()
    if InputIsKeyJustDown(63) then -- F6
        show_ui = not show_ui
        GamePrint("Achievement UI: " .. (show_ui and "ON" or "OFF"))
    end

    if show_ui then
        draw_achievement_ui()
    end
end