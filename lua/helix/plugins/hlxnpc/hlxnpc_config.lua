
if SERVER then
    
 util.AddNetworkString("ixnpc_job_police")
 net.Receive("ixnpc_job_police", function(len,ply) 
  if ply:IsNearNPC("police") then
   ply:Transfer_Faction("police")
  end
 end)


 util.AddNetworkString("ixnpc_gun_dealer")
 net.Receive("ixnpc_gun_dealer", function(len,ply) 
  if ply:IsNearNPC("gundealer") then
   ply:Give("weapon_357")
  end
 end)

 util.AddNetworkString("ixnpc_idcard")
 net.Receive("ixnpc_idcard", function(len,ply) 
  if ply:IsNearNPC("idcard") then
    ply:Buy_IdCard(100)
  end
 end)

end


HLXNPC  = 
{

   ["citizen"] = {
        ["name"] = "Citizen",
        ["dialogue"] = {

            [1] = {
                ["text"] = "Hi, I'm a simple citizen who likes to talk for the sake of talking.",
                ["buttons"] = {
                    [1] = {
                        ["text"] = "don't talk to me",
                        ["callback"] = function() Close_NPC_UI() end,
                    },
                    [2] = {
                        ["text"] = "interesting",
                        ["callback"] = function() Dialogue_NPC_UI(2) end,
                    }
                }
            },


            [2] = {
                ["text"] = "Great, I have so much to tell!",
                ["buttons"] = {
                    [1] = {
                        ["text"] = "no thanks",
                        ["callback"] = function() Close_NPC_UI() end,
                    }
                }
            }


        }
    },

     ["police"] = {
        ["name"] = "Policeman",
        ["dialogue"] = {

            [1] = {
                ["text"] = "Do you want to become a police officer?",
                ["buttons"] = {
                    [2] = {
                        ["text"] = "yes",
                        ["callback"] = function()

                           if CLIENT then 
                              net.Start("ixnpc_job_police")
                              net.SendToServer()
                              Close_NPC_UI()
                           end

                         end,
                    },
                    [1] = {
                        ["text"] = "no",
                        ["callback"] = function() Close_NPC_UI() end,
                        ["color"] = Color(189,65,65)
                    }
                }
            }

        }
    },

     ["gundealer"] = {
        ["name"] = "Gun Dealer",
        ["dialogue"] = {

            [1] = {
                ["text"] = "Do you want a weapon?",
                ["buttons"] = {
                    [2] = {
                        ["text"] = "yes",
                        ["callback"] = function()

                           if CLIENT then 
                              net.Start("ixnpc_gun_dealer")
                              net.SendToServer()
                              Close_NPC_UI()
                           end

                         end,
                    },
                    [1] = {
                        ["text"] = "no",
                        ["callback"] = function() Close_NPC_UI() end,
                        ["color"] = Color(189,65,65)
                    }
                }
            }

        }
    },

     ["idcard"] = {
        ["name"] = "Id card",
        ["dialogue"] = {

            [1] = {
                ["text"] = "Do you want a new idcard?",
                ["buttons"] = {
                    [2] = {
                        ["text"] = "yes",
                        ["callback"] = function()

                           if CLIENT then 
                              net.Start("ixnpc_idcard")
                              net.SendToServer()
                              Close_NPC_UI()
                           end

                         end,
                    },
                    [1] = {
                        ["text"] = "no",
                        ["callback"] = function() Close_NPC_UI() end,
                        ["color"] = Color(189,65,65)
                    }
                }
            }

        }
    }



}