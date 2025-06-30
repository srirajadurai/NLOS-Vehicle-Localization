%% Hybrid Ant Colony Optimization and Simulated Annealing for Routing Optimization

clc; clear; close all;

%% Problem Definition
% Define NLOS probability and penalty factor
NLOS_prob = 0.3; % 30% of the links are NLOS
gamma_NLOS = 1.5; % NLOS links have 50% increased path cost

num_cities = 10;  % Number of locations (nodes)
coords = rand(num_cities, 2) * 100; % Random coordinates for cities
distance_matrix = squareform(pdist(coords)); % Compute distance matrix
% Generate random NLOS conditions
NLOS_mask = rand(num_cities) < NLOS_prob;
% Apply NLOS penalty without affecting optimization logic
distancematrix = distance_matrix .* (1 + gamma_NLOS * NLOS_mask);
num_ants = 20;        % Number of ants
num_iterations = 100; % Maximum number of iterations
alpha = 1;           % Influence of pheromone
beta = 2;            % Influence of heuristic
rho = 0.5;          % Pheromone evaporation rate
Q = 100;            % Pheromone deposit factor
tau = ones(num_cities) * 0.1; % Initial pheromone levels

T0 = 100;  % Initial temperature for SA
cooling_rate = 0.99; % Cooling schedule

%% ACO + SA Algorithm

best_length = inf;
best_route = [];

for iter = 1:num_iterations
    paths = zeros(num_ants, num_cities);
    lengths = zeros(num_ants, 1);
    
    % Ant Colony Optimization - Construct Solutions
    for k = 1:num_ants
        visited = zeros(1, num_cities);
        path = zeros(1, num_cities);
        current_city = randi(num_cities);
        path(1) = current_city;
        visited(current_city) = 1;
        
        for step = 2:num_cities
            unvisited = find(visited == 0);
            probs = (tau(current_city, unvisited) .^ alpha) .* ...
                    ((1 ./ distance_matrix(current_city, unvisited)) .^ beta);
            probs = probs / sum(probs);
            
            next_city = unvisited(find(rand < cumsum(probs), 1));
            if isempty(next_city)
                next_city = unvisited(randi(length(unvisited)));
            end
            
            path(step) = next_city;
            visited(next_city) = 1;
            current_city = next_city;
        end
        
        paths(k, :) = path;
        lengths(k) = sum(diag(distance_matrix(path, [path(2:end), path(1)])));
        
        if lengths(k) < best_length
            best_length = lengths(k);
            best_route = path;
        end
    end
    
    % Update Pheromones
    tau = tau * (1 - rho);
    for k = 1:num_ants
        for j = 1:num_cities - 1
            tau(paths(k, j), paths(k, j + 1)) = tau(paths(k, j), paths(k, j + 1)) + Q / lengths(k);
        end
    end
    
    % Simulated Annealing for Refinement
    T = T0 * cooling_rate^iter;
    new_route = best_route;
    swap_idx = randperm(num_cities, 2);
    new_route([swap_idx(1), swap_idx(2)]) = new_route([swap_idx(2), swap_idx(1)]);
    
    new_length = sum(diag(distance_matrix(new_route, [new_route(2:end), new_route(1)])));
    
    if new_length < best_length || rand < exp((best_length - new_length) / T)
        best_length = new_length;
        best_route = new_route;
    end
    
    % Plot Progress
    figure(1); clf;
    plot(coords(best_route, 1), coords(best_route, 2), '-o', 'LineWidth', 2, 'MarkerSize', 8);
    hold on;
    plot([coords(best_route(end), 1), coords(best_route(1), 1)], ...
         [coords(best_route(end), 2), coords(best_route(1), 2)], '-o', 'LineWidth', 2);
    title(['Iteration ' num2str(iter) ': Best Distance = ' num2str(best_length)]);
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    grid on; drawnow;
end

disp(['Optimal Route Found: ', num2str(best_route)]);
disp(['Optimal Route Distance: ', num2str(best_length)]);
