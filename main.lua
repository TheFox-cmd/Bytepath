function love.load()
  image = love.graphics.newImage("/assets/image.png")
  love.window.setMode(800, 600, {resizable = true, vsync = true})
  love.window.setTitle("BytePath")
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(image, 0, 0)
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