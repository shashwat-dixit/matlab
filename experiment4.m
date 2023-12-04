clear
clc
vbus =[1.05+0j
.98-0.06j
1-0.05j]
ybus=[20-50j -10+20j -10+30j
-10+20j 16-52j -16+32j
-10+30j -16+32j 26-62j]
n=length(ybus)
Sp=zeros(n,n)
for i=1:n
for k=1:n
if i==k
continue
else
I(i,k)=-ybus(i,k)*(vbus(i)-vbus(k)); %current flow from (i)th bus to (k)th bus from (i)th bus
I(k,i)=-I(i,k) %current flow from (k)th bus to(i)th bus from (k)th bus
S(i,k)=vbus(i)*conj(I(i,k)) %power fed into the line i-k from bus i.
S(k,i)=vbus(k)*conj(I(k,i)) %power fed into the line i-k from bus k.
Sl(i,k)=S(i,k)+S(k,i) % power loss in the line i-k
Sp(i,i)=Sp(i,i)+S(i,k) %total bus power
end
end
end
Sbus=[Sp(1,1); Sp(2,2); Sp(3,3)]
Ibus=conj((Sbus./vbus))