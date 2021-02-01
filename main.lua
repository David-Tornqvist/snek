local player = {["x"] = 0, ["y"] = 0};
local seconds = 0;
local direction = "right";
local update = true;


local bitmap = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              ["convertToIndex"] = function (x,y)
                return y*20 + x;
              end
            };


love.draw = function()

    love.graphics.setColor(0,0,1,1);
    
    local coords = {["x"] = 0, ["y"] = 0};

    for i = 1, #bitmap do
      if(bitmap[i] == 1) then
        love.graphics.polygon("fill", coords.x, coords.y, coords.x+40, coords.y,coords.x+40,coords.y+40,coords.x,coords.y+40); 
      end

      coords.x = coords.x + 40;
      
      if(coords.x == 800) then
        coords.x = 0;
        coords.y = coords.y + 40;
      end    
    end

    if(update == false) then

      love.graphics.setColor(0,1,1,1);
      love.graphics.print("F5 to restart",400,300);
    end  
end



love.keypressed = function(key)
    if (key == "w") then
      direction = "up";
    elseif (key == "s") then  
      direction = "down";
    elseif (key == "a") then  
      direction = "left";
    elseif (key == "d") then  
      direction = "right";
    end
    
    if(key == "f5") then
      update = true;
      player.x = 0;
      player.y = 0;
      direction = "right";
      for i = 1, #bitmap do
        bitmap[i] = 0;
      end
    end  
end      

love.update = function(dt)
  seconds = seconds + dt;

  if((seconds > 0.1) and update) then
    seconds = 0;
    if(direction == "right") then
      player.x = player.x + 1;
    elseif (direction == "left") then
      player.x = player.x - 1;  
    elseif (direction == "up") then  
      player.y = player.y - 1;
    elseif (direction == "down") then
      player.y = player.y + 1;  
    end
    if((bitmap[bitmap.convertToIndex(player.x,player.y)] == 0) and (0 <= player.x) and (player.x <= 20) and (0 <= player.y) and (player.y <= 15)) then
      bitmap[bitmap.convertToIndex(player.x,player.y)] = 1;
    else
      update = false;  
    end   
  end 
end