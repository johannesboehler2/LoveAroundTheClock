-- Compass module

local compassModule = {} -- Here we store all the functions

local compassList = {} -- Here we store all the new compass


function compassModule:new(xCenter, yCenter, imgCompassBackground, imgCompass, fontFamily, fontSize, fontColor, scale)
	newCompass = {}
	newCompass.xCenter = xCenter
	newCompass.yCenter = yCenter
	newCompass.degree = 0
	newCompass.imgCompassBackground = imgCompassBackground
	newCompass.imgCompass = imgCompass
	newCompass.fontFamily = fontFamily
	newCompass.fontSize = fontSize
	newCompass.fontColor = fontColor
	newCompass.scale = scale
	newCompass.finalScale = scale
	newCompass.font = love.graphics.newFont(
		newCompass.fontFamily,
		newCompass.fontSize * newCompass.scale
	)
	newCompass.dummyMode = true
	
	
	function newCompass:setDegree(degree)
		self.degree = degree
	end
	
	function newCompass:setFont()
		self.font = love.graphics.newFont(
			self.fontFamily,
			self.fontSize * self.scale
		)
	end
	
	function newCompass:setFontColor(fontColor)
		self.fontColor = fontColor
	end
	
	function newCompass:setScale(scale)
		self.finalScale = scale
		self:setFont() -- Reinit font for font size
	end
	
	function newCompass:setImages(imgCompassBackground, imgCompass)
		self.imgCompassBackground = imgCompassBackground
		self.imgCompass = imgCompass
	end
	
	newCompass:setFont()
	

	table.insert(compassList, newCompass)
	
	
	return newCompass
end

function compassModule:update(dt) -- Put this in love.update()
	for i, compassElement in ipairs(compassList) do
		if compassElement.dummyMode then
			compassElement.degree = compassElement.degree + 5 * dt -- 5 ° / sek
		else
			-- TODO Get real data at this point!
		end
 		
 		
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
	local r, g, b, a = love.graphics.getColor()

	for i, compassElement in ipairs(compassList) do
	 	love.graphics.setColor(1, 1, 1, 1)
	 	
	 	
	 	-- Compass background image
	 	
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
		
		
		-- Compass image
		
	 	love.graphics.setColor(1, 1, 1, 1)
	 	
	 	love.graphics.draw(
	 		compassElement.imgCompass,
	 		compassElement.xCenter,
	 		compassElement.yCenter,
	 		-(compassElement.degree / 360 * math.pi * 2),
	 		0.5 * compassElement.scale,
	 		0.5 * compassElement.scale,
	 		compassElement.imgCompass:getWidth() / 2,
	 		compassElement.imgCompass:getHeight() / 2
		)
		
		
		local compassDegreeRounded = round(compassElement.degree) .. "°"
		
		love.graphics.setFont(compassElement.font)
		
		fontHeight = love.graphics:getFont():getHeight()
		fontWidth = love.graphics:getFont():getWidth(compassDegreeRounded)
		
		love.graphics.setColor(compassElement.fontColor)
		love.graphics.print(
			compassDegreeRounded,
			(13) * compassElement.scale,
			compassElement.yCenter - 268 * compassElement.scale
		)
	end
	
	love.graphics.setColor(r, g, b, a) -- We reset the color to the state before we draw the compass
end


return compassModule

