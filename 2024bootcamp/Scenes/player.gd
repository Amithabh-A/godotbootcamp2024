extends CharacterBody2D

@export var speed = 200
@export var gravity = 20
@export var jumpSpeed = 700

func _get_input():
	return Input.get_action_strength("Right")-Input.get_action_strength("Left")

func _ready():
	pass
	
	
func _physics_process(delta):
	velocity.x = speed*_get_input()
	
	# implementing gravity
	velocity.y+=gravity
	
	# Jump functionality
	if(Input.is_action_just_pressed("Jump") and is_on_floor()):
		velocity.y = velocity.y - jumpSpeed
		
	move_and_slide()
	_handle_animations()

func _handle_animations():
	var animatedSprite = $AnimatedSprite2D
	if(Input.is_action_just_pressed("attack")):
		animatedSprite.play("attack")
	elif(velocity.y>0 and not is_on_floor()):
		print(velocity.y)
		animatedSprite.play("end_jump")
	elif(Input.is_action_pressed("Jump") or velocity.y<0):
		animatedSprite.play("start_jump")
	elif(velocity.x==0 and velocity.y==0):
		animatedSprite.play("idle")
	elif (velocity.x>0 and animatedSprite.flip_h or velocity.x<0 and not animatedSprite.flip_h):
		animatedSprite.flip_h = !animatedSprite.flip_h
		animatedSprite.offset.x = -animatedSprite.offset.x
		
		animatedSprite.play("right")
		
