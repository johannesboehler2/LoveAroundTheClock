-- Text module

local textModule = {} -- Here we store all the functions

local textList = {} -- Here we store all the new buttons


function textModule:new(x, y, text) -- Put this in love.load()
	newText = {}
	
	newText.x = x
	newText.y = y
	newText.text = text

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
		love.graphics.setFont(settings.headlineFont)
		
		fontHeight = love.graphics:getFont():getHeight()
		fontWidth = love.graphics:getFont():getWidth(textElement.text)
		
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print(
			textElement.text,
			textElement.x * settings.windowScale - 1 * settings.windowScale,
			textElement.y * settings.windowScale - 1 * settings.windowScale
		)
		
		love.graphics.setColor(0.56, 0.56, 0.56, 1)
		love.graphics.print(
			textElement.text,
			textElement.x * settings.windowScale ,
			textElement.y * settings.windowScale
		)
	
	
	end
	
end


return textModule
