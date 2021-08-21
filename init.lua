--------------------------------------------
-- 在Menu列顯示WiFi名稱
-- 點選WiFi名稱可固定使用此WiFi，如果不是，會自動切斷
--------------------------------------------
wifiWatcher = nil
fixedWifiName = ""
function ssidChanged()
  local wifiName = hs.wifi.currentNetwork()
  if wifiName then
    wifiMenu:setTitle(wifiName)
    hs.alert.show("Wifi: " .. wifiName)
    -- fixed wifi check
    if fixedWifiName ~= "" then
      if wifiName == fixedWifiName then
        wifiMenu:setTitle("[" .. wifiName .. "]")
      else
        hs.alert.show("Wrong Wifi: " .. wifiName .. "\n(Give me " .. fixedWifiName .. ")", 60)
        hs.wifi.disassociate() -- disconnect wifi
      end
    end
  else
    wifiMenu:setTitle("Wifi OFF")
    hs.alert.show("Wifi Off")
  end
end

function setFiexedWifi()
  hs.alert.closeAll() -- force close all alerts
  local wifiName = hs.wifi.currentNetwork()
  if fixedWifiName ~= "" then
    fixedWifiName = ""
    hs.alert.show("Disable Fixed Wifi")
    wifiMenu:setTitle(wifiName)
  else
    fixedWifiName = wifiName
    hs.alert.show("Fixed Wifi: " .. wifiName)
    wifiMenu:setTitle("[" .. wifiName .. "]")
  end
end

wifiMenu = hs.menubar.newWithPriority(1) -- 2147483645
wifiMenu:setClickCallback(setFiexedWifi)
ssidChanged()

wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()


--------------------------------------------
-- arphen: test
--------------------------------------------
function menuClicked()
  hs.alert.show("clicked!")
  hs.wifi.disassociate() -- disconnect wifi
end
-- Ascii To Icon - http://xqt2.com/asciiIcons.html
numberIcons = {
[[ASCII:
....3.............
.........7........
..................
...A3..A..........
5..5...........b..
.....B...7....B...
..................
...A...A..........
...........b.9....
.8...8............
..................
........c.........
.................9
........a.........
.....B........B...
....c.............
..................
............a.....
]]
}

-- alpha = 0(空心), 1(填滿)
myMenu = hs.menubar.new():setIcon(hs.image.imageFromASCII(numberIcons[1], {
  { shouldClose = false },
  { fillColor = { alpha = 1 }},
}))

-- myMenu = hs.menubar.newWithPriority(2)
-- myMenu:setTitle("myMenu")
-- myMenu:setIcon(hs.image.imageFromPath("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/SidebarSmartFolder.icns"):setSize({h=16, w=16}))
myMenu:setClickCallback(menuClicked)

