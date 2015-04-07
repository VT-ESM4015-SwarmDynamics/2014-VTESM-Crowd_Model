function spawn_agent()
  % global fileID;
  global configuration;
  global buffer;
  global goal_paths;

  % buffer
  slot_num = tminus(1);
  buffer_slot = buffer(slot_num, :);
  last_frame = buffer_slot(3:end);
  nanframe = isnan(last_frame);
  nans = sum(nanframe);
  active = configuration.agents - nans/2;
  % new agent number
  agent_num = active + 1;

  %SPAWN DEM DUDES
  %flux from each entrance per second
  spawnRate1 = 1;
  spawnRate2 = 1;
  spawnRate3 = 1;
  % get an array of three random numbers [a, b, c] 
  random = 0 + (1/configuration.dt)*rand(3,1);
  %disp("aa")
  start_spawn = 0;
  if (random(1) <= spawnRate1 && active < configuration.agents)
    %spawn a dude at 1
    %disp("11111")
    start_spawn = 1;
   
  elseif (random(2) <= spawnRate2 && active < configuration.agents)
    %spawn a dude at 2
    %disp("2222222")
    start_spawn = 2;
  elseif (random(3) <= spawnRate3 && active < configuration.agents)
    %spawn a dude at 3
    %disp("3333333")
    start_spawn = 3;
  else
    % disp ('no spawn today');
    return
  end
  %disp("PAST");

  global spawn_points;
  spawn_points(agent_num) = start_spawn;
  global current_goals;
  current_goals(agent_num) = 1;

  % array of spawns like goals
  spawnArray = [[-4,-20,4,-20];[-14,0,-14,8];[14,0,14,8]]*300;
  
  goal_paths(agent_num) = randi([1 2]); % get the random path num

  spawn = spawnArray(start_spawn,:); % get the random spawn line
  if (spawn(1) > spawn(3))
    positionX = randi([(spawn(3)+200) (spawn(1)-200)]);
  elseif (spawn(1) < spawn(3))
    positionX = randi([(spawn(1)+200) (spawn(3)-200)]);
    else
    positionX = spawn(1);
  end
  if (spawn(2) > spawn(4))
    positionY = randi([(spawn(4)+200) (spawn(2)-200)]);
  elseif(spawn(4) > spawn(2))
    positionY = randi([(spawn(2)+200) (spawn(4)-200)]);
    else 
    positionY = spawn(2);
  end

  global buffer;

  % set last position
  buffer(tminus(1), 1+2*agent_num:2+2*agent_num) = [positionX, positionY];
  % set velocity 0 ( no difference from last last position )
  buffer(tminus(1), 1+2*agent_num:2+2*agent_num) = [positionX, positionY];

  current_goals(agent_num) = 1;
  velocity_upper_limits(agent_num) = 4.0*300 + randi([0 240]);
end
