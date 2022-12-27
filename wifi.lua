
ssid = "Saunaclub Augustastrasse"
password = "Hoeckerschwankueken"

station_cfg = {}
station_cfg.ssid = ssid
station_cfg.pwd = password
station_cfg.save = false

wifi.setmode(wifi.STATION)
wifi.sta.config(station_cfg)



------------------------------------------------
--- CONNECTING TO WIFI -------------------------
------------------------------------------------

local tObj = tmr.create()
print("connecting to wifi...")

tObj:alarm(1000, tmr.ALARM_AUTO, function ()
    if wifi.sta.status() == 5 then
        print("Connected to network with IP: " .. wifi.sta.getip())
        setupServer()

        tObj:stop(0)
        tObj:unregister()
    elseif wifi.sta.status() == 3 then
        print("AP not found: " .. ssid)
        
        tObj:stop(0)
        tObj:unregister()
    end
end)




------------------------------------------------
--- RECEIVING DATA -----------------------------
------------------------------------------------

function receiver(socket, request)
    matched = string.match(request, "GET \/.+HTTP")

    if string.find(matched, "led_on") then
        handleLEDon(matched, socket)
        sendResponse("{ status: 'ok' }", socket)
    elseif string.find(matched, "led_off") then 
        handleLEDoff(matched, socket)
        sendResponse("{ status: 'ok' }", socket)
    end
end


function handleLEDon(path, socket)    
    number = path:sub(13, -5)
    print("Setting LED "..number.." on")    
    gpio.mode(number, gpio.OUTPUT)
    gpio.write(number, gpio.HIGH)
end


function handleLEDoff(path, socket)
    number = path:sub(14, -5)

    print("Setting LED "..number.." off")    
    gpio.mode(number, gpio.OUTPUT)
    gpio.write(number, gpio.LOW)
end


function sendResponse(message, socket)
    response = "HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nContent-Type: application/json\r\n\r\n"
    response = response..message
    
    socket:send(response)
    socket:on("sent", function(local_socket) 
        socket:close()
    end)
end



------------------------------------------------
--- SETTING UP THE SERVER ----------------------
------------------------------------------------

function setupServer()
    server = net.createServer(net.TCP, 30)

    if server then
        server:listen(80, function(conn)
            conn:on("receive", receiver)
        end)
    end
end



