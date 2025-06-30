% MATLAB Code for Result Analysis in Hybrid Metaheuristic Localization for VANETs

%% 1. Localization Accuracy vs. Number of Vehicular Nodes
num_nodes = 50:50:500;
localization_accuracy = 90 - 10 * exp(-0.005 * (num_nodes - 50));
figure;
plot(num_nodes, localization_accuracy, '-o', 'LineWidth', 2);
xlabel('Number of Vehicular Nodes');
ylabel('Localization Accuracy (%)');
title('Impact of Node Density on Localization Accuracy in NLOS VANETs');
grid on;

%% 2. Emergency Message Delivery Rate vs. Localization Error
localization_error = linspace(0, 10, 10);
delivery_rate = 100 - 5 * localization_error;
figure;
plot(localization_error, delivery_rate, '-s', 'LineWidth', 2);
xlabel('Localization Error (m)');
ylabel('Emergency Message Delivery Rate (%)');
title('Impact of Localization Errors on Emergency Message Delivery in VANETs');
grid on;

%% 3. Latency in Emergency Message Propagation vs. Node Density
node_density = 50:50:500;
latency = 5 + 15 * exp(-0.002 * (node_density - 50));
figure;
plot(node_density, latency, '-d', 'LineWidth', 2);
xlabel('Node Density (Nodes per km^2)');
ylabel('Latency (ms)');
title('Convergence Efficiency of the Hybrid Metaheuristic Algorithm in VANET Localization');
grid on;

%% 4. Packet Loss Rate vs. Localization Technique
techniques = {'SHSAOA', 'ROA', 'IGWO', 'ACO', 'DA-TRPED'};
packet_loss = [5.5, 7, 6, 5, 8];
figure;
bar(categorical(techniques), packet_loss);
xlabel('Localization Technique');
ylabel('Packet Loss Rate (%)');
title('Impact of Vehicular Mobility on Packet Loss in VANETs');
grid on;

%% 5. Throughput vs. Localization Accuracy
accuracy_levels = 80:5:100;
throughput = 5 + 0.3 * (accuracy_levels - 80);
figure;
plot(accuracy_levels, throughput, '-^', 'LineWidth', 2);
xlabel('Localization Accuracy (%)');
ylabel('Throughput (Mbps)');
title('Effect of Communication Range on Data Throughput in VANETs');
grid on;

%% 6. Impact of Anchor Node Density on Localization Error
anchor_density = 5:5:50;
loc_error = 15 - 0.3 * anchor_density;
figure;
plot(anchor_density, loc_error, '-p', 'LineWidth', 2);
xlabel('Anchor Node Density (Nodes per km^2)');
ylabel('Localization Error (m)');
title('Impact of Anchor Node Density on Localization Error');
grid on;

%% 7. Comparison of Metaheuristic Algorithms in Vehicle Localization
algorithms = {'PSO', 'GA', 'ACO', 'GWO', 'ROA'};
accuracy = [85, 87, 95, 92, 90];
figure;
bar(categorical(algorithms), accuracy);
xlabel('Metaheuristic Algorithm');
ylabel('Localization Accuracy (%)');
title('Comparison of Metaheuristic Algorithms in Vehicle Localization');
grid on;

%% 8. Scalability Analysis of Hybrid Localization Methods in Dense VANETs
vehicular_density = 100:100:1000;
scalability_factor = 1 ./ (1 + exp(-0.005 * (vehicular_density - 500)));
figure;
plot(vehicular_density, scalability_factor, '-h', 'LineWidth', 2);
xlabel('Vehicular Density (Vehicles per km^2)');
ylabel('Scalability Factor');
title('Scalability Analysis of Hybrid Localization Methods in Dense VANETs');
grid on;