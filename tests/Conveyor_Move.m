% initialize arduino
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');
s = servo(a, 'D2', 'MinPulseDuration', 700e-6, 'MaxPulseDuration', 2300e-6);
% pins
relayPin = 'D7'; 
%sensorPin = 'D2'; % VCC = Brown, Signal = Black, GND = Blue

%configurePin(a, sensorPin, 'DigitalInput'); % makes D2 digital (0/1)

%% Testing
    while true
        command = input('1 to start, 2 to stop, q to exit: ', 's');

        if command == '1'
            writePosition(s, 0.25);
            %writeDigitalpin(a, relayPin, 1);
            disp('Conveyor is on');

        elseif command == '2' 
            writePosition(s, 0.5);
            %writeDigitalpin(a, relayPin, 0);
            disp('Conveyor is off');

        elseif command == 'q'
            disp('Exit conveyor');
            break;

        else
            disp('Invalid command.');

        end
    end

%%
% main loop
function conveyorSensor()
    % input to control conveyor
    sensorValue = readDigitalPin(a, sensorPin);

    if sensorValue == 1
        writeDigitalpin(a, relayPin, 0); % if lettuce detected, stops conveyor

    elseif sensorValue == 0
        writeDigitalpin(a, relayPin, 1); % if lettuce not detected, conveyor moves
    
    end
end

%%

%conveyorMotor();

clear a; % clears arduino 