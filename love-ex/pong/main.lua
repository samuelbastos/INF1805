function setglobals()
  time = 0  
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  playerOneCoordX = 0
  playerOneCoordY = height/2
  playerTwoCoordX = width-10
  playerTwoCoordY = height/2
  playerOneScoreValue = 0
  playerTwoScoreValue = 0
end

function wait (seconds, blip)
  blip.blipTimer = seconds + time
  coroutine.yield()
end

function newblip (seconds)
  local x, y, sec = love.graphics.getWidth()/2, love.graphics.getHeight()/2, seconds;
  return {
    blipTimer = 0,
    update = coroutine.wrap ( function (self)
      difficulty = 1
      xRandom = 0
      while xRandom == 0 do
        xRandom = 6*love.math.random(-1,1)
      end
      yRandom = love.math.random(-10,10)
      while true do

        x = x + xRandom
        y = y + yRandom

        if x <= playerOneCoordX+10 and y >= playerOneCoordY and y <= playerOneCoordY+60 then
          difficulty = difficulty*1.02
          xRandom = -xRandom*difficulty
        end
        if x >= playerTwoCoordX-10 and y >= playerTwoCoordY and y <= playerTwoCoordY+60 then
          difficulty = difficulty*1.02
          xRandom = -xRandom*difficulty    
        end
        if y <= 0  or y >= height-10 then
          yRandom = -yRandom
        end
        if x > width then
          playerOneScoreValue = playerOneScoreValue + 1
          x = love.graphics.getWidth()/2
          y = love.graphics.getHeight()/2
          xRandom = 0
          while xRandom == 0 do
            xRandom = 6*love.math.random(-1,1)
          end
          yRandom = love.math.random(5,10)
        end
        if x < 0 then
          playerTwoScoreValue = playerTwoScoreValue + 1
          x = love.graphics.getWidth()/2
          y = love.graphics.getHeight()/2
          xRandom = 0
          while xRandom == 0 do
            xRandom = 6*love.math.random(-1,1)
          end
          yRandom = love.math.random(5,10)
        end

        wait(sec/100,self)
      end
    end) ,
    draw = function ()
      love.graphics.rectangle("fill", x, y, 10, 10)
    end
  }
end

function newplayer (player)
  local x, y = 0, 200
  local number = player

  return {
  keypressed = function (key)
    if number == 1 then
      if key == 's' and playerOneCoordY < height -60 then
          playerOneCoordY = playerOneCoordY + 15
      end
      if key == 'w' and playerOneCoordY > 0 then
        playerOneCoordY = playerOneCoordY - 15
      end
    else
      if key == 'down' and playerTwoCoordY < height - 60 then
        playerTwoCoordY = playerTwoCoordY + 15
      end
      if key == 'up' and playerTwoCoordY > 0 then
        playerTwoCoordY = playerTwoCoordY - 15
      end
    end
  end,

  draw = function ()
    if number == 1 then
      love.graphics.rectangle("fill", playerOneCoordX, playerOneCoordY, 10, 60)
    else
      love.graphics.rectangle("fill", playerTwoCoordX, playerTwoCoordY, 10, 60)
    end
  end
  }
end

function love.keypressed(key)
  playerOne.keypressed(key)
  playerTwo.keypressed(key)
end

function love.load()
  setglobals()
  love.keyboard.setKeyRepeat( true )
  playerOne =  newplayer(1)
  playerTwo =  newplayer(2)
  ball = newblip(5)
end

function drawScore()
  oneScore = tostring(playerOneScoreValue)
  twoScore = tostring(playerTwoScoreValue)
  love.graphics.printf(oneScore, width/2 - 40, 40, 40, "center")
  love.graphics.printf(twoScore, width/2 + 20, 40, 40, "center")
end

function love.draw()
  playerOne.draw()
  playerTwo.draw()
  ball.draw()
  drawScore()
end

function love.update(dt)
  time = time + dt
  
  if ball.blipTimer == 0 then
     ball:update()
  end
  if ball.blipTimer < time then
     ball.blipTimer = 0
  end
end