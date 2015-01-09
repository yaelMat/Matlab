%Created by Yael Mathov
%Using convolution to find Laplacian or Magnitude of the function: cos(x) + sin(y)

%create and display the function cos(x) + sin(y)
%0 <= x,y <= 2*pi
[x,y] = meshgrid(0 : 0.05 : 2*pi);

f = cos(x) + sin(y);

figure(1)
imagesc(f)
colormap('gray')
axis image
title('original function');

%% Finding the Laplacian 
%Define a 3X3 Laplacian kernel
lapKernel = [0,1,0 ; 1,-4,1 ; 0,1,0];

%convolution between the kernel and the function f
laplacian = (1 / 50) * conv2(f , lapKernel , 'valid');

figure(2)
imagesc(laplacian)
colormap('gray')
title('laplacian');

%% Findinf the Gradient and Magnitude
%Define a 3X3 Derivation kernel, one to derive by y and one to derive by x
DrvKernelY = [-2 -2 -2 -2 -2; -1 -1 -1 -1 -1; 0 0 0 0 0; 1 1 1 1 1; 2 2 2 2 2];
DrvKernelX = DrvKernelY';
 
%Derivation using convolution
yDerivation = (1/50)*conv2(f, DrvKernelY,'valid');
xDerivation = (1/50)*conv2(f, DrvKernelX,'valid');

magnitude = (((yDerivation.^2)+(xDerivation.^2)).^0.5);

figure(3)
imagesc(magnitude)
colormap('gray')
axis image
title('Magnitude of gradient');

%% Finding Zero crossing
%Zero crossing for Laplacian
oneMatrix = ones( size(laplacian) );
betteLap = (oneMatrix ./ (1+ abs(laplacian)));

figure(4)
imagesc(im2bw(betteLap , 0.999999) )
title('zero crossing laplacian');
colormap('gray')