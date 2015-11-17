
function contains = common_contain(values, v, precision)
    n = common_element_count(values);
    for i = 1:n
        if(abs(values(i) - v) <= (precision))
            contains = true;
            return;
        end
    end
    contains = false;
end