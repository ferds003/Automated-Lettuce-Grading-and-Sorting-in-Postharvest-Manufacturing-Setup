%% 
function Comp_vis() % Opening and shutting camera 
% Define the folder path; 
folderPath = ; 

% Creates if does not exist 
if ~isfolder(folderPath) 
mkdir(folderPath); 
end 
% Initializes cameras 
cam1 = webcam(5); 
pause(1); % Gives time for the cameras to stabilize 
cam2 = webcam(1); 
pause(2.5); 
cam3 = webcam(3); 
cam4 = webcam(2); 
cam5 = webcam(4); 

% Takes image and closes 
img1 = snapshot(cam1); 
clear cam1; 
img2 = snapshot(cam2); 
clear cam2; 
img3 = snapshot(cam3); 
clear cam3; 
img4 = snapshot(cam4); 
clear cam4; 
img5 = snapshot(cam5); 
%psf= fspecial("gaussian",5,5); 

%img5 = deconvlucy(img5,psf); 
clear cam5; 
% Define file names for each image 
fileName1 = fullfile(folderPath, '1.jpg'); 
fileName2 = fullfile(folderPath, '2.jpg'); 
fileName3 = fullfile(folderPath, '3.jpg');
fileName4 = fullfile(folderPath, '4.jpg'); 
fileName5 = fullfile(folderPath, '5.jpg'); 
     
% Save images to the created folder 
imwrite(img1, fileName1); 
imwrite(img2, fileName2); 
imwrite(img3, fileName3); 
imwrite(img4, fileName4); 
imwrite(img5, fileName5);
end 
%% 
function RGBHSV_extract() % Extraction of RGB and HSV values 

% Folder for screenshots 
folder = ''; 

% Checks if the folder exists 
if ~isfolder(folder) 
    error('The specified folder does not exist: %s', folder); 
end
%% 
% Takes the file types from folder 
jpgFiles = dir(fullfile(folder, '*.jpg')); 
pngFiles = dir(fullfile(folder, '*.png')); 
allFiles = [jpgFiles; pngFiles]; % Combine both lists 

% Checks if images exist 
if isempty(allFiles) 
    error('No JPG or PNG files found in the specified folder.'); 
end 

%% 
% Arrays for RGB values and image names 
numImages = numel(allFiles); 
R = zeros(numImages, 1); 
G = zeros(numImages, 1); 
B = zeros(numImages, 1);

H = zeros(numImages, 1); 
S = zeros(numImages, 1); 
V = zeros(numImages, 1); 
     
imageNames = cell(numImages, 1); 
     
%% Extracting RGB HSV 
% Loop through each image file and extract RGB values 
for i = 1:numImages 
    % Load the image 
    filename = fullfile(folder, allFiles(i).name); 
    image = imread(filename); 
 
    % Converts to double 
    dImage = double(image); 

    % Extract the average RGB values 
    R(i) = mean(dImage(:, :, 1), 'all'); % red channel 
    G(i) = mean(dImage(:, :, 2), 'all'); % green channel 
    B(i) = mean(dImage(:, :, 3), 'all'); % blue channel 
 
    % Convert the image to HSV 
    hsvImage = rgb2hsv(image); 

    % Extract the HSV values 
    H(i) = mean2(hsvImage(:, :, 1)); % hue channel 
    S(i) = mean2(hsvImage(:, :, 2)); % saturation channel 
    V(i) = mean2(hsvImage(:, :, 3)); % value channel 

    % Save the image name 
    imageNames{i} = allFiles(i).name; 
end 
%% 
% Create a bar graph of the RGB values 
%rgbData = [R, G, B]; 
%h = bar(rgbData); 
%xlabel('Image Number') 
%ylabel('RGB Value (0-255)') 

% Set the colors of the bars and add a legend 
%h(1).FaceColor = [1 0 0]; % Red
%h(2).FaceColor = [0 1 0]; % Green 
%h(3).FaceColor = [0 0 1]; % Blue 
%legend({'Red', 'Green', 'Blue'}, 'Location', 'northwest') 

% Remove the image names from the x-axis 
%set(gca, 'XTickLabel', {}) 
%% 
% Save the RGB-HSV data to an Excel file 
valueTable = table(imageNames, R, G, B, H, S, V, 'VariableNames', {'Image', 'Red', 'Green' ... 
'Blue', 'Hue', 'Saturation', 'Value'}); 
writetable(valueTable, fullfile(folder, 'RGB_HSV_Values.xlsx'), 'FileType', 'spreadsheet'); 
disp('RGB and HSV values extracted and saved successfully!'); 
end 

%% 
function Fuzzy_logic(resultsMatrix) % Uses Fuzzy Logic on the Inputs 
% Construct FIS 
Fuzzy_Finale2 = mamfis(Name="Fuzzy_Finale2"); 
% Input 1 
Fuzzy_Finale2 = addInput(Fuzzy_Finale2,[40 100],Name="Moisture Content"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Moisture Content","trapmf",[0 40 75 90], ... 
Name="Low",VariableType="input"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Moisture Content","trimf",[75 90 94], ... 
Name="Average",VariableType="input"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Moisture Content","trapmf",[90 94 100 125],

Name = "High",VariableType="input"); 
% Input 2 
Fuzzy_Finale2 = addInput(Fuzzy_Finale2,[0.1 0.4],Name="Chlorophyll-A"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Chlorophyll-A","trapmf",[0 0.09 0.17 0.24], Name

Name = "Low",VariableType="input"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Chlorophyll-A","trimf",[0.17 0.24 0.368], ... 
Name="Moderate",VariableType="input"); 

Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Chlorophyll-A","trapmf",[0.24 0.368 0.4, 0.45], ... 
Name="High",VariableType="input"); 
% Input 3 
Fuzzy_Finale2 = addInput(Fuzzy_Finale2,[100 950],Name="Fresh Head Weight"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Fresh Head Weight","trapmf",[0 100 175, 200], ... 
Name="Low",VariableType="input"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Fresh Head Weight","trimf",[150 200 450], ... 
Name="Average",VariableType="input"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Fresh Head Weight","trapmf",[200 450 950, 1000], ... 
Name="High",VariableType="input"); 
% Output 1 
Fuzzy_Finale2 = addOutput(Fuzzy_Finale2,[0 100],Name="Grading Level"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Grading Level","gaussmf",[17.69 4.441e-16], ...
...
Name="L3",VariableType="output"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Grading Level","gaussmf",[17.69 50], ... 
    Name="L2",VariableType="output"); 
Fuzzy_Finale2 = addMF(Fuzzy_Finale2,"Grading Level","gaussmf",[17.69 100], ... 
    Name="L1",VariableType="output"); 
% Rules 
Fuzzy_Finale2 = addRule(Fuzzy_Finale2,[1 1 1 1 1 1; ... 
    1 1 2 1 1 1; ... 
    1 1 3 1 1 1; ... 
    2 1 1 1 1 1; ... 
    2 1 2 2 1 1; ... 
    2 1 3 2 1 1; ... 
    3 1 1 1 1 1; ... 
    3 1 2 2 1 1; ... 
    3 1 3 2 1 1; ... 
    1 2 1 1 1 1; ... 
    1 2 2 2 1 1; ... 
    1 2 3 2 1 1; ... 
    2 2 1 2 1 1; ... 
    2 2 2 3 1 1; ... 
    2 2 3 3 1 1; ... 
    3 2 1 2 1 1; ...
    3 2 2 3 1 1; ... 
    3 2 3 3 1 1; ... 
    1 3 1 1 1 1; ... 
    1 3 2 3 1 1; ... 
    1 3 3 3 1 1; ... 
    2 3 1 3 1 1; ... 
    2 3 2 3 1 1; ... 
    2 3 3 3 1 1; ... 
    3 3 1 3 1 1; ... 
    3 3 2 3 1 1; ... 
    3 3 3 2 1 1]);

% Loop through each row of the resultsMatrix 
for i = 1:size(resultsMatrix, 1) 
    sample1 = resultsMatrix(i, :);  % Get the required row of the matrix 
 
    % Input values are rows from matrix 
    inputValues = sample1;  % [Moisture Chlorophyll Weight] 
    output = evalfis(Fuzzy_Finale2, inputValues); 

    varName = sprintf('output%d', i); 
    assignin('base', varName, output); % Assigns var to the workspace 

    % Display the output 
    if output <= 33.33
        disp('Grade: L3'); 
    elseif (output > 33.33) && (output <= 66.67) 
        disp('Grade: L2'); 
    elseif output > 66.6 
        disp('Grade: L1');
    end 
end 
end 
%%

 %% Opening conveyor 
while true 
    clear; 
    a = arduino('COM3', 'Mega2560', 'Libraries', {'Servo', 'Ultrasonic'}); 
    % Pins for the ultrasonic sensor 
    TrigPin = 'D2';  % Trigger pin connected to digital pin 2 
    EchoPin = 'D3';  % Echo pin connected to digital pin 3 
    RelayConveyorPin = 'D4'; % Relay pin connected to digital pin 4 
    %RelayReleasePin = 'D5'; % Relay pin connected to digital pin 4    
 
     
    % initializes all servos 
    s1 = servo(a, 'D8', 'MinPulseDuration', 700e-6, 'MaxPulseDuration', 2300e-6); 
    s2 = servo(a, 'D9', 'MinPulseDuration', 700e-6, 'MaxPulseDuration', 2300e-6); 
    s3 = servo(a, 'D10', 'MinPulseDuration', 700e-6, 'MaxPulseDuration', 2300e-6); 
    writePosition(s1, 0); 
    writePosition(s2, 1); 
    writePosition(s3, 0); 
     
     
    clear sensor; % clears sensor in case it's already used 
     
    % Creates pin for UTS 
    sensor = ultrasonic(a, TrigPin, EchoPin); 
    configurePin(a, RelayConveyorPin, 'DigitalOutput'); 
     
    % Continuously monitors the ultrasonic sensor for object detection 
    while true 
     
        distance = readDistance(sensor);  % Measure distance in cm 
         
        % Displays the measured distance (for troubleshoot) 
        fprintf('Distance: %.2f cm\n', distance*100); 
         
        % Checks for objects 
        if distance*100 <= 29 % Object detected within 29 cm 
            disp('Object Detected!'); 
            writeDigitalPin(a, RelayConveyorPin, 0);  % Relay ON (activates the device) 
            disp('Relay is on!'); 
            break; 
        else 
            disp('No Object Detected'); 

      writeDigitalPin(a, RelayConveyorPin, 1); % Relay OFF (deacts) 
            disp('Relay is off'); 
        end 
         
        % Pauses before the next measurement 
          pause(0.05); 
    end 
%% 
% Create Arduino 
 
%% Picture-taking 
% Takes screenshot of the lettuces 
    Comp_vis(); 
     
%% Extraction 
% Calls the extraction function 
    RGBHSV_extract(); 
 
 % Folder Path  
    folderPath = ''; 
 
 % Define file name and sheet name 
    filename = 'RGB_HSV_Values.xlsx'; 
    sheetname = 'Sheet1'; 
 
 % File Path 
    filePath = fullfile(folderPath, filename); 
 
 % Read data from the specified worksheet 
    data = readtable(filePath, 'Sheet', sheetname); 
 
 % Extract variables from the table 
    x1 = data.Red;  % Red 
    x2 = data.Green;  % Green 
    x3 = data.Blue;  % Blue 
    x4 = data.Hue;  % Hue 
    x5 = data.Saturation;  % Saturation 
    x6 = data.Value;  % Value 
 
%% Moisture Content 
resultMoist = (0.408*x1 + 0.0193*x2 - 18.2*x4 - 18.2*x6 - 1.78*sin((cos(x2) + 8.49).^2) + 3.26*cos(x3 - 1.0*log((x2 - 1.0*cos(x2)).^2).^2) + 1.83*cos(x2 - 4.6*x1) - 1.92*cos(x2 + 7.0*x1.*sin(x5)) - 1.3*cos(49.0*x1.*x6.*sin(sin(x5))) + 7.05*cos(x3 - 1.0*log((cos(x2) + 8.49).^2).^2) + log(x2.^7.23e-6) + 11.0*cos(cos(x2 + 7.0*x1.*sin(x5))) + 42.6*cos(x2) - 371.0*x1.*sin(sin(x5)) + 0.634*x2.*cos(x3 - 1.0*log((cos(x2) + 8.49).^2).^2) - 0.703*x3.*cos(x3 - 1.0*log((cos(x2) + 8.49).^2).^2) - 0.0248*x3.*cos(x3 - 1.0*sin(x5)) - 20.0*log((cos(x2) + 8.49).^2).^2 + 368.0*x1.*sin(x5) - 0.0361*x2.*x6.*sin(x2) - 8.76e-4*x2.*x3.*x5.*sin(x1 + cos(x2) - 7.0*x1.^2.*x6.*sin(x5) + 8.49) - 5.06e-5*x1.*x3.*x4.*x6 - 1.02*x1.*x5.*sin(x1 + x3 + 2.32).*sin(x5) + 434.0); 
%% Chlorophyll-A 
resultChla = (0.0176 * x3 - 0.0252 * x1 + 0.0176 * x4 + 6.45 * x5 + 0.0138 * sin(x2.^(1/2) .* x4.^(1/2) .* (x1 + x4 + x5.^2).^(1/4)) - 33.1 * cos(x1.^(1/2)) - 0.125 * cos(x3.^(1/2)) - 0.0177 * cos(cos(x3)) + 0.00851 * sin(x1.^(5/4) .* cos(cos(x2)).^(1/2)) + 0.0051 * sin(x1.^(1/2) .* x2 .* x4 .* abs(x4)) - 0.00666 * sin(3.0 * x3 .* x4 .* x5) - 6.11 * cos(cos(x1.^(1/2))) + 0.0215 * cos(x3 .* x4 .* x5 - 1.19) - 66.6 * cos(cos(x1.^(1/2)).^(1/2)) + 0.0441 * cos(cos(x2)).^(1/4) + 0.141 * x1.^(1/2) - 2.32 * x4.^(1/2) - 34.4 * x5.^2 + 344.0 * x5.^4 + 0.0165 * x1.^(1/2) .* x4.^(1/2) .* (x1 + x4 + x5.^2).^(1/4) + 0.00114 * x1.^(1/2) .* x4.^(1/2) .* cos(x3) + 72.9); 

%% Weight 
resultWeight = (2190.0 .* x4 - 210.0 .* x3 - 9480.0 .* x6 - 28.1 .* sin(abs(x3 .* x6)) + 1570.0 .* sin(sin(x3 .* x5)) - 3940.0 .* cos(sqrt(x5)) - 613.0 .* sin(sin(x3)) + 1970.0 .* cos(2.0 .* x5) - 35.0 .* sin(sin(31.3 .* abs(x1))) - 219.0 .* sin(sin(31.3 .* abs(x6))) - 1660.0 .* sin(sin(sin(x3 .* x5))) - 8680.0 .* sin(sin(sqrt(x5))) + 19.7 .* sin(x1 + x4 + x5 + 2.0 .* sin(x3)) - 3940.0 .* abs(x5) + 3000.0 .* cos(x5) + 674.0 .* sin(x3) + 5.91e4 .* sin(x6)- 20.5 .* sin(cos(8.16 .* x2)) - 8.53e4 .* (x1 + x3 + sin(x3)).^(1/4) + 3.72e4 .* (x1 + x4 + sin(x3)).^(1/4) + 1270.0 .* sqrt(x2) + 9480.0 .* sqrt(x3) + 9.76e4);

%% Switch to release 
% Creates a matrix 
resultsMatrix = [resultMoist, resultChla, resultWeight]; 
disp(resultsMatrix); 
Fuzzy_logic(resultsMatrix); 


%% Movement of actuators 
% Restarting the conveyor staggered 
% for debugging 
% a = arduino('COM3', 'Mega2560', 'Libraries', {'Servo', 'Ultrasonic'});   
 

%% Output 5 
if (output5 > 33.33) && (output5 <= 66.67) && (output5 ~= 50)% For Level 2  
    % Returns to Original Pos 
    writePosition(s1, 0.25); 
    current_Pos1 = readPosition(s1); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(3.5); 
    writeDigitalPin(a, RelayConveyorPin, 0); 
    current_Pos1 = current_Pos1*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
    % Stops the lettuce 
    writePosition(s1, 0.25); 
    current_Pos1 = readPosition(s1);
    current_Pos1 = current_Pos1*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
    pause(1); 
    % Returns to original pos 
    writePosition(s1, 0); 
    current_Pos1 = readPosition(s1)*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
elseif output5 <= 33% for level 3 
% Returns to original pos 
    writePosition(s2, 0.75); 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(3.5); 
    writeDigitalPin(a, RelayConveyorPin, 0); 
% Stops the lettuce 
    writePosition(s2, 0.75); 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    pause(2); 
% Returns to original pos 
    writePosition(s2, 1); 
elseif output5 > 66 % for level 1 
% Returns to orig pos 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3); 
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(3.5); 
    writeDigitalPin(a, RelayConveyorPin, 0); 
% Stops the lettuce 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3);
    current_Pos1 = current_Pos1*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
    pause(1); 
    % Returns to original pos 
    writePosition(s1, 0); 
    current_Pos1 = readPosition(s1)*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
elseif output5 <= 33% for level 3 
% Returns to original pos 
    writePosition(s2, 0.75); 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(3.5); 
    writeDigitalPin(a, RelayConveyorPin, 0); 

% Stops the lettuce 
    writePosition(s2, 0.75); 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    pause(2); 

% Returns to original pos 
    writePosition(s2, 1);      
elseif output5 > 66 % for level 1 
% Returns to orig pos 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3); 
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(3.5); 
    writeDigitalPin(a, RelayConveyorPin, 0); 

% Stops the lettuce 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3);
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    pause(3.5); 

% Returns to orig pos 
    writePosition(s3, 0); 
    current_Pos3 = readPosition(s3)*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3);
    elseif output5 == 50 % for unidentified 
% Returns to original pos 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(3.5); 
    writeDigitalPin(a, RelayConveyorPin, 0);
% Stops the lettuce 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    pause(5);
% Returns to original pos 
    writePosition(s2, 1);
end
pause(1); 
%% Output 4 
if (output4 > 33.33) && (output4 <= 66.67) && (output4 ~= 50)% For Level 2  
        % Returns to Original Pos 
        writePosition(s1, 0.25); 
        current_Pos1 = readPosition(s1); 
        writeDigitalPin(a, RelayConveyorPin, 1); 
        pause(1.9); 
        writeDigitalPin(a, RelayConveyorPin, 0); 
        current_Pos1 = current_Pos1*180; 
          fprintf('Current motor position is %d degrees\n', current_Pos1); 
             
        % Stops the lettuce 
            writePosition(s1, 0.25); 
            current_Pos1 = readPosition(s1); 
            current_Pos1 = current_Pos1*180; 
            fprintf('Current motor position is %d degrees\n', current_Pos1); 
            pause(1); 
 
        % Returns to original pos 
            writePosition(s1, 0); 
            current_Pos1 = readPosition(s1)*180; 
            fprintf('Current motor position is %d degrees\n', current_Pos1); 
elseif output4 <= 33 % for level 3 
    % Returns to original pos 
        writePosition(s2, 0.75); 
        current_Pos2 = readPosition(s2); 
        current_Pos2 = current_Pos2*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos2); 
        writeDigitalPin(a, RelayConveyorPin, 1); 
        pause(1.9); 
        writeDigitalPin(a, RelayConveyorPin, 0); 
    % Stops the lettuce 
        writePosition(s2, 0.75); 
        current_Pos2 = readPosition(s2); 
        current_Pos2 = current_Pos2*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos2); 
        pause(2); 
    % Returns to original pos 
        writePosition(s2, 1); 
   elseif output4 > 66 % for level 1 
    % Returns to orig pos 
        writePosition(s3, 0.28); 
        current_Pos3 = readPosition(s3); 
        current_Pos3 = current_Pos3*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos3); 
        writeDigitalPin(a, RelayConveyorPin, 1); 
        pause(1.9); 
        writeDigitalPin(a, RelayConveyorPin, 0);
    % Stops the lettuce 
        writePosition(s3, 0.28); 
        current_Pos3 = readPosition(s3); 
        current_Pos3 = current_Pos3*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos3); 
        pause(3.5); 

    % Returns to orig pos 
        writePosition(s3, 0); 
        current_Pos3 = readPosition(s3)*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos3); 

elseif output4 == 50 % for unidentified 
    % Returns to original pos 

        current_Pos2 = readPosition(s2); 
        current_Pos2 = current_Pos2*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos2); 
        writeDigitalPin(a, RelayConveyorPin, 1); 
        pause(1.9); 
        writeDigitalPin(a, RelayConveyorPin, 0); 

    % Stops the lettuce 

        current_Pos2 = readPosition(s2); 
        current_Pos2 = current_Pos2*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos2); 
        pause(5); 

    % Returns to original pos 
        writePosition(s2, 1); 

  
end 
pause(1); 
%% Output 3 
if (output3 > 33.33) && (output3 <= 66.67) && (output3 ~= 50)% For Level 2  
% Returns to Original Pos 
writePosition(s1, 0.25); 
 current_Pos1 = readPosition(s1); 
        writeDigitalPin(a, RelayConveyorPin, 1); 
        pause(1.9); 
        writeDigitalPin(a, RelayConveyorPin, 0); 
        current_Pos1 = current_Pos1*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos1); 
         
    % Stops the lettuce 
        writePosition(s1, 0.25); 
        current_Pos1 = readPosition(s1); 
        current_Pos1 = current_Pos1*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos1); 
        pause(1); 
    % Returns to original pos 
        writePosition(s1, 0); 
        current_Pos1 = readPosition(s1)*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos1); 

elseif output3 <= 33 % for level 3 
    % Returns to original pos 
        writePosition(s2, 0.75); 
        current_Pos2 = readPosition(s2); 
        current_Pos2 = current_Pos2*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos2); 
        writeDigitalPin(a, RelayConveyorPin, 1); 
        pause(1.9); 
        writeDigitalPin(a, RelayConveyorPin, 0);
    % Stops the lettuce 
        writePosition(s2, 0.75); 
        current_Pos2 = readPosition(s2); 
        current_Pos2 = current_Pos2*180; 
        fprintf('Current motor position is %d degrees\n', current_Pos2); 
        pause(2); 

    % Returns to original pos 
        writePosition(s2, 1); 

elseif  output3 > 66 %output3 == 50 for level 1 
% Returns to orig pos 
writePosition(s3, 0.28); 
current_Pos3 = readPosition(s3); 
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(1.9); 
    writeDigitalPin(a, RelayConveyorPin, 0); 

% Stops the lettuce 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3); 
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    pause(3.5); 

% Returns to orig pos 
    writePosition(s3, 0); 
    current_Pos3 = readPosition(s3)*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 

elseif output3 == 50 % for unidentified 
% Returns to original pos 
    
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(1.9); 
    writeDigitalPin(a, RelayConveyorPin, 0); 
% Stops the lettuce 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    pause(4); 
% Returns to original pos 
    writePosition(s2, 1); 
end 

pause(1); 
%% Output 2
if (output2 > 33.33) && (output2 <= 66.67) && (output2 ~= 50)% For Level 2  
    % Returns to Original Pos 
    writePosition(s1, 0.25); 
    current_Pos1 = readPosition(s1); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(1.9); 
    writeDigitalPin(a, RelayConveyorPin, 0); 
    current_Pos1 = current_Pos1*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
     
% Stops the lettuce 
    writePosition(s1, 0.25); 
    current_Pos1 = readPosition(s1); 
    current_Pos1 = current_Pos1*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 
    pause(1); 

% Returns to original pos 
    writePosition(s1, 0); 
    current_Pos1 = readPosition(s1)*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos1); 

elseif output2 <= 33 % for level 3 
% Returns to original pos 
    writePosition(s2, 0.75); 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(1.9); 
    writeDigitalPin(a, RelayConveyorPin, 0); 

% Stops the lettuce 
    writePosition(s2, 0.75); 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    pause(2); 
% Returns to original pos 
    writePosition(s2, 1);
  elseif output2 > 66 % for level 1 
% Returns to orig pos 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3); 
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(1.9); 
    writeDigitalPin(a, RelayConveyorPin, 0); 

% Stops the lettuce 
    writePosition(s3, 0.28); 
    current_Pos3 = readPosition(s3); 
    current_Pos3 = current_Pos3*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 
    pause(3.5); 

% Returns to orig pos 
    writePosition(s3, 0); 
    current_Pos3 = readPosition(s3)*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos3); 

elseif output2 == 50 % for unidentified 
% Returns to original pos 

    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    writeDigitalPin(a, RelayConveyorPin, 1); 
    pause(1.9); 
    writeDigitalPin(a, RelayConveyorPin, 0); 

% Stops the lettuce 
    current_Pos2 = readPosition(s2); 
    current_Pos2 = current_Pos2*180; 
    fprintf('Current motor position is %d degrees\n', current_Pos2); 
    pause(5); 
% Returns to original pos 
    writePosition(s2, 1);
end 
pause(1); 
%% Output 1 
if (output1 > 33.33) && (output1 <= 66.67) && (output1 ~= 50)  % For Level 2  
% Returns to Original Pos 
writePosition(s1, 0.25); 
current_Pos1 = readPosition(s1); 
writeDigitalPin(a, RelayConveyorPin, 1); 
pause(3); 
writeDigitalPin(a, RelayConveyorPin, 0); 
current_Pos1 = current_Pos1*180; 
fprintf('Current motor position is %d degrees\n', current_Pos1); 
% Stops the lettuce 
writePosition(s1, 0.25); 
current_Pos1 = readPosition(s1); 
current_Pos1 = current_Pos1*180; 
fprintf('Current motor position is %d degrees\n', current_Pos1); 
pause(1); 
% Returns to original pos 
writePosition(s1, 0); 
current_Pos1 = readPosition(s1)*180; 
fprintf('Current motor position is %d degrees\n', current_Pos1); 
elseif output1 <= 33 % for level 3 
% Returns to original pos 
writePosition(s2, 0.75); 
current_Pos2 = readPosition(s2); 
current_Pos2 = current_Pos2*180; 
fprintf('Current motor position is %d degrees\n', current_Pos2); 
writeDigitalPin(a, RelayConveyorPin, 1); 
pause(3); 
writeDigitalPin(a, RelayConveyorPin, 0); 
% Stops the lettuce 
writePosition(s2, 0.75); 
current_Pos2 = readPosition(s2); 
current_Pos2 = current_Pos2*180; 
  fprintf('Current motor position is %d degrees\n', current_Pos2); 
                pause(2); 
     
            % Returns to original pos 
                writePosition(s2, 1); 
     
        elseif output1 > 66 % for level 1 
            % Returns to orig pos 
                writePosition(s3, 0.28); 
                current_Pos3 = readPosition(s3); 
                current_Pos3 = current_Pos3*180; 
                fprintf('Current motor position is %d degrees\n', current_Pos3); 
                writeDigitalPin(a, RelayConveyorPin, 1); 
                pause(3); 
                writeDigitalPin(a, RelayConveyorPin, 0); 
     
            % Stops the lettuce 
                writePosition(s3, 0.28); 
                current_Pos3 = readPosition(s3); 
                current_Pos3 = current_Pos3*180; 
                fprintf('Current motor position is %d degrees\n', current_Pos3); 
                pause(3.5); 
     
            % Returns to orig pos 
                writePosition(s3, 0); 
                current_Pos3 = readPosition(s3)*180; 
                fprintf('Current motor position is %d degrees\n', current_Pos3); 
     
     
        elseif output1 == 50 % for unidentified 
            % Returns to original pos
                current_Pos2 = readPosition(s2); 
                current_Pos2 = current_Pos2*180; 
                fprintf('Current motor position is %d degrees\n', current_Pos2); 
                writeDigitalPin(a, RelayConveyorPin, 1); 
                pause(3); 
                writeDigitalPin(a, RelayConveyorPin, 0);
            % Stops the lettuce 
                current_Pos2 = readPosition(s2);
                current_Pos2 = current_Pos2*180; 
fprintf('Current motor position is %d degrees\n', current_Pos2); 
pause(2); 
% Returns to original pos 
writePosition(s2, 1); 
end 
writeDigitalPin(a, RelayConveyorPin, 1); % Starts conveyor again 
end 

