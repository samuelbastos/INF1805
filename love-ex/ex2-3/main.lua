function love.load()
  x = 50 y = 200
  w = 200 h = 150
end

function naimagem (mx, my, x, y) 
  return (mx>x) and (mx<x+w) and (my>y) and (my<y+h)
end

function love.keypressed(key)
  local mx, my = love.mouse.getPosition() 
  if key == 'b' and naimagem (mx,my, x, y) then
     y = 200
     x = 50
  end
  if key == "down" and naimagem (mx, my, x, y) then
    y = y + 10
  end
  if key == "right" and naimagem (mx, my, x, y) then 
    x = x + 10
  end
end

function love.update (dt)
end

function love.draw ()
  love.graphics.rectangle("line", x, y, w, h)
end