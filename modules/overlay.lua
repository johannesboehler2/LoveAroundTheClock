overlayButton = require "modules/button"


-- Overlay module

local overlayModule = {} -- Here we store all the functions

local overlayList = {} -- Here we store all the new overlays


function overlayModule:new(scale, imgNormal, imgNormalArrow, menuList, bottomText)
	local newOverlay = {}
	
	newOverlay.opacity = 0
	newOverlay.finalOpacity = 0.78
	newOverlay.openAfter = 1 -- TODO remove
	newOverlay.closeAfter = 14 -- TODO remove
	newOverlay.time = 0
	newOverlay.fadeIn = false
	newOverlay.fadeOut = false
	newOverlay.isOpen = false
	newOverlay.scale = scale
	newOverlay.imgNormal = imgNormal
	newOverlay.imgNormalArrow = imgNormalArrow
	newOverlay.menuList = menuList
	newOverlay.bottomText = bottomText or false
	newOverlay.font = love.graphics.newFont(
		settings.overlayFontFamily,
		28 * newOverlay.scale
	)
	newOverlay.bottomFont = love.graphics.newFont(
		settings.overlayFontFamily, -- TODO
		24 * newOverlay.scale
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
		 	0.5 * overlayElement.scale,
		 	0.5 * overlayElement.scale
	 	)
	 	
	 	
	 	love.graphics.setColor(1, 1, 1, overlayElement.opacity)
		love.graphics.setFont(overlayElement.font)

		
		for i, menuElement in ipairs(overlayElement.menuList) do
		 	local text
		 	
		 	if menuElement[3] then
		 		text = "    " .. menuElement[1]
		 		overlayMenuImage = overlayElement.imgNormalArrow
		 	else
		 		text = menuElement[1]
		 		overlayMenuImage = overlayElement.imgNormal
		 	end
		 	
		 	toggleMenuImage = love.graphics.newImage("assets/images/toggle.png") -- TODO refactor for performance
		 	
		 	
		 	if menuElement[4] then
		 		love.graphics.setColor(1, 1, 1, overlayElement.opacity)
		 	else
		 		love.graphics.setColor(0.7, 0.7, 0.7, overlayElement.opacity)
		 	end
		 	
		 						
			love.graphics.draw(
			 	overlayMenuImage,
			 	(settings.windowWidth * overlayElement.scale - overlayMenuImage:getWidth() / 2 * overlayElement.scale) / 2, -- TODO
			 	(156 + (i - 1) * 62) * overlayElement.scale, -- TODO
			 	0,
			 	0.5 * overlayElement.scale, 
			 	0.5 * overlayElement.scale 
		 	)
		 	
		 	love.graphics.print(
				text,
				102 * overlayElement.scale, 
				(168 + (i - 1) * 62) * overlayElement.scale -- TODO
			)
			
			
			if menuElement[2] then
				love.graphics.draw(
				 	toggleMenuImage,
				 	(settings.windowWidth * overlayElement.scale + overlayMenuImage:getWidth() / 2 * overlayElement.scale - 126 * overlayElement.scale) / 2, -- TODO
				 	(161 + (i - 1) * 62) * overlayElement.scale, -- TODO
				 	0,
				 	0.5 * overlayElement.scale, 
				 	0.5 * overlayElement.scale 
			 	)
		 	end
		end
		
		
		if not overlayElement.bottomText == false then
			love.graphics.setFont(overlayElement.bottomFont)
			love.graphics.print(
				overlayElement.bottomText,
				102 * overlayElement.scale, -- TODO
				480 * overlayElement.scale -- TODO
			)
		end
	end
	
	love.graphics.setColor(r,g,b,a) -- We reset the color to the state before we draw the overlay
end


return overlayModule


