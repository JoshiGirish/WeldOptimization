function Cx = centroid4(mvl,mvm1,mvm2,mvh,kl,km1,km2,kh,input)
% Calculate the intersection point on membership lines
lpoint = kl + (1-mvl)*(km1-kl);
m1point1 = km1 - (1-mvm1)*(km1-kl);
m1point2 = km1 + (1-mvm1)*(km2-km1);
m2point1 = km2 - (1-mvm2)*(km2-km1);
m2point2 = km2 + (1-mvm2)*(kh-km2);
hpoint = km2 + mvh*(kh-km2);
min1 = round(min(input));
max1 = round(max(input));
% Calculate the individual areas of rectangles and triangles
Arec1 = (lpoint-min1)*mvl;
Arec2 = (m1point2-m1point1)*mvm1;
Arec3 = (m2point2-m2point1)*mvm2;
Arec4 = (max1-hpoint)*mvh;
Atri1 = 1/2*(km1-lpoint)*mvl;
Atri2 = 1/2*(m1point1-kl)*mvm1;
Atri3 = 1/2*(km2-m1point2)*mvm1;
Atri4 = 1/2*(m2point1-km1)*mvm2;
Atri5 = 1/2*(kh-m2point2)*mvm2;
Atri6 = 1/2*(hpoint-kh)*mvh;
% Calculate the individual centroids of the rectangles and triangles
Crec1 = [(min1+lpoint)/2 mvl/2];
Crec2 = [(m1point2+m1point1)/2 mvm1/2];
Crec3 = [(m2point2+m2point1)/2 mvm2/2];
Crec4 = [(max1+hpoint)/2 mvh/2];
Ctri1 = [lpoint+(km1-lpoint)/3 mvl/3];
Ctri2 = [m1point1-(m1point1-kl)/3 mvm1/3];
Ctri3 = [m1point2+(km2-m1point2)/3 mvm1/3];
Ctri4 = [m2point1-(m2point1-km1)/3 mvm2/3];
Ctri5 = [m2point2+(kh-m2point2)/3 mvm2/3];
Ctri6 = [hpoint-(hpoint-kh)/3 mvh/3];
% Total Area
A = Arec1 + Arec2 + Arec3 + Arec4 + Atri1 + Atri2 + Atri3 + Atri4 + Atri5 + Atri6;
moment = Crec1(1)*Arec1+Crec2(1)*Arec2+Crec3(1)*Arec3+Crec4(1)*Arec4+Ctri1(1)*Atri1+Ctri2(1)*Atri2+Ctri3(1)*Atri3+Ctri4(1)*Atri4+Ctri5(1)*Atri5+Ctri6(1)*Atri6;
if A == 0
    Cx = 0;
else
    Cx = moment/A;
end