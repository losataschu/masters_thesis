function fcomat = f_coef(location,state)

L = length(location.x);
tmp = zeros(3,L);

j0 = 10;
R1 = 0.1;
R2 = 1;
%R = R1/R2;
VM1 = 10;
Kw = 1;
ow = 20;
et = 1;
VM2 = 1;
Kn = 10;

for i=1:L
    tmp(1,i) = (-j0*R1/(R2+state.u(3,i)))*(state.ux(1,i)*state.ux(2,i)+...
                                           state.uy(1,i)*state.uy(2,i));
    tmp(3,i) = (VM1*ow/(Kw+ow))*(VM2*state.u(1,i)/(Kn+state.u(1,i)))*et*state.u(2,i);
end

fcomat = tmp;

end