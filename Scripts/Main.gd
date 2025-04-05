extends Node2D

@onready var pink_piece: Sprite2D = $PinkPiece
@onready var move_timer: Timer = $Timer

@export var spots: Array[Spot]

var place: int =0


#func _unhandled_input(event: InputEvent) -> void:
  #if Input.is_action_just_pressed("ui_click") and place < len(spots):
    #var tween = create_tween()
    #tween.tween_property(pink_piece, "position", spots[place].position, 1)
    #place += 1
  #elif Input.is_action_just_pressed("ui_click") and place >= len(spots):
    #print("You Done!")


func _on_dice_roll_complete(rolled: Variant) -> void:
  #rolled = 11 # For Testing
  await move(rolled, spots[place])
  if place == 5:
    print("Penalty Move")
    await move(2, spots[place])
  if place == 11:
    print("Bonus Move")
    await move(2, spots[place])

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
    tween.tween_property(pink_piece, "position", spots[place].position, 1)
    move_timer.start()
    await move_timer.timeout
