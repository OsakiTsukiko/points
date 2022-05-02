extends Spatial

var point_scene = preload("res://point.tscn")
onready var logger = $CanvasLayer/log
onready var x_inp = $CanvasLayer/x
onready var y_inp = $CanvasLayer/y
onready var z_inp = $CanvasLayer/z
onready var enter_btn = $CanvasLayer/Enter
onready var cubes = $Cubes

const SPACE = 5
var squares = []
var index = 0

func _ready():
	logger.text = "[Initialized..]\n"
	enter_btn.connect("pressed", self, "_enter_btn_pressed")
	for x in range(-10, 11):
		for y in range(-10, 11):
			for z in range(-10, 11):
				var instance = point_scene.instance()
				instance.translate(Vector3(x * SPACE, y * SPACE, z * SPACE))
#				squares.push_back(instance)
				
				var mat = SpatialMaterial.new()
				var color = Color(0,0,0,1)
				mat.albedo_color = color
				instance.material_override = mat
		
				cubes.add_child(instance)
#	for sq in squares:
#		add_child(sq)
	pass

func _physics_process(delta):
	if ( Input.is_action_pressed("ui_accept") ):
		for i in cubes.get_children():
			i.translate(Vector3(i.translation[0] + 1, i.translation[1] + 1, i.translation[2] + 1))
#			i.translate(Vector3(x * SPACE, y * SPACE, z * SPACE))
	pass

func _enter_btn_pressed():
	var coords = {
		"x": int(x_inp.text),
		"y": int(y_inp.text),
		"z": int(z_inp.text)
	}
	logger.text += "[" + String(coords.x) + ", " + String(coords.y) + ", " + String(coords.z) + "]\n"
	var instance = point_scene.instance()
	instance.translate(Vector3(coords.x, coords.y, coords.z))
	add_child(instance)
