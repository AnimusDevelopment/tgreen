proc/HasAbove(var/z)
	return (z-1 in multiz_levels) ? 1 : 0

proc/HasBelow(var/z)
	return (z+1 in multiz_levels) ? 1 : 0

// Thankfully, no bitwise magic is needed here.
proc/GetAbove(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	return HasAbove(turf.z) ? get_step(turf, UP) : null

proc/GetBelow(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	return HasBelow(turf.z) ? get_step(turf, DOWN) : null
