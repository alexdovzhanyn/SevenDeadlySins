on :key_down do |e|
  unless $player.health < 0
    case e.key
      when 'a'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x <= $level.x || !$player.can_move(:left)
          $player.move_left
          update_camera
        end
      when 'd'
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
      when 's'
        SaveManager.save
    end
  end
end

on :key_held do |e|
  unless $player.health < 0
    case e.key
      when 'a'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x <= $level.x || !$player.can_move(:left)
          $player.move_left
          update_camera
        end
      when 'd'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x + $player.collision_box.width >= $level.x + $level.width || !$player.can_move(:right)
          $player.move_right
          update_camera
        end
    end
  end
end

on :mouse_down do |e|
  unless $player.health < 0
    case e.button
      when :left
        Application.get(:window).objects.select{|object| object.kind_of? InterfaceRectangle}.each do |item|
          if Application.get(:window).mouse_x >= item.x && Application.get(:window).mouse_x <= item.x + item.width && Application.get(:window).mouse_y >= item.y && Application.get(:window).mouse_y <= item.y + item.height
            item.mouseclick.call
          end
        end
    end
  end
end