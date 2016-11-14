-- shapes main: This creates a small rectangle and rotates it by position and by angle.

function love.load() --- loads all we need in game
	--- set color for our shapes RGB
	love.graphics.setColor(0, 0, 0, 225)
	--- set the background color RGB
	love.graphics.setBackgroundColor(225, 153, 0)
end

-- variables
local angle = 0
local width = 10
local height = 10

-- draw a rectangle
function love.draw()
	-- rotate
	love.graphics.rotate(angle)

	-- draw a blue rectangle
	love.graphics.setColor(0, 0, 225)
	love.graphics.rectangle("fill", 300, 400, width, height)
end

-- update
function love.update(dt)
	-- on pressing the 'd' key, rotate to the right
	if love.keyboard.isDown('d') then
		angle = angle + math.pi * dt
	elseif love.keyboard.isDown('a') then
		angle = angle - math.pi * dt -- rotate to the left
	end
end


-- old code: this shows some shapes; a circle, rectangle, and arc.
--[[function love.draw() --- function to display/draw content to screen
	--- draw circle with parameters(mode, x-pos, y-pos, radius, segments)
	love.graphics.circle("fill", 200, 300, 50, 50)
	--- draw rectangle with parameters(mode, x-pos, y-pos, width, height)
	love.graphics.rectangle("fill", 300, 300, 100, 100)
	--- draw an arc with parameters(mode, x-pos, y-pos, radius, angle1, angle2)
	love.graphics.arc("fill", 450, 300, 100, math.pi / 5, math.pi / 2)
end
]]

