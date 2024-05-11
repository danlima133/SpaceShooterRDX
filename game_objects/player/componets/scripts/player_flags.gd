extends Componet

export(Dictionary) var Flags = {
	"movement": true,
	"bounds": true,
	"shoot": true
}

func getFlagState(flagId:String) -> bool:
	return Flags[flagId]

func setFlagState(flagId:String) -> bool:
	return Flags.get(flagId, false)
