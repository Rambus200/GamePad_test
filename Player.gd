
extends Area2D
signal hit
signal exit_key

export var speed = 400 
export var angle_rate = 0.1
var screen_size  
var debug_panel = false
var prev_rotation = 0.0

# Initialization
func _ready():
	hide()
	screen_size = get_viewport_rect().size
	
#Repeat code
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_just_pressed("Esc"):
		emit_signal("exit_key")
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
		$Particles2D.emitting = true
	else:
		$Particles2D.emitting = false
	
		
	#Call animation_position Function
	set_animation_position(velocity,delta)
	#Call Movement Function
	set_movement(velocity)
	#set_movement(velocity,prev_rotation)

#Methods

func set_animation_position(velocity,delta):
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	#For Label position
	$Label.rect_position.x = ($AnimatedSprite.position.x + 20)
	$Label.rect_position.y = ($AnimatedSprite.position.y + 20)
	#Casting position vector data to string
	$Label.text = String(position)
	#Position of Particles2D
	$Particles2D.position.x = ($AnimatedSprite.position.x)
	$Particles2D.position.y = ($AnimatedSprite.position.y)
	$Particles2D.local_coords = true
	
func get_animation_position():
	return position
	
	#Diagonal Movement
func set_movement(velocity):
	
	#Vert/Horz Movement
	if velocity.x > 0:
		$AnimatedSprite.set_rotation(PI/2)
		$Particles2D.set_rotation(PI/2)
	if velocity.x < 0:
		$AnimatedSprite.set_rotation(-PI/2)
		$Particles2D.set_rotation(-PI/2)
	if velocity.y > 0:
		$AnimatedSprite.set_rotation(-PI)
		$Particles2D.set_rotation(-PI)
	if velocity.y < 0:
		$AnimatedSprite.set_rotation(0)
		$Particles2D.set_rotation(0)
		
	if (velocity.x > 0 && velocity.y > 0):
		$AnimatedSprite.set_rotation((3*PI)/4)
		$Particles2D.set_rotation((3*PI)/4)
	if velocity.x > 0 && velocity.y < 0:
		$AnimatedSprite.set_rotation(PI/4)
		$Particles2D.set_rotation(PI/4)
	if velocity.x < 0 && velocity.y > 0:
		$AnimatedSprite.set_rotation(-(3*PI)/4)
		$Particles2D.set_rotation(-(3*PI)/4)
	if velocity.x < 0 && velocity.y < 0:
		$AnimatedSprite.set_rotation(-PI/4)
		$Particles2D.set_rotation(-PI/4)
	
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.call_deferred("set_disabled",true)
	
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
	
