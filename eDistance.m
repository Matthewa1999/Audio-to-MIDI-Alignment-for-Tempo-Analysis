%euclidean distance of two vectors
function d = eDistance(v1,v2)
   x = v2-v1;
   y = x.^2;
   s = sum(y);
   d = sqrt(s);
end