extends BuildingSprite

func _init() -> void:
	regular_material = preload("res://materials/wood_transparent.tres")
	overlap_material = preload("res://materials/wood_overlap.tres")
	
	body_entered.connect(overlaps_with_building)
	body_exited.connect(end_overlap)



