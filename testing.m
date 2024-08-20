% ///-------------------------------------------------------------------------------------------------
% // file:	C:\Users\Daniiel\Dropbox\biblioEmpOptimo\code\RobotCodes\corte\matlab\testing.m
% //
% // summary:	testing class
% // Este programa se encarga de (1) leer datos de entrada, (2) preacondicionar datos y (3) calcular coordenadas articulares
% // estas cordenadas con requeridas para el funcionamiento del robot y que genere el corte optimo.
% ///-------------------------------------------------------------------------------------------------

clc
close all
clear all
% declaraci�n de variables 
z6=405;
z0=325;
ktePlaca=700;
maxPath=[0,0;0,ktePlaca;ktePlaca,ktePlaca;ktePlaca,0];%coordenadas de la pieza rectangular mayor
% U0=[728.410;-396.026; 174.0300];%posici�n del origen de la pieza con respecto al origen del robot
U0=[870.899;-477.946; 49.446-z0+z6];%posici�n del origen de la pieza con respecto al origen del robot
ReB = [0 1 0; 1 0 0; 0 0 -1];%matriz de orientaci�n entre el efectorFinal (e) y la base (B)
offset=129.8;%revisar modelo en busca de este offset
L_fe=510+offset;%distancia del efector final en el eje z.
outputName='outputCortev15Macro';
% c�lculo de coordenadas articulares

% ///-------------------------------------------------------------------------------------------------
% /// <summary>	Load Data. </summary>
% ///                   Esta funci�n se ocupa de leer el archivo input.txt, crear una vector y cargar los  
% ///                   datos en dicho vector. La funci�n debe acceder al archivo input.txt
% /// <param> name= "Input.txt"  Es el archivo de texto en el cual se encuentran las coordenadas para el patron de corte.  
% ///  
% ///
% /// <remarks>	Daniiel, 14/04/2016. </remarks>
% ///-------------------------------------------------------------------------------------------------

path1=loadData('PatronCasoCortarGCUT13');

% ///-------------------------------------------------------------------------------------------------
% /// <summary>	compute4vertex . </summary>  Esta operaci�n se encarga de calcular los v�rtices C3 y C4 
% ///                                          del rect�ngulo a partir de los v�rtices C1 y C2.
% ///
% /// <param> name= parth1       Conjunto de dos v�rtices para cada rect�ngulo. Espacio cartesiano x, y, z. 
% ///                            Los v�rtices son dados en la secuencia C1, C2
% /// <remarks>	Daniiel, 14/04/2016. </remarks>
% ///-------------------------------------------------------------------------------------------------

path2=compute4Vertex(path1);
[beginEndMark path3]=deleteBorderPath( path2, maxPath );
path4=transform2RobotBase( path3, ReB, U0 );
% path4=transform2RobotBase( path2, ReB, U0 );
for n = 1:size(path3,1)
    articularCoordinates(n,:)=mgi_YASKAWA_function(path4(n,:),L_fe);
end
% ensamble del archivo de salida 
N=size(path3,1);%cantidad de rect�ngulos
assemblyFile(articularCoordinates, beginEndMark, N, outputName);
% assemblyFile_withoutMacro(articularCoordinates, beginEndMark, N, outputName);
