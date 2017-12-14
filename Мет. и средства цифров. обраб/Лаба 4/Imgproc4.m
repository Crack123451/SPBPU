clear;
close all;

I1=imread('D:/t-1.jpg');
I2=imread('D:/t.jpg');

figure,imshow(I1);
title ('Кадр t-1');
figure,imshow(I2);
title ('Кадр t');

Iser1=zeros (size(I1,1),size(I1,2));
Iser1=uint8(Iser1);
Iser2=zeros (size(I2,1),size(I2,2));
Iser2=uint8(Iser2);

for i=1:size(I1,1)
    for j=1:size(I1,2)
    Iser1(i,j)= uint8(I1(i,j,1)*0.299+I1(i,j,2)*0.587+I1(i,j,3)*0.114);
    Iser2(i,j)= uint8(I2(i,j,1)*0.299+I2(i,j,2)*0.587+I2(i,j,3)*0.114);
    end
end 

figure, imshow(Iser1);
title ('Кадр t-1 в оттенках серого');
figure, imshow(Iser2);
title ('Кадр t в оттенках серого');
figure;

%Размер блока 10х10. Размер зоны поиска 50x50
step=5; sizeBlock=10; number=1; searchArea=50;

for x=(sizeBlock/2):step:(size(Iser1,1)-sizeBlock/2)
    for y=(sizeBlock/2):step:(size(Iser2,1)-sizeBlock/2)
        I_t2=0;  %Кадр t
        I_t1=0;  %Кадр t-1
        
        %Сумма всех значений для I_t2 и I_t1 
        for i=(x-sizeBlock/2+1):x+(sizeBlock/2)
            for j=(y-sizeBlock/2+1):y+(sizeBlock/2)
                I_t2=I_t2+double(Iser1(j,i));
                I_t1=I_t1+double(Iser2(j,i));
            end
        end
        
        %Текущий размер зоны поиска и пиксель
        size_current=searchArea;
        x_center=x;
        y_center=y;
        It_1=-1;
        
        if (abs(I_t2-I_t1)>5)
            while size_current>=sizeBlock
                
                x_search1=x-size_current;          
                if x_search1<0
                    x_search1=1;
                end
                
                x_search2=x+size_current;
                if x_search2>size(Iser1,1)
                    x_search2=size(Iser1,1);
                end
                
                y_search1=y-size_current;
                if y_search1<0
                    y_search1=1;
                end
                
                y_search2=y+size_current;
                if y_search2>size(Iser1,2)
                    y_search2=size(Iser1,2);
                end
                
                x_c(1)=x_center; 
                y_c(1)=y_center;
                
                x_c(2)=x_search1+sizeBlock/2; 
                y_c(2)=y_center;
                
                x_c(3)=x_search1+sizeBlock/2; 
                y_c(3)=y_search2-sizeBlock/2;
                
                x_c(4)=x_center; 
                y_c(4)=y_search2-sizeBlock/2;
                
                x_c(5)=x_search2-sizeBlock/2; 
                y_c(5)=y_search2-sizeBlock/2;
                
                x_c(6)=x_search2-sizeBlock/2; 
                y_c(6)=y_center;
                
                x_c(7)=x_search2-sizeBlock/2; 
                y_c(7)=y_search1+sizeBlock/2;
                
                x_c(8)=x_center; 
                y_c(8)=y_search1+sizeBlock/2;
                
                x_c(9)=x_search1+sizeBlock/2; 
                y_c(9)=y_search1+sizeBlock/2;
                
                for l=1:9
                    flag=0;
                    for i=(x_c(l)-sizeBlock/2+1):(x_c(l)+sizeBlock/2)
                        for j=(y_c(l)-sizeBlock/2+1):(y_c(l)+sizeBlock/2)
                            flag=flag+double(Iser2(j,i));
                        end
                    end
                    
                    if (It_1==-1)||(abs(I_t2-flag)<abs(I_t2-It_1))
                        It_1=flag;
                        x_center=x_c(l);
                        y_center=y_c(l);
                    end
                end
                size_current=fix(size_current/2);
            end    
            hold on %Наложение графиков друг на друга
        end
        
        plot([x x_center], [y y_center])
        title ('Преобразования кадра t-1');
        MasVect(1,number)=x;
        MasVect(2,number)=x_center;
        MasVect(3,number)=y;
        MasVect(4,number)=y_center;
        number=number+1;
    end
end

%Восстановим изображение по векторам
for l=1:number-1
    for i=(-sizeBlock/2+1):(sizeBlock/2)
        for j=(-sizeBlock/2+1):(sizeBlock/2)
           if ((MasVect(4,l)+j)<=size(I1,2))&((MasVect(3,l)+j)<=size(I1,2))&((MasVect(2,l)+i)<=size(I1,1))&((MasVect(1,l)+i)<=size(I1,1))
                IserChange(MasVect(4,l)+j,MasVect(2,l)+i)=Iser1(MasVect(3,l)+j,MasVect(1,l)+i);
            end
        end
    end
end
imwrite(IserChange, 'result.jpg');