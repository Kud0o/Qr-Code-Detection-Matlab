function my_3_BB = GetRefrences( I )

[H, W ,~]= size(I);

I = ~I;

[L ,num] = bwlabel(I);


stats = regionprops(L,'BoundingBox','Centroid','Orientation');
indx =0 ;
final = [];
inner= [];
for i=1:num
    repeted =0;
    for O=1:length(inner)
        if inner(O)==i
            repeted =1;
            break; 
        end
    end
    if repeted ==1
        continue;
    end 
    if stats(i).BoundingBox(3) > 4 &&stats(i).BoundingBox(3) < W-10 && stats(i).BoundingBox(4)>4 && stats(i).BoundingBox(4)< H-10 && IS_sq(stats(i).BoundingBox)
       largeB = containsHM(stats(i).BoundingBox,stats,num); 
       is_contains = 0;
        if isempty(largeB)
           continue;
        else
            n= length(largeB);
            if n >0
               is_contains =1;
               inner = [inner;n];
            end
            for k=1:n
                t= largeB(k);
         
          rectangle('Position',stats(t).BoundingBox,'EdgeColor','r','LineWidth',2 );
         
            end
           
       end
        %figure, imshow(Im);
         if is_contains ==1
          rectangle('Position',stats(i).BoundingBox,'EdgeColor','g','LineWidth',2 );
          final=[final;stats(i)];
         
         end        
    end
end
width=0;
for i=1:length(final)
    width=width+final(i).BoundingBox(3);
end
width=width/length(final);
my_3_BB = [];
%figure,imshow(I);
for i=1:length(final)
   if final(i).BoundingBox(3)<= width+2
       my_3_BB=[my_3_BB;final(i)];
       rectangle('Position',final(i).BoundingBox,'EdgeColor','b','LineWidth',2 );

   end
end

for i=1:length(my_3_BB)
   
       rectangle('Position',my_3_BB(i).BoundingBox,'EdgeColor','b','LineWidth',2 );
end
end

