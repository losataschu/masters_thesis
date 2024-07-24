function ccomat = c_coef(location,state)

L = length(location.x);
tmp = zeros(36,L);

j0 = 10;
R1 = 0.1;
R2 = 1;
%R = R1/R2;
Dn = 0.0025;
Df = 1e-05;

for i = 1:L
    tmp(1,i) = Dn;
    tmp(4,i) = Dn;
    tmp(13,i) = (-j0*R1)*(state.u(1,i)/(R2+state.u(3,i)));
    tmp(16,i) = (-j0*R1)*(state.u(1,i)/(R2+state.u(3,i)));
    tmp(17,i) = Df;
    tmp(20,i) = Df;
end

ccomat = tmp;

end