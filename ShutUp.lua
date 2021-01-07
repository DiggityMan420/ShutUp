local PREFIX = "|cff33ff99"..(...).."|r:"
local LOCALE = GetLocale()
local C_TimerAfter, GetSpellInfo, SetCVar, SlashCmdList, UIErrorsFrame, print = C_Timer.After, GetSpellInfo, SetCVar, SlashCmdList, UIErrorsFrame, print
local needTimer = true
local cmd0, cmd1, cmdNext

cmd0 = function()
  SetCVar("Sound_EnableErrorSpeech", 0)
  UIErrorsFrame:Clear()
  cmdNext = cmd1
end

cmd1 = function()
  SetCVar("Sound_EnableErrorSpeech", 1)
  UIErrorsFrame:Clear()
  cmdNext = cmd0
end

cmdNext = cmd0

local function printHelp()
  if LOCALE == "enUS" then
    print(PREFIX, "Use /su in macros to temporarily stop error messages.")
  end
end

local function timerDone()
  needTimer = true
  if cmdNext ~= cmd0 then
    cmd1()
  end
end

SLASH_1 = "/su"
SlashCmdList["SU"] = function(args)
  if args and args ~= "" then
    printHelp()
    return
  end
  cmdNext()
  if needTimer then
    needTimer = false
    C_TimerAfter(0, timerDone)
  end
end
