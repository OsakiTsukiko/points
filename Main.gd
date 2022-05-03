extends Spatial

var point_scene = preload("res://point.tscn")
onready var logger = $CanvasLayer/log
onready var x_inp = $CanvasLayer/x
onready var y_inp = $CanvasLayer/y
onready var z_inp = $CanvasLayer/z
onready var enter_btn = $CanvasLayer/Enter
onready var cubes = $Cubes

const SPACE = 5

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
				var color = Color(randf(),randf(),randf(),1)
				mat.albedo_color = color
				instance.material_override = mat
		
				cubes.add_child(instance)
#	for sq in squares:
#		add_child(sq)
	pass

func _physics_process(delta):
	# Rotate
	if ( Input.is_action_pressed("ui_right") ):
		cubes.rotate(Vector3( 0, 1, 0 ), PI/100)
	if ( Input.is_action_pressed("ui_left") ):
		cubes.rotate(Vector3( 0, -1, 0 ), PI/100)
	if ( Input.is_action_pressed("ui_up") ):
		cubes.rotate(Vector3( -1, 0, 0 ), PI/100)
	if ( Input.is_action_pressed("ui_down") ):
		cubes.rotate(Vector3( 1, 0, 0 ), PI/100)
		
	# Explode?
	if ( Input.is_action_pressed("cubes_1") ):
		for i in cubes.get_children():
			i.translate(Vector3(i.translation[0], 0, 0))
	if ( Input.is_action_pressed("cubes_2") ):
		for i in cubes.get_children():
			i.translate(Vector3(-i.translation[0], 0, 0))
	pass

func _enter_btn_pressed():
	var coords = Vector3(
		int(x_inp.text),
		int(y_inp.text),
		int(z_inp.text)
	)
	
	logger.text += "[" + String(coords.x) + ", " + String(coords.y) + ", " + String(coords.z) + "]\n"
	var instance = point_scene.instance()
	instance.translate(Vector3(coords.x, coords.y, coords.z))
	add_child(instance)
