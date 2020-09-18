Citizen.CreateThread(function()
	local particlesList = {
		{name = "scr_firework_xmas_ring_burst_rgw", asset = "proj_xmas_firework"},
		{name = "scr_firework_xmas_burst_rgw", asset = "proj_xmas_firework"},
		{name = "scr_firework_xmas_repeat_burst_rgw", asset = "proj_xmas_firework"},
		{name = "scr_firework_xmas_spiral_burst_rgw", asset = "proj_xmas_firework"},
		{name = "scr_firework_indep_burst_rwb", asset = "proj_indep_firework_v2"},
		{name = "scr_firework_indep_spiral_burst_rwb", asset = "proj_indep_firework_v2"},
		{name = "scr_firework_indep_ring_burst_rwb", asset = "proj_indep_firework_v2"},
		{name = "scr_xmas_firework_burst_fizzle", asset = "proj_indep_firework_v2"},
		{name = "scr_firework_indep_repeat_burst_rwb", asset = "proj_indep_firework_v2"},
		{name = "scr_indep_firework_grd_burst", asset = "proj_indep_firework"},
		{name = "scr_indep_firework_air_burst", asset = "proj_indep_firework"},
		{name = "proj_indep_flare_trail", asset = "proj_indep_firework"}
	}

	local particlesCoords = {
		vector3(54.62, -1109.0, 0.0),
		vector3(54.62, -1109.0, 0.0),
		vector3(54.62, -1109.0, 0.0),
		vector3(54.62, -1109.0, 0.0),
		vector3(54.62, -1109.0, 0.0),
		vector3(54.62, -1109.0, 0.0),
		vector3(54.62, -1109.0, 0.0)
	}

	for i = 1, #particlesList, 1 do
		if not HasNamedPtfxAssetLoaded(particlesList[i].asset) then
			RequestNamedPtfxAsset(particlesList[i].asset)

			while not HasNamedPtfxAssetLoaded(particlesList[i].asset) do
				Citizen.Wait(10)
			end
		end
	end

	while true do
		math.random(GetGameTimer())
		Citizen.Wait(math.random(1, 5) * 200)

		for i = 1, math.random(1, 5), 1 do
			local particleUsed = particlesList[math.random(1, #particlesList)]
			local coords = particlesCoords[math.random(1, #particlesCoords)]

			UseParticleFxAssetNextCall(particleUsed.asset)
			local particleHandle = StartParticleFxNonLoopedAtCoord(particleUsed.name, (coords.x + math.random(10, 100)) + .0, (coords.y + math.random(10, 100)) + .0, (coords.z + math.random(100, 250)) + .0, 0.0, 0.0, 0.0, (math.random(1, 5)) + .0, 0.0, 0.0, 0.0)
			SetParticleFxLoopedFarClipDist(particleHandle, 500.0)
		end
	end
end)