local TestObject = workspace.TestObject
local HttpService : HttpService = game:GetService("HttpService")

function Scan(Object : Instance)
	local ObjectTable = {}
	for i,v in pairs(Object:GetChildren()) do
		if #v:GetChildren() > 0 then
			ObjectTable[v.Name] = Scan(v)
		else
			ObjectTable[v.Name] = v.ClassName
		end
	end
	return ObjectTable
end

local Ref = [[
$Types

export type $Class = {
$a
}
]]

local Classes = ""
local Types,Length = Scan(TestObject)
local Ref2 = ""
local Num = 0

for i,v in pairs(Scan(TestObject)) do
	Num+=1
	if Num < #TestObject:GetChildren() then
		Classes =  Classes.. "export type "..i.."="..HttpService:JSONEncode(v):gsub('"',"").."\n"
		Ref2 = Ref2.."\t"..i..":" .. i..','.."\n"
	elseif  Num == #TestObject:GetChildren() then
		Classes =  Classes.. "export type "..i.."="..HttpService:JSONEncode(v):gsub('"',"")
		Ref2 = Ref2.."\t"..i..":" .. i
	end
end

local S : ModuleScript = Instance.new("ModuleScript")
S.Name = TestObject.Name.."Type"
S.Source = Ref:gsub("$Types",Classes):gsub("$Class",TestObject.Name):gsub("$a",Ref2)
S.Parent = workspace

--print(Ref:gsub("$Class",TestObject.Name):gsub("$a",Ref2))

--print(Ref:gsub("$a",Ref2))