extends Sprite2D

# 1. The Default State (When they are just standing there)
@export var base_image: Texture2D

# 2. The Animation Frames (You drop the specific emotion frames here!)
@export var emotion_frames: Array[Texture2D]

# 3. Animation Controls
@export var time_between_frames: float = 0.5
@export var is_animating: bool = true

var current_frame_index = 0
var timer = 0.0

func _ready():
	# The moment the pet spawns, set them to their base image
	if base_image != null:
		texture = base_image

func _process(delta):
	# SAFETY CHECK: If we tell them to stop animating, or if we forgot to add frames, 
	# just show the base image and stop the math!
	if is_animating == false or emotion_frames.is_empty():
		if base_image != null:
			texture = base_image
		return
		
	# --- THE ANIMATION LOOP ---
	timer += delta
	
	if timer >= time_between_frames:
		timer = 0.0 # Reset the clock
		current_frame_index += 1 # Move to the next frame
		
		# If we hit the end of the list, loop back to the first frame!
		if current_frame_index >= emotion_frames.size():
			current_frame_index = 0
			
		# Physically change the picture on the screen!
		texture = emotion_frames[current_frame_index]
