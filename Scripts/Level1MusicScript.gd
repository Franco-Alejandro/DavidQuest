extends StreamPlayer

var song1
var song2
var currentSong = song1

func _ready():
	set_process(true)
   
   
func _process(delta):
	if(self.is_playing() != true):
		self.set_stream(song1)
	self.play()