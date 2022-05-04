function n = containsHM( BB, stats, length  )
 n =[];
for i= 1:length
    if  IS_sq(stats(i).BoundingBox) && stats(i).BoundingBox(3) > 3 && stats(i).BoundingBox(4)>3 
       
   if BB(1)<stats(i).BoundingBox(1) && BB(2)<stats(i).BoundingBox(2) &&BB(3)+BB(1)>stats(i).BoundingBox(1)+stats(i).BoundingBox(3) &&BB(4)+BB(2)>stats(i).BoundingBox(2)+stats(i).BoundingBox(4)  
   n= [n;i];
   
   end
     end
end

end

