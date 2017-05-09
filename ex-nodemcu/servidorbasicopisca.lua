led1 = 3
led2 = 6
sw1 = 1
sw2 = 2

 function LED (number)
  local n = number
  local flag = true
  gpio.mode(n, gpio.OUTPUT)

  local function liga  ()
      gpio.write(n, gpio.HIGH)
  end

  local function desliga ()
      gpio.write(n, gpio.LOW)
  end   

  local timer = tmr.create()
     timer:register(1000, tmr.ALARM_AUTO, function ()
     if flag then
    desliga()
    flag = false
     else 
    liga()
    flag = true
     end
  end)

  return {
    ligaPisca = function () timer:start() end,
    desligaPisca = function () timer:stop() end,
    recebeEstado = function () return gpio.read(n) end
  }  

end

local firstLED = LED(led1)
local secondLED = LED(led2)

gpio.mode(sw1, gpio.INPUT)
gpio.mode(sw2, gpio.INPUT)

gpio.write(led1, gpio.LOW);
gpio.write(led2, gpio.LOW);

local led={}
led[0]="OFF"
led[1]="ON_"

local sw={}
sw[1]="OFF"
sw[0]="ON_"

local lasttemp = 0

local function readtemp()
  lasttemp = adc.read(0)*(3.3/10.24)
end

local actions = {
  LERTEMP = readtemp,
  LIGA1 = firstLED.ligaPisca,
  DESLIGA1 = firstLED.desligaPisca,
  LIGA2 = secondLED.ligaPisca,
  DESLIGA2 = secondLED.desligaPisca,
}

srv = net.createServer(net.TCP)

function receiver(sck, request)

  -- analisa pedido para encontrar valores enviados
  local _, _, method, path, vars = string.find(request, "([A-Z]+) ([^?]+)%?([^ ]+) HTTP");
  -- se nÃ£o conseguiu casar, tenta sem variÃ¡veis
  if(method == nil)then
    _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
  end
  
  local _GET = {}
  
  if (vars ~= nil)then
    for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
      _GET[k] = v
    end
  end


  local action = actions[_GET.pin]
  if action then action() end

  local vals = {
    --TEMP = string.format("%2.1f",adc.read(0)*(3.3/10.24)),
    TEMP =  string.format("%2.1f", lasttemp),
    CHV1 = gpio.LOW,
    CHV2 = gpio.LOW,
    LED1 = led[firstLED.recebeEstado()],
    LED2 = led[secondLED.recebeEstado()],
  }

  local buf = [[
<h1><u>PUC Rio - Sistemas Reativos</u></h1>
<h2><i>ESP8266 Web Server</i></h2>
        <p>Temperatura: $TEMP oC <a href="?pin=LERTEMP"><button><b>REFRESH</b></button></a>
        <p>LED 1: $LED1  :  <a href="?pin=LIGA1"><button><b>ON</b></button></a>
                            <a href="?pin=DESLIGA1"><button><b>OFF</b></button></a></p>
        <p>LED 2: $LED2  :  <a href="?pin=LIGA2"><button><b>ON</b></button></a>
                            <a href="?pin=DESLIGA2"><button><b>OFF</b></button></a></p>
]]

  buf = string.gsub(buf, "$(%w+)", vals)
  sck:send(buf, function() print("respondeu") sck:close() end)
end

if srv then
  srv:listen(80,"192.168.0.29", function(conn)
      print("estabeleceu conexÃ£o")
      conn:on("receive", receiver)
    end)
end

addr, port = srv:getaddr()
print(addr, port)
print("servidor inicializado.")