button = require "modules/button"
compass = require "modules/compass"
text = require "modules/text"


local fps = 0;
local durationSinceLastSecond = 0;


function round(num, decimal)
	local mult = 10^(decimal or 0)
	return math.floor(num * mult + 0.5) / mult
end


function Color(hex, value)
	return {
		tonumber(string.sub(hex, 2, 3), 16) / 256,
		tonumber(string.sub(hex, 4, 5), 16) / 256,
		tonumber(string.sub(hex, 6, 7), 16) / 256,
		value or 1
	}
end

function ColorFromRGBA(r, g, b, a)
	return {
		1 / 255 * r,
		1 / 255 * g,
		1 / 255 * b,
		a or 1
	}
end


function love.load()
	-- TODO
	-- Optimize code
	-- Add night mode
	-- visible = love.window.isVisible( )
	-- Do not redraw if the display is off
	

	settings = {}
	settings.windowWidth = 540
	settings.windowHeight = 580
	settings.windowScale = 0.667
	settings.windowScale = 2
	--settings.windowScale = 1.85
	
	settings.backgroundColor = {0, 0, 0}
	settings.borderless = false

	settings.showFPS = false
	settings.nightMode = false
	
	settings.compassFontFamily = "assets/fonts/GeistMono-VariableFont_wght.ttf"
	settings.compassFontSize = 42
	
	
	love.window.setMode(
		settings.windowWidth * settings.windowScale,
		settings.windowHeight * settings.windowScale,
		{
			highdpi = true,
			borderless = settings.borderless,
			usedpiscale = true
		}
	)
	
	
	love.window.setTitle("Mecha Comet Compass")
	
	setImages()

	love.graphics.setBackgroundColor(settings.backgroundColor)

	
	windowWidth, windowHeight = love.window.getMode()
	
	-- Display center
	centerX, centerY = windowWidth / 2, windowHeight / 2

	
	buttonNightLightWidget = button:new(
		settings.windowWidth * settings.windowScale - 68 * settings.windowScale, -- X
		settings.windowHeight * settings.windowScale - 68 * settings.windowScale, -- Y
		0.5 * settings.windowScale, -- Scale (the image has double size)
		menuButtonImageNormal,
		menuButtonImageHover,
		function() -- Button's function
		    --print("Hello")
		    overlayWidget:toggle()
		end,
		function() -- Button's function
		    --print("Hover")
		end
	)

	
	compassWidget = compass:new(
		windowWidth / 2,
		windowHeight / 2,
		compassBackgroundImage,
		compassImage,
		settings.compassFontFamily,
		settings.compassFontSize,
		settings.windowScale
	)
	
	compassWidget:setDegree(110)
end

function love.update(dt)
	durationSinceLastSecond = durationSinceLastSecond + dt;
	
	-- Execute every second
	if durationSinceLastSecond > 1 then
		fps = 1 / dt
		durationSinceLastSecond = 0
	end
	
	-- Quit the game
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	
	function love.keypressed(key, scancode, isrepeat)
		if key == "f1" and isrepeat == false then
			if settings.showFPS then
				settings.showFPS = false
			else
				settings.showFPS = true
			end
		end
	end

	
	
	button:update(dt)
	text:update(dt)
   	compass:update(dt)
end

function love.draw()
	love.graphics.setColor(Color("#ffffff"))
		
 	
 	button:draw()
	text:draw()
	compass:draw()


	
	-- FPS
	
	if settings.showFPS then
		love.graphics.setNewFont(22 * settings.windowScale)
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(
			round(fps, 0) .. " FPS",
			windowWidth - 150 * settings.windowScale,
			10 * settings.windowScale
		)
	end
end

function setImages()
	if settings.nightMode then
		menuButtonImageNormal = love.graphics.newImage("assets/images/menu_button_simple_orange.png")
		menuButtonImageHover = love.graphics.newImage("assets/images/menu_button_simple_orange.png")
		
		compassBackgroundImage = love.graphics.newImage("assets/images/compass_background_orange.png")
		compassImage = love.graphics.newImage("assets/images/compass_orange.png")
	else
		menuButtonImageNormal = love.graphics.newImage("assets/images/menu_button_simple_orange.png")
		menuButtonImageHover = love.graphics.newImage("assets/images/menu_button_simple_orange.png")
		
		compassBackgroundImage = love.graphics.newImage("assets/images/compass_background_orange.png")
		compassImage = love.graphics.newImage("assets/images/compass_orange.png")
	end
end
