overlayButton = require "modules/button"


-- Overlay module

local overlayModule = {} -- Here we store all the functions

local overlayList = {} -- Here we store all the new overlays


function overlayModule:new()
	newOverlay = {}
	
	
	--MenuButtonWidget002 = overlayButton:new(
	--	settings.windowWidth * settings.windowScale - 68 * settings.windowScale, -- X
	--	148 * settings.windowScale, -- Y
	--	0.5 * settings.windowScale, -- Scale (the image has double size)
	--	love.graphics.newImage("assets/images/menu_button_normal_002.png"),
	--	love.graphics.newImage("assets/images/menu_button_hover_002.png"),
	--	function() -- Button's function
	--	    --print("Hello")
	--	end,
	--	function() -- Button's function
	--	    --print("Hover")
	--	end,
	--	"Menu 002",
	--	{1,1,1, 0.6}
	--)
	
	-- Add menu button widget to newOverlay
	
	
	font = love.graphics.newFont(
			settings.compassFontFamily,
			settings.compassFontSize * settings.windowScale
		)
	
	
	table.insert(overlayList, newOverlay)
	
	
	return newOverlay
end

function overlayModule:update(dt) -- Put this in love.update()
	for i,overlayElement in ipairs(overlayList) do
        	overlayButton:update(dt)
	end
end

function overlayModule:draw() -- Put this in love.draw()
	local r,g,b,a = love.graphics.getColor()

	for i,overlayElement in ipairs(overlayList) do
		-- Menu overlay
		
	 	love.graphics.setColor(0,0,0, 0.8)
		love.graphics.draw(
		 	backgroundImage,
		 	0,
		 	0,
		 	0,
		 	0.5 * settings.windowScale,
		 	0.5 * settings.windowScale
	 	)
	 	
	 	
	 	love.graphics.setColor(1,1,1,0.8)
	 	
		
		
		love.graphics.setFont(font)
	 	
	 	love.graphics.print(
			"Menu 001",
			260,
			210
		)
		
		love.graphics.print(
			"Menu 002",
			260,
			280
		)
		
		love.graphics.print(
			"Menu 003",
			260,
			350
		)
		
		
		love.graphics.setColor(r,g,b,a) -- We reset the color to the state before we draw the buttons
		
		
		
		--overlayButton:draw()
	end
end


return overlayModule


