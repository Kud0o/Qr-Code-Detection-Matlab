
Image = imread('Case4\\4.4.bmp');
Image = rgb2gray(Image);

T = Image;
figure,imshow(Image);

I = im2bw(Image);
T = im2bw(Image,0.8);
Refrences = GetRefrences(I);
if length(Refrences)<3
Refrences = GetRefrences(T);
end

rotated = Image;
%for i=1:1000

 corner1 = Refrences(1);
 corner2 = Refrences(1);
 middlecorner= Refrences(1);
 
 dist12 =sqrt((Refrences(1).BoundingBox(1)-Refrences(2).BoundingBox(1)).^2+(Refrences(1).BoundingBox(2)-Refrences(2).BoundingBox(2)).^2);
 dist13 =sqrt((Refrences(1).BoundingBox(1)-Refrences(3).BoundingBox(1)).^2+(Refrences(1).BoundingBox(2)-Refrences(3).BoundingBox(2)).^2);
 dist23 =sqrt((Refrences(3).BoundingBox(1)-Refrences(2).BoundingBox(1)).^2+(Refrences(3).BoundingBox(2)-Refrences(2).BoundingBox(2)).^2);
MaxDist =0;
 if dist12 > dist13 && dist12>dist23
 corner1 = Refrences(1);
 corner2 = Refrences(2);
 middlecorner = Refrences(3);
 MaxDist = dist12;
 end
 
 if dist13 > dist12 && dist13>dist23
corner1 = Refrences(1);
corner2 = Refrences(3);     
middlecorner = Refrences(2);
 MaxDist = dist13;
 end
 
 if dist23 > dist13 && dist23>dist12
 corner1 = Refrences(3);
 corner2 = Refrences(2);
 middlecorner = Refrences(1);
 MaxDist = dist23;
 end
 
 CenterX = (corner1.Centroid(1)+corner2.Centroid(1))/2;
 CenterY = (corner1.Centroid(2)+corner2.Centroid(2))/2;
 wid = middlecorner.BoundingBox(4)/2;
 EstimatedX = 2*CenterX - middlecorner.BoundingBox(1) -middlecorner.BoundingBox(3);
 EstimatedY = 2*CenterY - middlecorner.BoundingBox(2) -middlecorner.BoundingBox(4);
 
 slope= (EstimatedY-middlecorner.BoundingBox(2))/(EstimatedX-middlecorner.BoundingBox(1));
 angle = atand(slope);
 rectangle('Position',[EstimatedX,EstimatedY,middlecorner.BoundingBox(3),middlecorner.BoundingBox(4)],'EdgeColor','b','LineWidth',2 );
 final= imcrop(Image,[CenterX-0.5*MaxDist-wid  CenterY-0.5*MaxDist-wid MaxDist+2*wid MaxDist+2*wid])
 figure,imshow(final);
 Final = final;
 I = im2bw(final);
 [L ,num] = bwlabel(final);
 stats = regionprops(L,'BoundingBox','Centroid','Orientation');
 Max_shape=0;
 Qr = stats(1);
 for i=1:length(stats)
       if stats(i).BoundingBox(3) > Max_shape
           Max_shape=stats(i).BoundingBox(3);
   Qr = stats(i);        
       end
 end
rectangle('Position',Qr.BoundingBox,'EdgeColor','b','LineWidth',2 );
if abs(angle)>48
    angle=angle+180;
end

Final = imrotate(Final,angle-45,'crop');
figure,imshow(Final);

