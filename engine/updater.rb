update do
  if $player.health > 0
    update_player
  else
    $game_end_bg.color = [0,0,0,0.8]
    $game_end_text.color = [1,0,0,1]

    # Reposition text after we know its height & width to center it
    $game_end_text.x = WINDOW_WIDTH/2 - $game_end_text.width/2
    $game_end_text.y = WINDOW_HEIGHT/2 - $game_end_text.height/2
  end
end

def update_player
  # Check to see if player should be taking damage
  colliding_object = $player.colliding?
  if colliding_object && colliding_object.respond_to?(:damage)
    $player.health -= colliding_object.damage
  end

  $player.health_text.text = $player.health > 0 ? $player.health : 0

  # Handles jumping and gravity
  if !on_platform?($player)
    $player.velocityY -= GRAVITY
    $player.y -= $player.velocityY
  else
    $player.velocityY = 0
  end
end

def update_camera
  if $camera.should_move?($player)
    if $camera.should_move?($player) == 'Left'
      $camera.move(Player::MOVEMENT_SPEED, 0, $level)
    elsif $camera.should_move?($player) == 'Right'
      $camera.move(-Player::MOVEMENT_SPEED, 0, $level)
    end
  end
end