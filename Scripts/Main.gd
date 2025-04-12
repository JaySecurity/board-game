extends Node2D

@onready var pink_piece: Sprite2D = $PinkPiece
@onready var blue_piece: Sprite2D = $BluePiece
@onready var move_timer: Timer = $Timer
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var dice: Node2D = $Dice
@onready var players = [pink_piece, blue_piece]
@onready var player_1_score: Label = $Player1Score
@onready var player_2_score: Label = $Player2Score

@export var spots: Array[Spot]

func _ready() -> void:
  Events.question_close.connect(on_question_closed)

#var place: int = 0
var turn = 0

func _on_dice_roll_complete(rolled: Variant) -> void:
  dice.can_roll = false
  rolled = 6 # For Testing
  await move(rolled, spots[players[turn%2].place])
  if spots[players[turn%2].place].direction != Direction.Dir.REGULAR:
    if spots[players[turn%2].place].direction == Direction.Dir.QUESTION:
      print("Question Space")
      var Question_Box = preload('res://Scenes/QuestionBox.tscn')
      var question_box = Question_Box.instantiate()
      canvas.add_child(question_box)
    else:
      await move(spots[players[turn%2].place].spaces, spots[players[turn%2].place])
      turn += 1
      dice.can_roll = true
  else:
    turn += 1
    dice.can_roll = true
  

func move(spaces: int, start_spot: Spot) -> void:
  for i in spaces:
    if start_spot.direction == Direction.Dir.BACK:
      players[turn%2].place -= 1
    else:
      players[turn%2].place +=1
    if players[turn%2].place >= spots.size():
      print("Winner!")
      break
    var tween = create_tween()
    tween.tween_property(players[turn%2], "position", spots[players[turn%2].place].position, 0.5)
    move_timer.start()
    await move_timer.timeout

func on_question_closed(points: int) -> void:
  players[turn%2].score += points
  if turn % 2 == 0:
    player_1_score.text = str(pink_piece.score)
  else:
    player_2_score.text = str(blue_piece.score) 
  dice.can_roll = true
  turn += 1
  
     
  
  
