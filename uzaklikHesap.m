function uzaklik=uzaklikHesap(noktalar1,noktalar2)
x1=noktalar1(1,1);
y1=noktalar1(1,2);
z1=noktalar1(1,3);
d1=noktalar1(1,4);

x2=noktalar2(1,1);
y2=noktalar2(1,2);
z2=noktalar2(1,3);
d2=noktalar2(1,4);

a=(x2-x1)^2;
b=(y2-y1)^2;
c=(z2-z1)^2;
d=(d2-d1)^2;
uzaklik=sqrt(a+b+c+d);
end