I=imread('D:/man.jpg');
G=zeros (size(I,1),size(I,2));
G=uint8(G);
for i=1:size(I,1)
    for j=1:size(I,2)
    G(i,j)= uint8(I(i,j,1)*0.299+I(i,j,2)*0.587+I(i,j,3)*0.114);
   
    %size(I,1)
    end
end 
figure,imshow(G);
%Перевели в оттенки серого

k=zeros(256,1);
for i=1:size(G,1)
   for j=1:size(G,2)       
       k(G(i,j)+1)=k(G(i,j)+1)+1;
   end
end
%Построили гистограмму. Вывести её так - figure,plot(k);

b=0;
i=uint8(1);
j=uint8(255);
while(b<(size(I,1)*size(I,2)/100*5))
       if(k(i)>k(j))
            b=b+k(j);
            j=j-1;
       elseif(k(i)<=k(j))
            b=b+k(i);
            i=i+1;
       end
end
min =i;
max =j;
%Нашли границы с порогом 5%

for i=min+1:max
    k(i)=k(i)+k(i-1);
end
%Посчитали таблицу cdf
h=zeros (256,1);
h=uint8(h);
for i=min:max
    h(i)=round( (k(i)-k(min)) / (size(I,1)*size(I,2)-1) * (256-1) );
end
%Посчитали таблицу h

for i=1:size(I,1)
    for j=1:size(I,2)
    G(i,j)= h(G(i,j));
    end
end 

%Идем по массиву и заменяем оттенки исходя из таблицы h

k=zeros(256,1);
for p=1:size(G,1)
   for s=1:size(G,2)      
       k(G(p,s)+1)=k(G(p,s)+1)+1;
   end
end
%Гистограмма

figure,plot(k);
figure,imshow(G);
