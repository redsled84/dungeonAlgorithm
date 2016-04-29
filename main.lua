math.randomseed(os.time())
math.random(); math.random(); math.random();

local tileSize = 32
local Room = {rooms={}}

function Room:initializeRootRoom()
	local screenTileX = math.floor(love.graphics.getWidth() / tileSize)
	local screenTileY = math.floor(love.graphics.getHeight() / tileSize)
	local tilesWide = math.random(2, 7)
	local tilesHigh = math.random(2, 7)
	local x, y = math.random(0, screenTileX-tilesWide), math.random(0, screenTileY-tilesHigh)
	self.base = {x = x*tileSize, y = y*tileSize, w = tilesWide*tileSize, h = tilesHigh*tileSize}
end

function Room:chooseSide(roomA, roomB, side)
	if side == 2 then
		return roomA.x+roomA.w, roomA.y
	elseif side == 4 then
		return roomA.x-roomB.w, roomA.y
	elseif side == 1 then
		return roomA.x, roomA.y-roomB.h
	elseif side == 3 then
		return roomA.x, roomA.y+roomA.h
	end
end

function Room:spawnRooms()
	local side = math.random(1,4)	
	if #self.rooms < 1 then
		local roomB = {w = math.random(2,7)*tileSize, h = math.random(2, 7)*tileSize}
		local x, y = self:chooseSide(self.base, roomB, side)
		roomB.x, roomB.y = x, y
		table.insert(self.rooms, roomB)
	else

	end
end

function Room:draw()
	love.graphics.rectangle('fill', self.base.x, self.base.y, self.base.w, self.base.h)
	for i, v in ipairs(self.rooms) do
		love.graphics.rectangle('line', v.x, v.y, v.w, v.h)
	end
end

function Room:reset()
	self.base = {}
	self.rooms = {}
	Room:initializeRootRoom()
	Room:spawnRooms()
end

function love.load()
	Room:initializeRootRoom()
	Room:spawnRooms()
end

function love.update(dt)

end

function love.draw()
	Room:draw()
end

function love.keypressed(key)
	if key == 'r' then
		Room:reset()
	end
	if key == 'escape' then
		love.event.quit()
	end
end