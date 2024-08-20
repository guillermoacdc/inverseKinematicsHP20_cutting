function [ beginEndMarks, M2b ] = deleteBorderPath( M2, maxPath )
%DELETEBORDERPATH Este bloque se encarga de eliminar las rutas de corte que se superponen con los bordes de la pieza 
% a cortar. Estas rutas pueden aparecer en 8 ubicaciones documentadas en la Fig.  8. 
%   Detailed explanation goes here


k=1;
beginEndMarks=zeros(1,length(M2));
%2. identifica bordes
for( i=1:5:length(M2))
%     M2(i:i+3,:)    
    bordes=identificaBordesv1(M2(i:i+3,:), maxPath);
    beginEndMarks(k)=1;%marca inicio de beginEndMarks
    switch bordes
    case 1
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+3,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:);
        
    case 2
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:);
    case 3
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+3,:);
    case 4
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:);
        k=k+1;
        M2b(k,:)=M2(i+3,:);
    case 5
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+3,:) ; 
        k=k+1;
        M2b(k,:)=M2(i+2,:);
    case 6
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:) ; 
        k=k+1;
        M2b(k,:)=M2(i+3,:);
    case 7
        M2b(k,:)=M2(i+2,:);
        k=k+1;
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i,:)  ;
        k=k+1;
        M2b(k,:)=M2(i+3,:);
    case 8
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:);
        k=k+1;
        M2b(k,:)=M2(i+3,:);  
        k=k+1;
        M2b(k,:)=M2(i,:) ;   
    case 9
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:) ; 
        k=k+1;
        M2b(k,:)=M2(i+3,:);
        k=k+1;
        M2b(k,:)=M2(i,:);
    case 10
        M2b(k,:)=M2(i,:);
        k=k+1;
        M2b(k,:)=M2(i+1,:);
        k=k+1;
        M2b(k,:)=M2(i+2,:) ; 
        k=k+1;
        M2b(k,:)=M2(i+3,:);
        k=k+1;
        M2b(k,:)=M2(i,:);
    otherwise
        disp('other value')
    end
    beginEndMarks(k)=2;%marca fin de beginEndMarks
    k=k+1;
end
beginEndMarks=beginEndMarks(1:length(M2b));
end

