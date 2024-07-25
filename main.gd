extends Node2D

func _process(delta):
	if Global.hints != $ActionHints.hints:
		$ActionHints.hints = Global.hints;
		$ActionHints.update_hints()
		print($ActionHints.hints)
