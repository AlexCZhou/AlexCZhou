require("typealpha.remap")
require("typealpha.set")
require("typealpha.lazy")

-- 属于每台机器自己的配置
-- 只在文件存在时才加载
if vim.fn.filereadable(vim.fn.expand("./local.lua")) == 1 then
    require("typealpha.local")
end

