function [ M3 ] = transform2RobotBase( M2b, ReB, U0 )
%TRANSFORM2ROBOTBASE Esta operaci�n implementa las ecuaci�n (2) del Anexo 1.
%   Detailed explanation goes here

%  

for i=1:size(M2b,1)
    M3(i,:)=(U0+ReB*M2b(i,:)')';
end

end

