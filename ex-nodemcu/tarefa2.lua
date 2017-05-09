led = 3
but1 = 1
but2 = 2
flag = true
velocity = 1000

gpio.mode(led, gpio.OUTPUT)
gpio.mode(but1, gpio.INT)
gpio.mode(but2, gpio.INT)

local function liga()
    gpio.write(led, gpio.HIGH)
end

local function desliga()
    gpio.write(led, gpio.LOW)
end   

local timer = tmr.create()
timer:register(velocity, tmr.ALARM_AUTO, function () if flag then desliga() flag = false
                                                 else liga() flag = true end end)

local function ligaPisca() timer:start() end
local function desliga() timer:stop() end
local function mudaIntervalo(value) if value > 0 then timer:interval(value) timer:start() end end
  
ligaPisca()

gpio.trig(but1, "up", function () mudaIntervalo(2000) end)
gpio.trig(but2, "up", function () mudaIntervalo(0) end)

srv = net.createServer(net.TCP)

if srv then
  srv:listen(80,"192.168.0.29", function(conn)
      print("estabeleceu conexÃ£o")
      conn:on("receive", receiver)
    end)
end

addr, port = srv:getaddr()
print(addr, port)
print("servidor inicializado.")