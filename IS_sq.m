function flag = IS_sq(input)

if abs(input(3)-input(4)) <=0.17*input(4)
    flag=1;
else
    flag=0;
end
end

