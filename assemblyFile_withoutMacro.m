function assemblyFile_withoutMacro(pulsos, rectangulo, N, outputName)
%ASSEMBLYFILE Esta función se encarga de ensamblar el archivo de salida con
%nombre outputName.JOB
%   Detailed explanation goes here

%% Escribe datos en archivo salida txt
% 1. open a file for writing
fid = fopen([outputName '.JBI'], 'w');
% 2. imprimir encabezado
fprintf(fid, '/JOB\r\n');
fprintf(fid, '//NAME %s\r\n', outputName);
fprintf(fid, '//POS\r\n');
fprintf(fid, '///NPOS %d,0,0,0,0,0\r\n', N+1);
fprintf(fid, '///TOOL 0\r\n');
fprintf(fid, '///POSTYPE PULSE\r\n');
fprintf(fid, '///PULSE\r\n');
fprintf(fid, 'C00000=0,0,0,0,0,0\r\n');
% 3. imprimir valor de las coordenadas
% for i=1:length(pulsos)
for i=1:size(pulsos,1)
    fprintf(fid, 'C000');
    if (i<10)
        fprintf(fid,'0');
    end
    fprintf(fid, '%d' , i);
    fprintf(fid, '=');
    fprintf(fid, '%d, %d, %d, %d, %d, %d  \r\n', pulsos(i,:));
end
% 4. imprimir comandos intermedios
fprintf(fid, '//INST\r\n');
fprintf(fid, '///DATE 2015/05/11 9:31\r\n');
fprintf(fid, '///ATTR SC,RW\r\n');
fprintf(fid, '///GROUP1 RB1\r\n');
fprintf(fid, 'NOP\r\n');
% 5. imprimir comandos MOV
fprintf(fid, 'MOVJ C00000 VJ=5\r\n');
% for i=1:length(pulsos)
for i=1:size(pulsos,1)
    if(rectangulo(i)==1)
        fprintf(fid, 'MOVJ ');
    else
        fprintf(fid, 'MOVL ');
    end
    fprintf(fid, 'C000');
    if (i<10)
        fprintf(fid,'0');
    end
    fprintf(fid, '%d' , i);
    if(rectangulo(i)==1)
        fprintf(fid, ' VJ=5\r\n');
        %comando para encender el sistema de corte
%         fprintf(fid,'MACRO1 MJ#(5)\r\n');%CUT_ONN
%         fprintf(fid,'MACRO1 MJ#(0) ARGF2 ARGF2\r\n')%CUT_ON PIERCE=4 CUT=4
    else
        fprintf(fid, ' V=100 PL=0\r\n');
    end
    if(rectangulo(i)==2)
%comando para apagar el sistema de corte
%         fprintf(fid,'MACRO1 MJ#(1)\r\n');%CUT_OFF
    end
end
%     fprintf(fid, 'MOVJ C00000 VJ=5\r\n');%regresar al home del
%     robot--esta linea genera errores al cargar el codigo al pendant
    fprintf(fid, 'END\r\n');
fclose(fid);

end

