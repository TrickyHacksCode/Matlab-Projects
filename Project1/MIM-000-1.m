a = zeros(15,15);
b = ones(15,15);

a(1,2)=1;
a(2,:)=1;
a(4:6,1:4)=1;
a(8:2:15,6:8)=1;

b(1:2:15,1:2:15)=0;

c = zeros(250,250);
c(51:100,:)=0.25;
c(101:150,:)=0.5;
c(151:200,:)=0.75;
c(201:250,:)=1;

imshow(a)

k = waitforbuttonpress;
if k == 0;
    disp('Button Click')
else 
    disp('Key Press')
end

imshow(b)

k = waitforbuttonpress;
if k == 0;
    disp('Button Click')
else 
    disp('Key Press')
end

imshow(c)

