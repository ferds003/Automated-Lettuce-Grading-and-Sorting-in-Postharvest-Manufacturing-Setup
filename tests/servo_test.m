clear a s;
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');
s = servo(a, 'D2', 'MinPulseDuration', 700e-6, 'MaxPulseDuration', 2300e-6);

for angle = 0:0.25:1
    writePosition(s, angle);
    current_pos = readPosition(s);
    current_pos = current_pos*180;
    fprintf('Current motor position is %d degrees\n', current_pos);
    pause(2);
end

%writePosition(s, 0);
clear;
