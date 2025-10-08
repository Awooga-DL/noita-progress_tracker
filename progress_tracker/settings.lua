dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "progress_tracker"

mod_settings_version = 1
mod_settings = {
    {
        id = "BOSS_LOCATIONS",
        ui_name = "Uncheck to show boss locations",
        ui_description = "Disabling this shows the location name of where bosses are located.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "ALTAR_SECRETS",
        ui_name = "Uncheck to show altar secrets",
        ui_description = "Disabling this shows pretty much the exact thing you need to do.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "TRANSFORMATION_SECRETS",
        ui_name = "Uncheck to show transformation secrets",
        ui_description = "Disabling this shows pretty much the exact thing you need to do.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "MOON_SECRETS",
        ui_name = "Uncheck to show moon secrets",
        ui_description = "Disabling this shows pretty much the exact thing you need to do.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "SUN_SECRETS",
        ui_name = "Uncheck to show sun secrets",
        ui_description = "Disabling this shows pretty much the exact thing you need to do.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "OTHER_SECRETS",
        ui_name = "Uncheck to show other secrets",
        ui_description = "Disabling this shows pretty much the exact thing you need to do.",
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