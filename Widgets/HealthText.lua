---@class CUF
local CUF = select(2, ...)

local Cell = CUF.Cell
local L = Cell.L
local F = Cell.funcs
local P = Cell.pixelPerfectFuncs

---@class CUF.widgets
local W = CUF.widgets
---@class CUF.uFuncs
local U = CUF.uFuncs
---@class CUF.Util
local Util = CUF.Util
---@class CUF.widgets.Handler
local Handler = CUF.widgetsHandler
---@class CUF.builder
local Builder = CUF.Builder

---@class CUF.Menu
local menu = CUF.Menu
---@class CUF.constants
local const = CUF.constants

-------------------------------------------------
-- MARK: AddWidget
-------------------------------------------------

menu:AddWidget(const.WIDGET_KIND.HEALTH_TEXT, 250, "Health", Builder.MenuOptions.TextColor,
    Builder.MenuOptions.HealthFormat,
    Builder.MenuOptions.Anchor,
    Builder.MenuOptions.Font)

---@param button CUFUnitButton
---@param unit Unit
---@param setting string
---@param subSetting string
function W.UpdateHealthTextWidget(button, unit, setting, subSetting)
    local widget = button.widgets.healthText

    if not setting or setting == const.OPTION_KIND.HEALTH_FORMAT then
        widget:SetFormat(CUF.vars.selectedLayoutTable[unit].widgets.healthText.format)
    end

    U:UnitFrame_UpdateHealthText(button)
end

Handler:RegisterWidget(W.UpdateHealthTextWidget, const.WIDGET_KIND.HEALTH_TEXT)

-------------------------------------------------
-- MARK: UpdateHealthText
-------------------------------------------------

---@param button CUFUnitButton
function U:UnitFrame_UpdateHealthText(button)
    if button.states.displayedUnit then
        W:UpdateUnitHealthState(button)

        button.widgets.healthText:UpdateTextColor()
        button.widgets.healthText:UpdateValue()
    end
end

-------------------------------------------------
-- MARK: Format
-------------------------------------------------

-- TODO: make generic

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Percentage(self, current, max, totalAbsorbs)
    self:SetFormattedText("%d%%", current / max * 100)
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Percentage_Absorbs(self, current, max, totalAbsorbs)
    if totalAbsorbs == 0 then
        self:SetFormattedText("%d%%", current / max * 100)
    else
        self:SetFormattedText("%d%%+%d%%", current / max * 100, totalAbsorbs / max * 100)
    end
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Percentage_Absorbs_Merged(self, current, max, totalAbsorbs)
    self:SetFormattedText("%d%%", (current + totalAbsorbs) / max * 100)
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Percentage_Deficit(self, current, max, totalAbsorbs)
    self:SetFormattedText("%d%%", (current - max) / max * 100)
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Number(self, current, max, totalAbsorbs)
    self:SetText(tostring(current))
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Number_Short(self, current, max, totalAbsorbs)
    self:SetText(F:FormatNumber(current))
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Number_Absorbs_Short(self, current, max, totalAbsorbs)
    if totalAbsorbs == 0 then
        self:SetText(F:FormatNumber(current))
    else
        self:SetFormattedText("%s+%s", F:FormatNumber(current), F:FormatNumber(totalAbsorbs))
    end
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Number_Absorbs_Merged_Short(self, current, max, totalAbsorbs)
    self:SetText(F:FormatNumber(current + totalAbsorbs))
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Number_Deficit(self, current, max, totalAbsorbs)
    self:SetText(tostring(current - max))
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Number_Deficit_Short(self, current, max, totalAbsorbs)
    self:SetText(F:FormatNumber(current - max))
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Current_Short_Percentage(self, current, max, totalAbsorbs)
    self:SetFormattedText("%s %d%%", F:FormatNumber(current), (current / max * 100))
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Absorbs_Only(self, current, max, totalAbsorbs)
    if totalAbsorbs == 0 then
        self:SetText("")
    else
        self:SetText(tostring(totalAbsorbs))
    end
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Absorbs_Only_Short(self, current, max, totalAbsorbs)
    if totalAbsorbs == 0 then
        self:SetText("")
    else
        self:SetText(F:FormatNumber(totalAbsorbs))
    end
    self:SetWidth(self:GetStringWidth())
end

---@param self HealthTextWidget
---@param current number
---@param max number
---@param totalAbsorbs number
local function SetHealth_Absorbs_Only_Percentage(self, current, max, totalAbsorbs)
    if totalAbsorbs == 0 then
        self:SetText("")
    else
        self:SetFormattedText("%d%%", totalAbsorbs / max * 100)
    end
    self:SetWidth(self:GetStringWidth())
end

---@class HealthTextWidget
---@param self HealthTextWidget
---@param format HealthTextFormat
local function HealthText_SetFormat(self, format)
    if format == const.HealthTextFormat.PERCENTAGE then
        self.SetValue = SetHealth_Percentage
    elseif format == const.HealthTextFormat.PERCENTAGE_ABSORBS then
        self.SetValue = SetHealth_Percentage_Absorbs
    elseif format == const.HealthTextFormat.PERCENTAGE_ABSORBS_MERGED then
        self.SetValue = SetHealth_Percentage_Absorbs_Merged
    elseif format == const.HealthTextFormat.PERCENTAGE_DEFICIT then
        self.SetValue = SetHealth_Percentage_Deficit
    elseif format == const.HealthTextFormat.NUMBER then
        self.SetValue = SetHealth_Number
    elseif format == const.HealthTextFormat.NUMBER_SHORT then
        self.SetValue = SetHealth_Number_Short
    elseif format == const.HealthTextFormat.NUMBER_ABSORBS_SHORT then
        self.SetValue = SetHealth_Number_Absorbs_Short
    elseif format == const.HealthTextFormat.NUMBER_ABSORBS_MERGED_SHORT then
        self.SetValue = SetHealth_Number_Absorbs_Merged_Short
    elseif format == const.HealthTextFormat.NUMBER_DEFICIT then
        self.SetValue = SetHealth_Number_Deficit
    elseif format == const.HealthTextFormat.NUMBER_DEFICIT_SHORT then
        self.SetValue = SetHealth_Number_Deficit_Short
    elseif format == const.HealthTextFormat.CURRENT_SHORT_PERCENTAGE then
        self.SetValue = SetHealth_Current_Short_Percentage
    elseif format == const.HealthTextFormat.ABSORBS_ONLY then
        self.SetValue = SetHealth_Absorbs_Only
    elseif format == const.HealthTextFormat.ABSORBS_ONLY_SHORT then
        self.SetValue = SetHealth_Absorbs_Only_Short
    elseif format == const.HealthTextFormat.ABSORBS_ONLY_PERCENTAGE then
        self.SetValue = SetHealth_Absorbs_Only_Percentage
    end
end

-------------------------------------------------
-- MARK: CreateHealthText
-------------------------------------------------

---@param button CUFUnitButton
function W:CreateHealthText(button)
    ---@class HealthTextWidget: FontString
    local healthText = button.widgets.healthBar:CreateFontString(nil, "OVERLAY", "CELL_FONT_WIDGET")
    button.widgets.healthText = healthText
    healthText:ClearAllPoints()
    healthText:SetPoint("CENTER", 0, 0)
    healthText:SetFont("Cell Default", 12, "Outline")
    healthText.enabled = false
    healthText.id = const.WIDGET_KIND.HEALTH_TEXT
    ---@type ColorType
    healthText.colorType = const.ColorType.CLASS_COLOR
    healthText.rgb = { 1, 1, 1 }

    healthText.SetFormat = HealthText_SetFormat
    healthText.SetValue = SetHealth_Percentage
    healthText.SetEnabled = W.SetEnabled
    healthText.SetPosition = W.SetPosition
    healthText.SetFontStyle = W.SetFontStyle
    healthText.SetFontColor = W.SetFontColor

    function healthText:UpdateValue()
        if button.widgets.healthText.enabled and button.states.healthMax ~= 0 then
            button.widgets.healthText:SetValue(button.states.health, button.states.healthMax, button.states.totalAbsorbs)
            button.widgets.healthText:Show()
        else
            button.widgets.healthText:Hide()
        end
    end

    function healthText:UpdateTextColor()
        if self.colorType == const.ColorType.CLASS_COLOR then
            self:SetTextColor(F:GetClassColor(button.states.class))
        else
            self:SetTextColor(unpack(self.rgb))
        end
    end
end