clear 

% Create table from comma delimiter
data = readtable('agaricus-lepiota.txt','ReadVariableNames',false);
labels = data(:,1); % create a table for the labels
labels = categorical(labels{:,:}); % convert table to a vector of categorical variables


%delete labels column from data matrix
data(:,1) = []; 

% Short the dataset for testing
crop = 10;
cats = categorical(data{1:crop,:});

% Convert table to matrix
% cats = categorical(data{:,:}); 

% Convert the entries of the feature vectors to numerical values using ordinal encoding
cats = double(cats);

% Generate the weighted graph
numrows = size(cats,1);
numcols = size(cats,2);
sigma = 0.5;
distance = pdist2(cats, cats, 'hamming');
S = exp(-1 * distance/(2*sigma));  %pairwise hamming distances

% TODO Hay que quitarle unos
uns = ones(numrows,1);

% Adjency matrix is semblança matrix
D = diag(S * uns);

L = D - S;

% Calculate eigenvalues
% [V,D] = eig(A) devuelve la matriz diagonal D de los valores propios y
% la matriz V cuyas columnas son los vectores propios derechos correspondientes, de manera que A*V = V*D.
[V,V_D]=eig(L);



