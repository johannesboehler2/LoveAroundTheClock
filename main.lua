button = require "modules/button"
compass = require "modules/compass"
text = require "modules/text"
clock = require "modules/clock"
overlay = require "modules/overlay"
gamepad = require "modules/gamepad"


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
	-- Add settings overlay
	-- Add different colors
	-- Add high DPI mode
	-- Define all the parameters here
	-- Try to detect Mecha Comet
	-- visible = love.window.isVisible( )
	-- Do not redraw if the display is off
	

	settings = {}
	settings.windowWidth = 540
	settings.windowHeight = 620
	settings.windowScale = 0.667
	settings.windowScale = 2
	--settings.windowScale = 1.85
	settings.headlineFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	settings.headlineFontSize = 34 * settings.windowScale
	settings.headlineFont = love.graphics.newFont(
		settings.headlineFontFamily,
		settings.headlineFontSize
	)
	
	settings.clockFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	settings.clockFontSize = 28
	
	settings.headlineText = "Löve around the clock"
	settings.backgroundColor = {0.2, 0.2, 0.2}
	settings.borderless = false
	settings.clockRadius = 200
	settings.clockBorderWidth = 20
	settings.deepWidth = 6
	settings.showFPS = false
	settings.showGamepad = false
	settings.fullscreen = false
	settings.showHeadline = false
	settings.showCompass = true
	settings.showClock = true
	settings.nightMode = false
	
	
	settings.smallFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	settings.smallFontSize = 22
	settings.smallFont = love.graphics.newFont(
		settings.smallFontFamily,
		settings.smallFontSize
	)
	
	settings.compassFontFamily = "assets/fonts/GlacialIndifference-Bold.otf"
	settings.compassFontSize = 35
	
	settings.overlayFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	
	
	love.window.setMode(
		settings.windowWidth * settings.windowScale,
		settings.windowHeight * settings.windowScale,
		{
			highdpi = true,
			borderless = settings.borderless,
			usedpiscale = true
		}
	)
	
	backgroundImage = love.graphics.newImage("assets/images/background_dark.png")
	
	if settings.fullscreen == true then
		settings.windowScale = 1200 / settings.windowHeight
	
		settings.windowWidth = 1920
		settings.windowHeight = 1200
		
		love.window.setMode(
			settings.windowWidth,
			settings.windowHeight,
			{
				highdpi = true,
				borderless = settings.borderless,
				usedpiscale = true
			}
		)
		
		settings.windowWidth = 1920 / settings.windowScale
		settings.windowHeight = 1200 / settings.windowScale
		
		love.window.setFullscreen(true, "desktop")
		
		backgroundImage = love.graphics.newImage("assets/images/background_dark_fullscreen.png")
	end
	
	
	love.window.setTitle(settings.headlineText)
	
	setImages()
	
	if settings.nightMode then
		love.graphics.setBackgroundColor(0, 0, 0)
	else
		love.graphics.setBackgroundColor(settings.backgroundColor)
	end
	
	
	windowWidth, windowHeight = love.window.getMode()
	
	-- Display center
	centerX, centerY = windowWidth / 2, windowHeight / 2
    
	print(windowWidth)
	print (windowHeight)
	print(love.graphics.getDPIScale( ))
	print(love.system.getOS())
	desktopwidth, desktopheight = love.window.getDesktopDimensions( 1 )
	print(desktopwidth)
	print(desktopheight)
	love.window.setPosition(0 , 0, 1) 
	print(love.system.getPowerInfo())
	print(love.window.getDisplayName(1))

	
	MenuButtonWidget = button:new(
		settings.windowWidth * settings.windowScale - 68 * settings.windowScale, -- X
		48 * settings.windowScale, -- Y
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
    
    
	if settings.showHeadline then
		headlineTextWidget = text:new(9, 6, settings.headlineText, settings.headlineFont,  settings.windowScale)
		headlineTextWidget.text = "Clock"
	end
    
	geoLocationWidget = text:new(
		190,
		6,
		settings.headlineText,
		settings.smallFontFamily,
		settings.smallFontSize,
		settings.windowScale
	)
	geoLocationWidget:setText("47,50° N\n9,73° O")
	geoLocationWidget:setXY(12, 521)
	geoLocationWidget:setColor({0.76, 0.76, 0.76, 1})
    
    
	if settings.showCompass then
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
	
	
	clockBackground = love.graphics.newImage("assets/images/clock_background.png")
	
	clockWidget = clock:new(
		windowWidth / 2,
		windowHeight / 2,
		clockBackground,
		settings.clockFontFamily,
		settings.clockFontSize,
		settings.windowScale * 0.91 -- 0.91 /  1.25 (with compass / without compass)
	)
	
	--clockWidget.scale = 0.1
	--clockWidget.finalScale = settings.windowScale * 0.91

	overlayWidget = overlay:new(
		settings.windowScale,
		love.graphics.newImage("assets/images/menu_button_rectangle_normal.png"),
		love.graphics.newImage("assets/images/menu_button_rectangle_arrow.png"),
		love.graphics.newImage("assets/images/toggle.png"),
		{
			{
				"Uhr anzeigen", -- Text TODO make it smarter
				true, -- Toggle
				false, -- Back
				false -- Active
			},
			{
				"Kompass anzeigen",
				true, -- Toggle
				false,
				true
			},
			{
				"Koordinaten anzeigen",
				true, -- Toggle
				false,
				false
			},
			{
				"About ...",
				false, -- Toggle
				false,
				false
			},
			{
				"Zurück",
				false, -- Toggle
				true,
				false
			}
		},
		"LoveAroundTheClock 0.1\nby Johannes Böhler 2026"
	)
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

		if key == "f2" and isrepeat == false then
			if settings.showClock then
				settings.showClock = false
			else
				settings.showClock = true
			end
		end
		
		if key == "f3" and isrepeat == false then
			if settings.showCompass then
				settings.showCompass = false
			else
				settings.showCompass = true
			end
			
			--TODO set clock scale
		end
		
		if key == "f9" and isrepeat == false then
			if settings.showGamepad then
				settings.showGamepad = false
			else
				settings.showGamepad = true
			end
		end

		
		if key == "f10" and isrepeat == false then
			overlayWidget:toggle()
		end
		
		print(key)
	end
	
	local joysticks = love.joystick.getJoysticks()
	gamepad = joysticks[1]
	
	if gamepad then
		if gamepad:isDown(10) then
			if gamepadButtonPressed10 == false then 
				overlayWidget:toggle()
			end
			gamepadButtonPressed10 = true
		else
			gamepadButtonPressed10 = false
		end
		
		if gamepad:isDown(4) then
			if gamepadButtonPressed4 == false then 
				if settings.showClock then
					settings.showClock = false
				else
					settings.showClock = true
				end
			end
			gamepadButtonPressed4 = true
		else
			gamepadButtonPressed4 = false
		end
		
		if gamepad:isDown(1) then
			if gamepadButtonPressed1 == false then 
				if settings.showCompass then
					settings.showCompass = false
				else
					settings.showCompass = true
				end
			end
			gamepadButtonPressed1 = true
		else
			gamepadButtonPressed1 = false
		end
	end
	

	-- Current time
	currentTime = os.date("*t")
	
	
	if settings.showClock and settings.showCompass == false then
		clockWidget:setScale(1.15 * settings.windowScale) -- 1.25
	end
	
	if settings.showClock and settings.showCompass then
		clockWidget:setScale(0.91 * settings.windowScale)
	end
	
	
	button:update(dt)
	text:update(dt)
   	compass:update(dt)
   	clock:update(dt)
	overlay:update(dt)
end

function love.draw()
	love.graphics.setColor(Color("#ffffff"))
	 
	 if settings.nightMode == false then
		 if settings.fullscreen then
			 love.graphics.draw(
			 	backgroundImage,
			 	0,
			 	0,
			 	0,
			 	backgroundImage:getWidth() / settings.windowWidth, -- TODO
			 	backgroundImage:getHeight() / settings.windowHeight * 1.8 -- TODO
		 	)	 
		 else
			 love.graphics.draw(
			 	backgroundImage,
			 	0,
			 	0,
			 	0,
			 	0.5 * settings.windowScale,
			 	0.5 * settings.windowScale
		 	)
		 	
		 	love.graphics.setColor(0, 0, 0, 0.7)
		 	
			--love.graphics.rectangle(
			--	"fill",
			--    0,
			--    0,
			--    settings.windowWidth * settings.windowScale,
			--    settings.windowHeight * settings.windowScale
		    	--)
		 end
	 end
		
 	
 	button:draw()
	text:draw()
	
	
	if settings.showCompass then
		compass:draw()
	end
	
	if settings.showClock then
		clock:draw()
	end

	
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


    	-- Gamepad
	
	if gamepad and settings.showGamepad then
		drawGamepad()
	end
	
	overlay:draw()
	
	--print(love.window.isVisible( ))
end

function setImages()
	if settings.nightMode then
		menuButtonImageNormal = love.graphics.newImage("assets/images/menu_button_normal_red.png")
		menuButtonImageHover = love.graphics.newImage("assets/images/menu_button_hover_red.png")
		
		compassBackgroundImage = love.graphics.newImage("assets/images/compass_background_red.png")
		compassImage = love.graphics.newImage("assets/images/compass_red.png")
	else
		menuButtonImageNormal = love.graphics.newImage("assets/images/menu_button_normal_002.png")
		menuButtonImageHover = love.graphics.newImage("assets/images/menu_button_hover_002.png")
		
		compassBackgroundImage = love.graphics.newImage("assets/images/compass_background.png")
		compassImage = love.graphics.newImage("assets/images/compass.png")
	end
end
