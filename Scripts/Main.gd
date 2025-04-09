extends Node2D

@onready var pink_piece: Sprite2D = $PinkPiece
@onready var move_timer: Timer = $Timer
@onready var canvas: CanvasLayer = $CanvasLayer

@export var spots: Array[Spot]

var place: int = 0

func _on_dice_roll_complete(rolled: Variant) -> void:
  rolled = 6 # For Testing
  await move(rolled, spots[place])
  
  if spots[place].direction != Direction.Dir.REGULAR:
    print("Special Space")
  if spots[place].direction == Direction.Dir.QUESTION:
    print("Question Space")
    var Question_Box = preload('res://Scenes/QuestionBox.tscn')
    var question_box = Question_Box.instantiate()
    canvas.add_child(question_box)
  else:
    await move(spots[place].spaces, spots[place])
  

func move(spaces: int, start_spot: Spot) -> void:
  for i in spaces:
    if start_spot.direction == Direction.Dir.BACK:
      place -= 1
    else:
      place +=1
    if place >= spots.size():
      print("Winner!")
      break
    var tween = create_tween()
    tween.tween_property(pink_piece, "position", spots[place].position, 0.5)
    move_timer.start()
    await move_timer.timeout
