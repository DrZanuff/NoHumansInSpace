extends Node

var timer
var mode = "random"

func _ready() -> void:
	if not has_node("Nodes"):
		var node = Node.new()
		node.name = "Nodes"
		add_child( node )
	
	var t = Timer.new()
	t.name = "ZoneTimer"
	add_child(t)
	t.connect("timeout",self,"time_out")
	timer = t
	move_morphus()


func move_morphus():
	if mode == "random":
		randomize()
		var n = randi() % get_node("Nodes").get_child_count()
		var zone = get_node("Nodes").get_child( n )
		
		for i in get_node("Nodes").get_children():
			randomize()
			var danger = [ 0 , 0 , 0 , 0 , 1 , 2 , 3]
			danger.shuffle()
			i.morphus_danger( danger[0])
		
		if timer is Timer:
			timer.start( rand_range( 5 , 20 ) )
			

func time_out():
	print("move!")
	move_morphus()
