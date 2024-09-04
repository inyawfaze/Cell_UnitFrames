---@meta

-------------------------------------------------
-- MARK: External Annotations
-------------------------------------------------

---@class LibGroupInfo
---@field GetCachedInfo function

-------------------------------------------------
-- MARK: Cell Annotations
-------------------------------------------------

---@class CellDBGeneral
---@field menuPosition "top_bottom" | "left_right"
---@field locked boolean
---@field fadeOut boolean

---@class CellDBAppearance
---@field outOfRangeAlpha number
---@field barAlpha number
---@field lossAlpha number
---@field healPrediction table<number, table<number, number>>
---@field barAnimation "Smooth" | "Flash"

---@class CellDB
---@field layouts Layouts
---@field general CellDBGeneral
---@field appearance CellDBAppearance

---@class CellAnimationGroup: AnimationGroup
---@field alpha Animation

---@class CellAnimation
---@field fadeIn CellAnimationGroup
---@field fadeOut CellAnimationGroup

---@class CellDropdown: Frame, BackdropTemplate
---@field SetItems function
---@field SetEnabled function
---@field SetSelectedValue function
---@field SetLabel function
---@field SetSelected function
---@field SetFont function
---@field button button
---@field ClearSelected function
---@field GetSelected function
---@field AddItem function
---@field ClearItems function

---@class CellColorPicker: Frame, BackdropTemplate
---@field SetColor fun(self: CellColorPicker, r: number|table, g: number?, b: number?, a: number?)
---@field label FontString
---@field onChange fun(r: number, g: number, b: number, a: number)

---@class CellSlider: Slider
---@field afterValueChangedFn function
---@field currentEditBox Frame

---@class CellUnknowFrame: Frame
---@field title FontString
---@field GetSelected function

---@class CellCombatFrame: Frame
---@field mask Frame
---@field combatMask Frame

---@alias Layouts table<string, LayoutTable>

---@class LayoutTable
---@field CUFUnits UnitLayoutTable
---@field barOrientation table
---@field powerFilters table<string, boolean|string>
---@field groupFilter table<number, boolean>

---@class CellScrollFrame: ScrollFrame
---@field content Frame
---@field SetScrollStep fun(self: CellScrollFrame, step: number)
---@field ResetScroll fun(self: CellScrollFrame)
---@field SetContentHeight fun(self: CellScrollFrame, height: number, num: number?, spacing: number?)
---@field Reset fun(self: CellScrollFrame)

---@class CellCheckButton: CheckButton
---@field label FontString

---@class CellButton: Button
---@field SetTextColor fun(self: CellButton, r: number, g: number, b: number, a: number)

-------------------------------------------------
-- MARK: CUF Frames
-------------------------------------------------

---@class SmoothStatusBar: StatusBar
---@field SetMinMaxSmoothedValue number
---@field ResetSmoothedValue number
---@field SetSmoothedValue number

-------------------------------------------------
-- MARK: Misc
-------------------------------------------------

---@class stringlib
---@field utf8charbytes fun(text: string, index: number): number
---@field utf8len fun(text: string): number
---@field utf8sub fun(text: string, start: number, end_: number): string
---@field utf8replace fun(text: string, mapping: table): string
---@field utf8upper fun(text: string): string
---@field utf8lower fun(text: string): string
---@field utf8reverse fun(text: string): string
