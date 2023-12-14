extends HBoxContainer

@onready var frequency_tuner = $FrequencyTuner
@onready var music_player = $MusicPlayer

@export var MusicArray : Array[AudioStream] = []

var hslider_range_min := 0
var hslider_range_max := 10000

# Custom property to store frequency range
class AudioStreamPlayerWithRange extends AudioStreamPlayer:
	var start_frequency := 0
	var end_frequency := 0

func _ready():
	create_audio_players()

func create_audio_players():
	var num_tracks = MusicArray.size()
	print("Number of tracks:", num_tracks)

	var frequency_range = hslider_range_max / num_tracks

	for i in range(num_tracks):
		var audio_player = AudioStreamPlayerWithRange.new()
		audio_player.stream = MusicArray[i]
		audio_player.volume_db = -80

		# Assign a frequency range to each AudioStreamPlayer
		audio_player.start_frequency = i * frequency_range
		audio_player.end_frequency = (i + 1) * frequency_range

		music_player.add_child(audio_player)
		audio_player.play()

		# Print debug information
		print("Track", i + 1, "added. Frequency range:", audio_player.start_frequency, "-", audio_player.end_frequency)



func _on_frequency_tuner_value_changed(value):
	for child in music_player.get_children():
		if child is AudioStreamPlayerWithRange:
			adjust_volume(child, value)

func adjust_volume(audio_player, hslider_value):
	var start_frequency = audio_player.start_frequency
	var end_frequency = audio_player.end_frequency

	# Adjust the volume only if the HSlider value is within the frequency range
	if hslider_value >= start_frequency and hslider_value <= end_frequency:
		# Calculate the distance from the center of the frequency range
		var center_frequency = (start_frequency + end_frequency) / 2
		var distance = abs(hslider_value - center_frequency)
		var max_distance = (end_frequency - start_frequency) / 2

		# Adjust the volume based on the distance
		var volume_ratio = clamp(1.0 - distance / max_distance, 0.0, 1.0)
		var target_volume = lerp(-80, 0, volume_ratio)

		audio_player.volume_db = target_volume
	else:
		# If outside the frequency range, set volume to a lower value or mute
		audio_player.volume_db = -80


