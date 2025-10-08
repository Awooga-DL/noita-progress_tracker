dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "progress_tracker"

mod_settings_version = 1
mod_settings = {
    {
        id = "SPOILER_FREE",
        ui_name = "Uncheck to show boss locations",
        ui_description = "Disabling this shows the location name of where bosses are located.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
}

function ModSettingsUpdate(init_scope)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end