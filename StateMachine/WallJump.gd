extends Node

onready var SM = get_parent()
onready var player = get_node("../..")
onready var player_animsprite = player.get_node("AnimatedSprite")

var is_on_wall = false

const CanWallJumpTypes = [
	"TileMap"
]

const walljump_y_vel = 1000
const walljump_x_vel = 750

func _ready():
	yield(player, "ready")
	
func check_walljump():
	# could check this with either the class name or the ResourceID. I opted for class name so that any other TileMap's would also count as objects that would proc a walljump
	var is_right = player.get_right_collider() and player.get_right_collider().get_class() in CanWallJumpTypes
	var is_left = player.get_left_collider() and player.get_left_collider().get_class() in CanWallJumpTypes
	var is_walljump = (is_right or is_left) and (player.get_node("Wall/Left").enabled or player.get_node("Wall/Right").enabled)
	
	if is_walljump :
		SM.set_state("WallJump")

func start():
	player.velocity = Vector2.ZERO
	player.should_direction_flip = false
	is_on_wall = true
	$Timer.start()
	player.set_animation("WallJump") # anim defaults to facing left
	
	if player.get_right_collider(): # if not null, it's colliding with something
		if not player_animsprite.flip_h:
			player_animsprite.flip_h = true
		
	elif player.get_left_collider():
		if player_animsprite.flip_h:
			player_animsprite.flip_h = false


func end():
	player.should_direction_flip = true
	$Sweat.emitting = false

func physics_process(_delta):
	if not is_on_wall:
		player.set_wall_raycasts(false)
		SM.set_state("Falling")
	
	if Input.is_action_just_pressed("jump"):
		var x = walljump_x_vel
		if player_animsprite.flip_h:
			x = -x
		player.velocity = Vector2(x, -walljump_y_vel)
		player.move_and_slide(player.velocity, Vector2.UP)
		SM.set_state("Falling")
	
	if $Timer.time_left <= $Timer.wait_time/2 and is_on_wall and not $Sweat.emitting:
		$Sweat.position = player.position # set particles to player's position
		$Sweat.position.y -= 10 # offset to put the particles on player's head
		$Sweat.emitting = true

func _on_Timer_timeout():
	is_on_wall = false
