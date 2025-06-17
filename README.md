# HLXRP NPC

you will probably need that addon to make work the hlxnpc : https://github.com/sunmoonyan/HLXRP_Base

This NPC system for the Helix framework allows you to create your own NPCs using the configuration file ("hlxnpc_config.lua").

![alt text](https://i.ibb.co/153FYRV/6.png)
![alt text](https://i.ibb.co/fzsvBQv2/4.png)

here is an exemple of a preset

![alt text](https://i.ibb.co/84djtMMr/Screenshot-from-2025-06-18-00-49-18.png)


Close_NPC_UI() to close the dialogue,
Dialogue_NPC_UI() to choose the next dialogue of the npc
ply:Transfer_Faction() to transfer the faction/job of the player
ply:IsNearNPC("npc") to check if the player is really near the npc (really important for security issue)

and we use net to send the action to the server , the ixnpc_job_police is receive in the server part :


![alt text](https://i.ibb.co/VWjYHYYL/Screenshot-from-2025-06-18-00-50-53.png)
