update do
  if $player.health > 0
    update_player
  else
    $game_end_bg.color = [0,0,0,0.8]
    $game_end_text.color = [1,0,0,1]

    # Reposition text after we know its height & width to center it
    $game_end_text.x = units_to_pixels(WINDOW_WIDTH/2) - $game_end_text.width/2
    $game_end_text.y = units_to_pixels(WINDOW_HEIGHT/2) - $game_end_text.height/2
    $game_end_bg.x = $camera.x
    $game_end_bg.y = $camera.y
  end
end

def update_player
  # Check to see if player should be taking damage
  if $player.colliding?
    $player.colliding?.each do |collision|
      if collision[:object].respond_to?(:damage)
        $player.health -= collision[:object].damage
      end
    end
  end

  $player.health_text.text = $player.health > 0 ? $player.health : 0

  # Handles jumping and gravity
  if $player.can_move(:down)
    $player.velocityY -= GRAVITY

    # Check if player should hit something between this frame and the next
    # This is done by projecting the players position values in between frames
    $player.velocityY.abs.ceil.times do |position|
      temp_player = $player.clone
      temp_player.y += position

      if !temp_player.can_move(:down)
        $player.y = temp_player.y
        $player.velocityY = 0
        break
      end
    end

    $player.y -= $player.velocityY
  else
    $player.velocityY = 0
  end
end

def update_camera
  if $camera.should_move?($player)
    if $camera.should_move?($player) == 'Left'
      $camera.move(units_to_pixels(Player::MOVEMENT_SPEED), 0, $level)
    elsif $camera.should_move?($player) == 'Right'
      $camera.move(units_to_pixels(-Player::MOVEMENT_SPEED), 0, $level)
    end
  end
end