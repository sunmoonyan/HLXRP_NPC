util.AddNetworkString("ix_npc")


local player = FindMetaTable("Player")

   function player:IsNearNPC(npc)
      for i,v in ipairs(ents.FindInBox(self:GetPos()-Vector(100,100,100), self:GetPos()+Vector(100,100,100))) do
         if v:GetClass() == "ix_npc" then 
            if v:GetNpc() == npc then
               return true
            end
         end
      end
   end

   function player:Transfer_Faction(faction)
              if self:HasWhitelist(ix.faction.Get(faction)["index"]) then
               self:GetCharacter():SetFaction(ix.faction.Get(faction)["index"])
              else
               ix.util.Notify("you are not allowed to enter this profession", ply)
              end
   end

  function player:Buy_IdCard(price)
    local Char = self:GetCharacter()
    local Inv = self:GetCharacter():GetInventory()

         if Char:GetMoney() >= price then 
          
            if Inv:HasItem("idcard") == false  then
               Inv:Add("idcard", 1, {
                name = Char:GetName(),
                id = Char:GetData("id")
               })
               Char:SetMoney(Char:GetMoney()-price)
               ix.util.Notify("you have received a new identity card", self)
            else
               ix.util.Notify("you already have an identity card", self)
            end
         else
               ix.util.Notify("you don't have enough money", self)
         end
     
  end


