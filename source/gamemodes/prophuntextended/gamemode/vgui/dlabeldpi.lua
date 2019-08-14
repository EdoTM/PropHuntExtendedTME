--[[
	The MIT License (MIT)
	
	Copyright (c) 2015-2019 Xaymar

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]

-- DPI Aware Label

local UI = {}

function UI:Init()
    self.scale = 1.0
    self.fontdata = FontManager:CreateFontData({})
    
	UIManager:Listen("UpdateDPI", self, function(dpi) self:UpdateDPI(dpi) end)
	self:UpdateDPI(UIManager:GetDPIScale())
end

function UI:OnRemove()
    UIManager:Silence("UpdateDPI", self)
end

function UI:SetFontEx(fontData)
    self.fontdata = fontData
    
    local scaled = table.Merge({}, self.fontdata)
    scaled.size = math.Round(self.fontdata.size * self.scale)
    scaled.blursize = math.Round(self.fontdata.blursize * self.scale)

    self:SetFont(FontManager:Request(FontManager:ToName(scaled), scaled))
end

function UI:UpdateDPI(dpi)
    self.scale = dpi
    self:SetFontEx(self.fontdata)
    self:InvalidateLayout()
    self:InvalidateParent()
end

derma.DefineControl("DLabelDPI", "DPI Aware DLabel (requires UIManager)", UI, "DLabel");
