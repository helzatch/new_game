platform = {}
player = {}

function love.load()
        -- This is the height and the width of the platform.
	platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
	platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.
 
        -- This is the coordinates where the platform will be rendered.
	platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
	platform.y = platform.height -  platform.height/16             -- This starts drawing the platform at the height of the screen minus one 1/16 of the of the height
        -- This is the coordinates where the player character will be rendered.
	player.x = love.graphics.getWidth() / 2   -- This sets the player at the middle of the screen based on the width of the game window. 
	player.y = platform.height -  platform.height/16  -- This sets the player at the height of the screen minus one 1/16 of the of the height

        -- This calls the file named "purple.png" and puts it in the variable called player.img.
	player.img = love.graphics.newImage('purple.png')

	player.speed = 200    -- This is the player's speed. This value can be change based on your liking.
end
 
function love.update(dt)
	if love.keyboard.isDown('d') then
		-- This makes sure that the character doesn't go pass the game window's right edge.
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		-- This makes sure that the character doesn't go pass the game window's left edge.
		if player.x > 0 then 
			player.x = player.x - (player.speed * dt)
		end
	end
end
 
function love.draw()
	love.graphics.setColor(255, 255, 255)        -- This sets the platform color to white. (The parameters are in RGB Color format).
 
        -- The platform will now be drawn as a white rectangle while taking in the variables we declared above.
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)

	        -- This draws the player.
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
end
