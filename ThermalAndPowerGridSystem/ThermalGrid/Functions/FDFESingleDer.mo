within ThermalAndPowerGridSystem.ThermalGrid.Functions;

function FDFESingleDer
  extends Modelica.Icons.Function;
input Integer N;
input Real z[N];
input Real L;
output Real FD[N,N];
protected
Real A[N,N];
parameter Real dz =L/(N-1);

algorithm


for i in 1:N-1 loop
for j in 1:N loop
 if (i==j) then
 A[i,j]:= 0;
 elseif ((j-i)==1) then  
 A[i,j]:=1;
 elseif ((i-j) ==1) then
 A[i,j]:= -1;
 elseif ((i==1 and j==N)) then
 A[i,j] := -1;
 else
 A[i,j]:= 0;
 end if;
end for;
end for;

for j in 1:N loop
if ((N-j)==1) then
A[N,j] := -1;
elseif (j==1) then
A[N,j] := 1;
else
A[N,j] := 0;
end if;
end for;

FD :=  1/(2*dz)*A;

end FDFESingleDer;
