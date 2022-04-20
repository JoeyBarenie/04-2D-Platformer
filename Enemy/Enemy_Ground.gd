extends KinematicBody2D

export var speed = 2
export var damage = 10
var direction = 1
var velocity = Vector2.ZERO
export var max_constraint = 100
export var min_constraint = -100



func _physics_process(_delta):
	if direction < 0 and $Sprite.flip_h:
		$Sprite.flip_h = true
	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false
		
	velocity.x += direction * speed
	move_and_slide(velocity, Vector2.UP)
	
			
func _on_Area2D_body_entered(body):
	print(body.name)
	if velocity.x != 0 and (body.name == "Platform" or body.name == "Ground"):
		velocity.x = 0
		direction.x *= -1
	if body.name == "Player":
		body.do_damage(damage)
