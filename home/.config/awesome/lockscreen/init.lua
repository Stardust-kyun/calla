--[[ L O C K S C R E E N ]]

local gfs = require("gears.filesystem")

local lock_screen = {}

local config_dir = gfs.get_configuration_dir()
package.cpath = package.cpath .. ";" .. config_dir .. "layouts/lockscreen/?.so;"

lock_screen.init = function()
  local pam = require("liblua_pam")
  lock_screen.authenticate = function(password)
    return pam.auth_current_user(password)
  end
  require("layouts.lockscreen.lock")
end

return lock_screen
