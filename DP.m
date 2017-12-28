% set parameters:
zl=0;
zh=7.5;
N=100; % number of grid for stocks of good;
ol=0.5;
oh=5;
No=20; % number of shocks;
beta=0.95.*ones(1,No); % beta is a 1*5 row vector

% set the grids for z and omiga:
z=linspace(zl,zh,N); % initial stock of goods;
zp=linspace(zl,zh,N); % next period stock of goods;
omiga=linspace(ol,oh,No); % 20 shocks;
% set return function:
F=@(x1,x2,x3)3*(x1+x3-x2)^(1/3)-0.05*(x2)^2; % let x1=z, x2=zp, x3=omiga;
% compute all values of return function:
% question 3:
reward=-inf(N,N,No); % set initial return function;
for i=1:N;
 for j=1:N;
    for k=1:No;
        if zp(j)<=z(i)+omiga(k); % condition for consumption to be nonnegative;
            reward(i,j,k)=F(z(i),zp(j),omiga(k));
        else reward(i,j,k)=-inf;
        end   
    end
 end
end

% question 4 and 5:
tol=10e-9;
newtol=2;
v=zeros(100,20); % initial guess of value function;
vnew=zeros(100,20); % initial matrix for value function;
zpnew=zeros(100,20);
beta=0.95*ones(1,20); % define a row vector 
n=0;
% value function iteration:
while newtol>tol;
  for i=1:100; % i is initial stock;
      for k=1:20;  % k is omiga;
          val=zeros(1,100); % create a temperary 1*5 vector;
          for j=1:100; % j is next period stock, namely policy;
          val(j)=reward(i,j,k)+(1/20)*(beta*v(j,:)');
          end
          [value,u]=max(val,[],2);
          vnew(i,k)=value; % updated value function;
          zpnew(i,k)=u;  % new policy functions;
      end
  end
  newtol=max(max(abs(vnew-v))); % update tolerance;
  v=vnew;
  n=n+1;
end
% the outputs are v(100,20), zpnew(100,20) and n. 


% problem 6:
for m=1:20
  plot(z,v(:,m));
  hold on;
end

% problem 7:
% policy function:
zp=zeros(100,20);
for i=1:100
    for j=1:20
        zp(i,j)=z(zpnew(i,j));
    end
end
% plot the policy function for each omiga:    
for m=1:20
    plot(z,zp(:,m));
    hold on;
end

p=@(x1,x2,x3)(x1+x3-x2)^(-2/3); % price function;
P=zeros(100,20);
for i=1:100
    for j=1:20
        P(i,j)=p(z(i),zp(i,j),omiga(j));
    end 
end
 % plot price function for each omiga:
 for i=1:20
     plot(z,P(:,i));
     hold on;
 end

 
 % question 9: initial value function:
 s=0;
 for i=1:20
     s=s+3*omiga(i)^(1/3);
 end
 
 
 for i=1:100
     for j=1:20
         v(i,j)=3*(z(i)+omiga(j))^(1/3)+19*(1/20)*s;
     end
 end
 
% question 10
 omig=randsample(1:20,100000);
 omiga=omig.*0.25;
 
 














