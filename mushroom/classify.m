clear 

% Create table from comma delimiter
data = readtable('agaricus-lepiota.txt','ReadVariableNames',false);
labels = data(:,1); % create a table for the labels
labels = categorical(labels{:,:}); % convert table to a vector of categorical variables


%delete labels column from data matrix
data(:,1) = []; 

% Short the dataset for testing
crop = 1000;
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
S = exp(-1 * distance/(2*(sigma^2)));  %pairwise hamming distances


uns = ones(numrows,1);

% Take off zeros from diagonal
S = S - diag(uns);

% Adjency matrix is semblança matrix
D = diag(S * uns);

% Laplacian
L = D - S;

% Normalized laplacian
L_sn = D^(-0.5) * L * D^(-0.5);

% Random walk laplacian
L_rw = D^(-1)*L;

% Calculate eigenvalues
% [V,D] = eig(A) devuelve la matriz diagonal D de los valores propios y
% la matriz V cuyas columnas son los vectores propios derechos correspondientes, de manera que A*V = V*D.
[V,V_D]=eig(L);
% De forma predeterminada, eig no siempre devuelve los valores propios
% y los vectores propios en orden. Hay que ordenarlos
[d,ind] = sort(diag(V_D));
V_D_sort = V_D(ind,ind);

[idx,C] = kmeans(V_D,2);

% figure; 
% plot(L_sn(idx==1,1),L_sn(idx==1,2),'r.','MarkerSize',12);
% hold on
% plot(L_sn(idx==2,1),L_sn(idx==2,2),'b.','MarkerSize',12)
% plot(C(:,1),C(:,2),'kx', 'MarkerSize',15)
% legend('Cluster 1','Cluster 2','Centroids','Location','NW')
% hold off

CM = confusionmat(L_sn, cats)

