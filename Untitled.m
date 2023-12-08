clc
clear
close all

% - Ernesto Mihael Tolentino Leon 

% PROGRAMA: MATLAB 

function w=poison(x1,xr,yb,yt,M,N)
f=@(x,y) -1.2; g1=@(x) x*(6-x); g2=@(x) 0;
g3=@(y) y*(5-y); g4=@(y) 0;
m=M+1; n=N+1; mn=m*n; close all 
h=(xr-x1)/M; h2=h^2; k=(yt-yb)/N; k2=k^2;
x=x1+(0:M)*h; y=yb+(0:N)*k;
A=zeros(mn,mn); b=zeros(mn,1);
for i=2:m-1
for j=2:n-1
    A(i+(j-1)*m,i-1+(j-1)*m)=1/h2;
    A(i+(j-1)*m,i+1+(j-1)*m)=1/h2;
    A(i+(j-1)*m,i+(j-1)*m)= -2/h2-2/k2;
    A(i+(j-1)*m,i+(j-2)*m)=1/k2;
    A(i+(j-1)*m,i+j*m)=1/k2;
    b(i+(j-1)*m)=f(x(i),y(j));
end
    
end

for i=1:m
    j=1;
    A(i+(j-1)*m,i+(j-1)*m)=1;
    b(i+(j-1)*m)=g1(x(i));
    j=n;
    A(i+(j-1)*m,i+(j-1)*m)=1;
    b(i+(j-1)*m)=g2(x(i));
end
for j=2:n-1
    i=1;
    A(i+(j-1)*m,i+(j-1)*m)=1;
    b(i+(j-1)*m)=g3(y(j));
    i=m;
    A(i+(j-1)*m,i+(j-1)*m)=1;
    b(i+(j-1)*m)=g4(y(j));
end

A
v=A\b;

w=reshape(v(1:mn),m,n);
mesh(x,y,w')
    
    
    
end