on :key_down do |e|
  unless $player.health < 0
    case e.key
      when 'a', 'left'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x <= $level.x || !$player.can_move(:left)
          $player.move_left
          update_camera
        end
      when 'd', 'right'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x + $player.collision_box.width >= $level.x + $level.width || !$player.can_move(:right)
          $player.move_right
          update_camera
        end
      when 'space'
        if $player.can_move(:up) && $player.colliding?
          $player.toggle_jump
        end
      when 'i'
        $player.inventory.toggle
      when 'e'
        $player.interact
    end
  end
end

on :key_held do |e|
  unless $player.health < 0
    case e.key
      when 'a', 'left'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x <= $level.x || !$player.can_move(:left)
          $player.move_left
          update_camera
        end
      when 'd', 'right'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x + $player.collision_box.width >= $level.x + $level.width || !$player.can_move(:right)
          $player.move_right
          update_camera
        end
    end
  end
end