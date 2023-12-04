clear
clc
p=[1 2 0.6j
1 2 0.4j
1 3 0.5j
2 4 0.2j
3 4 0.5j]
z=[1 2 0.2j
1 3 0.1j]
f1=z(:,1)
s1=z(:,2)
mz2=z(:,3)
sb=p(:,1)
eb=p(:,2)
Z=p(:,3)
n=max(max(sb),max(eb))
ele=length(eb)
ypri=zeros(ele,ele)
ybus=zeros(n)
a=zeros(ele,n)
for i=1:ele
a(i,sb(i))=1
a(i,eb(i))=-1
zpri(i,i)=Z(i)
end
nmc=2
for i=1:nmc
zpri(f1(i),s1(i))=mz2(i);
zpri(s1(i),f1(i))=mz2(i);
end
ypri=inv(zpri)
at=transpose(a)
ybus=at*ypri*a
ybus=ybus(2:4,2:4)