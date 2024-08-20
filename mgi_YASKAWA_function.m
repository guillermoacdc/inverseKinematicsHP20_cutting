function pulsos = mgi_YASKAWA_function(PeB,lh)
%Modelo Geometrico Inverso del robot YASKAWA MOTOMAN
%Entran variables cartesianas, salen variables articulares
%probarlo con el codigo:
%mgi_YASKAWA_function([1125.9,-383.279,372.133])
%
% pulsos =
%       -25210       73314      -23288           0       52761        9776

PeB = PeB';

l1z =505;
l1x=150;
l2=760;
l3=140;
l4=795;
% lh=105 +(105+83+300);%105 + longitud del efector final
%lh=650;

ReB = [0 1 0; 1 0 0; 0 0 -1];
ReB= ReB';
paux = PeB-ReB*[0;0;lh];
q1 = atan2(paux(2),paux(1));

pw=[sqrt(paux(1)^2 + paux(2)^2)- l1x; 0; paux(3)-l1z];
a1=sqrt(l3*l3 + l4*l4);

% mirar si el punto esta fuera del espacio de trabajo
if(sqrt(pw(1)*pw(1) + pw(3)*pw(3))>(a1+l2))
    fprintf('el punto esta fuera del espacio de trabajo')
    return
end


coseno_tetha_dos=(pw(1)^2 + pw(3)^2 - l2^2 - a1^2)/(2*l2*a1);
seno_theta_dos=-sqrt(1-coseno_tetha_dos^2);
Tetha_dos= atan2(seno_theta_dos,coseno_tetha_dos);
Ro=atan(l4/l3);
q3=Tetha_dos+Ro;


betha=acos((l2^2+pw(1)^2+pw(3)^2-a1^2)/(2*l2*sqrt(pw(1)^2+pw(3)^2)));
alpha=atan2(pw(3),pw(1));
Theta_uno=alpha+betha;
q2=pi/2-Theta_uno;


Rb3=[-sin(q1) cos(q1)*cos(q2)*cos(q3)+cos(q1)*sin(q2)*sin(q3) cos(q1)*cos(q2)*cos(q3)-cos(q1)*sin(q2)*sin(q3);
cos(q1) sin(q1)*sin(q2)*sin(q3)+sin(q1)*cos(q2)*cos(q3) sin(q1)*cos(q2)*sin(q3)-sin(q1)*sin(q2)*cos(q3);
0 sin(q3-q2) -cos(q3-q2)];
R3B=transpose(Rb3);
R3E=R3B*ReB;
az=R3E(3,3);
ax=R3E(1,3);
q4=atan2(-ax,az);

ny=R3E(2,1);
sy=R3E(2,2);
ay=R3E(2,3);
q5=atan2(ay,sqrt(ny^2+sy^2));

q6=atan2(-ny,sy);

conversion=[1341; 1783;1376;910;909;520];
pulsos=(180/pi)*[q1; q2; q3; q4; q5; q6];
pulsos=pulsos.*conversion;
pulsos=int32(pulsos);



% pulsos=pulsos';

% respuesta
% S -25113
% L 31570
% U -2901
% R 0
% B 18027
% T 9798