class_name BuildingSprite
extends Area3D

var can_place : bool = true

var regular_material : StandardMaterial3D 
var overlap_material : StandardMaterial3D

@onready var mesh : Mesh = $MeshInstance3D.mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_rotation = Vector3.ZERO

func get_placed():
	pass

func overlaps_with_building(building : Node3D):
	if building is Building:
		can_place = false
		mesh.material = overlap_material
		print("Overlapped!")
	
func end_overlap(building : Node3D):
	if building is Building:
		can_place = true
		mesh.material = regular_material
		print("No More Overlap!")
