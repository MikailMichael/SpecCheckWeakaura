C_Timer.After(2, function()  -- Delays execution to ensure UI loads fully
    loadoutName = ""
    
    local isHoldingCtrl = false
    local holdTime = 0
    local requiredHoldTime = 1  -- Seconds
    local targetIcon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t" -- Star icon
    
    -- Ensure timerFrame is created only once
    if not timerFrame then
        timerFrame = CreateFrame("Frame")  
    end
    
    -- Ensure changeTalents is created only once
    if not changeTalents then
        changeTalents = CreateFrame("Button", nil, ReadyCheckFrame, "UIPanelButtonTemplate")  
    end
    
    -- Function to check key state
    local function CheckCtrlHold(self, elapsed)
        if IsControlKeyDown() then
            holdTime = holdTime + elapsed
            if holdTime >= requiredHoldTime then
                ReadyCheckFrameYesButton:Enable()  -- Enable button after 1 second
                timerFrame:SetScript("OnUpdate", nil)  -- Stop checking
            end
        else
            holdTime = 0  -- Reset if they let go of CTRL
        end
    end
    
    -- Function to get loadout name
    local function GetLoadoutName()
        local specID = PlayerUtil.GetCurrentSpecID()
        local specName = GetSpecializationNameForSpecID(specID) or "Unknown Spec"
        local configID = C_ClassTalents.GetLastSelectedSavedConfigID(specID)
        local configInfo = C_Traits.GetConfigInfo(configID)
        loadoutName = configInfo.name or "Unknown Name"
        ReadyCheckFrameText:SetText("Current Spec: " .. targetIcon .. " " .. loadoutName .. " " .. targetIcon .. "\n\nHold down CTRL for 1 sec to Ready") -- Surrounds loadout in stars
    end
    
    -- Function to setup Ready Check Frame
    local function SetReadyCheckValues()
        ReadyCheckFrame:SetHeight(160)
        
        ReadyCheckFrameYesButton:Disable()  -- Disable "Ready" button initially
        changeTalents:SetPoint("BOTTOM", ReadyCheckFrameText, "BOTTOM", 0, -34)
        changeTalents:SetSize(ReadyCheckFrameNoButton:GetWidth(), 30)
        changeTalents:SetText("Change Talents")
    end
    
    -- Function to check when talents change, and sets the new talent build name to the Ready Check Text
    local function onTalentWindowClose()
        if ReadyCheckFrame:IsShown() then
            GetLoadoutName()
        end
    end
    
    -- Function to open Talents when Change Talents is clicked
    changeTalents:SetScript("OnClick", function() 
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
            timerFrame:SetScript("OnUpdate", CheckCtrlHold)  -- Start checking for CTRL hold
    end)
end)