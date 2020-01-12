extends Area


export (bool)var danger = false 
export (int,0,3)var danger_level
var danger_meter = 0
var danger_rate = 0
#####################################

var player_in_area = false
var player

func _ready() -> void:
	set_danger_rate()

func _physics_process(delta: float) -> void:
	
	if player_in_area and danger:
		if danger_level < 3:
			danger_meter = min( 
				100,
				danger_meter + (danger_level * (delta * danger_rate) )
				)
			
			if danger_meter == 100:
				danger_meter = 0
				danger_level = min( 3 , danger_level+1 )
				player.set_danger(danger_level)
				if danger_level == 3:
					randomize()
					$KillTimer.start( rand_range(1,2) )
		
	
	if not player_in_area:
		if danger_level > 1:
			danger_meter = max( 
				0,
				danger_meter - (danger_level * (delta * danger_rate) )
				)
			if danger_meter == 0:
				danger_meter = 100
				danger_level = max( 1 , danger_level-1 )

func set_danger_rate():
	randomize()
	danger_rate = rand_range(10,30)
	
func morphus_danger(level):
	if level == 0:
		danger = false
	else:
		danger = true
	danger_level = level
	set_danger_rate()


func _on_KillTimer_timeout() -> void:
	if player:
		player.kill_player()
	$KillTimer.stop()


func _on_DangerZones_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player = body
		player_in_area = true
		player.set_danger(danger_level)

func _on_DangerZones_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
		player = body
		player.set_danger(0)
		$KillTimer.stop()
