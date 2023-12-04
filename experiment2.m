clear
clc
p=[1 2 0.035j
1 3 0.03j
1 4 0.045j
2 3 10-30j
2 4 1.25-3.75j
3 4 1.67-5j]
refbus=1
sb=p(:,1)
eb=p(:,2)
y=p(:,3)
n=max(max(sb),max(eb))
ele=length(eb)
ypri=zeros(ele,ele)
ybus=zeros(n)
a=zeros(ele,n)
for i=1:ele
a(i,sb(i))=1
a(i,eb(i))=-1
end
a=a(:,2:4)
for i=1:ele
ypri(i,i)=y(i)
end
at=transpose(a);
ybus=at*ypri*a