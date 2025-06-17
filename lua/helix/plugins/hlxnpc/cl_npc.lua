if CLIENT then

    local npcid = nil

    net.Receive("ix_npc", function() 
        Open_NPC_UI(net.ReadString(), 1, net.ReadEntity())
    end)

    function Npc_UI(npctable, dialogue)
        local npcinfo = HLXNPC[npctable]
        npcid = npctable

        local Xsize = ScrW()
        local Ysize = ScrH()

        local lines = 0
        local letter = 0
        local smoothdesc = ""
        local maxlen = 60
        local len1, len2 = math.modf(string.len(npcinfo["dialogue"][dialogue]["text"]) / maxlen)

        timer.Create("npcui_smoothdesc", 0.008, string.len(npcinfo["dialogue"][dialogue]["text"]), function()
            smoothdesc = string.sub(npcinfo["dialogue"][dialogue]["text"], 0, letter)
            letter = letter + 1

            if string.GetChar(npcinfo["dialogue"][dialogue]["text"], letter) == "" then
                print(string.GetChar(npcinfo["dialogue"][dialogue]["text"], letter))
            else
                LocalPlayer():EmitSound("ui/buttonrollover.wav", 25)
            end
        end)

        NpcMenu = vgui.Create("DFrame")
        NpcMenu:SetPos(0, 0)
        NpcMenu:SetSize(Xsize, Ysize)
        NpcMenu:SetTitle("")
        NpcMenu:MakePopup()
        NpcMenu:SetDraggable(false)
        NpcMenu:ShowCloseButton(false)
        NpcMenu.exit = false
        NpcMenu.linecolor = 0

        if len2 > 0 then
            lines = len1 + 1
        else
            lines = len1
        end

        function NpcMenu:Paint(w, h)
            if self.exit == false then
                self.linecolor = Lerp(0.005, self.linecolor, 255)
            else
                self.linecolor = Lerp(0.05, self.linecolor, 0)
            end

            surface.SetDrawColor(255, 255, 255, self.linecolor)
            surface.DrawLine(w * 0.6, h * 0.1, w * 0.6, h * 0.9)
            surface.DrawLine(w * 0.6, h * 0.2, w * 0.9, h * 0.2)
            draw.DrawText(npcinfo["name"], "CloseCaption_Normal:50", w * 0.61, h * 0.125, Color(255, 255, 225, self.linecolor), TEXT_ALIGN_LEFT)

            for i = 1, lines do
                draw.DrawText(string.sub(smoothdesc, maxlen * i - maxlen + 1, maxlen * i), "Trebuchet18", w * 0.625, (h * (0.015 * i) + h * 0.22), Color(255, 255, 255, self.linecolor), TEXT_ALIGN_LEFT)
            end
        end

        for i = 1, math.Clamp(table.Count(npcinfo["dialogue"][dialogue]["buttons"]), 0, 6) do
            local button = vgui.Create("DButton", NpcMenu)
            button:SetText("")

            local buttonWidth = Xsize * 0.3
            local buttonHeight = Ysize * 0.1
            local startY = Ysize * 0.8

            if npcinfo["dialogue"][dialogue]["buttons"][i]["color"] then
                button.buttoncolor = npcinfo["dialogue"][dialogue]["buttons"][i]["color"]
            else
                button.buttoncolor = ix.config.Get("color")
            end

            button:SetPos(Xsize * 0.6, startY - (i - 1) * buttonHeight)
            button:SetSize(buttonWidth, buttonHeight)
            button.colorAlpha = 0

            button.DoClick = function()
                LocalPlayer():EmitSound("Helix.Whoosh")
                npcinfo["dialogue"][dialogue]["buttons"][i]["callback"]()
            end

            function button:OnCursorEntered()
                LocalPlayer():EmitSound("Helix.Rollover")
            end

            function button:Paint(w, h)
                if self:IsHovered() then
                    self.colorAlpha = Lerp(0.01, self.colorAlpha, 255)
                else
                    self.colorAlpha = Lerp(0.1, self.colorAlpha, 0)
                end

                if NpcMenu.exit == false then
                    surface.SetDrawColor(self.buttoncolor.r, self.buttoncolor.g, self.buttoncolor.b, self.colorAlpha)
                else
                    surface.SetDrawColor(self.buttoncolor.r, self.buttoncolor.g, self.buttoncolor.b, NpcMenu.linecolor)
                end
                if NpcMenu.exit then self:Remove() end
                surface.SetMaterial(Material("vgui/gradient-l.png"))
                surface.DrawTexturedRect(0, 0, w, h)
                draw.DrawText(npcinfo["dialogue"][dialogue]["buttons"][i]["text"], "ixMenuButtonBigLabelFont", w / 2, h * 0.3, Color(255, 255, 225, NpcMenu.linecolor), TEXT_ALIGN_CENTER)
            end
        end
    end

    function Close_NPC_UI()
        if NpcMenu:IsValid() then
            NpcMenu.exit = true

            if timer.Exists("npcui_smoothdesc") then
                timer.Remove("npcui_smoothdesc")
            end

            hook.Add("CalcView", "npc_focus", function(ply, pos, angles, fov)
                npcui_smoothpos = LerpVector(0.01, npcui_smoothpos, LocalPlayer():EyePos())
                npcui_smoothang = LerpAngle(0.01, npcui_smoothang, LocalPlayer():GetAngles())

                return {
                    origin = npcui_smoothpos,
                    angles = npcui_smoothang,
                    fov = fov,
                    drawviewer = true
                }
            end)

            timer.Create("exit_npc_focus", 1, 1, function()
                hook.Remove("CalcView", "npc_focus")
                NpcMenu:Close()
                LocalPlayer():SetNoDraw(false)
            end)
        end
    end

    function Dialogue_NPC_UI(dialogue)
        if NpcMenu:IsValid() then
            NpcMenu:Close()
            Npc_UI(npcid, dialogue)
            NpcMenu.linecolor = 255
        end
    end

    function Open_NPC_UI(npc, dialogue, ent)
    	if HLXNPC[npc] == nil then return end
        npcui_smoothpos = LocalPlayer():EyePos()
        npcui_smoothang = LocalPlayer():GetAngles()

        Npc_UI(npc, dialogue)

        LocalPlayer():SetNoDraw(true)

        hook.Add("CalcView", "npc_focus", function(ply, pos, angles, fov)
            npcui_smoothpos = LerpVector(0.01, npcui_smoothpos, ent:LocalToWorld(Vector(25, 10, 65)))
            npcui_smoothang = LerpAngle(0.01, npcui_smoothang, ent:LocalToWorldAngles(Angle(10, 170, 0)))

            return {
                origin = npcui_smoothpos,
                angles = npcui_smoothang,
                fov = fov,
                drawviewer = true
            }
        end)
    end

end
