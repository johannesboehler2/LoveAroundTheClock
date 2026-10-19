-- Clock module

local clockModule = {} -- Here we store all the functions

local clockList = {} -- Here we store all the new clocks


function clockModule:new(xCenter, yCenter, imgClockBackground, scale)
	newClock = {} -- We create a table and we create inside of it all the features we want for the clock
	newClock.xCenter = xCenter
	newClock.yCenter = yCenter
	newClock.imgClockBackground = imgClockBackground
	newClock.scale = scale
	newClock.clockFaceBackgroundColor = {0.7, 0.7, 0.7}
	
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
			newClock.imgClockBackground,
			clockElement.xCenter - 0.5 * clockBackground:getWidth() / 2 * clockElement.scale,
			clockElement.yCenter - 0.5 * clockBackground:getHeight() / 2 * clockElement.scale,
			0, 0.5 * clockElement.scale
		)
	
	
		-- Clock face

		love.graphics.setColor(newClock.clockFaceBackgroundColor)
		love.graphics.circle(
			"fill",
			clockElement.xCenter,
			clockElement.yCenter + settings.deepWidth * clockElement.scale / 2, -- TODO
			settings.clockRadius * clockElement.scale - 0.5 -- TODO
		)
		love.graphics.circle(
			"line",
			clockElement.xCenter,
			clockElement.yCenter + settings.deepWidth * clockElement.scale / 2, -- TODO
			settings.clockRadius * clockElement.scale -- TODO
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.circle(
			"fill",
			clockElement.xCenter,
			clockElement.yCenter - settings.deepWidth * clockElement.scale / 2, -- TODO
			settings.clockRadius * clockElement.scale - 0.5 -- TODO
		)
		love.graphics.circle(
			"line",
			clockElement.xCenter,
			clockElement.yCenter - settings.deepWidth * clockElement.scale / 2,
			settings.clockRadius * clockElement.scale
		)

		love.graphics.setColor(Color("#b2262c")) -- TODO: get from settings
		love.graphics.circle(
			"fill",
			clockElement.xCenter,
			clockElement.yCenter - settings.deepWidth * clockElement.scale,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale - 0.5 -- TODO
		)
		love.graphics.circle(
			"line",
			clockElement.xCenter,
			clockElement.yCenter - settings.deepWidth * clockElement.scale,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale -- TODO
		)

		love.graphics.setColor(Color("#ed333b")) -- TODO: get from settings
		love.graphics.circle(
			"fill",
			clockElement.xCenter,
			clockElement.yCenter,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale - 0.5 -- TODO
		)
		love.graphics.circle(
			"line",
			clockElement.xCenter,
			clockElement.yCenter,
			settings.clockRadius * clockElement.scale - settings.clockBorderWidth * clockElement.scale -- TODO
		)
	
	
		love.graphics.setColor(1, 1, 1, 0.8) -- TODO: get from settings
    
		for i = 0, 59 do
			local angle = math.rad(i * 6)
		
			local innerRadius =
				settings.clockRadius * clockElement.scale -
				6 * clockElement.scale -
				settings.clockBorderWidth * clockElement.scale
			
			local outerRadius =
				settings.clockRadius * clockElement.scale -
				settings.clockBorderWidth * clockElement.scale
			
			local x1 = clockElement.xCenter + innerRadius * math.sin(angle)
			local y1 = clockElement.yCenter - innerRadius * math.cos(angle)
			local x2 = clockElement.xCenter + outerRadius * math.sin(angle)
			local y2 = clockElement.yCenter - outerRadius * math.cos(angle)

			if i % 15 == 0 then
				love.graphics.setLineWidth(8 * clockElement.scale)
				love.graphics.line(
					x1,
					y1,
					x2 - 30 * clockElement.scale * math.sin(angle),
					y2 + 30 * clockElement.scale * math.cos(angle)
				)
			elseif i % 5 == 0 then
				love.graphics.setLineWidth(4 * clockElement.scale)
				love.graphics.line(
					x1,
					y1,
					x2 - 30 * clockElement.scale * math.sin(angle),
					y2 + 30 * clockElement.scale * math.cos(angle)
				)
			else
				love.graphics.setLineWidth(2 * clockElement.scale)
				love.graphics.line(
					x1,
					y1,
					x2 - 12 * clockElement.scale * math.sin(angle),
					y2 + 12 * clockElement.scale * math.cos(angle)
				)
			end
		end
		
		
		-- Clock face hour numbers

		love.graphics.setFont(settings.hourNumbersFont)
		for i = 1, 12 do
		    local angle = math.rad((i) * 30)
		    
		    local numberRadius =
			    settings.clockRadius * clockElement.scale -
			    48 * clockElement.scale -
			    settings.clockBorderWidth * clockElement.scale
			    
		    local x = centerX + numberRadius * math.sin(angle)
		    local y = centerY - numberRadius * math.cos(angle)

		    local text = tostring(i == 0 and 12 or i)
		    local textWidth = settings.hourNumbersFont:getWidth(text)
		    love.graphics.setColor(1, 1, 1)
		    love.graphics.print(text, x - textWidth/2, y - 15 * clockElement.scale)
		end
	
	
		-- Hour hand

		local hourAngle = math.rad((currentTime.hour % 12) * 30 + currentTime.min * 0.5)
		local hourLength =
			(
				settings.clockRadius * clockElement.scale -
				settings.clockBorderWidth * clockElement.scale
			) * 0.6
		local hourX = clockElement.xCenter + hourLength * math.sin(hourAngle)
		local hourY = clockElement.yCenter - hourLength * math.cos(hourAngle)

		love.graphics.setLineWidth(12 * clockElement.scale)

		love.graphics.setColor(0, 0, 0, 0.2)
		love.graphics.line(
			clockElement.xCenter + 3 * clockElement.scale,
			clockElement.yCenter + 3 * clockElement.scale,
			hourX + 3 * clockElement.scale,
			hourY + 3 * clockElement.scale
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.line(clockElement.xCenter, clockElement.yCenter, hourX, hourY)
		
		
		-- Minute hand

		local minuteAngle = math.rad(currentTime.min * 6)
		local minuteLength = 
			(
				settings.clockRadius * clockElement.scale -
				settings.clockBorderWidth * clockElement.scale
			) * 0.76
		local minuteX = clockElement.xCenter + minuteLength * math.sin(minuteAngle)
		local minuteY = clockElement.yCenter - minuteLength * math.cos(minuteAngle)

		love.graphics.setLineWidth(6 * clockElement.scale)

		love.graphics.setColor(0, 0, 0, 0.2)
		love.graphics.line(
			clockElement.xCenter + 3 * clockElement.scale,
			clockElement.yCenter + 3 * clockElement.scale,
			minuteX + 3 * clockElement.scale,
			minuteY + 3 * clockElement.scale
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.line(clockElement.xCenter, clockElement.yCenter, minuteX, minuteY)
		
		
		-- Second hand

		local secondAngle = math.rad(currentTime.sec * 6)
		local secondLength =
			(
				settings.clockRadius * clockElement.scale -
				settings.clockBorderWidth * clockElement.scale
			) * 0.85
		local secondX = centerX + secondLength * math.sin(secondAngle)
		local secondY = centerY - secondLength * math.cos(secondAngle)

		love.graphics.setLineWidth(2 * clockElement.scale)

		love.graphics.setColor(0, 0, 0, 0.2)
		love.graphics.line(
			centerX + 3 * clockElement.scale,
			centerY + 3 * clockElement.scale,
			secondX + 3 * clockElement.scale,
			secondY + 3 * clockElement.scale
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.line(centerX, centerY, secondX, secondY)
		
		
		-- Circle in center

		love.graphics.setColor(0, 0, 0, 0.2)
		love.graphics.circle(
			"fill",
			centerX + 1.5 * clockElement.scale,
			centerY + 1.5 * clockElement.scale,
			18 * clockElement.scale
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("fill", centerX, centerY, 15 * clockElement.scale)

		love.graphics.setLineWidth(2 * clockElement.scale)
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("line", centerX, centerY, 15 * clockElement.scale)

		love.graphics.setColor(Color("#ed333b"))
		love.graphics.circle("line", centerX, centerY, 3 * clockElement.scale)
	end
	
	love.graphics.setColor(r,g,b,a)
end


return clockModule
	 	
