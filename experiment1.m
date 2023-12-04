clear
clc
p=[1 2 0.055j
1 3 0.085j
1 4 0.055j
1 5 0.055j
1 6 0.04j
2 3 5-15j
2 4 1.25-3.75j
3 4 1.6667-5j
3 5 1.6667-5j
3 6 2.5-7.5j
4 5 10-30j
5 6 1.25-3.75j]
refbus=1
sb=p(:,1)
eb=p(:,2)
y=p(:,3)
nbus=max(max(sb),max(eb))
nline=length(eb)
ybus=zeros(nbus)
for i=1:nline
ybus(sb(i),sb(i))=ybus(sb(i),sb(i))+y(i);
ybus(eb(i),eb(i))=ybus(eb(i),eb(i))+y(i);
ybus(sb(i),eb(i))=-y(i);
ybus(eb(i),sb(i))=-y(i);
%fprintf('%0.2f+j%0.2f\n',real(ybus(i)),imag(ybus(i)))
end
for i=1:nbus
for k=1:nbus
if i==1
continue;
elseif k==1
continue;
else
fprintf('%8.2f+(%2.2f)j',real(ybus(i,k)),imag(ybus(i,k)))
end
end
fprintf('\n')
end