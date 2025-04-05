extends CenterContainer

@export var button_one_is_right: bool

func _on_button_pressed() -> void:
  if button_one_is_right:
    print("Button One Is Correct")
  else:
    print('Wrong!')

func _on_button_2_pressed() -> void:
  if not button_one_is_right:
    print("Button Two Is Correct")
  else:
    print('Wrong!')
