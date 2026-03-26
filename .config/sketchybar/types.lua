---@meta

---@class SbarItem
---@field name string
---@field set fun(self: SbarItem, properties: table)
---@field subscribe fun(self: SbarItem, event: string|string[], callback: fun(env: table))
---@field query fun(self: SbarItem): table
---@field push fun(self: SbarItem, values: number[])

---@class Sbar
---@field bar fun(properties: table)
---@field default fun(properties: table)
---@field add fun(type: string, ...: any): SbarItem
---@field set fun(name: string, properties: table)
---@field exec fun(command: string, callback?: fun(result: string, exit_code?: integer))
---@field query fun(name: string): table
---@field trigger fun(event: string, env?: table)
---@field animate fun(curve: string, duration: number, callback: fun())
---@field delay fun(seconds: number, callback: fun())
---@field remove fun(name: string)
---@field begin_config fun()
---@field end_config fun()
---@field event_loop fun()
---@field set_bar_name fun(name: string)

---@type Sbar
sbar = sbar
