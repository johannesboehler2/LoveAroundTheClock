-- Clock module

local clockModule = {} -- Here we store all the functions

local clockList = {} -- Here we store all the new clocks


function clockModule:new(xCenter, yCenter, scale)
	newClock = {} -- We create a table and we create inside of it all the features we want for the clock
	newClock.xCenter = xCenter
	newClock.yCenter = yCenter
	newClock.scale = scale
	
	table.insert(clockList, newClock)
	
	
	return newClock
end

function clockModule:update(dt) -- Put this in love.update()
	for i,clockElement in ipairs(clockList) do
	
	end
	
end

function clockModule:draw() -- Put this in love.draw()
	local r,g,b,a = love.graphics.getColor()

	for i,clockElement in ipairs(clockList) do
	
		love.graphics.setColor(1, 1, 1)
		
 	
		love.graphics.draw(
			clockBackground,
			windowWidth / 2 - 0.5 * clockBackground:getWidth() / 2 * clockElement.scale,
			windowHeight / 2 -0.5 * clockBackground:getHeight() / 2 * clockElement.scale,
			0, 0.5 * clockElement.scale
		)
	
	
		-- Clock face

		love.graphics.setColor(0.7, 0.7, 0.7)
		love.graphics.circle(
			"fill",
			centerX,
			centerY + settings.deepWidth * clockElement.scale / 2,
			settings.clockRadius * clockElement.scale - 0.5
		)
		love.graphics.circle(
			"line",
			centerX,
			centerY + settings.deepWidth * clockElement.scale / 2,
			settings.clockRadius * clockElement.scale
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.circle(
			"fill",
			centerX,
			centerY - settings.deepWidth * clockElement.scale / 2,
			settings.clockRadius * clockElement.scale - 0.5
		)
		love.graphics.circle(
			"line",
			centerX,
			centerY - settings.deepWidth * clockElement.scale / 2,
			settings.clockRadius * clockElement.scale
		)

		love.graphics.setColor(Color("#b2262c")) -- TODO: get from settings
		love.graphics.circle(
			"fill",
			centerX,
			centerY - settings.deepWidth * clockElement.scale,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale - 0.5
		)
		love.graphics.circle(
			"line",
			centerX,
			centerY - settings.deepWidth * clockElement.scale,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale
		)

		love.graphics.setColor(Color("#ed333b")) -- TODO: get from settings
		love.graphics.circle(
			"fill",
			centerX,
			centerY,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale - 0.5
		)
		love.graphics.circle(
			"line",
			centerX,
			centerY,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale
		)
	
	
	
	
	
	end
	
	love.graphics.setColor(r,g,b,a)
end


return clockModule
	 	
