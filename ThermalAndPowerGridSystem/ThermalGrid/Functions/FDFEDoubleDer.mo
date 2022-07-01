within ThermalAndPowerGridSystem.ThermalGrid.Functions;

function FDFEDoubleDer
  extends Modelica.Icons.Function;
input Integer N;
input Real L;
input Real z[N];
output Real FD2[N,N];
protected
Real A[N,N];
parameter Real dz =L/(N-1);

algorithm


for i in 1:N loop
for j in 1:N loop
 if (i==j) then
 A[i,j]:= -2;
 elseif ((j-i)==1) then  
 A[i,j]:=1;
 elseif ((i-j) ==1) then
 A[i,j]:= 1;
 elseif ((i==N and j==N)) then
 A[i,j] :=-2/3;
 elseif (i==N and j==N-1) then
  A[i,j] :=-2/3;
 else
 A[i,j]:= 0;
 end if;
end for;
end for;


FD2 :=  (1/(dz^2))*A;

end FDFEDoubleDer;
