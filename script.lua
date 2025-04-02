C_Timer.After(2, function()  -- Delays execution to ensure UI loads fully
        local loadoutName = ""
        local holdTime = 0
        local requiredHoldTime = 1  -- Seconds
        local targetIcon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t" -- Star icon
        _G.Env = aura_env

        -- Ensure timerFrame is created only once
        if not _G.Env.timerFrame then
            _G.Env.timerFrame = CreateFrame("Frame")  
        end
        
        -- Ensure changeTalents is created only once
        if not _G.Env.changeTalents then
            _G.Env.changeTalents = CreateFrame("Button", nil, ReadyCheckFrame, "UIPanelButtonTemplate")  
        end
        
        -- Function to check key state
        local function CheckCtrlHold(self, elapsed)
            if IsControlKeyDown() then
                holdTime = holdTime + elapsed
                if holdTime >= requiredHoldTime then
                    ReadyCheckFrameYesButton:Enable()  -- Enable button after 1 second
                    _G.Env.timerFrame:SetScript("OnUpdate", nil)  -- Stop checking
                end
            else
                holdTime = 0  -- Reset if they let go of CTRL
            end
        end
        
        -- Function to get loadout name
        local function GetLoadoutName()
            local specID = PlayerUtil.GetCurrentSpecID()
            local configID = C_ClassTalents.GetLastSelectedSavedConfigID(specID)
            local configInfo = configID and C_Traits.GetConfigInfo(configID)
            loadoutName = configInfo and configInfo.name or "Unknown Name"
            ReadyCheckFrameText:SetText("Current Spec: " .. targetIcon .. " " .. loadoutName .. " " .. targetIcon .. "\n\nHold down CTRL for 1 sec to Ready") -- Surrounds loadout in stars
        end
        
        -- Function to setup Ready Check Frame
        local function SetReadyCheckValues()
            ReadyCheckFrame:SetHeight(160)
            
            ReadyCheckFrameYesButton:Disable()  -- Disable "Ready" button initially
            if UnitIsGroupLeader("player") then
                _G.Env.changeTalents:Hide()
            else
                _G.Env.changeTalents:Show()
            end
            _G.Env.changeTalents:SetPoint("BOTTOM", ReadyCheckFrameText, "BOTTOM", 0, -34)
            _G.Env.changeTalents:SetSize(ReadyCheckFrameNoButton:GetWidth(), 30)
            _G.Env.changeTalents:SetText("Change Talents")
        end
        
        -- Function to check when talents change, and sets the new talent build name to the Ready Check Text
        local function onTalentWindowClose()
            if ReadyCheckFrame:IsShown() then
                GetLoadoutName()
            end
        end
        
        -- Function to open Talents when Change Talents is clicked
        _G.Env.changeTalents:SetScript("OnClick", function() 
                PlayerSpellsUtil.TogglePlayerSpellsFrame(2)
                
                -- Hook into Talent Frames Closing event
                PlayerSpellsFrame:HookScript("OnHide", function()
                        onTalentWindowClose()      
                end)
        end)
        
        -- Hook into the Ready Check event
        hooksecurefunc("ShowReadyCheck", function()
                GetLoadoutName()
                SetReadyCheckValues()
                holdTime = 0
                _G.Env.timerFrame:SetScript("OnUpdate", CheckCtrlHold)  -- Start checking for CTRL hold
        end)
end)

