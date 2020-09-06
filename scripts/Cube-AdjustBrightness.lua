--
-- LUA script to set the level of lights according to the clockwise feature of the Xiaomi Cube Controller
--
commandArray = {}

AdjustBrightness = 10   --Intensity level (%)
MaxBrightness = 100     --Max brightness (%)
-- Name of lights to manage
BulbArray = {'', ''}
-- Name of Xiaomi Cube Controller device
XiaomiCube = ''

CalcValue = 0

if (devicechanged[XiaomiCube] == 'anti_clock_wise') then
    if (otherdevices[BulbArray[1]] == 'Set Level') then
        GroupBrightness = otherdevices_svalues[BulbArray[1]];
    
        print ("Turning down the brightness of living room lights...");
        CalcValue = (GroupBrightness - AdjustBrightness)
        --Minimal value allowed for the intensity level
        if CalcValue <= AdjustBrightness then
            CalcValue = AdjustBrightness
        end
    end
elseif (devicechanged[XiaomiCube] == 'clock_wise') then
    if (otherdevices[BulbArray[1]] == 'Set Level') then
        GroupBrightness = otherdevices_svalues[BulbArray[1]];
        
        print ("Increasing the brightness of living room lights...");
        CalcValue = (GroupBrightness + AdjustBrightness)
        --Maximal value allowed for the intensity level
        if CalcValue >= MaxBrightness then
            CalcValue = MaxBrightness
        end
    end
end

if CalcValue ~= 0 then
    for i in pairs(BulbArray) do
        commandArray[BulbArray[i]] = 'Set Level '..CalcValue..''
    end
    print ("Brightness changed to " ..CalcValue.. "%");
end

return commandArray
