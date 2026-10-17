overlayButton = require "modules/button"


-- Overlay module

local overlayModule = {} -- Here we store all the functions

local overlayList = {} -- Here we store all the new overlays


function overlayModule:new()
	local newOverlay = {}
	
	newOverlay.opacity = 0
	newOverlay.finalOpacity = 0.78
	newOverlay.openAfter = 1
	newOverlay.closeAfter = 14
	newOverlay.time = 0
	newOverlay.fadeIn = false
	newOverlay.fadeOut = false
	newOverlay.isOpen = false
	newOverlay.font = love.graphics.newFont(
		settings.overlayFontFamily,
		28 * settings.windowScale
	)
	newOverlay.aboutFont = love.graphics.newFont(
		settings.overlayFontFamily,
		24 * settings.windowScale
	)
	
	function newOverlay:open()
		self.fadeIn = true
		self.fadeOut = false
	end
	
	function newOverlay:close()
		self.fadeIn = false
		self.fadeOut = true
	end
	
	function newOverlay:toggle()
		if self.isOpen then
			self:close()
		else
			self:open()
		end
	end
	
	newOverlay.menuList = {
		{
			"Uhr anzeigen", -- Text
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
	}
	
	table.insert(overlayList, newOverlay)
	
	
	return newOverlay
end

function overlayModule:update(dt) -- Put this in love.update()
	for i,overlayElement in ipairs(overlayList) do
        	overlayElement.time = overlayElement.time + dt 
        	
        	
        	
        	--if overlayElement.time > overlayElement.openAfter and overlayElement.time < overlayElement.openAfter + 1 + overlayElement.closeAfter and overlayElement.fadeOut == false then
		--	overlayElement.fadeIn = true
        	--	overlayElement.opacity = overlayElement.opacity + 1 / (0.5/ dt) -- 0.15s
        	--	
		--	if overlayElement.opacity > overlayElement.finalOpacity then
		--		overlayElement.opacity = overlayElement.finalOpacity
		--		overlayElement.fadeIn = false
		--	end
        	--end
        	
        	--if overlayElement.time > overlayElement.openAfter + 1 + overlayElement.closeAfter then
        	--	overlayElement.fadeOut = true
        	--	overlayElement.opacity = overlayElement.opacity - 1 / (0.5 / dt) -- 0.15s
        	--
		--	if overlayElement.opacity < 0 then
		--		overlayElement.opacity = 0
		--		overlayElement.fadeOut = false
		--	end
        	--end
        	
        	if overlayElement.fadeIn == true then
        		overlayElement.opacity = overlayElement.opacity + 1 / (0.2/ dt) -- 0.5s
        		
        		overlayElement.isOpen = true
        		
			if overlayElement.opacity > overlayElement.finalOpacity then
				overlayElement.opacity = overlayElement.finalOpacity
				overlayElement.fadeIn = false
			end
        	end
        	
        	if overlayElement.fadeOut == true then
        		overlayElement.opacity = overlayElement.opacity - 1 / (0.2 / dt) -- 0.5s
        		
        		overlayElement.isOpen = false
        	
			if overlayElement.opacity < 0 then
				overlayElement.opacity = 0
				overlayElement.fadeOut = false
			end
        	end
        	
	end
end

function overlayModule:draw() -- Put this in love.draw()
	local r,g,b,a = love.graphics.getColor()

	for i,overlayElement in ipairs(overlayList) do
		-- Menu overlay
		
	 	love.graphics.setColor(0,0,0, overlayElement.opacity)
		love.graphics.draw(
		 	backgroundImage,
		 	0,
		 	0,
		 	0,
		 	0.5 * settings.windowScale,
		 	0.5 * settings.windowScale
	 	)
	 	
	 	
	 	love.graphics.setColor(1, 1, 1, overlayElement.opacity)
		love.graphics.setFont(overlayElement.font)

		
		for i, menuElement in ipairs(overlayElement.menuList) do
		 	local text
		 	
		 	if menuElement[3] then
		 		text = "    " .. menuElement[1]
		 		overlayMenuImage = love.graphics.newImage("assets/images/menu_button_rectangle_arrow.png") -- TODO refactor for performance
		 	else
		 		text = menuElement[1]
		 		overlayMenuImage = love.graphics.newImage("assets/images/menu_button_rectangle_normal.png") -- TODO refactor for performance
		 	end
		 	
		 	toggleMenuImage = love.graphics.newImage("assets/images/toggle.png") -- TODO refactor for performance
		 	
		 	
		 	if menuElement[4] then
		 		love.graphics.setColor(1, 1, 1, overlayElement.opacity)
		 	else
		 		love.graphics.setColor(0.7, 0.7, 0.7, overlayElement.opacity)
		 	end
		 	
		 						
			love.graphics.draw(
			 	overlayMenuImage,
			 	(settings.windowWidth * settings.windowScale - overlayMenuImage:getWidth() / 2 * settings.windowScale) / 2,
			 	(156 + (i - 1) * 62) * settings.windowScale,
			 	0,
			 	0.5 * settings.windowScale,
			 	0.5 * settings.windowScale
		 	)
		 	
		 	love.graphics.print(
				text,
				102 * settings.windowScale,
				(168 + (i - 1) * 62) * settings.windowScale
			)
			
			
			if menuElement[2] then
				love.graphics.draw(
				 	toggleMenuImage,
				 	(settings.windowWidth * settings.windowScale + overlayMenuImage:getWidth() / 2 * settings.windowScale - 126 * settings.windowScale) / 2,
				 	(161 + (i - 1) * 62) * settings.windowScale,
				 	0,
				 	0.5 * settings.windowScale,
				 	0.5 * settings.windowScale
			 	)
		 	end
		end
		
		love.graphics.setFont(overlayElement.aboutFont)
		
		love.graphics.print(
			"LoveAroundTheClock 0.1\nby Johannes Böhler",
			102 * settings.windowScale,
			480 * settings.windowScale
		)
		
		
		love.graphics.setColor(r,g,b,a) -- We reset the color to the state before we draw the buttons
		
		
		
		--overlayButton:draw()
	end
end


return overlayModule


