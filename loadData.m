function [ path1 ] = loadData( fileName )
%LOADDATA Esta funci�n se ocupa de leer el archivo input.txt, crear una vector 
% y cargar los datos en dicho vector. La funci�n debe acceder al archivo input.txt
%   Detailed explanation goes here
path1 = dlmread([fileName  '.txt']);

end

