extends Node2D

func _on_back_button_pressed():
	# 1. UNFREEZE TIME! (Customers resume walking)
	get_tree().paused = false
	
	# 2. Hide this fake area so we can see the Cafe again
	hide()
