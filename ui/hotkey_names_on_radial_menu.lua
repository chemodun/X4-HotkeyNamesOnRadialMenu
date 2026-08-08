-- Hotkey Names on Radial Menu (hotkey_names_on_radial_menu)
-- Answers the substituted ui/core/lua/compass.xpl's name lookups, which it
-- cannot resolve itself: core scripts see none of the menus environment.
-- Compatible with X4 8.00 and 9.00.

local ffi = require("ffi")
local C   = ffi.C

ffi.cdef [[
  int GetConfigSetting(const char*const setting);
  void SetConfigSetting(const char*const setting, const bool value);
]]

local MOD_ID = "hotkey_names_on_radial_menu"

-- Must match the same three keys in ui/core/lua/compass.xpl's config table.
local NAME_PLACEHOLDER = "hnrm.name"
local DIRTY_SETTING    = "hnrmDirty"
local DEBUG_SETTING    = "hnrmDebug"

-- Mirrors the Native Hotkey API's single Debug Logging toggle.
local debugEnabled = false

local function debugLog(msg)
  if debugEnabled then
    DebugError("Hotkey Names on Radial Menu: " .. msg)
  end
end

-- GetLiveData is resolved by global name at call time, so wrapping it needs no
-- file substitution - but the captured original must still answer everything
-- that is not ours.
local ego_GetLiveData = GetLiveData
GetLiveData = function(placeholder, component, templateConnectionName)
  if placeholder == NAME_PLACEHOLDER then
    local numericId = tonumber(templateConnectionName)
    local name = numericId and HotkeyApi and HotkeyApi.GetActionNameByInputId and
        HotkeyApi.GetActionNameByInputId(numericId)
    debugLog("control " .. tostring(templateConnectionName) .. " -> '" .. tostring(name) .. "'")
    return name or ""
  end
  if ego_GetLiveData then
    return ego_GetLiveData(placeholder, component, templateConnectionName)
  end
end

-- compass.xpl clears the flag once it has dropped its cache, so read it back
-- instead of tracking our own copy: the burst of registrations on every load
-- then costs one write rather than one per registered action.
local function MarkDirty()
  if C.GetConfigSetting(DIRTY_SETTING) ~= 1 then
    C.SetConfigSetting(DIRTY_SETTING, true)
    debugLog("hotkey registry changed - radial menu name cache flagged stale")
  end
end

local function OnHotkeyApiChanged()
  debugEnabled = HotkeyApi.IsDebugEnabled() and true or false
  C.SetConfigSetting(DEBUG_SETTING, debugEnabled)
  MarkDirty()
end

-- Raised by the API on every Lua (re)load, so the listener is re-registered
-- after a reload and the cache is invalidated at least once per session.
local function OnRegisterRequest()
  if not (HotkeyApi and HotkeyApi.RegisterOnChanged) then
    DebugError("Hotkey Names on Radial Menu: Native Hotkey API 8.00.09 or later is required")
    return
  end
  HotkeyApi.RegisterOnChanged(MOD_ID, OnHotkeyApiChanged)
  OnHotkeyApiChanged()
end

RegisterEvent("HotkeyApi.Register_Request", OnRegisterRequest)
