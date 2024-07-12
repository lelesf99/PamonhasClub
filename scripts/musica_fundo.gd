extends Node2D

var music_player: AudioStreamPlayer2D
var current_music: AudioStream = null

func _ready():
	music_player = AudioStreamPlayer2D.new()
	add_child(music_player)
	music_player.autoplay = true
	music_player.connect("finished", self._on_music_finished)
	if current_music:
		music_player.stream = current_music
		music_player.loop = true

func play_music(music_stream: AudioStream):
	music_player.stop()
	music_player.stream = music_stream
	music_player.play()
	current_music = music_stream

func stop_music():
	music_player.stop()
	music_player.stream = null
	current_music = null

func _on_music_finished():
	music_player.play()
