extends Componet

enum {
	MOVEMENT
	BOUNDS
}

export(Dictionary) var Flags = {
	MOVEMENT: true,
	BOUNDS: true
}

func getFlagState(flagId:int) -> int:
	return Flags.get(flagId, ERR_DOES_NOT_EXIST)

func setFlagState(flagId:int, state:bool) -> int:
	if Flags.has(flagId):
		Flags[flagId] = state
		return OK
	return ERR_DOES_NOT_EXIST
