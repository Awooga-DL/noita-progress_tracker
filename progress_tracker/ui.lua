local mod_id = "progress_tracker"
local current_page = 1
local items_per_page = 15

local function update_settings()
    boss_locations_enabled = ModSettingGet(mod_id .. ".BOSS_LOCATIONS")
    altar_secrets_enabled = ModSettingGet(mod_id .. ".ALTAR_SECRETS")
    transformation_secrets_enabled = ModSettingGet(mod_id .. ".TRANSFORMATION_SECRETS")
    moon_secrets_enabled = ModSettingGet(mod_id .. ".MOON_SECRETS")
    sun_secrets_enabled = ModSettingGet(mod_id .. ".SUN_SECRETS")
    other_secrets_enabled = ModSettingGet(mod_id .. ".OTHER_SECRETS")
end

local function get_display_name(ach)
    if ach.category == "BOSS_LOCATIONS" and boss_locations_enabled and ach.boss_name then
        return ach.boss_name
    elseif ach.category == "ALTAR_SECRETS" and altar_secrets_enabled and ach.altar_name then
        return ach.altar_name
    elseif ach.category == "TRANSFORMATION_SECRETS" and transformation_secrets_enabled and ach.transformation_name then
        return ach.transformation_name
    elseif ach.category == "MOON_SECRETS" and moon_secrets_enabled and ach.moon_name then
        return ach.moon_name
    elseif ach.category == "SUN_SECRETS" and sun_secrets_enabled and ach.sun_name then
        return ach.sun_name
    elseif ach.category == "OTHER_SECRETS" and other_secrets_enabled and ach.other_name then
        return ach.other_name
    end
    return ach.name -- fallback
end

function draw_achievement_ui()
    update_settings()

    local gui = GuiCreate()
    GuiStartFrame(gui)

    -- Achievement data
    local achievements = {
        {name = "Sacrifice a Chest to the altar", flag = "misc_chest_rain", category = "ALTAR_SECRETS", altar_name = "Sacrifice Chest"},
        {name = "Sacrifice a Utility Box to the altar", flag = "misc_util_rain", category = "ALTAR_SECRETS", altar_name = "Sacrifice Utility Box"},
        {name = "Sacrifice a Worm Crystal to the altar", flag = "misc_worm_rain", category = "ALTAR_SECRETS", altar_name = "Sacrifice Worm Crystal"},
        {name = "Sacrifice a Greed Cursed Crystal to the altar", flag = "misc_greed_rain", category = "ALTAR_SECRETS", altar_name = "Sacrifice Greed Crystal"},
        {name = "Sacrifice a 3 Emerald Tablets to the altar", flag = "misc_altar_tablet", category = "ALTAR_SECRETS", altar_name = "Sacrifice Tablets"},
        {name = "Sacrifice a Henkeva potu to the altar", flag = "misc_mimic_potion_rain", category = "ALTAR_SECRETS", altar_name = "Sacrifice Henkeva potu"},
        {name = "Sacrifice a Monk Statue to the altar", flag = "misc_monk_bots", category = "ALTAR_SECRETS", altar_name = "Sacrifice Monk Statue"},
        {name = "Sacrifice a Sun Rock to the altar", flag = "misc_sun_effect", category = "ALTAR_SECRETS", altar_name = "Sacrifice Uusi Aurinko"},
        {name = "Sacrifice a Dark Sun Rock to the altar", flag = "misc_darksun_effect", category = "ALTAR_SECRETS", altar_name = "Sacrifice Pimea Aurinko"},
        {name = "Ascend the tower...", flag = "secret_tower"},
        {name = "Obtain the Ghostly Transformation", flag = "player_status_ghostly", category = "TRANSFORMATION_SECRETS", transformation_name = "Get 3 ghosts"},
        {name = "Obtain the Ratty Transformation", flag = "player_status_ratty", category = "TRANSFORMATION_SECRETS", transformation_name = "Become the rat king"},
        {name = "Obtain the Funky Transformation", flag = "player_status_funky", category = "TRANSFORMATION_SECRETS", transformation_name = "Time to get funky :)"},
        {name = "Obtain the Lukki Transformation", flag = "player_status_lukky", category = "TRANSFORMATION_SECRETS", transformation_name = "Giant Enemy Spider - Jerma :)"},
        {name = "Obtain one of the Halo Transformation", flag = "player_status_halo", category = "TRANSFORMATION_SECRETS", transformation_name = "Good or Evil?"},
        {name = "Obtain the Essence of Fire", flag = "essence_fire"},
        {name = "Obtain the Essence of Water", flag = "essence_water"},
        {name = "Obtain the Essence of Earth", flag = "essence_laser"},
        {name = "Obtain the Essence of Air", flag = "essence_air"},
        {name = "Obtain the Essence of Spirits", flag = "essence_alcohol"},
        {name = "Enter the center of the Moon with all 4 normal Essences", flag = "secret_moon", category = "MOON_SECRETS", moon_name = "Void Moon"},
        {name = "Enter the center of the Moon with all 4 normal Essences plus the Essence of Spirits", flag = "secret_moon2", category = "MOON_SECRETS", moon_name = "Drunk Moon"},
        {name = "Enter the center of the Moon with all 4 normal Essences and bring the gourdified final boss with you", flag = "special_mood", category = "MOON_SECRETS", moon_name = "Gourd Moon"},
        {name = "Enter the center of the Dark Moon with all 4 normal Essences", flag = "secret_dmoon", category = "MOON_SECRETS", moon_name = "Blood Moon - Terraria refrence real"},
        {name = "Enter the center of the Dark Moon with all 4 normal Essences and bring the gourdified final boss with you", flag = "dead_mood", category = "MOON_SECRETS", moon_name = "Become a Heretic"},
        {name = "Devour both the Moon and the Dark Moon with the Sun", flag = "secret_sun_collision", category = "SUN_SECRETS", sun_name = "As Above, So Below"},
        {name = "Devour both the Moon and the Dark Moon with the Dark Sun", flag = "secret_darksun_collision", category = "SUN_SECRETS", sun_name = "As Above, So Below but Dark"},
        {name = "Beat the game by completing The Work underground with the Sampo", flag = "progress_ending0", category = "OTHER_SECRETS", other_name = "Complete the Work"},
        {name = "Beat the game by completing The Work at the Mountain Altar with the Sampo", flag = "progress_ending1_toxic", category = "OTHER_SECRETS", other_name = "Complete the Work?"},
        {name = "Beat the game by completing The Work at the Mountain Altar with exactly 11 Orbs and the Sampo", flag = "progress_ending1_gold", category = "OTHER_SECRETS", other_name = "All is Pure.."},
        {name = "Beat the game by activating the Mountain Altar with 33+ Orbs, only possible in NG+", flag = "progress_ending2", category = "OTHER_SECRETS", other_name = "Difficulty: Peaceful"},
        {name = "Beat the game after reaching New Game+++", flag = "progress_newgameplusplus3", category = "OTHER_SECRETS", other_name = "Third time's the charm.."},
        {name = "Beat the game in Nightmare mode", flag = "progress_nightmare", category = "OTHER_SECRETS", other_name = "Welcome to pain with extra steps."},
        {name = "Defeat Suomuhauki, boss of the Underground Jungle", flag = "miniboss_dragon", category = "BOSS_LOCATIONS", boss_name = "Defeat Suomuhauki"},
        {name = "Defeat Kolmisilman koipi, boss of the Pyramid to the east", flag = "miniboss_limbs", category = "BOSS_LOCATIONS", boss_name = "Defeat Kolmisilman koipi"},
        {name = "Defeat Kolmisilman sydan, boss of the Meat Realm", flag = "miniboss_meat", category = "BOSS_LOCATIONS", boss_name = "Defeat Kolmisilman sydan"},
        {name = "Defeat Unohdettu, boss of the Forgotten cave", flag = "miniboss_ghost", category = "BOSS_LOCATIONS", boss_name = "Defeat Unohdettu"},
        {name = "Defeat Sauvojev tuntija, a boss that protects the Orb across the lava lake bridge", flag = "miniboss_pit", category = "BOSS_LOCATIONS", boss_name = "Defeat Sauvojev tuntija"},
        {name = "Defeat Ylialkemisti, boss of the Ancient Labratory", flag = "miniboss_alchemist", category = "BOSS_LOCATIONS", boss_name = "Defeat Ylialkemisti"},
        {name = "Defeat Kolmisilman silma, boss of the Power Plant", flag = "miniboss_robot", category = "BOSS_LOCATIONS", boss_name = "Defeat Kolmisilman silma"},
        {name = "Defeat Mestarien mestari, boss of the Wizards Cave", flag = "miniboss_wizard", category = "BOSS_LOCATIONS", boss_name = "Defeat Mestarien mestari"},
        {name = "Defeat Limatoukka, boss of the Meat Realm nesting inside a giant skull", flag = "miniboss_maggot", category = "BOSS_LOCATIONS", boss_name = "Defeat Limatoukka"},
        {name = "Defeat Syvaolento, boss of the Lake", flag = "miniboss_fish", category = "BOSS_LOCATIONS", boss_name = "Defeat Syvaolento"},
        {name = "Defeat Tapion vasalli, boss of the Lake Island", flag = "miniboss_islandspirit", category = "BOSS_LOCATIONS", boss_name = "Defeat Tapion vasalli"},
        {name = "Defeat Tapion vasalli after killing 300+ helpless creatures", flag = "miniboss_threelk"},
        {name = "Defeat the Gate Guardians, guarding the entrance to the Wizards Cave", flag = "miniboss_gate_monsters", category = "BOSS_LOCATIONS", boss_name = "Defeat the Gate Guardians"},
        {name = "Defeat Toveri", flag = "final_secret_orb3"},
        {name = "Defeat Kivi", flag = "miniboss_sky"},
        {name = "Defeat Kolmisilma, the final boss", flag = "boss_centipede", category = "BOSS_LOCATIONS", boss_name = "Defeat Kolmisilma"},
        {name = "Collect an Orb. Any Orb.", flag = "progress_orb_1"},
        {name = "Collect an Evil Orb >:)", flag = "progress_orb_evil"},
        {name = "Collect any 11 Orbs, Evil orbs included!", flag = "progress_orb_all"},
        {name = "Reach the end room without killing a single creature, including the final boss", flag = "progress_pacifist", category = "OTHER_SECRETS", other_name = "The Pacifist"},
        {name = "Reach the end room without collecting any gold", flag = "progress_nogold", category = "OTHER_SECRETS", other_name = "Basically Homeless"},
        {name = "Reach the end room in 5 minutes or less", flag = "progress_clock", category = "OTHER_SECRETS", other_name = "New PB"},
        {name = "Reach the end room in 60 seconds or less", flag = "progress_minit", category = "OTHER_SECRETS", other_name = "NEW WR??"},
        {name = "Reach the end room without taking any damage", flag = "progress_nohit", category = "OTHER_SECRETS", other_name = "Make it out unharmed"},
        {name = "Create a Sun", flag = "progress_sun", category = "SUN_SECRETS", sun_name = "Uusi Aurinko"},
        {name = "Create a Dark Sun", flag = "progress_darksun", category = "SUN_SECRETS", sun_name = "Pimea Aurinko"},
        {name = "Kill Kolmisilma with the Sun or Dark Sun", flag = "progress_sunkill", category = "SUN_SECRETS", sun_name = "Benign Sunshine!"},
        {name = "Make the Sun and the Dark Sun collide...", flag = "secret_supernova", category = "SUN_SECRETS", sun_name = "Supernova"},
        {name = "Beat the game with the Curse of Greed", flag = "secret_greed", category = "OTHER_SECRETS", other_name = "Wealth but at a cost"},
        {name = "Take Kauhirvio to the diamond", flag = "final_secret_orb", category = "OTHER_SECRETS", other_name = "Friendship :D"},
        {name = "Take Toveri to the diamond", flag = "final_secret_orb2", category = "OTHER_SECRETS", other_name = "FRIENDSHIP>>>"},
        {name = "Open the Dark Chest", flag = "secret_chest_dark"},
        {name = "Open the Coral Chest", flag = "secret_chest_light"},
        {name = "Unlock the spell The End of Everything", flag = "card_unlocked_everything"},
        {name = "Unlock the spell Divide by 10", flag = "card_unlocked_divide"},
        {name = "Bring a refreshing gourd and throw it at Kolmisilma", flag = "secret_fruit", category = "BOSS_LOCATIONS", boss_name = "Secret Fruit"},
        {name = "Beat the game with all 4 normal Essences", flag = "secret_allessences", category = "OTHER_SECRETS", other_name = "All Essence Win!"},
        {name = "Find and stand on the Meditation Cube that rarely spawns in the Coal Pits", flag = "secret_meditation", category = "OTHER_SECRETS", other_name = "Meditate"},
        {name = "Fill the buried eye that spawns rarely in the Snowy Depths with either normal or unstable teleportanium", flag = "secret_buried_eye", category = "OTHER_SECRETS", other_name = "Buried Eye"},
        {name = "Fill the hourglass with normal or unstable teleportatium", flag = "secret_hourglass", category = "OTHER_SECRETS", other_name = "Hourglass Chamber"},
        {name = "Bring an Emerald Tablet to the fishing hut", flag = "progress_hut_a", category = "OTHER_SECRETS", other_name = "Mysterious hut.."},
        {name = "Bring a reforged Emerald Tablet to the fishing hut", flag = "progress_hut_b", category = "OTHER_SECRETS", other_name = "Mysterious Hut.. Part 2?"},
        {name = "Activate the Nullifying Altar", flag = "secret_null", category = "OTHER_SECRETS", other_name = "Null"},
    }

    local missing_achievements = {}
    local unlocked_achievements = {}

    for _, a in ipairs(achievements) do
        local ach_copy = {name = get_display_name(a), flag = a.flag}

        if HasFlagPersistent(a.flag) then
            table.insert(unlocked_achievements, ach_copy)
        else
            table.insert(missing_achievements, ach_copy)
        end
    end

    local combined = {}
    for _, a in ipairs(missing_achievements) do table.insert(combined, a) end
    for _, a in ipairs(unlocked_achievements) do table.insert(combined, a) end

    local total_pages = math.ceil(#combined / items_per_page)
    if total_pages == 0 then total_pages = 1 end
    if current_page < 1 then current_page = total_pages end
    if current_page > total_pages then current_page = 1 end

    local start_i = (current_page - 1) * items_per_page + 1
    local end_i = math.min(start_i + items_per_page - 1, #combined)

    GuiText(gui, 10, 50, string.format("Achievement Progress (Page %d/%d)", current_page, total_pages))

    local y = 70
    for i = start_i, end_i do
        local a = combined[i]
        if HasFlagPersistent(a.flag) then
            GuiColorSetForNextWidget(gui, 0, 1, 0, 1) -- green
            GuiText(gui, 20, y, "[Y] " .. a.name)
        else
            GuiColorSetForNextWidget(gui, 1, 0.25, 0.25, 1) -- red
            GuiText(gui, 20, y, "[N] " .. a.name)
        end
        y = y + 12
    end

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)
    GuiText(gui, 10, y + 10, "<- Left / Right ->  to change pages")

    if InputIsKeyJustDown(80) then current_page = current_page - 1 end
    if InputIsKeyJustDown(79) then current_page = current_page + 1 end
end