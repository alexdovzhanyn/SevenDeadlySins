on :key_down do |e|
  unless $player.health < 0
    case e.key
      when 'a'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x <= $level.x || !$player.can_move(:left) || $game_menu.open
          $player.move_left
          update_camera
        end
      when 'd'
        # Don't allow the player to walk off the level
        unless $player.collision_box.x + $player.collision_box.width >= $level.x + $level.width || !$player.can_move(:right) || $game_menu.open
          $player.move_right
          update_camera
        end
      when 'space'
        if $player.can_move(:up) && $player.colliding? && !$game_menu.open
          $player.toggle_jump
        end
      when 'i'
        unless $game_menu.open
          $player.inventory.toggle
        end
      when 'e'
        unless $game_menu.open
          $player.interact
        end
      when 'escape'
        if !$interface_controller.open_interface_items.empty?
          # This is kind of weird, but since we're removing from the array during the loop, we cant use .each
          $interface_controller.open_interface_items.length.times do
            $interface_controller.remove_item($interface_controller.open_interface_items[0])
          end
        else
          $game_menu.toggle
        end
    end
  end
end

on :key_held do |e|
  unless $player.health < 0 || $game_menu.open
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
  case e.button
    when :left
      Application.get(:window).objects.select{|object| object.kind_of? InterfaceRectangle}.each do |item|
        if Application.get(:window).mouse_x >= item.x && Application.get(:window).mouse_x <= item.x + item.width && Application.get(:window).mouse_y >= item.y && Application.get(:window).mouse_y <= item.y + item.height
          if item.mouseclick
            item.mouseclick.call
          end
        end
      end
  end
end