Object = require 'libraries/classic/classic'

function love.load()
  local objectFiles = {}
  requireFiles('objects', objectFiles)
  instantiateFiles(objectFiles)

  -- circle = Circle(400, 300, 50)
  hypercircle = Hypercircle(400, 300, 50, 10, 120)
end

function love.update(dt)
  -- circle:update(dt)
  hypercircle:update(dt)
end

function love.draw()
  -- circle:draw()
  hypercircle:draw()
end

function love.run()
  if love.math then love.math.setRandomSeed(os.time()) end

  if love.load then love.load(arg) end

  if love.timer then love.timer.step() end

  local dt = 0

  -- main loop 
  while true do 
    -- process events
    if love.event then 
      -- push events to the queue on every frame
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then return end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- update dt
    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end

    if love.update then love.update(dt) end

    if love.graphics and love.graphics.isActive() then 
      love.graphics.clear(love.graphics.getBackgroundColor())
      love.graphics.origin()
      if love.draw then love.draw() end
      love.graphics.present()
    end

    if love.timer then love.timer.sleep(0.001) end
  end
end

function requireFiles(folder, fileList) 
  local files = love.filesystem.getDirectoryItems(folder)
  for _, file in ipairs(files) do
    local filepath = folder .. '/' .. file
    if love.filesystem.isFile(filepath) 
      then table.insert(fileList, filepath)
    else 
      recursiveRequire(filepath, fileList)
    end
  end
end

function instantiateFiles(fileList) 
  for _, file in ipairs(fileList) do 
    require(file:sub(1, -5))
  end
end
