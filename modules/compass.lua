-- Compass module

local compassModule = {} -- Here we store all the functions

local compassList = {} -- Here we store all the new buttons


function compassModule:new(xCenter, yCenter, imgCompassBackground, imgCompass, fontFamily, fontSize, scale) -- Put this in love.load()
	newCompass = {} -- We create a table and we create inside of it all the features we want for the compass
	newCompass.xCenter = xCenter
	newCompass.yCenter = yCenter
	newCompass.degree = 0
	newCompass.imgCompassBackground = imgCompassBackground
	newCompass.imgCompass = imgCompass
	newCompass.fontFamily = fontFamily
	newCompass.fontSize = fontSize
	newCompass.scale = scale
	newCompass.font = love.graphics.newFont(
		newCompass.fontFamily,
		newCompass.fontSize * newCompass.scale
	)

	table.insert(compassList, newCompass)
	
	
	return newCompass
end

function compassModule:update(dt) -- Put this in love.update()
	for i,compassElement in ipairs(compassList) do
 		compassElement.degree = compassElement.degree + 10 * dt -- 20 ° / sek
 		
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
	 		compassElement.xCenter,
	 		compassElement.yCenter,
	 		0,
	 		0.5 * compassElement.scale,
	 		0.5 * compassElement.scale,
	 		compassElement.imgCompassBackground:getWidth() / 2,
	 		compassElement.imgCompassBackground:getHeight() / 2
		)
		
		
	 	love.graphics.setColor(1, 1, 1, 1)
	 	
	 	love.graphics.draw(
	 		compassElement.imgCompass,
	 		compassElement.xCenter,
	 		compassElement.yCenter,
	 		-(compassElement.degree / 360 * math.pi * 2), -- TODO
	 		0.5 * compassElement.scale,
	 		0.5 * compassElement.scale,
	 		compassElement.imgCompass:getWidth() / 2,
	 		compassElement.imgCompass:getHeight() / 2
		)
		
		
		local compassDegreeRounded = round(compassElement.degree) .. "°"
		
		love.graphics.setFont(compassElement.font) -- TODO
		
		fontHeight = love.graphics:getFont():getHeight()
		fontWidth = love.graphics:getFont():getWidth(compassDegreeRounded)
		
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print(
			compassDegreeRounded,
			compassElement.xCenter - fontWidth / 2 - 1 * compassElement.scale,
			compassElement.yCenter - 299 * compassElement.scale - 1 * compassElement.scale
		)
		
		love.graphics.setColor(0.76, 0.76, 0.76, 1)
		love.graphics.print(
			compassDegreeRounded,
			compassElement.xCenter - fontWidth / 2 ,
			compassElement.yCenter - 299 * compassElement.scale
		)
		
		
		--Can I change the font size -- TODO scale with the compass
		
		love.graphics.setFont(compassElement.font) -- TODO
		
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print(
			compassDegreeRounded,
			(11 - 1) * compassElement.scale,
			compassElement.yCenter - 267 * compassElement.scale - 1 * compassElement.scale
		)
		
		love.graphics.setColor(0.76, 0.76, 0.76, 1)
		love.graphics.print(
			compassDegreeRounded,
			(11) * compassElement.scale,
			compassElement.yCenter - 267 * compassElement.scale
		)
		
	end
end


return compassModule

