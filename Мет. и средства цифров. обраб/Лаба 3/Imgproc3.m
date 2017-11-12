clear;
close all;

I=imread('D:/Diag.jpg');
G=zeros (size(I,1)+2,size(I,2)+2); %������� ������ � ������
G=uint8(G);

for i=1:size(I,1)
    for j=1:size(I,2)
    G(i+1,j+1)= I(i,j);
    end
end 
%��������� ������ ��� ���������� �����

G(1,1)=I(1,1);
G(1,size(I,2)+2)=I(1,size(I,2));
G(size(I,1)+2,1)=I(size(I,1),1);
G(size(I,1)+2,size(I,2)+2)=I(size(I,1),size(I,2));
%��������� ���� �����

for j=1:size(I,2) %�������� �� �������� (1 � ��������� ������)
    G(1,j+1)=I(1,j);
    G(size(I,1)+2,j+1)=I(size(I,1),j);
end

for i=1:size(I,1) %�������� �� ������� (1 � ���������� �������)
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
title ('����������� ���������� �����������');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������ �����
G=uint16(G);
Gitog=zeros (size(I,1),size(I,2)); %������� ������ Gitog
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
title ('����������� �� ���������� ������� �����');

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
title ('����������� ����� ���������� ������� �����');

figure,imshow(Gitog);
title ('����������� ����� ������� �����');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������
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
title ('����������� �� ���������� ����������');

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
title ('����������� ����� ���������� ����������');

figure,imshow(Gitog);
title ('����������� ����� ����������');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������� ������ ��������� ����������� ��� �����
G=zeros (size(I,1),size(I,2));
G=uint8(G);

for i=1:size(I,1)
    for j=1:size(I,2)
        G(i,j)= I(i,j);
    end
end 

%��������� ������ Gitog � �������� [1,1.3] � ��������� ��� �� ������ G
%���������� max �������� G = 327.6 (���� ���������� G � ��� double)
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
title ('����������� ����� ��������� ��������');

figure,imshow(G);
title ('����������� ����� ��������� ��������');