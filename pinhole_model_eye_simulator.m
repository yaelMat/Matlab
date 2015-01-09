%Creat by Yael Mathov 
%Eye simulator (Pinhole model) 
%Input: jpg picture - 'target.jpg'
%Output: the input picture as presented in a pinhole camera with spherical
%background (helf sphere). The sphere's radius is 1cm.
%The base of the helf sphere background is in (0,0,-2) and the center in (0,0,-1)
%The pinhole in (0,0,0) and the target is 10cm away from the pinhole.

%define constants
photore = 400;
f = 5;

%creat x,y,z sphere
X = linspace(-1,1,photore); 
[x,y] = meshgrid(X, X); 
z = -1- sqrt(1 - x.^2 - y.^2); 

%calculate the points on the image
xt = real((x .* f) ./ z);
yt = real((y .* f) ./ z);
zt = real((z .* f) ./ z);

%load image
target = imread('target.jpg');
[rows,cols,dim]=size(target);

%Convert points to the image perspective
xtu = round((xt / f) * (rows / 2) + (rows / 2));
ytu = round((yt / f) * (cols  / 2) + (cols / 2));

%copy the right pixels fron image to my matrix
matEye = zeros(photore,photore,dim);

for i=[1 : photore]   
    for j=[1 : photore]   
   
        if( and (and((xtu(i,j) > 0) , (ytu(i,j)  > 0)) , z(i,j)<-1))
            matEye(i , j ,1) = target(xtu(j,i)  , ytu(j,i) , 1);
            matEye(i , j  ,2) = target(xtu(j,i)  , ytu(j,i) , 2);
            matEye(i , j  ,3) = target(xtu(j,i)  , ytu(j,i) , 3);
 
        end
    end
end

%display
final = mat2gray(matEye);
imshow(final);




