select(2, ...) 'aux.gui.listing'

local aux = require 'aux'
local gui = require 'aux.gui'

local ROW_HEIGHT = 15
local ROW_TEXT_SIZE = 14
local HEAD_HEIGHT = 27
local HEAD_SPACE = 2
local DEFAULT_COL_INFO = {{width=1}}

local handlers = {
    OnEnter = function(self)
        self.mouseover = true
        if not self.data then return end
        if not self.st.highlightDisabled then
            self.highlight:Show()
        end

        local handler = self.st.handlers.OnEnter
        if handler then
            handler(self.st, self.data, self)
        end
    end,

    OnLeave = function(self)
        self.mouseover = false
        if not self.data then return end
        if not (self.st.selected and self.st.selected(self.data)) then
            self.highlight:Hide()
        end

        local handler = self.st.handlers.OnLeave
        if handler then
            handler(self.st, self.data, self)
        end
    end,

    OnClick = function(self, button)
        if not self.data then return end
        local handler = self.st.handlers.OnClick
        if handler then
            handler(self.st, self.data, self, button)
        end
    end,

	OnDoubleClick = function(self, button)
		if not self.data then return end

		local handler = self.st.handlers.OnDoubleClick
		if handler then
			handler(self.st, self.data, self, button)
		end
	end,

    OnMouseDown = function(self, button)
        if not self.data then return end

        local handler = self.st.handlers.OnMouseDown
        if handler then
            handler(self.st, self.data, self, button)
        end
    end,

    OnMouseUp = function(self, button)
        if not self.data then return end

        local handler = self.st.handlers.OnMouseUp
        if handler then
            handler(self.st, self.data, self, button)
        end
    end,
}

local methods = {
    Update = function(self)
	    if #self.colInfo > 1 or self.colInfo[1].name then
		    self.headHeight = HEAD_HEIGHT
	    else
		    self.headHeight = 0
	    end

	    if #(self.rowData or empty) > self.numRows then
		    self.contentFrame:SetPoint('BOTTOMRIGHT', -15, 0)
	    else
		    self.contentFrame:SetPoint('BOTTOMRIGHT', 0, 0)
	    end

	    local width = self.contentFrame:GetRight() - self.contentFrame:GetLeft()

	    while #self.headCols < #self.colInfo do
		    self:AddColumn()
	    end

	    for i, col in ipairs(self.headCols) do
		    if self.colInfo[i] then
			    col:Show()
			    col:SetWidth(self.colInfo[i].width * width)
			    col:SetHeight(self.headHeight)
			    col.text:SetText(self.colInfo[i].name or '')
			    col.text:SetJustifyH(self.colInfo[i].headAlign or 'CENTER')
		    else
			    col:Hide()
		    end
	    end

	    while #self.rows < self.numRows do
		    self:AddRow()
	    end

	    for i, row in ipairs(self.rows) do
		    if i > self.numRows then
			    row.data = nil
			    row:Hide()
		    else
			    row:Show()
			    while #row.cols < #self.colInfo do
				    self:AddCell(i)
			    end
			    for j, col in ipairs(row.cols) do
				    if self.headCols[j] and self.colInfo[j] then
					    col:Show()
					    col:SetWidth(self.colInfo[j].width * width)
					    col.text:SetJustifyH(self.colInfo[j].align or 'LEFT')
				    else
					    col:Hide()
				    end
			    end
		    end
	    end
	    
        if not self.rowData then return end
        FauxScrollFrame_Update(self.scrollFrame, #self.rowData, self.numRows, ROW_HEIGHT)
        local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
        self.offset = offset

        for i = 1, self.numRows do
	        local row = self.rows[i]
            row.data = nil
            if i > #self.rowData then
	            row:Hide()
            else
	            row:Show()
                local data = self.rowData[i + offset]
                if not data then break end
	            row.data = data

                if row.mouseover or self.selected and self.selected(data) then
	                row.highlight:Show()
                else
	                row.highlight:Hide()
                end

                for j, col in pairs(row.cols) do
                    if self.colInfo[j] then
                        local colData = data.cols[j]
                        if type(colData.value) == 'function' then
	                        col.text:SetText(colData.value(unpack(colData.args)))
                        else
                            col.text:SetText(colData.value)
                        end
                    end
                end
            end
        end
    end,

    SetData = function(self, rowData)
        self.rowData = rowData
        self.updateSort = true
        self:Update()
    end,

    AddColumn = function(self)
        local colNum = #self.headCols + 1
        local col = CreateFrame('Frame', nil, self.contentFrame)
        if colNum == 1 then
            col:SetPoint('TOPLEFT', 0, 0)
        else
            col:SetPoint('TOPLEFT', self.headCols[colNum - 1], 'TOPRIGHT')
        end
        col.st = self
        col.colNum = colNum

	    local text = col:CreateFontString()
	    text:SetAllPoints()
	    text:SetFont(gui.font, 12)
	    text:SetTextColor(aux.color.label.enabled())
        col.text = text

	    local tex = col:CreateTexture()
	    tex:SetAllPoints()
	    tex:SetTexture([[Interface\AddOns\aux-AddOn\WorldStateFinalScore-Highlight]])
	    tex:SetTexCoord(.017, 1, .083, .909)
	    tex:SetAlpha(.5)

        tinsert(self.headCols, col)
        
        for i, row in ipairs(self.rows) do
            while #row.cols < #self.headCols do
                self:AddCell(i)
            end
        end
    end,

    AddCell = function(self, rowNum)
        local row = self.rows[rowNum]
        local colNum = #row.cols + 1
        local cell = CreateFrame('Frame', nil, row)
        local text = cell:CreateFontString()
        cell.text = text
        text:SetFont(gui.font, ROW_TEXT_SIZE)
        text:SetJustifyV('CENTER')
        text:SetPoint('TOPLEFT', 1, -1)
        text:SetPoint('BOTTOMRIGHT', -1, 1)
        cell:SetHeight(ROW_HEIGHT)
        cell.st = self

        if colNum == 1 then
	        cell:SetPoint('TOPLEFT', 0, 0)
        else
	        cell:SetPoint('TOPLEFT', row.cols[colNum - 1], 'TOPRIGHT')
        end
        tinsert(row.cols, cell)
    end,

    AddRow = function(self)
        local row = CreateFrame('Button', nil, self.contentFrame)
        row:SetHeight(ROW_HEIGHT)
        row:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
        for name, func in pairs(handlers) do
	        row:SetScript(name, func)
        end
        local rowNum = #self.rows + 1
        if rowNum == 1 then
            row:SetPoint('TOPLEFT', 0, -(self.headHeight + HEAD_SPACE))
            row:SetPoint('TOPRIGHT', 0, -(self.headHeight + HEAD_SPACE))
        else
            row:SetPoint('TOPLEFT', 0, -(self.headHeight + HEAD_SPACE + (rowNum - 1) * ROW_HEIGHT))
            row:SetPoint('TOPRIGHT', 0, -(self.headHeight + HEAD_SPACE + (rowNum - 1) * ROW_HEIGHT))
        end
        local highlight = row:CreateTexture()
        highlight:SetAllPoints()
        highlight:SetColorTexture(1, .9, 0, .4)
        highlight:Hide()
        row.highlight = highlight
        row.st = self

        row.cols = {}
        self.rows[rowNum] = row
        for _ = 1, #self.colInfo do
            self:AddCell(rowNum)
        end
    end,

	SetSelection = function(self, f)
		self.selected = f
	end,

    SetHandler = function(self, event, handler)
	    self.handlers[event] = handler
    end,

    SetColInfo = function(self, colInfo)
        colInfo = colInfo or DEFAULT_COL_INFO
        self.colInfo = colInfo
        self:Update()
    end,
}

function M.new(parent)
    local st = CreateFrame('Frame', gui.unique_name(), parent)
    st:SetAllPoints()

    st.numRows = max(floor((parent:GetHeight() - HEAD_HEIGHT - HEAD_SPACE) / ROW_HEIGHT), 0)

    local contentFrame = CreateFrame('Frame', nil, st)
    contentFrame:SetPoint('TOPLEFT', 0, 0)
    contentFrame:SetPoint('BOTTOMRIGHT', 0, 0)
    st.contentFrame = contentFrame

    local scrollFrame = CreateFrame('ScrollFrame', st:GetName() .. 'ScrollFrame', st, 'FauxScrollFrameTemplate')
    scrollFrame:SetScript('OnVerticalScroll', function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, ROW_HEIGHT, function() st:Update() end)
    end)
    scrollFrame:SetAllPoints(contentFrame)
    st.scrollFrame = scrollFrame

    local scroll_bar = _G[scrollFrame:GetName() .. 'ScrollBar']
    scroll_bar:ClearAllPoints()
    scroll_bar:SetPoint('TOPRIGHT', st, -4, -HEAD_HEIGHT)
    scroll_bar:SetPoint('BOTTOMRIGHT', st, -4, 4)
    scroll_bar:SetWidth(10)
    local thumbTex = scroll_bar:GetThumbTexture()
    thumbTex:SetPoint('CENTER', 0, 0)
    thumbTex:SetColorTexture(aux.color.content.background())
    thumbTex:SetHeight(150)
    thumbTex:SetWidth(scroll_bar:GetWidth())
    _G[scroll_bar:GetName() .. 'ScrollUpButton']:Hide()
    _G[scroll_bar:GetName() .. 'ScrollDownButton']:Hide()

    for name, func in pairs(methods) do
        st[name] = func
    end
    
    st.headCols = {}
    st.rows = {}
    st.handlers = {}
    st.colInfo = DEFAULT_COL_INFO

    return st
end