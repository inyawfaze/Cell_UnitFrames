---@class CUF
local CUF = select(2, ...)

local Cell = CUF.Cell
local P = Cell.pixelPerfectFuncs

---@class CUF.uFuncs
local U = CUF.uFuncs

local unit = "target"

local targetFrame, anchorFrame, hoverFrame, config = U:CreateBaseUnitFrame(unit, "Target Frame")
Cell.frames.targetFrame = targetFrame
Cell.frames.targetFrameAnchor = anchorFrame

local targetButton = CreateFrame("Button", "CellTargetButton", targetFrame, "CUFUnitButtonTemplate") --[[@as CUFUnitButton]]
targetButton:SetAttribute("unit", unit)
targetButton:SetPoint("TOPLEFT")
targetButton._layout = "Target"
Cell.unitButtons.target = targetButton

-------------------------------------------------
-- callbacks
-------------------------------------------------
local function UpdateMenu(which)
    U:UpdateUnitButtonMenu(which, unit, targetButton, anchorFrame, config)
end
Cell:RegisterCallback("UpdateMenu", "TargetFrame_UpdateMenu", UpdateMenu)

local function UpdateLayout(_, which)
    U:UpdateUnitButtonLayout(unit, which, targetButton, anchorFrame)
end
Cell:RegisterCallback("UpdateLayout", "TargetFrame_UpdateLayout", UpdateLayout)

local function UpdatePixelPerfect()
    P:Resize(targetFrame)
    P:Resize(anchorFrame)
    config:UpdatePixelPerfect()
end
Cell:RegisterCallback("UpdatePixelPerfect", "TargetFrame_UpdatePixelPerfect", UpdatePixelPerfect)

local function TargetFrame_UpdateVisibility(which)
    U:UpdateUnitFrameVisibility(which, unit, targetButton, targetFrame)
end
Cell:RegisterCallback("UpdateVisibility", "TargetFrame_UpdateVisibility", TargetFrame_UpdateVisibility)
CUF:RegisterCallback("UpdateVisibility", "TargetFrame_UpdateVisibility", TargetFrame_UpdateVisibility)
