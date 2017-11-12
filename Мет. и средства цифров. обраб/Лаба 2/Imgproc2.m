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

%МЕТОД СОБЕЛЯ
G=int16(G);
Gx=zeros (size(I,1),size(I,2)); %Создали массив Gx
Gx=int16(Gx);
Gy=zeros (size(I,1),size(I,2)); %Создали массив Gy
Gy=int16(Gy);
Gitog=zeros (size(I,1),size(I,2)); %Создали массив Gitog
Gitog=uint16(Gitog);

for i=2:(size(G,1)-1)
    for j=2:(size(G,2)-1)
        Gx(i-1,j-1)= G(i-1,j-1)-G(i-1,j+1)+2*G(i,j-1)-2*G(i,j+1)+G(i+1,j-1)-G(i+1,j+1);
        Gy(i-1,j-1)= -G(i-1,j-1)-2*G(i-1,j)-G(i-1,j+1)+G(i+1,j-1)+2*G(i+1,j)+G(i+1,j+1);
        %Gitog(i-1,j-1)= abs(Gx(i-1,j-1))+abs(Gy(i-1,j-1));
    end
end
Gitog = abs(Gx) + abs(Gy);
k=zeros(65535,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end
figure,plot(k);
title ('Гистограмма до растяжения метода Собеля');

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
figure,plot(k);
title ('Гистограмма после растяжения метода Собеля');

figure,imshow(Gitog);
title ('Изображение после метода Собеля');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%МЕТОД ПРЕВИТТА
Gx=zeros (size(I,1),size(I,2)); %Создали массив Gx
Gx=int16(Gx);
Gy=zeros (size(I,1),size(I,2)); %Создали массив Gy
Gy=int16(Gy);
Gitog=zeros (size(I,1),size(I,2)); %Создали массив Gitog
Gitog=uint16(Gitog);

for i=2:(size(G,1)-1)
    for j=2:(size(G,2)-1)
        Gx(i-1,j-1)= G(i-1,j-1)-G(i-1,j+1)+G(i,j-1)-G(i,j+1)+G(i+1,j-1)-G(i+1,j+1);
        Gy(i-1,j-1)= -G(i-1,j-1)-G(i-1,j)-G(i-1,j+1)+G(i+1,j-1)+G(i+1,j)+G(i+1,j+1);
        %Gitog(i-1,j-1)= abs(Gx(i-1,j-1))+abs(Gy(i-1,j-1));
    end
end
Gitog = abs(Gx) + abs(Gy);
k=zeros(65535,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end
figure,plot(k);
title ('Гистограмма до растяжения метода Превитта');

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
figure,plot(k);
title ('Гистограмма после растяжения метода Превитта');

figure,imshow(Gitog);
title ('Изображение после метода Превитта');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%МЕТОД РОБЕРТА
Gx=zeros (size(I,1),size(I,2)); %Создали массив Gx
Gx=int8(Gx);
Gy=zeros (size(I,1),size(I,2)); %Создали массив Gy
Gy=int8(Gy);
Gitog=zeros (size(I,1),size(I,2)); %Создали массив Gitog
Gitog=uint8(Gitog);

for i=2:(size(G,1)-1)
    for j=2:(size(G,2)-1)
        Gx(i-1,j-1)= G(i,j)-G(i+1,j+1);
        Gy(i-1,j-1)= G(i,j+1)-G(i+1,j);
    end
end
Gitog = abs(Gx) + abs(Gy);

k=zeros(256,1);
for i=1:size(Gitog,1)
   for j=1:size(Gitog,2)       
       k(Gitog(i,j)+1)=k(Gitog(i,j)+1)+1;
   end
end

figure,plot(k)
title ('Гистограмма после метода Роберта');

figure,imshow(Gitog);
title ('Изображение после метода Роберта');
