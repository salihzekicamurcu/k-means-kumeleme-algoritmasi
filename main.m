clear;clc;close all;
global ay;ay=[];
global gun;gun=[];
global ortalamaFiyat;ortalamaFiyat=[];
global ortalamaSicaklik;ortalamaSicaklik=[];
global maxFiyat;maxFiyat=[];
global minFiyat;minFiyat=[];
global minSicaklik;minSicaklik=[];
global maxSicaklik;maxSicaklik=[];
veri=importdata('veri2013.mat');
boyut=size(veri);
for i=1:boyut(1)
    str=char(veri{i,1});
    %fprintf('%s\n',str);
    g=str2num(str(1:2));
    a=str2num(str(4:5));
    gun=[gun;g];
    ay=[ay;a];
    str=veri{i,2};
    minS=str;
    minFiyat=[minFiyat;minS];
    str=veri{i,3};
    maxS=str;
    maxFiyat=[maxFiyat;maxS]; 
 
    str=char(veri{i,4});
    str = strtrim(str);
    indis=1;
    for sss=1:length(str)
        if( str(sss)=='°')
            indis=sss;
        end
    end
    str=str(1:indis-1);  
    ms=str2num(str);
    maxSicaklik=[maxSicaklik;ms];  
    %----------------------------------
    str=veri{i,5};
    str = strtrim(str);
    indis=1;
    for ss=1:length(str)
        if( str(ss)=='°')
            indis=ss;
        end
    end
    str=str(1:indis-1);  
    minsic=str2num(str);
    minSicaklik=[minSicaklik;minsic];
end

for i=1:boyut
    ortalama_fiyat=(minFiyat(i)*0.5)+(maxFiyat(i)*0.5);
    ortalamaFiyat=[ ortalamaFiyat;ortalama_fiyat]; 
end
for i=1:boyut
    ortalama_sicak=floor((minSicaklik(i)*0.4)+(maxSicaklik(i)*0.6));
    ortalamaSicaklik=[ ortalamaSicaklik;ortalama_sicak]; 
end

veriler=[gun,ay,ortalamaSicaklik];
title('baslangic');
subplot(1,3,1);
plot3(ay,gun,ortalamaFiyat,'*');grid on;
zlabel('fiyat');ylabel('ay');xlabel('gun');
m1=[];m2=[];m3=[];m4=[];
m1=[randi([1,31],1,1),randi([1,12],1,1),randi([0,10],1,1)];
m2=[randi([1,31],1,1),randi([1,12],1,1),randi([1,10],1,1)];
m3=[randi([1,31],1,1),randi([1,12],1,1),randi([2,10],1,1)];
m4=[randi([1,31],1,1),randi([1,12],1,1),randi([1,10],1,1)];
grup1=[];
grup2=[];
grup3=[];
grup4=[];
for i=1:boyut(1)
        uzakliklar=[];
        noktalar=[veriler(i,1),veriler(i,2),veriler(i,3)];
        
        u1=uzaklikHesap3d(m1,noktalar);
        uzakliklar=[uzakliklar;u1,1];
        
        u2=uzaklikHesap3d(m2,noktalar);
        uzakliklar=[uzakliklar;u2,2];
        
        u3=uzaklikHesap3d(m3,noktalar);
        uzakliklar=[uzakliklar;u3,3];
        
        u4=uzaklikHesap3d(m4,noktalar);
        uzakliklar=[uzakliklar;u4,4];
        
        uzakliklar=sortrows(uzakliklar,1);
        aitlik=uzakliklar(1,2);
        if(aitlik==1)
            grup1=[grup1;noktalar];
        elseif(aitlik==2)
            grup2=[grup2;noktalar];
        elseif(aitlik==3)
            grup3=[grup3;noktalar];
        elseif(aitlik==4)
            grup4=[grup4;noktalar];
        end
   
end
title('ilk iterasyon');
subplot(1,3,2);
plot3(grup1(:,1),grup1(:,2),grup1(:,3),'r*');grid on;hold on;
plot3(grup2(:,1),grup2(:,2),grup2(:,3),'g+');grid on;hold on;
plot3(grup3(:,1),grup3(:,2),grup3(:,3),'bh');grid on;hold on;
plot3(grup4(:,1),grup4(:,2),grup4(:,3),'ko');grid on;hold on;
zlabel('fiyat');ylabel('ay');xlabel('gun');


plot3(m1(1),m1(2),m1(3),'rs');hold on;
plot3(m2(1),m2(2),m2(3),'gs');hold on;
plot3(m3(1),m3(2),m3(3),'bs');hold on;
plot3(m4(1),m4(2),m4(3),'ks');hold on;



for s=1:800
    grup1=[];grup2=[];grup3=[];
    for i=1:boyut(1)
        uzakliklar=[];
        noktalar=[veriler(i,1),veriler(i,2),veriler(i,3)];
        
        u1=uzaklikHesap3d(m1,noktalar);
        uzakliklar=[uzakliklar;u1,1];
        
        u2=uzaklikHesap3d(m2,noktalar);
        uzakliklar=[uzakliklar;u2,2];
        
        u3=uzaklikHesap3d(m3,noktalar);
        uzakliklar=[uzakliklar;u3,3];    
        
        u4=uzaklikHesap3d(m4,noktalar);
        uzakliklar=[uzakliklar;u4,4];    
       
        uzakliklar=sortrows(uzakliklar,1);
        aitlik=uzakliklar(1,2);
       % d%isplay(uzakliklar);
        if(aitlik==1)
             grup1=[grup1;noktalar];
        elseif(aitlik==2)
            grup2=[grup2;noktalar];
        elseif(aitlik==3)
            grup3=[grup3;noktalar];
       elseif(aitlik==4)
            grup4=[grup4;noktalar];
        end
    end
      m1=[mean(grup1(:,1)),mean(grup1(:,2)),mean(grup1(:,3))];
      m2=[mean(grup2(:,1)),mean(grup2(:,2)),mean(grup2(:,3))];
      m3=[mean(grup3(:,1)),mean(grup3(:,2)),mean(grup3(:,3))];
      m4= [mean(grup4(:,1)),mean(grup4(:,2)),mean(grup4(:,3))];
end






subplot(1,3,3);
title('sonuc iterasyon');


plot3(grup1(:,1),grup1(:,2),grup1(:,3),'r*');grid on;hold on;
plot3(grup2(:,1),grup2(:,2),grup2(:,3),'g+');grid on;hold on;
plot3(grup3(:,1),grup3(:,2),grup3(:,3),'bh');grid on;hold on;
plot3(grup4(:,1),grup4(:,2),grup4(:,3),'ko');grid on;hold on;
zlabel('fiyat');ylabel('ay');xlabel('gun');

plot3(m1(1),m1(2),m1(3),'rs');hold on;
plot3(m2(1),m2(2),m2(3),'gs');hold on;
plot3(m3(1),m3(2),m3(3),'bs');hold on;
plot3(m4(1),m4(2),m4(3),'bs');hold on;

figure;
plot3(grup1(:,1),grup1(:,2),grup1(:,3),'r*');grid on;hold on;
plot3(grup2(:,1),grup2(:,2),grup2(:,3),'g*');grid on;hold on;
plot3(grup3(:,1),grup3(:,2),grup3(:,3),'b*');grid on;hold on;
plot3(grup4(:,1),grup4(:,2),grup4(:,3),'k*');grid on;hold on;
zlabel('fiyat');ylabel('ay');xlabel('gun');
plot3(m1(1),m1(2),m1(3),'rs');hold on;
plot3(m2(1),m2(2),m2(3),'gs');hold on;
plot3(m3(1),m3(2),m3(3),'bs');hold on;
plot3(m4(1),m4(2),m4(3),'ks');hold on

fprintf(' m1x:%1.0f m1y:%1.0f m1z:%1.1f\n',m1(:));
fprintf(' m2x:%1.0f m2y:%1.0f m2z:%1.1f\n',m2(:));
fprintf(' m3x:%1.0f m3y:%1.0f m3z:%1.1f\n',m3(:));
fprintf(' m4x:%1.0f m4y:%1.0f m4z:%1.1f\n',m4(:));
grup1=sortrows(grup1,3);
grup2=sortrows(grup2,3);
grup3=sortrows(grup3,3);
grup4=sortrows(grup4,3);