-- Compass module

local compassModule = {} -- Here we store all the functions

local compassList = {} -- Here we store all the new buttons


function compassModule:new(x, y, imgCompassBackground, imgCompass) -- Put this in love.load()
	newCompass = {} -- We create a table and we create inside of it all the features we want for the compass
	newCompass.x = x
	newCompass.y = y
	newCompass.degree = 0
	newCompass.imgCompassBackground = imgCompassBackground
	newCompass.imgCompass = imgCompass

	table.insert(compassList, newCompass)
	
	
	return newCompass
end

function compassModule:update(dt) -- Put this in love.update()
	for i,compassElement in ipairs(compassList) do
		local x, y = love.mouse.getPosition()
		
 		compassElement.degree = compassElement.degree + 4 * dt -- 20 ° / sek
 		
 		if compassElement.degree >= 359.5 then
 			if compassElement.degree > 359.5 and compassElement.degree < 360 then
 				compassElement.degree = compassElement.degree - 360
 			else
 				compassElement.degree = 0
 			end
		end
        	
	end

end

function compassModule:draw() -- Put this in love.draw()
	local r,g,b,a = love.graphics.getColor()

	for i,compassElement in ipairs(compassList) do
	 	love.graphics.setColor(1, 1, 1, 1)
	 	
	 	love.graphics.draw(
	 		compassElement.imgCompassBackground,
	 		windowWidth / 2, -- TODO
	 		windowHeight / 2, -- TODO
	 		0,
	 		0.5 * settings.windowScale, -- TODO
	 		0.5 * settings.windowScale, -- TODO
	 		compassElement.imgCompassBackground:getWidth() / 2,
	 		compassElement.imgCompassBackground:getHeight() / 2
		)
		
		
	 	love.graphics.setColor(1, 1, 1, 1)
	 	
	 	love.graphics.draw(
	 		compassElement.imgCompass,
	 		windowWidth / 2, -- TODO
	 		windowHeight / 2, -- TODO
	 		-(compassElement.degree / 360 * math.pi * 2), -- TODO
	 		0.5 * settings.windowScale, -- TODO
	 		0.5 * settings.windowScale, -- TODO
	 		compassElement.imgCompass:getWidth() / 2,
	 		compassElement.imgCompass:getHeight() / 2
		)
		
		
		local compassDegreeRounded = round(compassElement.degree) .. "°"
		
		love.graphics.setFont(settings.headlineFont)
		
		fontHeight = love.graphics:getFont():getHeight()
		fontWidth = love.graphics:getFont():getWidth(compassDegreeRounded)
		
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print(
			compassDegreeRounded,
			windowWidth / 2 - fontWidth / 2 - 1 * settings.windowScale,
			windowHeight / 2 - 299 * settings.windowScale - 1 * settings.windowScale
		)
		
		love.graphics.setColor(0.76, 0.76, 0.76, 1)
		love.graphics.print(
			compassDegreeRounded,
			windowWidth / 2 - fontWidth / 2 ,
			windowHeight / 2 - 299 * settings.windowScale
		)
	end
end


return compassModule

