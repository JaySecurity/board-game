extends Sprite2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $Timer
@onready var can_roll: bool = true

signal roll_complete(rolled)

func _ready() -> void:
  randomize()

func _unhandled_input(event: InputEvent) -> void:
  if can_roll and Input.is_action_just_pressed("ui_click"):
    animation_player.play("Roll")
    timer.start()


func _on_timer_timeout() -> void:
  var rolled : int = randi_range(1,6)
  print(rolled)
  animation_player.play(str(rolled))
  roll_complete.emit(rolled)
