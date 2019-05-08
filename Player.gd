
extends Area2D

export var speed = 400 
var screen_size  
var debug_panel = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	screen_size = get_viewport_rect().size
	
	
func _process(delta):

	var velocity = Vector2()
	if Input.is_action_just_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_just_pressed("ui_left"):
			velocity.x -=1
	if Input.is_action_just_pressed("ui_up"):
			velocity.y -=1
	if Input.is_action_just_pressed("ui_down"):
			velocity.y +=1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
		
	$AnimatedSprite.position += velocity * delta
	$AnimatedSprite.position.x = clamp($AnimatedSprite.position.x,0,screen_size.x)
	$AnimatedSprite.position.y = clamp($AnimatedSprite.position.y,0,screen_size.y)
	
	#Diagonal Movement
#	if velocity.x > 0 && velocity.y > 0:
#		$AnimatedSprite.set_rotation(PI/4)
#	if velocity.x > 0 && velocity.y < 0:
#		$AnimatedSprite.set_rotation(-PI/4)
#	if velocity.x < 0 && velocity.y > 0:
#		$AnimatedSprite.set_rotation((3*PI)/4)
#	if velocity.x < 0 && velocity.y < 0:
#		$AnimatedSprite.set_rotation(-(3*PI)/4)
	
	#Vert/Horz Movement
	if velocity.x > 0:
		$AnimatedSprite.set_rotation(PI/2)
	if velocity.x < 0:
		$AnimatedSprite.set_rotation(-PI/2)
	if velocity.y > 0:
		$AnimatedSprite.set_rotation(-PI)
	if velocity.y < 0:
		$AnimatedSprite.set_rotation(0)
		
#	if (Input.is_action_just_pressed("Debug") && debug_panel== false):
#		$Label.show()
#		$Label.text = Engine.get_frames_per_second()
#	else:
#		$Label.hide()