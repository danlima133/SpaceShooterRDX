#---------> Script with template - GoCM <---------

#@Snake Case@

# - Something PUBLIC: ref
# - Something PRIVATE: _ref

# - Method Virtual: _ref

# - Members Functionals: _ref_

# @Camel Case@

# - Class: RefFer

extends Componet
class_name LevelData # <--- Custom Class

# --------- ClassS ---------:

class Refs:
	enum Scope {
		STARS
		PLAYER
	}
	
	enum Token {
		NONE
		BRONZE
		SILVIER
		GOLD
		SCORE
	}
	
	const scopes = {
		Scope.STARS: "stars",
		Scope.PLAYER: "player"
	}

	const tokens = {
		Token.BRONZE: "bronze",
		Token.SILVIER: "silvier",
		Token.GOLD: "gold",
		Token.SCORE: "score"
	}

# --------- END ------------

#---------- Signal ---------

signal set_value(scope, token, value)

#---------- END ------------

# --------- Members ---------

var _level_data = {
	Refs.Scope.STARS: {
		Refs.Token.BRONZE: 0,
		Refs.Token.SILVIER: 0,
		Refs.Token.GOLD: 0
	},
	Refs.Scope.PLAYER: {
		Refs.Token.SCORE: 0
	}
}

# --------- END ------------

# --------- Methods (CUSTOM) ---------:

# @PUBLICS:

func set_value(scope, token, value, plus_equals = false):
	var _data_scope_ = _level_data.get(scope, {})
	if _data_scope_.has(token):
		if plus_equals:
			_level_data[scope][token] += value
		else:
			_level_data[scope][token] = value
		emit_signal("set_value", scope, token, _level_data[scope][token])

func get_value(scope, token = Refs.Token.NONE):
	if token == Refs.Token.NONE:
		return _level_data.get(scope)
	var _data_scope_ = _level_data.get(scope, {})
	if _data_scope_.has(token):
		return _level_data[scope][token]

func export_data(config = {}) -> Dictionary:
	var _scopes_ = config.get("scopes", _level_data.keys())
	var _data_ = {}
	for scope in _scopes_:
		var _tokens_ = _level_data[scope].keys()
		for token in _tokens_:
			var scopeText = _get_text_with_scope(scope)
			var tokenText = _get_text_with_token(token)
			if scopeText != "" and tokenText != "":
				var value = _level_data[scope][token]
				if not _data_.has(scopeText):
					_data_[scopeText] = {}
				_data_[scopeText][tokenText] = value
	return _data_

# @PRIVATES:

func _get_text_with_scope(scope):
	return Refs.scopes.get(scope, "")

func _get_text_with_token(token) -> String:
	return Refs.tokens.get(token, "")

# --------- END ------------
