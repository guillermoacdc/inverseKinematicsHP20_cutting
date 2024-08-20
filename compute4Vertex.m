function [ path2 ] = compute4Vertex( path1 )
%COMPUTE4VERTEX Esta operaci�n se encarga de calcular los v�rtices C3 y C4 
% del rect�ngulo a partir de los v�rtices C1 y C2. Ver Fig.  2
%   Detailed explanation goes here
k=1;
path2=zeros(size(path1,1)*4,3);%evaluar si es necesario
for i=1:size(path1,1)
    path2(k,:)=path1(i,1:3);
    k=k+1;
    path2(k,1)=path1(i,1);
    path2(k,2)=path1(i,5);
    path2(k,3)=path1(i,3);
    k=k+1;
    path2(k,:)=path1(i,4:6);
    k=k+1;
    path2(k,1)=path1(i,4);
    path2(k,2)=path1(i,2);
    path2(k,3)=path1(i,3);
    k=k+1;
%     adici�n del punto de inicio del rect�ngulo para asegurar que se
%     cierre la trayectoria de corte
    path2(k,:)=path1(i,1:3);
    k=k+1;
end
end

