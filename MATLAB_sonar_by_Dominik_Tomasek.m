%%autor Dominik TOmášek 
clear
a = arduino('COM4', 'Uno', 'Libraries', {'Servo','Ultrasonic'});
ultrasonic_sensor = ultrasonic(a,'D7','D6','OutputFormat','double');
servo_motor = servo(a,'D5');


grid on;

% while true 
p = 1;
table = zeros(180,2);
for angle = 0 : 1/180 : 1

    writePosition(servo_motor, angle);
    distance = readDistance(ultrasonic_sensor);
    table(p,1) = (p-1);
    table(p,2) = round(distance * 100,2);
    if table(p,2)>=100
        table(p,2)=100;
    end
    p = p + 1;

  kk=table(:,2)<=30;
 
polarplot (table(:,1)*pi/180, table (:,2));
hold on 
polarplot (table(kk,1)*pi/180, table (kk,2),'Color','r');
title('SONAR POMOCÍ ULTRASONICKÉHO SENZORU');
thetalim([0 180]);
rlim([0 100])

hold off
end

q = 1;
for angle = 1 : -1/180 : 0

    writePosition(servo_motor, angle);
    distance = readDistance(ultrasonic_sensor);
    table(p-q,2) = (table(p-q,2) + round(distance * 100,2))/2;
     if table(p-q,2)>=100
        table(p-q,2)=100;
    end
    q = q + 1;
   
    kk=table(:,2)<=30;

    
    polarplot (table(:,1)*pi/180, table (:,2));
    hold on 
    polarplot (table(kk,1)*pi/180, table (kk,2),'Color','r');

title('SONAR POMOCÍ ULTRASONICKÉHO SENZORU');
thetalim([0 180]);
rlim([0 100])

% grid on;
hold off

end

% end