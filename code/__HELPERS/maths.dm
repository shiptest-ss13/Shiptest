/proc/invert_hex(hex)
	var/length = length(hex)

	var/num = hex2num(hex)

	return num2hex((16 ** length) - 1 - num, length)

/proc/cubic_random(min, max)
	// Ensure we're in a valid range
	if(max <= min)
		return min

	var/span = max - min

	// Center-biased cubic curve: closer to average
	var/curve = ((rand() - 0.5) ** 3) * 4 + 0.5
	curve = clamp(curve, 0, 1)

	var/result = min + round(curve * span)

	return result
