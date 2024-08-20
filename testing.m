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
% declaración de variables 
z6=405;
z0=325;
ktePlaca=700;
maxPath=[0,0;0,ktePlaca;ktePlaca,ktePlaca;ktePlaca,0];%coordenadas de la pieza rectangular mayor
% U0=[728.410;-396.026; 174.0300];%posición del origen de la pieza con respecto al origen del robot
U0=[870.899;-477.946; 49.446-z0+z6];%posición del origen de la pieza con respecto al origen del robot
ReB = [0 1 0; 1 0 0; 0 0 -1];%matriz de orientación entre el efectorFinal (e) y la base (B)
offset=129.8;%revisar modelo en busca de este offset
L_fe=510+offset;%distancia del efector final en el eje z.
outputName='outputCortev15Macro';
% cálculo de coordenadas articulares

% ///-------------------------------------------------------------------------------------------------
% /// <summary>	Load Data. </summary>
% ///                   Esta función se ocupa de leer el archivo input.txt, crear una vector y cargar los  
% ///                   datos en dicho vector. La función debe acceder al archivo input.txt
% /// <param> name= "Input.txt"  Es el archivo de texto en el cual se encuentran las coordenadas para el patron de corte.  
% ///  
% ///
% /// <remarks>	Daniiel, 14/04/2016. </remarks>
% ///-------------------------------------------------------------------------------------------------

path1=loadData('PatronCasoCortarGCUT13');

% ///-------------------------------------------------------------------------------------------------
% /// <summary>	compute4vertex . </summary>  Esta operación se encarga de calcular los vértices C3 y C4 
% ///                                          del rectángulo a partir de los vértices C1 y C2.
% ///
% /// <param> name= parth1       Conjunto de dos vértices para cada rectángulo. Espacio cartesiano x, y, z. 
% ///                            Los vértices son dados en la secuencia C1, C2
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
N=size(path3,1);%cantidad de rectángulos
assemblyFile(articularCoordinates, beginEndMark, N, outputName);
% assemblyFile_withoutMacro(articularCoordinates, beginEndMark, N, outputName);
