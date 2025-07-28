# HLXRP NPC

https://discord.gg/c9tse8PhE3

you will probably need that addon to make work the hlxnpc : https://github.com/sunmoonyan/HLXRP_Base

This NPC system for the Helix framework allows you to create your own NPCs using the configuration file ("hlxnpc_config.lua").

![alt text](https://i.ibb.co/153FYRV/6.png)
![alt text](https://i.ibb.co/fzsvBQv2/4.png)

here is an exemple of a preset

```
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


- player:InteractNPC(npc,dialogue) npc is the preset and dialogue is the optional choosen dialogue , 
- ply:IsNearNPC("npc") to check if the player is really near the npc (really important for security issue)
  

and we use net to send the action to the server , the ixnpc_job_police is receive in the server part :


![alt text](https://i.ibb.co/VWjYHYYL/Screenshot-from-2025-06-18-00-50-53.png)


