local SamyLibWeaponEnchant = LibStub('AceAddon-3.0'):NewAddon('SamyLibWeaponEnchant', 'AceEvent-3.0', 'AceComm-3.0', 'AceTimer-3.0')

local _aceSerialize = LibStub('AceSerializer-3.0')
local _libCompress = LibStub("LibCompress")
local _encodingTable = _libCompress:GetAddonEncodeTable()

function SamyLibWeaponEnchant:OnEnable()
    self:RegisterEvent('GROUP_ROSTER_UPDATE', GroupRoosterUpdated)
end

function SamyLibWeaponEnchant:GroupRoosterUpdated(a, b, c, d)
    print('GroupRoosterUpdated', a, b, c d)
end

function SamyLibWeaponEnchant:OnCommReceived(prefix, message, type, sender)
    local myName, myRealm = UnitName('player')
    if (sender == myName) then
        return
    end

    local decoded = _encodingTable:Decode(message)
    local uncompressed, message = _libCompress:Decompress(decoded)
    if (not uncompressed) then
        print('Problem decompressing: ' .. message) --TODO Should prob not spam print
        return
    end

    local isSuccess, weaponEnchantData = AceSerialize:Deserialize(uncompressed)
    if (not isSuccess) then
        print('error parsing ' .. message .. ' error: ' .. weaponEnchantData) --TODO Should prob not spam print
        return
    end


end