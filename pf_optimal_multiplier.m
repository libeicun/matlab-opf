function om = pf_optimal_multiplier(y0, delta)
    multiplier_a = y0;
    multiplier_b = -multiplier_a;
    multiplier_c = y0 + delta;
    g0 = (multiplier_a') * (multiplier_b);
    g1 = (multiplier_b') * (multiplier_b) + 2*(multiplier_a') * (multiplier_c);
    g2 = 3 * ((multiplier_b') * (multiplier_c));
    g3 = 2 * ((multiplier_c') * (multiplier_c));
    
    mus = roots([g3 g2 g1 g0]);
    mu = mus(mus == real(mus));
    om = mu(1);

    om = 1;