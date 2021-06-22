clear

A = zeros(12)

for i = 1:11
    A(i, i+1) = 1;
    A(i+1, i) = 1;
end

A(6,7) = 0;
A(7,12) = 0;

uns = ones(12,1);

D = diag(A * uns);

L = D - A

% Calculate eigenvalues
% [V,D] = eig(A) devuelve la matriz diagonal D de los valores propios y
% la matriz V cuyas columnas son los vectores propios derechos correspondientes, de manera que A*V = V*D.
[V,V_D]=eig(L)