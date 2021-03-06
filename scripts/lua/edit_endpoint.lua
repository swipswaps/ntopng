--
-- (C) 2019-20 - ntop.org
--

local dirs = ntop.getDirs()
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path

require "lua_utils"
local json = require("dkjson")
local notification_configs = require("notification_configs")

local action = _POST["action"]

sendHTTPContentTypeHeader('application/json')

if (not haveAdminPrivileges(true)) then
    return
end

local endpoint_conf_name = _POST["endpoint_conf_name"]
local response = {}

if (action == "add") then
    local endpoint_conf_type = _POST["endpoint_conf_type"]
    response.result = notification_configs.add_config(endpoint_conf_type, endpoint_conf_name, _POST)
elseif (action == "edit") then
    response.result = notification_configs.edit_config(endpoint_conf_name, _POST)
elseif (action == "remove") then
    response.result = notification_configs.delete_config(endpoint_conf_name)
end

print(json.encode(response))
