% Esta funcion identifica el borde de un rectangulo segun una codificacion
% predefinida. La codificación puede ser consultada en el archivo (Tabla de verdad de bordes.docx)
% Se asume un material de dimensiones maximas cMax=[0,0;0,800;800,800;800,0];
% Se sugiere adicionar como parámetro de entrada el vector cMax

function borde = identificaBordes(c, cMax)

Xmax=cMax(3,1);
Ymax=cMax(2,2);
if (c(2,1)== 0 &   c(2,2)== Ymax)
       borde=1;
elseif (c(4,1)== Xmax &...
        c(4,2)== 0  )
    borde=2;
elseif (c(3,1)== Xmax &...
        c(3,2)== Ymax    )
    borde=3;
elseif (c(1,1)== 0 &...
        c(1,2)== 0 )
    borde=4;
elseif (c(2,2)== Ymax &...
        c(3,2)== Ymax)
    borde=5;
elseif (c(1,2)== 0 &...
        c(4,2)== 0)
    borde=6;
elseif (c(3,1)== Ymax &...
        c(4,1)== Ymax)
    borde=7;
elseif (c(1,1)== 0 &...
        c(2,1)== 0)
    borde=8;
elseif (c(1,1)== 0 & c(1,2)== 0 & c(2,1)== 0 & c(2,2)== Ymax & c(3,1)== Xmax & c(3,2)== Ymax & c(4,1)== Xmax & c(4,2)== 0)         
    borde=9;
    fprintf('corte no posible, solo recorrerA los bordes del material')
else
    borde=10;%corresponde con un corte de un rectangulo que no se interseca con los bordes del material
end
