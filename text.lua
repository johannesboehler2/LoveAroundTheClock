-- Text module

local textModule = {} -- Here we store all the functions

local textList = {} -- Here we store all the new buttons


function textModule:new(x, y, text, font, scale) -- Put this in love.load()
	newText = {}
	
	newText.x = x
	newText.y = y
	newText.text = text
	newText.font = font
	newText.scale = scale
	newText.color = {0.56, 0.56, 0.56, 1}
	
	
	function newText:setText(text)
		self.text = text
	end
	
	function newText:setXY(x, y)
		self.x = x
		self.y = y
	end
	
	function newText:setFont(font)
		self.font = font
	end
	
	function newText:setColor(color)
		self.color = color
	end
	

	table.insert(textList, newText)
	
	
	return newText
end

function textModule:update(dt) -- Put this in love.update()
	for i,textElement in ipairs(textList) do
		local x, y = love.mouse.getPosition()
        	
	end

end

function textModule:draw() -- Put this in love.draw()
	local r,g,b,a = love.graphics.getColor()

	for i,textElement in ipairs(textList) do
		-- Headline
		love.graphics.setFont(textElement.font)
		
		fontHeight = love.graphics:getFont():getHeight()
		fontWidth = love.graphics:getFont():getWidth(textElement.text)
		
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print(
			textElement.text,
			textElement.x * textElement.scale - 1 * textElement.scale,
			textElement.y * textElement.scale - 1 * textElement.scale
		)
		
		love.graphics.setColor(textElement.color)
		love.graphics.print(
			textElement.text,
			textElement.x * textElement.scale ,
			textElement.y * textElement.scale
		)
	
	end
	
end


return textModule
