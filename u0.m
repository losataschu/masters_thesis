function u0cell = u0(location)

L = length(location.x);
tmp = zeros(3,L);
A = 0.002;
B = 0.003;

for i = 1:L
    tmp(2,i) = -A*location.x(i)+B;
    if (0.7 < location.x(i) && location.x(i) < 0.9)
        tmp(1,i) = 18;
    end
end

u0cell = tmp;

end