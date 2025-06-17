--[[
 ________  ___  ___  ________   ________  ___  ___  ___     
|\   ____\|\  \|\  \|\   ___  \|\   ____\|\  \|\  \|\  \    
\ \  \___|\ \  \\\  \ \  \\ \  \ \  \___|\ \  \\\  \ \  \   
 \ \_____  \ \  \\\  \ \  \\ \  \ \_____  \ \   __  \ \  \  
  \|____|\  \ \  \\\  \ \  \\ \  \|____|\  \ \  \ \  \ \  \ 
    ____\_\  \ \_______\ \__\\ \__\____\_\  \ \__\ \__\ \__\
   |\_________\|_______|\|__| \|__|\_________\|__|\|__|\|__|
   \|_________|                   \|_________|              
                                                            
                                                            
]]--

local PLUGIN = PLUGIN

PLUGIN.name = "Helix NPC"
PLUGIN.author = "Sunshi"
PLUGIN.description = "."



if SERVER then
 AddCSLuaFile("hlxnpc_config.lua")
 AddCSLuaFile("cl_npc.lua")
 include("sv_npc.lua")
 include("hlxnpc_config.lua")



    function PLUGIN:SaveData()
        local data = {}
        -----[Jobs]----
        for _, entity in ipairs(ents.FindByClass("ix_npc")) do
            local bodygroups = {}
            for _, v in ipairs(entity:GetBodyGroups() or {}) do
                bodygroups[v.id] = entity:GetBodygroup(v.id)
            end
            data[#data + 1] = {
                name = entity:GetDisplayName(),
                description = entity:GetDescription(),
                pos = entity:GetPos(),
                angles = entity:GetAngles(),
                model = entity:GetModel(),
                skin = entity:GetSkin(),
                bodygroups = bodygroups,
                npc = entity:GetNpc(),
                ent = "ix_npc",
            }
        end
        self:SetData(data)
    end

    function PLUGIN:LoadData()
        for _, v in ipairs(self:GetData() or {}) do
        -----[Jobs]----
         if v.ent == "ix_npc" then
            local entity = ents.Create("ix_npc")
            entity:SetPos(v.pos)
            entity:SetAngles(v.angles)
            entity:Spawn()
            entity:SetModel(v.model)
            entity:SetSkin(v.skin or 0)
            entity:SetDisplayName(v.name)
            entity:SetDescription(v.description)
            entity:SetNpc(v.npc)
            for id, bodygroup in pairs(v.bodygroups or {}) do
                entity:SetBodygroup(id, bodygroup)
            end
        end
       end
     end

-- Dégradé magenta foncé
local colors = {
    "\27[38;2;102;0;153m",  -- Dark Magenta
    "\27[38;2;128;0;170m",
    "\27[38;2;153;0;187m",
    "\27[38;2;178;0;204m",
    "\27[38;2;204;0;221m",
    "\27[38;2;221;51;238m",
    "\27[38;2;238;102;255m" -- Lighter magenta
}
local reset = "\27[0m"
local total = #colors

for i = 1, total do
    local bar = ""

    -- Crochet gauche (magenta foncé)
    bar = bar .. colors[1] .. "["

    -- Contenu de la barre en dégradé
    for j = 1, total do
        if j <= i then
            bar = bar .. colors[j] .. "="
        else
            bar = bar .. colors[#colors] .. " "
        end
    end

    -- Crochet droit (magenta clair)
    bar = bar .. colors[#colors] .. "]"

    -- Texte latéral (teinte moyenne)
    bar = bar .. colors[4] .. " Loading HLXNPC by Sunshi..." .. reset

    print(bar)
end
local green = "\27[38;2;102;204;102m"
print(green .. "-------------[HLXNPC LOADED]------------" .. reset)


 
else
 IncludeCS("cl_npc.lua")
 IncludeCS("hlxnpc_config.lua")
end



