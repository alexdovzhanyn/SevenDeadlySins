update do
  if $player.health > 0
    update_player
    update_entities
    update_misc
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

def update_entities
  $entities.each do |entity|
    # entity.breathe

    if entity.respond_to?(:destination)
      if entity.idle_timer == 0
        if entity.destination != nil
          entity.walk_to_destination
        else
          entity.generate_destination
        end
      else
        entity.idle_timer -= 1
      end
    end

    if entity.can_move(:down)
      entity.collision_box.velocityY -= GRAVITY

      # Check if player should hit something between this frame and the next
      # This is done by projecting the players position values in between frames
      entity.collision_box.velocityY.abs.ceil.times do |position|
        temp_entity = entity.clone
        temp_entity.collision_box = entity.collision_box.clone
        temp_entity.collision_box.y += position

        if !temp_entity.can_move(:down)
          entity.collision_box.y = temp_entity.collision_box.y
          entity.collision_box.velocityY = 0
          break
        end
      end

      entity.collision_box.velocityY.abs.ceil.times do |position|
        temp_entity = entity.clone
        temp_entity.collision_box = entity.collision_box.clone
        temp_entity.collision_box.y -= position

        if !temp_entity.can_move(:up)
          entity.collision_box.y = temp_entity.collision_box.y + 1
          entity.collision_box.velocityY = entity.collision_box.velocityY > 0 ? 0 : entity.collision_box.velocityY
          break
        end
      end

      entity.collision_box.y -= entity.collision_box.velocityY
    else
      entity.collision_box.velocityY = 0
    end
  end

  def update_misc
    Application.get(:window).objects.select{|object| object.kind_of? ChatBubble}.each do |bubble|
      if bubble.timeout && bubble.timeout == 0
        bubble.remove_self
      elsif bubble.timeout
        bubble.timeout -= 1
      end
    end
  end
end