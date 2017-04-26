function setglobals()
  time = 0  
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
end

function wait (seconds, blip)
  blip.blipTimer = seconds + time
  coroutine.yield()
end

function checkCollission(ball)
  if ball.getBallXCoord() <= playerOne.getPlayerXCoord()+10 and ball.getBallYCoord() >= playerOne.getPlayerYCoord() and ball.getBallYCoord() <= playerOne.getPlayerYCoord()+60 then
    ball.difficulty = ball.difficulty*1.02
    ball.xRandom = -ball.xRandom*ball.difficulty
  elseif ball.getBallXCoord() >= playerTwo.getPlayerXCoord()-10 and ball.getBallYCoord() >= playerTwo.getPlayerYCoord() and ball.getBallYCoord() <= playerTwo.getPlayerYCoord()+60 then
    ball.difficulty = ball.difficulty*1.02
    ball.xRandom = -ball.xRandom*ball.difficulty    
  elseif ball.getBallYCoord() <= 0  or ball.getBallYCoord() >= height-10 then
    ball.yRandom = -ball.yRandom
  elseif ball.getBallXCoord() > width then
    playerOne.setScore (playerOne.getScore() + 1)
    ball.difficulty = 1
    ball.setBallXCoord(width/2)
    ball.setBallYCoord(height/2)
    ball.xRandom = 0
    while ball.xRandom == 0 do
      ball.xRandom = 6*love.math.random(-1,1)
    end
    ball.yRandom = love.math.random(-10,10)
  elseif ball.getBallXCoord() < 0 then
    playerTwo.setScore (playerTwo.getScore() + 1)
    ball.difficulty = 1
    ball.setBallXCoord(width/2)
    ball.setBallYCoord(height/2)
    ball.xRandom = 0
    while ball.xRandom == 0 do
      ball.xRandom = 6*love.math.random(-1,1)
    end
    ball.yRandom = love.math.random(-10,10)
  end
end

function newblip (seconds)
  local x, y, sec = love.graphics.getWidth()/2, love.graphics.getHeight()/2, seconds;
  return {
    blipTimer = 0,
    difficulty = 1,
    xRandom = 0,
    yRandom = love.math.random(-10,10),

    getBallXCoord = function ()
      return x
    end,
    getBallYCoord = function ()
      return y
    end,
    setBallXCoord = function  (xcoord)
      x = xcoord
    end,
    setBallYCoord = function (ycoord)
      y = ycoord
    end,
    update = coroutine.wrap ( function (self)
      while self.xRandom == 0 do
        self.xRandom = 6*love.math.random(-1,1)
      end
      while true do

        x = x + self.xRandom
        y = y + self.yRandom

        checkCollission(self)

        wait(sec/100,self)
      end
    end) ,
    draw = function ()
      love.graphics.rectangle("fill", x, y, 10, 10)
    end
  }
end

function newplayer (playerNumber)
  
  local number = playerNumber
  local x, y
  local score = 0

  if number == 1 then
    x = 0
    y = height/2
  else
    x = width-10
    y = height/2
  end

  return {

  getPlayerXCoord = function ()
    return x
  end,

  getPlayerYCoord = function ()
    return y
  end,

  getScore = function ()
    return score
   end,

  setScore = function(newScore)
    score = newScore
  end,

  keypressed = function (key)
    if number == 1 then
      if key == 's' and y < height -60 then
          y = y + 15
      end
      if key == 'w' and y > 0 then
        y = y - 15
      end
    else
      if key == 'down' and y < height - 60 then
        y = y + 15
      end
      if key == 'up' and y > 0 then
        y = y - 15
      end
    end
  end,

  draw = function ()
      love.graphics.rectangle("fill", x, y, 10, 60)
  end
  }
end


function love.keypressed(key)
  playerOne.keypressed(key)
  playerTwo.keypressed(key)
end

function love.load()
  setglobals()
  playerOne =  newplayer(1)
  playerTwo =  newplayer(2)
  ball = newblip(5)
  love.keyboard.setKeyRepeat( true )
end

function drawScore()
  oneScore = tostring(playerOne.getScore())
  twoScore = tostring(playerTwo.getScore())
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