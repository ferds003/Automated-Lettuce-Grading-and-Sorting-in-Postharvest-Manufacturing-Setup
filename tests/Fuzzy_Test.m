%%
function Comp_vis() % Opening and shutting camera
% Selects folder
folderPath = 'C:\Users\RAF Solutions\Documents\Romell\Thesis\MATLAB\Fuzzy\Lettuce_Image';

% Creates if does not exist
if ~isfolder(folderPath)
    mkdir(folderPath);
end

% Initializes cameras
cam1 = webcam(5);
pause(2); % Gives time for the cameras to stabilize
cam2 = webcam(1);
pause(3);
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
clear cam5;

% Define file names for each image
fileName1 = fullfile(folderPath, '1.jpg');  % You can change the extension to .png, .bmp, etc.
fileName2 = fullfile(folderPath, '2.jpg');
fileName3 = fullfile(folderPath, '3.jpg');
fileName4 = fullfile(folderPath, '4.jpg');
fileName5 = fullfile(folderPath, '5.jpg');

% Save images to the specified folder
imwrite(img1, fileName1);
imwrite(img2, fileName2);
imwrite(img3, fileName3);
imwrite(img4, fileName4);
imwrite(img5, fileName5);

end

%%
function RGBHSV_extract() % Extraction of RGB and HSV values
    %%
    % Folder for augmented images
    folder = 'C:\Users\RAF Solutions\Documents\Romell\Thesis\MATLAB\Fuzzy\Lettuce_Image';

    % Check if the folder exists
    if ~isfolder(folder)
        error('The specified folder does not exist: %s', folder);
    end

    %%
    % Get all JPG and PNG image files
    jpgFiles = dir(fullfile(folder, '*.jpg'));
    pngFiles = dir(fullfile(folder, '*.png'));
    allFiles = [jpgFiles; pngFiles]; % Combine both lists

    % Check if images exist
    if isempty(allFiles)
        error('No JPG or PNG files found in the specified folder.');
    end

    %%
    % Preallocate arrays for RGB values and image names
    numImages = numel(allFiles);
    R = zeros(numImages, 1);
    G = zeros(numImages, 1);
    B = zeros(numImages, 1);

    H = zeros(numImages, 1);
    S = zeros(numImages, 1);
    V = zeros(numImages, 1);

    imageNames = cell(numImages, 1);

    %%
    % Loop through each image file and extract RGB values
    for i = 1:numImages
        % Load the image
        filename = fullfile(folder, allFiles(i).name);
        image = imread(filename);
    
        % Convert to double for accurate calculations
        dImage = double(image);

        % Extract the average RGB values
        R(i) = mean(dImage(:, :, 1), 'all'); % Red channel
        G(i) = mean(dImage(:, :, 2), 'all'); % Green channel
        B(i) = mean(dImage(:, :, 3), 'all'); % Blue channel
    
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
    % Mamdani FIS
    fis = mamfis('Name', 'MamdaniExample');

    % Inputs
    fis = addInput(fis, [60 100], 'Name', 'Moisture');
    fis = addMF(fis, 'Moisture', 'trimf', [60 75 90], 'Name', 'Low');
    fis = addMF(fis, 'Moisture', 'trimf', [75 90 94], 'Name', 'Medium');
    fis = addMF(fis, 'Moisture', 'trimf', [90 94 100], 'Name', 'High');

    fis = addInput(fis, [0.1 0.4], 'Name', 'Chlorophyll');
    fis = addMF(fis, 'Chlorophyll', 'trimf', [0.1 0.17 0.241], 'Name', 'Low');
    fis = addMF(fis, 'Chlorophyll', 'trimf', [0.17 0.241 0.368], 'Name', 'Medium');
    fis = addMF(fis, 'Chlorophyll', 'trimf', [0.24 0.368 0.4], 'Name', 'High');

    fis = addInput(fis, [100 905], 'Name', 'Weight');
    fis = addMF(fis, 'Weight', 'trimf', [100 150 200], 'Name', 'Low');
    fis = addMF(fis, 'Weight', 'trimf', [150 200 450], 'Name', 'Medium');
    fis = addMF(fis, 'Weight', 'trimf', [200 450 905], 'Name', 'High');

    % Output and Membership Functions
    fis = addOutput(fis, [0 100], 'Name', 'Grade');
    fis = addMF(fis, 'Grade', 'trimf', [0 25 50], 'Name', 'Low');
    fis = addMF(fis, 'Grade', 'trimf', [25 50 75], 'Name', 'Medium');
    fis = addMF(fis, 'Grade', 'trimf', [50 75 100], 'Name', 'High');

    % Rules
    ruleList = [
        1 1 1 1 1 1;  % Moisture Low, Chlorophyll Low, Weight Low -> Grade Low
        1 1 2 1 1 1;  % Moisture Low, Chlorophyll Low, Weight Medium -> Grade Low
        1 1 3 1 1 1;  % Moisture Low, Chlorophyll Low, Weight High -> Grade Low
        2 1 1 1 1 1;  % Moisture Medium, Chlorophyll Low, Weight Low -> Grade Low
        2 1 2 2 1 1;  % Moisture Medium, Chlorophyll Low, Weight Medium -> Grade Medium
        2 1 3 2 1 1;  % Moisture Medium, Chlorophyll Low, Weight High -> Grade High
        3 1 1 1 1 1;  % Moisture High, Chlorophyll Low, Weight Low -> Grade Low
        3 1 2 2 1 1;  % Moisture High, Chlorophyll Low, Weight Medium -> Grade Medium
        3 1 3 2 1 1;  % Moisture High, Chlorophyll Low, Weight High -> Grade Medium
        1 2 1 1 1 1;  % Moisture Low, Chlorophyll Medium, Weight Low -> Grade Low
        1 2 2 2 1 1;  % Moisture Low, Chlorophyll Medium, Weight Medium -> Grade Medium
        1 2 3 2 1 1;  % Moisture Low, Chlorophyll Medium, Weight High -> Grade High
        2 2 1 2 1 1;  % Moisture Medium, Chlorophyll Medium, Weight Low -> Grade Low
        2 2 2 3 1 1;  % Moisture Medium, Chlorophyll Medium, Weight Medium -> Grade Medium
        2 2 3 3 1 1;  % Moisture Medium, Chlorophyll Medium, Weight High -> Grade High
        3 2 1 2 1 1;  % Moisture High, Chlorophyll Medium, Weight Low -> Grade Low
        3 2 2 3 1 1;  % Moisture High, Chlorophyll Medium, Weight Medium -> Grade Medium
        3 2 3 3 1 1;  % Moisture High, Chlorophyll Medium, Weight High -> Grade High
        1 3 1 1 1 1;  % Moisture Low, Chlorophyll High, Weight Low -> Grade Low
        1 3 2 3 1 1;  % Moisture Low, Chlorophyll High, Weight Medium -> Grade Medium
        1 3 3 3 1 1;  % Moisture Low, Chlorophyll High, Weight High -> Grade High
        2 3 1 3 1 1;  % Moisture Medium, Chlorophyll High, Weight Low -> Grade Low
        2 3 2 3 1 1;  % Moisture Medium, Chlorophyll High, Weight Medium -> Grade Medium
        2 3 3 3 1 1;  % Moisture Medium, Chlorophyll High, Weight High -> Grade High
        3 3 1 3 1 1;  % Moisture High, Chlorophyll High, Weight Low -> Grade Low
        3 3 2 3 1 1;  % Moisture High, Chlorophyll High, Weight Medium -> Grade Medium
        3 3 3 3 1 1;  % Moisture High, Chlorophyll High, Weight High -> Grade High
    ];


    % Add rules to the FIS
    fis = addRule(fis, ruleList);

   % Loop through each row of the resultsMatrix
    for i = 1:size(resultsMatrix, 1)
        sample1 = resultsMatrix(i, :);  % Get the ith row of the matrix
    
        % Input values are rows from matrix
        inputValues = sample1;  % [Moisture Chlorophyll Weight]
        output = evalfis(fis, inputValues);

        varName = sprintf('output%d', i);
        assignin('base', varName, output);

        % Display the output
        if output < 33.33
            disp('Grade: L3');

        elseif (output > 33.33) && (output < 66.67)
            disp('Grade: L2');

        elseif output > 66.6
            disp('Grade: L1');

        end
    end
end

%%
function arduiServo(output5)

    if output5 >= 50
    clear a s;
    a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');
    s = servo(a, 'D2', 'MinPulseDuration', 700e-6, 'MaxPulseDuration', 2300e-6);

    % Returns to 0
        writePosition(s, 0.4);
        current_Pos = readPosition(s);
        current_Pos = current_Pos*180;
        fprintf('Current motor position is %d degrees\n', current_Pos);
        pause(2);

    % Positions the servo to 45 degrees
        writePosition(s, 0.75);
        current_Pos = readPosition(s);
        current_Pos = current_Pos*180;
        fprintf('Current motor position is %d degrees\n', current_Pos);
        pause(2);

    % Returns to 0
        writePosition(s, 0.4);
        pause(2);

    clear a s current_Pos;
    end
end

%% Picture-taking
% Takes screenshot of the lettuces
    Comp_vis();
    
%% Extraction
% Calls the extraction function
    RGBHSV_extract();

 % Folder Path 
    folderPath = 'C:\Users\RAF Solutions\Documents\Romell\Thesis\MATLAB\Fuzzy\Lettuce_Image';

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

%% Moisture

 % Compute - model 3237 50G50R
    resultMoist = (...
        0.408*x1 + 0.0193*x2 - 18.2*x4 - 18.2*x6 ...
        - 1.78*sin((cos(x2) + 8.49).^2) + 3.26*cos(x3 - 1.0*log((x2 - 1.0*cos(x2)).^2).^2) ...
        + 1.83*cos(x2 - 4.6*x1) - 1.92*cos(x2 + 7.0*x1.*sin(x5)) ...
        - 1.3*cos(49.0*x1.*x6.*sin(sin(x5))) + 7.05*cos(x3 - 1.0*log((cos(x2) + 8.49).^2).^2) ...
        + log(x2.^7.23e-6) + 11.0*cos(cos(x2 + 7.0*x1.*sin(x5))) + 42.6*cos(x2) ...
        - 371.0*x1.*sin(sin(x5)) + 0.634*x2.*cos(x3 - 1.0*log((cos(x2) + 8.49).^2).^2) ...
        - 0.703*x3.*cos(x3 - 1.0*log((cos(x2) + 8.49).^2).^2) ...
        - 0.0248*x3.*cos(x3 - 1.0*sin(x5)) - 20.0*log((cos(x2) + 8.49).^2).^2 ...
        + 368.0*x1.*sin(x5) - 0.0361*x2.*x6.*sin(x2) ...
        - 8.76e-4*x2.*x3.*x5.*sin(x1 + cos(x2) - 7.0*x1.^2.*x6.*sin(x5) + 8.49) ...
        - 5.06e-5*x1.*x3.*x4.*x6 - 1.02*x1.*x5.*sin(x1 + x3 + 2.32).*sin(x5) ...
        + 434.0 ...
    );

%% Chlorophyll-A

    resultChla = (...
        0.0176 * x3 - 0.0252 * x1 + 0.0176 * x4 + 6.45 * x5 ...
        + 0.0138 * sin(x2.^(1/2) .* x4.^(1/2) .* (x1 + x4 + x5.^2).^(1/4)) ...
        - 33.1 * cos(x1.^(1/2)) - 0.125 * cos(x3.^(1/2)) ...
        - 0.0177 * cos(cos(x3)) ...
        + 0.00851 * sin(x1.^(5/4) .* cos(cos(x2)).^(1/2)) ...
        + 0.0051 * sin(x1.^(1/2) .* x2 .* x4 .* abs(x4)) ...
        - 0.00666 * sin(3.0 * x3 .* x4 .* x5) ...
        - 6.11 * cos(cos(x1.^(1/2))) ...
        + 0.0215 * cos(x3 .* x4 .* x5 - 1.19) ...
        - 66.6 * cos(cos(x1.^(1/2)).^(1/2)) ...
        + 0.0441 * cos(cos(x2)).^(1/4) ...
        + 0.141 * x1.^(1/2) - 2.32 * x4.^(1/2) - 34.4 * x5.^2 + 344.0 * x5.^4 ...
        + 0.0165 * x1.^(1/2) .* x4.^(1/2) .* (x1 + x4 + x5.^2).^(1/4) ...
        + 0.00114 * x1.^(1/2) .* x4.^(1/2) .* cos(x3) + 72.9 ...
    );
%% Weight
 
 % Compute the expression - model id 917    50G50R
    resultWeight = (...
        2190.0 .* x4 - 210.0 .* x3 - 9480.0 .* x6 ...
        - 28.1 .* sin(abs(x3 .* x6)) + 1570.0 .* sin(sin(x3 .* x5)) ...
        - 3940.0 .* cos(sqrt(x5)) - 613.0 .* sin(sin(x3)) ...
        + 1970.0 .* cos(2.0 .* x5) - 35.0 .* sin(sin(31.3 .* abs(x1))) ...
        - 219.0 .* sin(sin(31.3 .* abs(x6))) ...
        - 1660.0 .* sin(sin(sin(x3 .* x5))) ...
        - 8680.0 .* sin(sin(sqrt(x5))) ...
        + 19.7 .* sin(x1 + x4 + x5 + 2.0 .* sin(x3)) ...
        - 3940.0 .* abs(x5) + 3000.0 .* cos(x5) ...
        + 674.0 .* sin(x3) + 5.91e4 .* sin(x6) ...
        - 20.5 .* sin(cos(8.16 .* x2)) ...
        - 8.53e4 .* (x1 + x3 + sin(x3)).^(1/4) ...
        + 3.72e4 .* (x1 + x4 + sin(x3)).^(1/4) ...
        + 1270.0 .* sqrt(x2) + 9480.0 .* sqrt(x3) ...
        + 9.76e4 ...
    );

 % Creates a matrix
    resultsMatrix = [resultMoist, resultChla, resultWeight];
    disp(resultsMatrix);
    Fuzzy_logic(resultsMatrix);
    %arduiServo(output5);