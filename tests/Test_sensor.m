% Connect to the Raspberry Pi
rpi = raspi('192.168.104.240', 'ferds', 'lettuce');  % Replace with your Raspberry Pi IP address

% Define the GPIO pin connected to the servo
servoPin = 18;  % GPIO pin 18 (PWM-capable pin)

% Configure the pin as a PWM output
configurePin(rpi, servoPin, 'PWM');

% Set the PWM frequency (50 Hz for standard servo control)
writePWMFrequency(rpi, servoPin, 50);  % Frequency for servos is typically 50 Hz

% Create a servo object with the appropriate Min/Max Pulse Durations
servoObj = servo(rpi, servoPin, 'MinPulseDuration', 0.0005, 'MaxPulseDuration', 0.0025);

% Move the servo to 0 degrees (turn left)
angle = 0;  % 0 degrees (Min position)
position = angle / 180;  % Normalize to 0-1 range (0 degrees -> 0, 180 degrees -> 1)
writePosition(servoObj, position);  % Set the servo position
disp(['Moving to 0 degrees (position: ', num2str(position), ')']);
pause(2);  % Wait for 2 seconds

% Move the servo to 90 degrees (middle position)
angle = 90;  % 90 degrees (Middle position)
position = angle / 180;  % Normalize to 0-1 range (0 degrees -> 0, 180 degrees -> 1)
writePosition(servoObj, position);  % Set the servo position
disp(['Moving to 90 degrees (position: ', num2str(position), ')']);
pause(2);  % Wait for 2 seconds

% Move the servo to 180 degrees (turn right)
angle = 180;  % 180 degrees (Max position)
position = angle / 180;  % Normalize to 0-1 range (0 degrees -> 0, 180 degrees -> 1)
writePosition(servoObj, position);  % Set the servo position
disp(['Moving to 180 degrees (position: ', num2str(position), ')']);
pause(2);  % Wait for 2 seconds
