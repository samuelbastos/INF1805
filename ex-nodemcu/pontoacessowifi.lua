-- Conexao na rede Wifi
wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ssid="samuel_nodemcu",pwd="12345678"})
wifi.ap.setip({ip="192.168.0.29",netmask="255.255.255.0",gateway="192.168.0.29"})
print(wifi.ap.getip())
