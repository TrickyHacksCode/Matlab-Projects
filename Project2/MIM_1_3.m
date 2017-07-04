function MIM_1_3
% Exercicio 1
a=zeros(200,200);         %criaccao de uma matriz double
b=zeros(200,200,'uint8'); %criaccao de uma matriz uint8
c=zeros(200,200,'int8');  %criaccao de uma matriz int8

%Alteração da área central (100x100)
a(50:150,50:150)=100;
b(50:150,50:150)=100;
c(50:150,50:150)=100;

but;
% w = waitforbuttonpress;
% if w == 0
%     disp('Button click')
% else
%     disp('Key press')
% end

imshow(a)

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end
 
imshow(b)

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(c)

%Alteração da área central (50x50)

a(75:125,75:125)=-50;
b(75:125,75:125)=-50;
c(75:125,75:125)=-50;

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(a)

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(b)

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(c)

% Exercicio 2

r1=imread('rosa.jpg'); %leitura da imagem rosa 

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(r1)

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imwrite(r1,'my_rose.jpg'); % Guardar a imagem com um nome diff

r2=imread('my_rose.jpg');  % Leitura da imagem novamente

imshow(r2)

r3=double(r1)-double(r2); %subtraindo ambas as imagens uma a outra

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(r3,[])

minr3=min(r3); %minimo da matriz resultante

maxr3=max(r3); %maximo da matriz resultante

imwrite(r3,'myy_rose.tiff'); % Guardar a imagem em ext tiff

r4=imread('myy_rose.tiff');

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(r4)

% Exercicio 3

r7=imread('rosa.jpg'); %nova leitura da imagem rosa.jpg

a=50+r7; %matriz imagem + 50

b=a-50; %matriz imagem - 50


w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(r7)


w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(a)


w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(b)


% Exercicio 4

% a criar um bordo de 25 pixels
% Existem 2 metodos possiveis 
% 1 deles verificar o min e max e retirar manualmente
% procuramos uma func que efectua essa redução sem sucesso (pergunta 
% para o professor ) 


% Exercicio 5

r9=imread('rosa.jpg');

g=imrotate(r9,30); %Roda a imagem 30º para a esquerda

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

imshow(g)

h=imrotate(g, -30); %Roda a imagem 30º para a direita

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end

dimshow(h)


%Perguntas Adicionais
%tentativa de func -> erro



function but

w = waitforbuttonpress;
if w == 0
    disp('Button click')
else
    disp('Key press')
end


