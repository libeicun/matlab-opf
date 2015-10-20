function isNearZero = pf_near_zero(vector, precision)

    isNearZero = 1;
    n = size(vector);
    i = n(1);
    j = n(2);

    for i_ = 1:i
        for j_ = 1:j
            if abs(vector(i_,j_)) > precision
                isNearZero = 0;
                return;
            end
        end
    end