function [ M3 ] = transform2RobotBase( M2b, ReB, U0 )
%TRANSFORM2ROBOTBASE Esta operación implementa las ecuación (2) del Anexo 1.
%   Detailed explanation goes here

%  

for i=1:size(M2b,1)
    M3(i,:)=(U0+ReB*M2b(i,:)')';
end

end

