clear;
rng(99);

% create dataset
Xp = randn(2,200)+[7;7];
Xq = randn(2,200)+[1;1];

% appending ones
Xp = [Xp;ones(1,200)];
Xq = [Xq;ones(1,200)];

x = [Xp Xq];
y = [ones(1,200), -ones(1,200)];
n = size(x,2);

w = randn(3,1);
c = 1;

eta = .1;
for it = 1:100
    % randomize, do or not, does not matter
    idx = randperm(400); x = x(:,idx); y = y(idx);
    etai = eta/it;
    for i = 1:n   
%         %         perceptron
%         if y(i)*(w'*x(:,i)) < 0
%             w = w + etai* x(:,i)/(norm(x(:,i)))*y(i);
%             display(sprintf('w:%.5f, %.5f, w0: %.5f', w(1), w(2), w(3)))
%         end
        
    % SVM
    if y(i)*(w'*x(:,i)) <= 1
        w = w + etai* (x(:,i)/(norm(x(:,i)))*y(i) - [c*w(1:end-1);0]);
        display(sprintf('w:%.5f, %.5f, w0: %.5f', w(1), w(2), w(3)))
    end
    end
end

% plotting
fig = figure;
xs = sym('xs',[2,1],'real');
scatter(Xp(1,:),Xp(2,:),'linewidth',2);
hold on;
title("an SM-SVM classifier")
scatter(Xq(1,:),Xq(2,:),'linewidth',2);

h = fcontour(w'*[xs;ones(1,size(xs,2))]);
h.LevelList = [-1, 0, 1];
h.LineWidth = 2;
h.LineStyle = '--';
axis([-2,10,-2,10]);
grid on
colorbar