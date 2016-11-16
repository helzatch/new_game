-- Same as /playground/sprites/ project, but in this one the character is bounded to the left and right side, so can't go further.
-- It's based on some code of /new_game/main/ project.
-- Note that the /playground/sprites/ project has actually better code (uses less literals, a bit more of functionality) so we can
-- take that and put it here too.

local Quad = love.graphics.newQuad
platform = {}
player = {}

function love.load()

	character = {}

	character.player = love.graphics.newImage("patchy.png")
	character.x = 50
	character.y = 50
	direction = "right" -- should be right
	iteration = 1

	max = 9 -- qty of sprite's frames

	idle = true

	timer = 0.1

	-- wall hit test
	character.width = 45
	character.height = 98
	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()
	platform.x = 0
	platform.y = platform.height - platform.height / 16
	player.x = love.graphics.getWidth() / 2
	player.y = platform.height - platform.height / 6 + 2 -- 0 is top
	player.speed = 5


	quads = {}
	--quads['right'] = {}
	walk = 'walk'
	quads[walk] = {}

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
			if love.keyboard.isDown('right') then
				--character.x = character.x + 5
				if player.x < (love.graphics.getWidth()) then
					player.x = player.x + (player.speed)
				end
			end
			if love.keyboard.isDown('left') then
				--character.x = character.x - 5
				if player.x > 0 + (character.width) + 4 then
					player.x = player.x - (player.speed)
				end
			end
			-- re-starts the animation
			if iteration > max then
				iteration = 0
			end
		end
	end
end


function love.draw()
	if direction == 'left' then
		love.graphics.draw(character.player, quads[walk][iteration], player.x - 45, player.y, 0,
			1, 1)
			--love.graphics.draw(character.player, quads['left'][iteration], character.x, character.y, 0,
			---1, 1)
		--love.graphics.draw(character.player, quads[direction][iteration], character.x, character.y)
		---1, 1)
		--[[
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
		--love.graphics.draw(character.player, quads[direction][iteration], character.x, character.y)
		--[[love.graphics.draw(character.player, quads[direction][iteration], character.x, character.y,
			0, 0, 0, 0, 0, 0, 0)]]
		love.graphics.draw(character.player, quads[walk][iteration], player.x, player.y, 0,
			-1, 1)
	end
end

function love.keypressed(key)
	--[[if quads[key] then
		direction = key
		idle = false
	end]]
	if key == 'left' or key == 'right' then
		direction = key
		idle = false;
	end
end

function love.keyreleased(key)
	--[[if quads[key] and direction == key then
		idle = true
		iteration = 0

		-- Sets to default poistion after a relesea, (left or right)
		--direction = "right" --should be right
	end]]

	if key == 'left' or key == 'right' then
		idle = true
		iteration = 0
	end
end