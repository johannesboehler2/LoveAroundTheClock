-- Button module

function in_bound(target, mx, my) --This one do math and allows you to create a hitbox for the button
	return mx >= target.x and mx <= target.x + target.width and my >= target.y and my <= target.y + target.height
end

screen = { w= love.graphics.getWidth(), h= love.graphics.getHeight()} -- This help us to center the buttons

local button_module = {} -- Here we store all the functions

local button_module.buttons = {} -- Here we store all the new buttons


function button_module:new(x, y, scale, imgNormal, imgHover, funcClick, funcHover, text, textColor, textX, textY, center)
	-- Put this in love.load()
	local newButton = {} -- We create a table and we create inside of it all the features we want for the button
	newButton.x = x
	newButton.y = y
	newButton.scale = scale
	newButton.width = imgNormal:getWidth() * scale
	newButton.height = imgNormal:getHeight() * scale
	newButton.imgNormal = imgNormal
	newButton.imgHover = imgHover
	newButton.scale = scale
	
	newButton.funcClick = funcClick or function()print("No function detected")end
	newButton.funcHover = funcHover or function()print("No function detected")end
	newButton.text = text or false
	newButton.textColor = textColor or {1, 1, 1}
	newButton.textX = textX or 12
	newButton.textY = textY or 8
	newButton.center = center or false
	
	newButton.hover = false
	newButton.hoverOpacity = 0

	table.insert(button_module.buttons, newButton)
end



function button_module:update(dt) -- Put this in love.update()
	for i,v in ipairs(button_module.buttons) do
		local x,y = love.mouse.getPosition()
		local leftClick = love.mouse.isDown(1)
		local rightClick = love.mouse.isDown(2)
		local inBound = in_bound(v, x, y)

		if inBound and leftClick then
			v.funcClick()
		end
		
		if inBound then
        		v.funcHover()
        		
        		v.hover = true
        		v.hoverOpacity = v.hoverOpacity + 1 / (0.15 / dt) -- 0.15s
        		if v.hoverOpacity > 1 then
        			v.hoverOpacity = 1
    			end
        	else
        		v.hover = false
        		
        		v.hoverOpacity = v.hoverOpacity - 1 / (0.15 / dt) -- 0.15s
        		
        		if v.hoverOpacity < 0 then
        			v.hoverOpacity = 0
    			end
		end
        	
	end

end

function button_module:draw() -- Put this in love.draw()
	local r,g,b,a = love.graphics.getColor()

	for i,v in ipairs(button_module.buttons) do
		if v.center == true then -- if the center option is set on "true" then we center the button AND the text :D
			--TODO: implement
		else
		    	love.graphics.setColor(1,1,1)
		    	
		    	if v.hover then
				love.graphics.draw(
				 	v.imgNormal,
				 	v.x,
				 	v.y,
				 	0,
				 	v.scale,
				 	v.scale
			 	)
            	
            			love.graphics.setColor(1,1,1, v.hoverOpacity)
            	
				love.graphics.draw(
				 	v.imgHover,
				 	v.x,
				 	v.y,
				 	0,
				 	v.scale,
				 	v.scale
			 	)
			else
				love.graphics.draw(
				 	v.imgNormal,
				 	v.x,
				 	v.y,
				 	0,
				 	v.scale,
				 	v.scale
			 	)
			 	
			 	if v.hoverOpacity > 0 then
		        		love.graphics.setColor(1,1,1, v.hoverOpacity)
		        	
					love.graphics.draw(
					 	v.imgHover,
					 	v.x,
					 	v.y,
					 	0,
					 	v.scale,
					 	v.scale
				 	)
				end
		 	end
		 	
			if not v.text == false then
				love.graphics.setColor(v.textColor)
				love.graphics.print(v.text, v.x + v.textX, v.y + v.textY)	
			end
		end

		love.graphics.setColor(r,g,b,a) -- We reset the color to the state before we draw the buttons
	end
end

function button_module:delete(btn)
	table.remove(buttons, btn.label)
end

return button_module
