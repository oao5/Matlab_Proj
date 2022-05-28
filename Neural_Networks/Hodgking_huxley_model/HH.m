function [Vt,nt,ht,mt] = HH(V0,C,g_k,g_Na,g_l,E_Na,E_l,E_k,I_ex,dt)

    Vt = zeros(1,length(I_ex));
    Vt(1) = V0; 
    mt = zeros(1,length(I_ex)-1);
    nt = zeros(1,length(I_ex)-1);
    ht =zeros(1,length(I_ex)-1);
    m = 0.0529;
    n = 0.317; 
    h = 0.597;
    
    for i = 1: (length(I_ex)-1)
       V=Vt(i);
       I_K = g_k * n^4 * (E_k-V);
       I_Na = g_Na *m^3 * h * (E_Na-V);
       I_L  = g_l*(E_l - V);
       I_tot = I_K + I_L+ I_Na + I_ex(i);
       dv_dt = I_tot/C ;
       Vt(i+1) = V + dv_dt*(dt*1000);
       [a_n,b_n,a_m,b_m,a_h,b_h] = a_b((V));
       n = n + ((a_n*(1-n) - b_n*n)*(dt*1000));
       m = m + ((a_m*(1-m) - b_m*m)*(dt*1000)) ;
       h = h + ((a_h*(1-h) - b_h*h)*(dt*1000));
       nt(i)= n;
       mt(i)= m;
       ht(i)= h;
    end
end

function [a_n,b_n,a_m,b_m,a_h,b_h] = a_b(t)
    v=t*1000;
    a_n = 0.01 * (v + 55) / (1 - exp(-(v + 55) / 10));
    b_n = 0.125 * exp(-(v + 65) / 80);
    a_m = 0.1 * (v + 40) / (1 - exp(-(v + 40) / 10));
    b_m = 4 * exp(-(v + 65) / 18);
    a_h = 0.07 * exp(-(v + 65) / 20);
    b_h = 1 / (1 + exp(-(v + 35) / 10));
end




