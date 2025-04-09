extends CenterContainer

@export var button_one_is_right: bool

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label

var questions: Array = [
  ["Question", true],
  ["Question2", false],
  ["Question3", true],
] 

var current: Array
  
func _init() -> void:
  randomize()
  questions.shuffle()
  current = questions.pop_back()
  pass
  
func _ready() -> void:
  label.text = current[0]
  button_one_is_right = current[1]
  
func _on_button_pressed() -> void:
  if button_one_is_right:
    print("Button One Is Correct")
    queue_free()
  else:
    print('Wrong!')

func _on_button_2_pressed() -> void:
  if not button_one_is_right:
    print("Button Two Is Correct")
    queue_free()
  else:
    print('Wrong!')
