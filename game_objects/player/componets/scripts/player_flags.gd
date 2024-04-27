extends Componet

enum {
	MOVEMENT
	BOUNDS
}

export(Dictionary) var Flags = {
	MOVEMENT: true,
	BOUNDS: true
}

func getFlagState(flagId:int) -> bool:
	return Flags[flagId]

func setFlagState(flagId:int) -> bool:
	return Flags.get(flagId, false)
