local current_page = 1
local items_per_page = 15

function draw_achievement_ui()
    local gui = GuiCreate()
    GuiStartFrame(gui)

    -- Achievement data
    local achievements = {
        {name = "Sacrifice a Chess to the altar", flag = "misc_chest_rain"},
        {name = "Sacrifice a Utility Box to the altar", flag = "misc_util_rain"},
        {name = "Sacrifice a Worm Crystal to the altar", flag = "misc_worm_rain"},
        {name = "Sacrifice a Greed Cursed Crystal to the altar", flag = "misc_greed_rain"},
        {name = "Sacrifice a 3 Emerald Tablets to the altar", flag = "misc_altar_tablet"},
        {name = "Sacrifice a Henkeva potu to the altar", flag = "misc_mimic_potion_rain"},
        {name = "Sacrifice a Monk Statue to the altar", flag = "misc_monk_bots"},
        {name = "Sacrifice a Sun Rock to the altar", flag = "misc_sun_effect"},
        {name = "Sacrifice a Dark Sun Rock to the altar", flag = "misc_darksun_effect"},
        {name = "Ascend the tower...", flag = "secret_tower"},
        {name = "Obtain the Ghostly Transformation", flag = "player_status_ghostly"},
        {name = "Obtain the Ratty Transformation", flag = "player_status_ratty"},
        {name = "Obtain the Funky Transformation", flag = "player_status_funky"},
        {name = "Obtain the Lukki Transformation", flag = "player_status_lukky"},
        {name = "Obtain one of the Halo Transformation", flag = "player_status_halo"},
        {name = "Obtain the Essence of Fire", flag = "essence_fire"},
        {name = "Obtain the Essence of Water", flag = "essence_water"},
        {name = "Obtain the Essence of Earth", flag = "essence_laser"},
        {name = "Obtain the Essence of Air", flag = "essence_air"},
        {name = "Obtain the Essence of Spirits", flag = "essence_alcohol"},
        {name = "Enter the center of the Moon with all 4 normal Essences", flag = "secret_moon"},
        {name = "Enter the center of the Moon with all 4 normal Essences plus the Essence of Spirits", flag = "secret_moon2"},
        {name = "Enter the center of the Moon with all 4 normal Essences and bring the gourdified final boss with you", flag = "special_mood"},
        {name = "Enter the center of the Dark Moon with all 4 normal Essences", flag = "secret_dmoon"},
        {name = "Enter the center of the Dark Moon with all 4 normal Essences and bring the gourdified final boss with you", flag = "dead_mood"},
        {name = "Devour both the Moon and the Dark Moon with the Sun", flag = "secret_sun_collision"},
        {name = "Devour both the Moon and the Dark Moon with the Dark Sun", flag = "secret_darksun_collision"},
        {name = "Beat the game by completing The Work underground with the Sampo", flag = "progress_ending0"},
        {name = "Beat the game by completing The Work at the Mountain Altar with the Sampo", flag = "progress_ending1_toxic"},
        {name = "Beat the game by completing The Work at the Mountain Altar with exactly 11 Orbs and the Sampo", flag = "progress_ending1_gold"},
        {name = "Beat the game by activating the Mountain Altar with 33+ Orbs, only possible in NG+", flag = "progress_ending2"},
        {name = "Beat the game after reaching New Game+++", flag = "progress_newgameplusplus3"},
        {name = "Beat the game in Nightmare mode", flag = "progress_nightmare"},
        {name = "Defeat Suomuhauki, boss of the Underground Jungle", flag = "miniboss_dragon"},
        {name = "Defeat Kolmisilman koipi, boss of the Pyramid to the east", flag = "miniboss_limbs"},
        {name = "Defeat Kolmisilman sydan, boss of the Meat Realm", flag = "miniboss_meat"},
        {name = "Defeat Unohdettu, boss of the Forgotten cave", flag = "miniboss_ghost"},
        {name = "Defeat Sauvojev tuntija, a boss that protects the Orb across the lava lake bridge", flag = "miniboss_pit"},
        {name = "Defeat Ylialkemisti, boss of the Ancient Labratory", flag = "miniboss_alchemist"},
        {name = "Defeat Kolmisilman silma, boss of the Power Plant", flag = "miniboss_robot"},
        {name = "Defeat Mestarien mestari, boss of the Wizards Cave", flag = "miniboss_wizard"},
        {name = "Defeat Limatoukka, boss of the Meat Realm nesting inside a giant skull", flag = "miniboss_maggot"},
        {name = "Defeat Syvaolento, boss of the Lake", flag = "miniboss_fish"},
        {name = "Defeat Tapion vasalli, boss of the Lake Island", flag = "miniboss_islandspirit"},
        {name = "Defeat Tapion vasalli after killing 300+ helpless creatures", flag = "miniboss_threelk"},
        {name = "Defeat the Gate Guardians, guarding the entrance to the Wizards Cave", flag = "miniboss_gate_monsters"},
        {name = "Defeat Toveri", flag = "final_secret_orb3"},
        {name = "Defeat Kivi", flag = "miniboss_sky"},
        {name = "Defeat Kolmisilma, the final boss", flag = "boss_centipede"},
        {name = "Collect an Orb. Any Orb.", flag = "progress_orb_1"},
        {name = "Collect an Evil Orb >:)", flag = "progress_orb_evil"},
        {name = "Collect any 11 Orbs, Evil orbs included!", flag = "progress_orb_all"},
        {name = "Reach the end room without killing a single creature, including Kolmisilman", flag = "progress_pacifist"},
        {name = "Reach the end room without collecting any gold", flag = "progress_nogold"},
        {name = "Reach the end room in 5 minutes or less", flag = "progress_clock"},
        {name = "Reach the end room in 60 seconds or less", flag = "progress_minit"},
        {name = "Reach the end room without taking any damage", flag = "progress_nohit"},
        {name = "Create a Sun", flag = "progress_sun"},
        {name = "Create a Dark Sun", flag = "progress_darksun"},
        {name = "Kill Kolmisilma with the Sun or Dark Sun", flag = "progress_sunkill"},
        {name = "Make the Sun and the Dark Sun collide...", flag = "secret_supernova"},
        {name = "Beat the game with the Curse of Greed", flag = "secret_greed"},
        {name = "Take Kauhirvio to the diamond", flag = "final_secret_orb"},
        {name = "Take Toveri to the diamond", flag = "final_secret_orb2"},
        {name = "Open the Dark Chest", flag = "secret_chest_dark"},
        {name = "Open the Coral Chest", flag = "secret_chest_light"},
        {name = "Unlock the spell The End of Everything", flag = "card_unlocked_everything"},
        {name = "Unlock the spell Divide by 10", flag = "card_unlocked_divide"},
        {name = "Bring a refreshing gourd and throw it at Kolmisilma", flag = "secret_fruit"},
        {name = "Beat the game with all 4 normal Essences", flag = "secret_allessences"},
        {name = "Find and stand on the Meditation Cube that rarely spawns in the Coal Pits", flag = "secret_meditation"},
        {name = "Fill the buried eye that spawns rarely in the Snowy Depths with either normal or unstable teleportanium", flag = "secret_buried_eye"},
        {name = "Fill the hourglass with normal or unstable teleportatium", flag = "secret_hourglass"},
        {name = "Bring an Emerald Tablet to the fishing hut", flag = "progress_hut_a"},
        {name = "Bring a reforged Emerald Tablet to the fishing hut", flag = "progress_hut_b"},
        {name = "Activate the Nullifying Altar", flag = "secret_null"},
    }

    local missing_achievements = {}
    local unlocked_achievements = {}
    for _, a in ipairs(achievements) do
        if HasFlagPersistent(a.flag) then
            table.insert(unlocked_achievements, a)
        else
            table.insert(missing_achievements, a)
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
