# GlobalTime.gd

extends Node

# Constants for time colors
enum TimeColor {
	SILV,
	AMB,
	ROS,
	MAGEN,
	VIOL,
	CYA,
	NULL
}

# Variables
var currentColor: int = TimeColor.SILV  # Initial color
var timePassed: float = 0.0  # Total time passed
var timeIncrement: float = 0.10  # Adjust as needed
var current_time = "Silv - Glow"
# Function to change the time externally
func changeTime(time_multiplier): # Just a number we use
	timePassed += timeIncrement * time_multiplier  # Increment total time passed

	# Check if it's time to change color
	while timePassed >= timeIncrement * 6:
		timePassed -= timePassed # Reset the time counter

		# Increment the current color
		currentColor = (currentColor + 1) % TimeColor.NULL  # Wrap around to SILV after CYA

		# Call a function to handle the change in time color
		handleTimeColorChange(currentColor)


# Function to handle the change in time color
func handleTimeColorChange(color: int):
	match color:
		TimeColor.SILV:
			print("Silv - Glow")
			current_time = "Silv - Glow"
			# Add glow-time actions or update the game state accordingly
		TimeColor.AMB:
			print("Amb - Glow")
			current_time = "Amb - Glow"
		TimeColor.ROS:
			print("Ros - Glow")
			current_time = "Ros - Glow"
		TimeColor.MAGEN:
			print("Magen - Shade")
			current_time = "Magen - Shade"
			# Add shade-time actions or update the game state accordingly
		TimeColor.VIOL:
			print("Viol - Shade")
			current_time = "Viol - Shade"
		TimeColor.CYA:
			print("Cya - Shade")
			current_time = "Cya - Shade"

# Function to get the current time color
func getCurrentTimeColor() -> int:
	return currentColor
