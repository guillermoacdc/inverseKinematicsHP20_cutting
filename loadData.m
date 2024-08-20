function [ path1 ] = loadData( fileName )
%LOADDATA Esta función se ocupa de leer el archivo input.txt, crear una vector 
% y cargar los datos en dicho vector. La función debe acceder al archivo input.txt
%   Detailed explanation goes here
path1 = dlmread([fileName  '.txt']);

end

