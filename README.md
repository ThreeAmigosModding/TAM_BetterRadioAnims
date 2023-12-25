# Better Radio Anims by Three Amigos Modding

![tam_changelog](https://raw.githubusercontent.com/ThreeAmigosModding/ThreeAmigosModding/main/img/Product_Cover_BRA.png)

[Support Discord](https://discord.gg/threeamigos)

[Tebex](https://threeamigos.shop)

Improved radio anims with support for rp-emotes and scully emotes

## Installation

Add ``setr voice_enableRadioAnim 0`` to your server.cfg 

Download the release of [ox_lib](https://github.com/overextended/ox_lib) from  & add it to your server.cfg or resources.cfg **BEFORE** `TAM_BetterRadioAnims`

Add `ensure TAM_BetterRadioAnims` to your server or resources cfg file

Download [animations](https://www.gta5-mods.com/misc/leo-custom-anim) and add to stream folder

### If using scully_emotemenu:

**Add to scully_emotemenu/custom_emotes.lua:** ``Emotes = {}``
```lua
    {
        Label = 'Radio 2',
        Command = 'radio2',
        Animation = 'radio_chatter',
        Dictionary = 'random@arrests',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
        },
    },
    {
        Label = 'Radio Chest',
        Command = 'radiochest',
        Animation = 'chest_mic',
        Dictionary = 'anim@cop_mic_pose_002',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
        },
    },
    {
        Label = 'Earpiece',
        Command = 'earpiece',
        Animation = 'cellphone_call_listen_base',
        Dictionary = 'cellphone@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
        },
    },
```

### If using rpemotes:

**Add to rpemotes/client/AnimationListCustom.lua:**

``CustomDP.Emotes = {}``
```lua
    ["radio2"] = {
        "random@arrests",
        "radio_chatter",
        "Radio 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
        }
    },
    ["radiochest"] = {
        "anim@cop_mic_pose_002",
        "chest_mic",
        "Radio Chest",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
        }
    },
    ["earpiece"] = {
        "cellphone@",
        "cellphone_call_listen_base",
        "Earpiece",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
        }
    },
```

# Credits

[Marshular](https://github.com/marshular) - Original creator, gave [explicit permission](https://i.imgur.com/uKDUEd1.png) to release under Three Amigos Modding
