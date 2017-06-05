function cout = parlcon( x, a, b )

if (b <= a)
    error('Give a rectangle a < b')
end

c = [x-b;a-x];

cout = max(c);

end

