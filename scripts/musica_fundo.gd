extends Node2D;
@onready var music_player = $AudioStreamPlayer2D;

var current = 0;

var musicas = [
	preload("res://Trilha Sonora/Dormi Na Praca (Karaoke).WAV"), 
	preload("res://Trilha Sonora/E O Amor (Karaoke).WAV"), 
	preload("res://Trilha Sonora/Ela E Demais (Karaoke).WAV"), 
	preload("res://Trilha Sonora/Evidencias (Karaoke).WAV"), 
	preload("res://Trilha Sonora/Joaquim_e_ManoelBoate_Azul.WAV"), 
	preload("res://Trilha Sonora/Mato_Grosso_e_MathiasTentei_Te_Esquecer_3.WAV"), 
	preload("res://Trilha Sonora/Pense Em Mim (Karaoke).wav")
];

func _ready():
	if music_player.playing: 
		return;
	musicas.shuffle();
	music_player.connect("finished", self._on_music_finished)
	if musicas[current]:
		music_player.stream = musicas[current]
		music_player.play();
		print('just played ', musicas[current])

func stop_music():
	music_player.stop()

func _on_music_finished():
	print("finished", current)
	current = (current + 1) % musicas.size();
	music_player.stream = musicas[current];
	music_player.play();
