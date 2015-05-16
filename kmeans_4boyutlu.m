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

set=[gun,ay,ortalamaSicaklik,ortalamaFiyat];

boyut=size(set);
k=input('K:');
donguson=input('dongusayisi:');
merkezler=[];
for i=1:k
    merkezler(i,1)=i;
    merkezler(i,2)=randi([1,30],1,1);
    merkezler(i,3)=randi([1,12],1,1);
    merkezler(i,4)=randi([-10,20],1,1);
    merkezler(i,5)=randi([0,5],1,1);
end
boyut=size(set);
gruplar=[];
for iterasyon=1:donguson
    gruplar=[];
for sayac=1:boyut(1)
    x1=set(sayac,1);
    y1=set(sayac,2);
    z1=set(sayac,3);
    d1=set(sayac,4);
   % fprintf('%d, %d\n',x1,x2);
   uzakliklar=[];
   
   for  i=1:k
        x2=merkezler(i,2);
        y2=merkezler(i,3);
        z2=merkezler(i,4);
        d2=merkezler(i,5);
        g1=[x1,y1,z1,d1];
        g2=[x2,y2,z2,d2];
        u=uzaklikHesap(g1,g2);
        uzakliklar=[uzakliklar;i,u,x2,y2,z2,d2];
   end
    uzakliklar=sortrows(uzakliklar,2);
    indis=uzakliklar(1,1);
    noktax=uzakliklar(1,3);
    noktay=uzakliklar(1,4);
    noktaz=uzakliklar(1,5);
    noktad=uzakliklar(1,6);
    gruplar=[gruplar;indis,x1,y1,z1,d1];
   
    
end
% display(gruplar);
sonuc=[];
    for i=1:k
            aranan=find(gruplar(:,1)==i);
            merkezler(i,1)=i;
            merkezler(i,2)=floor(mean(set(aranan,1)));
            merkezler(i,3)=floor(mean(set(aranan,2)));
            merkezler(i,4)=floor(mean(set(aranan,3)));
            merkezler(i,5)=floor(mean(set(aranan,4)));
           
    end
    
end
display(merkezler);
cikti=[];

g1=[];g2=[];g3=[];g4=[];g5=[];g6=[];g7=[];

for gn=1:k
  fprintf('Grup:%d\n',gn);
  
  
  indisler=find(gruplar(:,1)==gn);
  byt=size(indisler);
  snc=[];
  for sayac=1:byt(1)
        grupindis=indisler(sayac);
        aitlik=gruplar(grupindis,1);
        gx=gruplar(grupindis,2);
        gy=gruplar(grupindis,3);
        gz=gruplar(grupindis,4);
        gd=gruplar(grupindis,5);
        if(aitlik==1)
                %plot3(gx,gy,gz,'bd');hold on;
                g1=[g1;gx,gy,gz,gd];
        elseif(aitlik==2)
                g2=[g2;gx,gy,gz,gd];
              %  plot3(gx,gy,gz,'y*');hold on;
        elseif(aitlik==3)
             %   plot3(gx,gy,gz,'ks');hold on;
             g3=[g3;gx,gy,gz,gd];
        elseif(aitlik==4)
              %  plot3(gx,gy,gz,'r.');hold on;
              g4=[g4;gx,gy,gz,gd];
        elseif(aitlik==5)
              %  plot3(gx,gy,gz,'m+');hold on;
              g5=[g5;gx,gy,gz,gd];
       elseif(aitlik==6)
             %   plot3(gx,gy,gz,'k*');hold on;     
             g6=[g6;gx,gy,gz,gd];
        else
            g7=[g7;gx,gy,gz,gd];
        end
        
       fprintf('Gün:%d\t Ay:\t%d Sicaklik:%d\t Kume:\t%d \n',gx,gy,gz,aitlik);
      %  fprintf('ara(%d)',grupindis);
       % display(gruplar(grupindis,:));
  end
    xlabel('gun');ylabel('ay');zlabel('sicaklik');
  fprintf('*********************\n');
  
  
end
dizi2=sortrows(gruplar,4);
sonuc=sortrows(gruplar,1);
close all;
columnname = {'Sinif','ay','gün','Sicaklik','Fiyat'};
f = figure('Position',[100 100 500 300]);
d = gallery('integerdata',1000,[1000 5],1);
t = uitable(f,'Position', [25 25 700 600],'Data',sonuc,'ColumnName', columnname,'ColumnWidth',{50});