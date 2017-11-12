clear;
close all;

I=imread('D:/Diag.jpg');
G=zeros (size(I,1)+2,size(I,2)+2); %Создали массив с рамкой
G=uint8(G);

for i=1:size(I,1)
    for j=1:size(I,2)
    G(i+1,j+1)= I(i,j);
    end
end 
%Заполнили массив без заполнения рамки

G(1,1)=I(1,1);
G(1,size(I,2)+2)=I(1,size(I,2));
G(size(I,1)+2,1)=I(size(I,1),1);
G(size(I,1)+2,size(I,2)+2)=I(size(I,1),size(I,2));
%Заполняем углы рамки

for j=1:size(I,2) %Проходим по столбцам (1 и последней строки)
    G(1,j+1)=I(1,j);
    G(size(I,1)+2,j+1)=I(size(I,1),j);
end

for i=1:size(I,1) %Проходим по строкам (1 и последнего столбца)
    G(i+1,1)=I(i,1);
    G(i+1,size(I,2)+2)=I(i,size(I,2));
end

k=zeros(255,1);
for i=1:size(G,1)
   for j=1:size(G,2)       
       k(G(i,j)+1)=k(G(i,j)+1)+1;
   end
end

figure,plot(k);
title ('Гистограмма начального изображения');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Фильтр Гауса
G=uint16(G);
Gitog=zeros (size(I,1),size(I,2)); %Создали массив Gitog
Gitog=uint16(Gitog);

for i=2:(size(G,1)-1)
    for j=2:(size(G,2)-1)
        Gitog(i-1,j-1)=G(i-1,j-1)+2*G(i-1,j)+G(i-1,j+1)+2*G(i,j-1)+4*G(i,j)+2*G(i,j+1)+G(i+1,j-1)+2*G(i+1,j)+G(i+1,j+1);
    end
end
Gitog=Gitog/16;

k=zeros(65535,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end
figure,plot(k);
title ('Гистограмма до растяжения фильтра Гауса');

L=max(max(Gitog));
Lmin=min(min(Gitog));

%[0,510] -> [0,65535] 
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       Gitog(i,j) = double(Gitog(i,j))*(65535.0/double(L));
   end
end

k=zeros(65535,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end
figure,plot(k)
title ('Гистограмма после растяжения фильтра Гауса');

figure,imshow(Gitog);
title ('Изображение после фильтра Гауса');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Лапласиан
for i=2:(size(G,1)-1)
    for j=2:(size(G,2)-1)
        Gitog(i-1,j-1)=-G(i-1,j-1)-G(i-1,j)-G(i-1,j+1)-G(i,j-1)+8*G(i,j)-G(i,j+1)-G(i+1,j-1)-G(i+1,j)-G(i+1,j+1);
    end
end

k=zeros(65535,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end
figure,plot(k);
title ('Гистограмма до растяжения Лапласиана');

L=max(max(Gitog));
Lmin=min(min(Gitog));

%[0,510] -> [0,65535] 
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       Gitog(i,j) = double(Gitog(i,j))*(65535.0/double(L));
   end
end

k=zeros(65535,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end
figure,plot(k)
title ('Гистограмма после растяжения Лапласиана');

figure,imshow(Gitog);
title ('Изображение после Лапласиана');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Создаем массив исходного изображения без рамки
G=zeros (size(I,1),size(I,2));
G=uint8(G);

for i=1:size(I,1)
    for j=1:size(I,2)
        G(i,j)= I(i,j);
    end
end 

%Переводим массив Gitog в диапазон [1,1.3] и домнажаем его на массив G
%Получается max значение G = 327.6 (если переводить G в тип double)
L=max(max(Gitog));
%G=double(G);
Gitog=double(Gitog);
for i=1:size(Gitog,1)
    for j=1:size(Gitog,2)
        Gitog(i,j)=Gitog(i,j)/double(L)*1.3;
        G(i,j)=Gitog(i,j)*G(i,j);
    end
end
k=zeros(255,1);
for i=1:size(G,1)
   for j=1:size(G,2)       
       k(G(i,j)+1)=k(G(i,j)+1)+1;
   end
end

figure,plot(k);
title ('Гистограмма после повышения четкости');

figure,imshow(G);
title ('Изображение после повышения четкости');