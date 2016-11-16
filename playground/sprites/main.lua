-- Description of program: Loads an sprite into a table. And make it move to the left and right, the right is mirrored
local Quad = love.graphics.newQuad

function love.load()

	-- Loads the sprite and gives the position
	character = {}
	character.player = love.graphics.newImage("patchy.png")
	character.x = 50
	character.y = 50

	-- Direction to which we can move
	direction = {}
	direction.right = "right"
	direction.left = "left"
	direction.current = direction.right


	walkSpeed = 5
	iteration = 1 -- Current frame of the sprite
	leftAndRightPressed = false -- Left and right keys pressed at the same time
	max = 9 -- Quantity of sprite's frames
	idle = true -- The character is moving?
	timer = 0.1

	-- Table to load the sprite's frames
	quads = {}
	walk = 'walk'
	quads[walk] = {}
	-- I know using [walk] might seem stupid, but later we can a dimension like [jump]
	-- that's why it's specified as a two dimension table.
	quads[walk][0] = love.graphics.newQuad(540, 256, 45, 98, 1418, 5297)
	quads[walk][1] = love.graphics.newQuad(590, 256, 45, 98, 1418, 5297)
	quads[walk][2] = love.graphics.newQuad(641, 256, 45, 98, 1418, 5297)
	quads[walk][3] = love.graphics.newQuad(691, 256, 45, 98, 1418, 5297)
	quads[walk][4] = love.graphics.newQuad(738, 256, 45, 98, 1418, 5297)
	quads[walk][5] = love.graphics.newQuad(785, 256, 45, 98, 1418, 5297)
	quads[walk][6] = love.graphics.newQuad(832, 256, 45, 98, 1418, 5297)
	quads[walk][7] = love.graphics.newQuad(879, 256, 45, 98, 1418, 5297)
	quads[walk][8] = love.graphics.newQuad(926, 256, 45, 98, 1418, 5297)
	quads[walk][9] = love.graphics.newQuad(972, 256, 45, 98, 1418, 5297)

end

function love.update(dt)

	if idle == false then
		timer = timer + dt
		if timer > 0.2 then
			timer = 0.1
			iteration = iteration + 1
			-- Both left and right keys pressed?
			if love.keyboard.isDown(direction.right) and love.keyboard.isDown(direction.left) then
				iteration = 0
				idle = true
				leftAndRightPressed = true
				return
			end
			-- Right key pressed
			if love.keyboard.isDown(direction.right) then
				character.x = character.x + walkSpeed
			end
			-- Left key pressed
			if love.keyboard.isDown(direction.left) then
				character.x = character.x - walkSpeed
			end
			-- Reached last frame of sprite, start again
			if iteration > max then
				iteration = 0
			end
		end
	end
end


function love.draw()
	if direction.current == direction.left then
		-- Signature of draw function
		--love.graphics.draw( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky)
		-- Magic number 45 is the size of the Quad (sprite frame) and it's rested to avoid a bug when switching from right to left movement, or viceversa.
		love.graphics.draw(character.player, quads[walk][iteration], character.x - 45, character.y, 0,
			1, 1)
		--[[ Explanation of parameters:
			texture: ?
			Quad: ?
			x: The character's Y-Axis postion
			y: The character's Y-axis position
			r: Circular Rotation 
			sx: With 0 it doesn't shows anything, with 1 shows the same as the orignal image, with -1 it flips horizontally and vertically.
				With a value less than -1 it does the same flip, but it also zooms the image.
				With a value more than 1 doesnt' flips but it zooms.
			sy: 0 doesn't shows anything, 1 it's the default value. -1 Flips the value vertically.
				A value less than -1 does the same flip, but it squeezes the image horizontally and makes it longer vertically.
				A value more than 1 squezees the image horziontally, and makes it larger vertically (it increases vertically if the value increments, accordingly)
		]]
	else
		love.graphics.draw(character.player, quads[walk][iteration], character.x, character.y, 0,
			-1, 1)
	end
end

function love.keypressed(key)
	-- Sets the current direction based on key param
	if key == direction.left or key == direction.right then
		direction.current = key
		idle = false
	end
end

function love.keyreleased(key)
	-- If both, left and right, keys *were* pressed and then one or both were released.
	if (key == direction.left or key == direction.right) and leftAndRightPressed == true then
		idle = false -- Make move if one key is released after both were pressed
		leftAndRightPressed = false
	elseif key == direction.left or key == direction.right then
		idle = true
		iteration = 0
	end
end