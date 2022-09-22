local Candy = {
	Lolipop = 75/100,
	MintPop = 20/100,
	ChocolateBar = 5/100
}

for i = 1,20 do
	local Selection = nil
	local Weight = math.random()

	for CandyName , CandyWeight in pairs(Candy) do
		if Weight <= CandyWeight then
			Selection = CandyName
			break
		end
		Weight -= CandyWeight
	end

	print(Selection)
end