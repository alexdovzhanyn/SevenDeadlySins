on :key_down do |e|
  unless $player.health < 0
    case e.key
      when "a"
        # Don't allow the player to walk off the level
        unless $player.x <= $level.x || !$player.can_move(:left)
          $player.move_left
          update_camera
        end
      when "d"
        # Don't allow the player to walk off the level
        unless $player.x + $player.width >= $level.x + $level.width || !$player.can_move(:right)
          $player.move_right
          update_camera
        end
      when "space"
        if $player.can_move(:up) && $player.colliding?
          $player.toggle_jump
        end
      when "left shift" 
        current_platform = on_platform?($player)
        if current_platform
          $player.drop_from_platform(current_platform)
        end
      when "right shift"
        current_platform = on_platform?($player)
        if current_platform
          $player.drop_from_platform(current_platform)
        end
    end
  end
end

on :key_held do |e|
  unless $player.health < 0
    case e.key
      when 'a'
        # Don't allow the player to walk off the level
        unless $player.x <= $level.x || !$player.can_move(:left)
          $player.move_left
          update_camera
        end
      when 'd'
        # Don't allow the player to walk off the level
        unless $player.x + $player.width >= $level.x + $level.width || !$player.can_move(:right)
          $player.move_right
          update_camera
        end
    end
  end
end