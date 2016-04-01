do
 
function pairsByKeys(t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
    end
 
-- Returns true if is not empty
local function has_usage_data(dict)
  if (dict.usage == nil or dict.usage == '') then
    return false
  end
  return true
end
 
-- Get commands for that plugin
local function plugin_help(name,number,requester)
  local plugin = ""
  if number then
    local i = 0
    for name in pairsByKeys(plugins) do
      if plugins[name].hidden then
        name = nil
      else
        i = i + 1
        if i == tonumber(number) then
          plugin = plugins[name]
        end
      end
    end
  else
    plugin = plugins[name]
    if not plugin then return nil end
  end
 
    local text = ""
    if (type(plugin.usage) == "table") then
      for ku,usage in pairs(plugin.usage) do
          if ku == 'user' then -- usage for user
              if (type(plugin.usage.user) == "table") then
                  for k,v in pairs(plugin.usage.user) do
                      text = text..v..'\n'
                  end
              elseif has_usage_data(plugin) then -- Is not empty
                  text = text..plugin.usage.user..'\n'
              end
          elseif ku == 'moderator' then -- usage for moderator
              if requester == 'moderator' or requester == 'admin' or requester == 'sudo' then
                  if (type(plugin.usage.moderator) == "table") then
                      for k,v in pairs(plugin.usage.moderator) do
                          text = text..v..'\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.moderator..'\n'
                  end
              end
          elseif ku == 'admin' then -- usage for admin
              if requester == 'admin' or requester == 'sudo' then
                  if (type(plugin.usage.admin) == "table") then
                      for k,v in pairs(plugin.usage.admin) do
                          text = text..v..'\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.admin..'\n'
                  end
              end
          elseif ku == 'sudo' then -- usage for sudo
              if requester == 'sudo' then
                  if (type(plugin.usage.sudo) == "table") then
                      for k,v in pairs(plugin.usage.sudo) do
                          text = text..v..'\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.sudo..'\n'
                  end
              end
          else
              text = text..usage..'\n'
          end
      end
      text = text..'\n------------------------\n'
    elseif has_usage_data(plugin) then -- Is not empty
      text = text..plugin.usage..'\n-------------------------\n'
    end
    return text
end
 
 
-- !help command
local function telegram_help()
  local i = 0
  local text = "Plugins list:\n\n"
  -- Plugins names
  for name in pairsByKeys(plugins) do
    if plugins[name].hidden then
      name = nil
    else
    i = i + 1
    text = text..i..'> '..name..'\n'
    end
  end
  text = text..'\n'..'__________________________________\n#CopierTeam'
  return text
end
 
 
-- !help all command
local function help_all(requester)
  local ret = ""
  for name in pairsByKeys(plugins) do
    if plugins[name].hidden then
      name = nil
    else
      ret = ret .. plugin_help(name, nil, requester)
    end
  end
  return ret
end
 
local function run(msg, matches)
  if is_sudo(msg) then
      requester = "sudo"
  elseif is_admin(msg) then
      requester = "admin"
  elseif is_momod(msg) then
      requester = "moderator"
  else
      requester = "user"
  end
  if matches[1] == "helps" then
    return telegram_help()
  elseif matches[1] == "help all" then
    return help_all(requester)
  else
    local text = ""
    if tonumber(matches[1])  then
      text = plugin_help(nil, matches[1], requester)
    else
      text = plugin_help(matches[1], nil, requester)
    end
    if not text then
      text = telegram_help()
    end
    return text
  end
end
 
return {
  description = "Help plugin. Get info from other plugins.  ",
  usage = {
    "helps: Show list of plugins.",
    "help all: Show all commands for every plugin.",
    "helps [plugin name]: Commands for that plugin.",
    "helps [number]: Commands for that plugin. Type !help to get the plugin number."
  },
  patterns = {
    "^([Hh]elps)$",
    "^help all",
    "^[Hh]elps (.+)"
  },
  run = run
}
 
end
