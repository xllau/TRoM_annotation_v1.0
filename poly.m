function mask = poly(width,height)
    mask = zeros(width,height);
    position = zeros(1,2);
    h = impoly;
    position = wait(h);
    if size(position,1) > 2
        mask = poly2mask(position(:,1),position(:,2),width,height);
    else
        mask = zeros(width,height);
    end