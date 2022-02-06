extends Node

var difficulty = 0

func _on_DifficultyTimer_timeout():
	if $DifficultyBar.value < $DifficultyBar.max_value:
		$DifficultyBar.value += 1
		difficulty = floor($DifficultyBar.value / 60)
