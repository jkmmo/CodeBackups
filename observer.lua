local Observer = {}
local Https = game:GetService("HttpService")

function Observer.new(MyTable,Callback)
    local St = {}
    local Mt = {}
    local Constructing = true
    local Var = false
    setmetatable(St,{
        __index = function(self,key)
            return Mt[key]
        end,
            
        __newindex = function(self,Key,Value)
            if not Constructing then
                Callback(Key,Value)
            end
            Mt[Key] = Value
        end,
        __tostring = function(self)
            if Var == true then
                return tostring(Mt.Value)
            else
                local s : string = Https:JSONEncode(Mt):gsub(",","\n"):gsub("{","\n{\n"):gsub("}","\n}")
                return s
            end
        end
    })
    
    if type(MyTable) == "table" then
        for i,v in pairs(MyTable) do
            St[i] = v
        end
    else
        St.Value = MyTable
        Var = true
    end
    
    Constructing = false
    return St
end

return Observer