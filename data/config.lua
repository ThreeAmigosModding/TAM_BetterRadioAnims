--[[------------------------------------------
---- For Support - discord.gg/threeamigos ----
--]]------------------------------------------

config = {}

config.debug = true -- enable or disable debug prints to your client console. Also enables the ability to use commands to get drawable types & textures.

config.defaultEmote = "wt2" -- default emote that plays if you dont have the clothing option (Use wt3 or wt4 if using RPEmotes)

config.useKeybind = false -- whether or not to enable/disable the use of keybinds instead of the PMA voice event handler

config.keybindKey = "LMENU" -- key to set for keyboard keybind. See https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

config.controllerKey = "R1_INDEX" -- Button to set for controller keybind. Set to nil to disable. See https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/pad_digitalbutton/

config.useEvent = true -- whether or not to tie into the PMA voice event handler.

config.chestAnim = { -- Chest Animation
    enable = true, -- enable the chest radio animation
    drawable = 9, -- the drawable (clothing type) for the chest radio animation
    male = {
       variations = { -- the clothing variations for the chest radio animation for male
            1
       },
       textures = { -- the texture id's of the drawable for male clothing. 
            0
       }
    },
    female = {
        variations = { -- the clothing variations for the chest radio animation for female
            1
        },
        textures = { -- the texture id's of the drawable for female clothing.
            0
        }
    },
    emote = "radiochest" -- Emote to play
}

config.shoulderAnim = { -- Shoulder Animation
    enable = true, -- enable the shoulder radio animation
    drawable = 9, -- the drawable (clothing type) for the shoulder radio animation
    male = {
        variations = { -- the clothing variations for the chest radio animation for male
            2
        },
        textures = { -- the texture id's of the drawable for male clothing. 
            0
        }
     },
     female = {
        variations = { -- the clothing variations for the chest radio animation for female
            2
        },
        textures = { -- the texture id's of the drawable for female clothing.
            0
        }
     },
    emote = "radio", -- emote to play
    emoteAiming = "radio2" -- Emote to play when aiming
}

config.earpieceAnim = { -- Ear Piece Animation
    enable = true, -- enable the ear piece radio animation
    drawable = 9, -- the drawable (clothing type) for the ear piece
    male = {
        variations = { -- the clothing variations for the chest radio animation for male
            3
        },
        textures = { -- the texture id's of the drawable for male clothing. 
            0
        }
     },
     female = {
        variations = { -- the clothing variations for the chest radio animation for female
            3
        },
        textures = { -- the texture id's of the drawable for female clothing.
            0
        }
     },
    emote = "earpiece" -- Emote to play
}

config.blacklistedPeds = { -- blacklist peds from using the anims - list of peds: https://forge.plebmasters.de/peds
    `a_c_seagull`,
    `a_c_shepard`,
    `a_c_hen`,
    `a_c_poodle`,
    `a_c_tigershark`,
    `a_c_retriever`,
    `a_c_chimp`,
    `a_c_rat`,
    `a_c_rotweiler`,
    `a_c_deer`,
    `a_c_rhesus`,
    `a_c_chickenhawk`,
    `a_c_rabbit_01`,
    `a_c_mtlion`,
    `a_c_humpbank`,
    `a_c_pig`,
    `a_c_westy`,
    `a_c_dolphin`,
    `a_c_pigeon`,
    `a_c_pug`,
    `a_c_crow`,
    `a_c_stingray`,
    `a_c_killerwhale`,
    `a_c_sharkhammer`,
    `a_c_fish`,
    `a_c_cat_01`,
    `a_c_chop_01`,
    `a_c_cow`,
    `a_c_chop`,
    `a_c_husky`,
    `a_c_coyote`,
    `a_c_boar`,
    `a_c_cormorant`,
    `a_c_deer_02`,
    `a_c_chimp_02`,
    `a_c_mtlion_02`,
    `a_c_boar_02`,
    `a_c_rabbit_02`,
    `a_c_panther`,
    `a_c_coyote_02`,
    `a_c_pug_02`
}

config.blacklistedClasses = { -- vehicle classes to blacklist
    8,
    13,
    15,
    16
}


--[[
    List of drawable variations, though we recommend to keep them on either accessory, undershirt or torso.
    0: Face 
    1: Mask 
    2: Hair 
    3: Torso 
    4: Leg 
    5: Parachute / bag 
    6: Shoes 
    7: Accessory 
    8: Undershirt 
    9: Kevlar 
    10: Badge 
    11: Torso 2
]]

return config