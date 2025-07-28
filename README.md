# HLXRP NPC

https://discord.gg/c9tse8PhE3

you will probably need that addon to make work the hlxnpc : https://github.com/sunmoonyan/HLXRP_Base

This NPC system for the Helix framework allows you to create your own NPCs using the configuration file ("hlxnpc_config.lua").

![alt text](https://i.ibb.co/153FYRV/6.png)
![alt text](https://i.ibb.co/fzsvBQv2/4.png)

# How to create your own NPC
inside the hlxnpc_config.lua you can add your own npc preset by adding a table like these preset

The first example is a basic npc without any function.

```lua
["example_1"] = {
    ["startdialogue"] = 1, -- The starting dialogue ID is 1

    ["dialogue"] = {
        [1] = { -- Dialogue ID 1
            ["text"] = "Hello how are you", -- The sentence spoken by the NPC
            ["args"] = {}, -- Custom arguments that can be injected into the text
            ["condition"] = function(ply) return true end, -- Condition to display this dialogue

            ["buttons"] = {
                [1] = { -- Button 1
                    ["text"] = "No.", -- Text displayed on the button
                    ["args"] = {}, -- Custom arguments for the button text
                    ["condition"] = function(ply) return true end, -- Condition to show this button
                    ["callback"] = function(ply) end, -- Function executed when the player selects this button
                    ["closedialogue"] = true, -- Whether to close the dialogue after selecting this button
                },

                [2] = { -- Button 2
                    ["text"] = "Yes.", -- Text displayed on the button
                    ["args"] = {}, -- Custom arguments for the button text
                    ["condition"] = function(ply) return true end, -- Condition to show this button
                    ["callback"] = function(ply) end, -- Function executed when the player selects this button
                    ["closedialogue"] = true, -- Whether to close the dialogue after selecting this button
                },
            }
        },
    }
},
```
This second example show how to add custom argument inside a text and how to use the callback functions when a button is pressed
```lua
["example_2"] = {
    ["startdialogue"] = 1,

    ["dialogue"] = {
        [1] = {
            ["text"] = "Hello what is your name?",
            ["args"] = {},
            ["condition"] = function(ply) return true end,

            ["buttons"] = {
                [1] = {
                    ["text"] = "I don't know.",
                    ["args"] = {},
                    ["condition"] = function(ply) return true end,
                    ["callback"] = function(ply) end,
                    ["closedialogue"] = true,
                },

                [2] = {
                    ["text"] = "My name is %s.",
                    ["args"] = {function(ply) return ply:GetName() end}, -- This argument provides the player's name to the text
                    ["condition"] = function(ply) return true end,
                    ["callback"] = function(ply) ply:InteractNPC("example_2", 2) end, -- Triggers the second dialogue when selected
                    ["closedialogue"] = false,
                },
            }
        },

        [2] = {
            ["text"] = "Nice to meet you %s.",
            ["args"] = {function(ply) return ply:GetName() end},
            ["condition"] = function(ply) return true end,

            ["buttons"] = {
                [1] = {
                    ["text"] = "Thanks.",
                    ["args"] = {},
                    ["condition"] = function(ply) return true end,
                    ["callback"] = function(ply) end,
                    ["closedialogue"] = true,
                },
            }
        },
    }
},
```
This last example use a function to choose what is the first dialogue , it show some button only if the player is a policeman
```lua
["example_3"] = {
    ["startdialogue"] = function(ply)
        -- If the player has the police playermodel, start with dialogue ID 1; otherwise, start with ID 2
        if ply:GetModel() == "models/police.mdl" then
            return 1
        else
            return 2
        end
    end,

    ["dialogue"] = {
        [1] = {
            ["text"] = "Hello are you a policeman %s?",
            ["args"] = {function(ply) return ply:GetName() end},
            ["condition"] = function(ply)
                -- Only show this dialogue if the player is using the police playermodel
                return ply:GetModel() == "models/police.mdl"
            end,

            ["buttons"] = {
                [1] = {
                    ["text"] = "No I'm not a policeman.",
                    ["args"] = {},
                    ["condition"] = function(ply) return true end,
                    ["callback"] = function(ply) end,
                    ["closedialogue"] = true,
                },

                [2] = {
                    ["text"] = "Yes I am.",
                    ["args"] = {}, -- No arguments needed for this button
                    ["condition"] = function(ply) return ply:GetCharacter():IsPolice() end,
                    ["callback"] = function(ply) ply:InteractNPC("example_3", 2) end, -- Starts dialogue ID 2 when selected
                    ["closedialogue"] = false,
                },
            }
        },

        [2] = {
            ["text"] = "Nice to meet you %s.",
            ["args"] = {function(ply) return ply:GetName() end},
            ["condition"] = function(ply) return true end,

            ["buttons"] = {
                [1] = {
                    ["text"] = "Thanks.",
                    ["args"] = {},
                    ["condition"] = function(ply) return true end,
                    ["callback"] = function(ply) end,
                    ["closedialogue"] = true,
                },
            }
        },
    }
},
```

# Usefull functions
```lua
player:InteractNPC(npc,dialogue) --npc is the preset and dialogue is the optional choosen dialogue , 
ply:IsNearNPC("npc") --to check if the player is really near the npc (really important for security issue)
```



