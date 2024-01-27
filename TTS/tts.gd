extends Timer

# fuente: https://tmpxyz.itch.io/auditionroom-webgl
@onready var bips : Array[AudioStreamPlayer] = [$bip1, $bip2, $bip3, $bip4]

func _ready():
	connect("timeout", play_bip)

func play_bip():
	var ix := randi() % (bips.size() + 1)
	if ix < bips.size():
		bips[ix].play()
