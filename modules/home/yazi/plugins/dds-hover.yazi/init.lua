--- ~/.config/yazi/plugins/dds-hover.yazi/init.lua
local M = {}
function M:setup()
    ps.sub_remote("dds-hover", function(url)
        ya.manager_emit("hover", { url })
    end)
end

return M
