--
-- LUA script to send an email when the main door is opened
-- during business hours
--
commandArray = {}

-- Name of the door sensor
DoorSensor = ''
-- Name of the alarm bell device
AlarmBell = ''
-- Name of the alarm volume device
AlarmVolume = ''
-- Pattern of sensors name (ex: 'Sensor - ')
SensorPatternName = ''
-- Name of the alarm switch device
-- I have a Xiaomi switch device to enable or disable the home alarm
AlarmSwitch = ''
-- Email for sending notification
Email = "x.x@x.com"
-- Business hours
MinimumHour = 9
MaximumHour = 17
bFound = 0

if ((otherdevices[AlarmSwitch] == 'On') or (tonumber(os.date('%H')) >= MinimumHour and tonumber(os.date('%H')) <= MaximumHour)) then
    if (devicechanged[DoorSensor] == 'Open') then
        for deviceName,deviceValue in pairs(otherdevices) do
            if string.match(deviceName, SensorPatternName) then
                if deviceValue == "Open" then
                    bFound = 1
                end
            end
        end
        if (bFound == 1) then
            commandArray['SendEmail']='Porte ET fenêtres ouvertes !#La porte d\'entrée et des fenêtres sont ouvertes !#' .. Email
            print ("Main door AND windows opened!");
            commandArray[AlarmVolume] = 'Set Level 10%'
            commandArray[1]={[AlarmBell]='Set Level 10'}
            commandArray[2]={[AlarmBell]='Off AFTER 4'}
        else
            commandArray['SendEmail']='Porte ouverte !#La porte d\'entrée est ouverte !#' .. Email
            print ("Main door opened!");
        end
    else
        print ("Main door closed");
    end
end 

return commandArray
