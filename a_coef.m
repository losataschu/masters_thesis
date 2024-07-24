function acomat = a_coef(location,state) 

L = length(location.x);
tmp = zeros(3,L);

j0 = 10;
R1 = 0.1;
R2 = 1;
%R = R1/R2;
bt = 0.35;
VM = 1e-05;
Kf = 1e-03;
v2 = 0.35;
DR = 0;

for i=1:L
    tmp(1,i) = ((-j0*R1)/((R2+state.u(3,i))^2))*(state.ux(2,i)*state.ux(3,i) +...
                                              state.uy(2,i)*state.uy(3,i)) +...
               DR*state.u(3,i);
    tmp(2,i) = bt*VM*state.u(1,i)/(Kf+state.u(2,i));
    tmp(3,i) = v2;
end

acomat = tmp;

end