extends Timer

# fuente: https://tmpxyz.itch.io/auditionroom-webgl
@onready var bips := [$bip1, $bip2, $bip3, $bip4]
var end := false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout", play_bip)

func play_bip():
	var ix = randi() % (bips.size() + 1)
	if ix < bips.size():
		bips[ix].play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass
