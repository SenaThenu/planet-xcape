extends Node

var spawn_wave_timer: Timer = null
var can_spawn_a_wave: bool = false
var countdown_time: int = 3  # default value of 3 ensures aliens start spawning 3 secs after the game began

func _ready():
	# Create a new Timer node
	spawn_wave_timer = Timer.new()
	
	# Configure the Timer node
	spawn_wave_timer.wait_time = 1.0
	spawn_wave_timer.one_shot = false
	spawn_wave_timer.autostart = true
	
	spawn_wave_timer.timeout.connect(_on_spawn_wave_timer_timeout)

func _on_spawn_wave_timer_timeout():
	# decrease the countdown time
	countdown_time -= 1
	
	if countdown_time <= 0:
		spawn_wave_timer.stop()
		can_spawn_a_wave = true
		countdown_time = LevelManager.get_level_props()["time_gap_between_waves"]

func set_can_spawn_a_wave_to_false():
	can_spawn_a_wave = false
	spawn_wave_timer.start()
