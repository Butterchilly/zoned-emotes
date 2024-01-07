Config = {}

Config.USE_Notify = false -- \\ If You Want Notify then do it Config.USE_Notify = true

-- \\ Which Notify You Use // -- 
Config.Notify = 'ox' -- 'qb' or 'ox' -- \\ Only IF Config.USE_Notify = true
-- \\ Which Emote You Use // --
Config.Emotes = 'scully_emotemenu' -- \\ 'rpemotes' or 'scully_emotemenu'
Config.emoteName = "dancethriller" --- U can change ur emote here also or with /setemote command
Config.emoteDuration = 1000
Config.exportName = "rpemotes" -- You have to change to name here according to the name of your emote script name. and change dependecy also in fxmanifest.lua


Config.zones = {
    {center = vector3(197.29, 383.97, 107.84), radius = 5.0},
    {center = vector3(215.00, 365.00, 105.00), radius = 5.0},
    -- Add more zones here
}
