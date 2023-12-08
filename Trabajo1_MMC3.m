
close all

% *****  INTEGRANTES: ***** 
% - Ernesto Mihael Tolentino Leon 

% PROGRAMA: MATLAB 

% PREGUNTA 1

m=input('ingrese num. intervalos para la variable espacial: ');
n=input('ingrese num. intervalos para la variable temporal: ');
a=input('ingrese el extremo a= ');
b=input('ingrese el extremo b= ');
T=input('ingrese el tiempo final T= ');
C=input('ingrese el coeficiente c^2= ');
c1=input('Ingrese la temperatura en x=a, h1(t)=','s');
c2=input('Ingrese la temperatura en x=b, h2(t)=','s');
h1=inline(c1,'t');
h2=inline(c2,'t');
%partición
xnodos=linspace(a,b,m+1);
tnodos=linspace(0,T,n+1);
h=(b-a)/m;
k=T/n;
r=C*k/h^2;
ss=strcat('coeficiente lamda=',num2str(r));disp(ss);
%construyendo la matriz ensamblaje
A=(1+2*r)*eye(m-1)+diag(-r*ones(1,m-2),+1)+diag(-r*ones(1,m-2),-1);
fprintf('La matriz de ensamblaje de %d x %d es ...\n',m-1,m-1);
A
%solucion inicial para t=0 en el interior de [a,b]
fun=input('Ingrese la funcion f(x)=','s');
f=inline(fun);
for i=2:m
    solfila(i-1)=f(xnodos(i));
end
xx=input('Pulse una tecla para continuar ... ','s');
%solucion inicial para t=0 en todo el intervalo [a,b]
sol=[h1(tnodos(1)),solfila,h2(tnodos(1))];
%el proceso iterativo en el metodo explicito
for j=2:n+1
    fila = inv(A)solfila'+inv(A)[r*h1(tnodos(j-1)),zeros(1,m-3),r*h2(tnodos(j-1))]';
    solfila=fila';
    sol=[sol;h1(tnodos(j-1)),solfila,h2(tnodos(j-1))];
end
sol
%grafica de la solucion aproximada
mesh(xnodos,tnodos,sol);
title('solucion aproximada por el metodo implicito');
xlabel('eje x');
ylabel('eje t');




