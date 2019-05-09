
extends Area2D

export var speed = 400 
var screen_size  
var debug_panel = false

# Initialization
func _ready():
	
	screen_size = get_viewport_rect().size
	

#Repeat code
func _process(delta):

	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_pressed("ui_left"):
			velocity.x -=1
	if Input.is_action_pressed("ui_up"):
			velocity.y -=1
	if Input.is_action_pressed("ui_down"):
			velocity.y +=1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	#Call animation_position Function
	set_animation_position(velocity,delta)
	#Call Movement Function
	set_movement(velocity)

#Methods

func set_animation_position(velocity,delta):
	$AnimatedSprite.position += velocity * delta
	$AnimatedSprite.position.x = clamp($AnimatedSprite.position.x,0,screen_size.x)
	$AnimatedSprite.position.y = clamp($AnimatedSprite.position.y,0,screen_size.y)
	
	#For Label position
	$Label.rect_position.x = ($AnimatedSprite.position.x + 20)
	$Label.rect_position.y = ($AnimatedSprite.position.y + 20)
	#Casting position vector data to string
	$Label.text = String($AnimatedSprite.position)
	
func get_animation_position():
	return $AnimatedSprite.position

	#Diagonal Movement
func set_movement(velocity):
	
	#Vert/Horz Movement
	if velocity.x > 0:
		$AnimatedSprite.set_rotation(PI/2)
	if velocity.x < 0:
		$AnimatedSprite.set_rotation(-PI/2)
	if velocity.y > 0:
		$AnimatedSprite.set_rotation(-PI)
	if velocity.y < 0:
		$AnimatedSprite.set_rotation(0)
		
	if (velocity.x > 0 && velocity.y > 0):
		$AnimatedSprite.set_rotation((3*PI)/4)
	if velocity.x > 0 && velocity.y < 0:
		$AnimatedSprite.set_rotation(PI/4)
	if velocity.x < 0 && velocity.y > 0:
		$AnimatedSprite.set_rotation(-(3*PI)/4)
	if velocity.x < 0 && velocity.y < 0:
		$AnimatedSprite.set_rotation(-PI/4)
		
#	if (Input.is_action_just_pressed("Debug") && debug_panel== false):
#		$Label.show()
#		$Label.text = Engine.get_frames_per_second()
#	else:
#		$Label.hide()