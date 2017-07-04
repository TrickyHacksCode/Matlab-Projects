function varargout = g3guiao5(varargin)
% g3guiao5 MATLAB code for g3guiao5.fig
%      g3guiao5, by itself, creates a new g3guiao5 or raises the existing
%      singleton*.
%
%      H = g3guiao5 returns the handle to a new g3guiao5 or the handle to
%      the existing singleton*.
%
%      g3guiao5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in g3guiao5.M with the given input arguments.
%
%      g3guiao5('Property','Value',...) creates a new g3guiao5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before g3guiao5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to g3guiao5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help g3guiao5

% Last Modified by GUIDE v2.5 20-Oct-2016 15:48:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @g3guiao5_OpeningFcn, ...
                   'gui_OutputFcn',  @g3guiao5_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before g3guiao5 is made visible.
function g3guiao5_OpeningFcn(hObject, eventdata, handles, varargin)
global img_actual;
global img_original;

img_actual=0;
img_original=0;
handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes g3guiao5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = g3guiao5_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in ler_imagem.
function ler_imagem_Callback(hObject, eventdata, handles)
global img_original;
global img_actual;
global filename1;
global pathname1;
global name1;

[filename1,pathname1]= uigetfile('*.jpg;*.bmp;*.jpeg', 'ABRIR FICHEIRO');
name1 = strcat(pathname1,filename1);
img_original=imread(name1);

axes (handles.axes1);

imshow(img_original)

repor_original_Callback(hObject, eventdata, handles)

guidata(hObject,handles)

% --- Executes on button press in gravar_imagem.
function gravar_imagem_Callback(hObject, eventdata, handles)
global img_actual;
global img_original;
global filename2;
global pathname2;
global name2;

[filename2,pathname2]=uiputfile('*.jpg', '*.bmp');
name2 = strcat(pathname2,filename2);
if  img_actual == 0
    imwrite(img_original, name2);
else 
     imwrite(img_actual, name2);
end
guidata(hObject,handles)


% --- Executes on slider movement.
function slider_brilho_Callback(hObject, eventdata, handles)
MyAdjust (hObject, eventdata, handles)
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider_brilho_CreateFcn(hObject, eventdata, handles)
global s;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
s=(get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes on slider movement.
function slider_contraste_Callback(hObject, eventdata, handles)
MyAdjust (hObject, eventdata, handles)
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider_contraste_CreateFcn(hObject, eventdata, handles)
global ctr;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
ctr=(get(hObject,'Value')/2);
guidata(hObject,handles)


% --- Executes on slider movement.
function slider_gamma_Callback(hObject, eventdata, handles)
MyAdjust (hObject, eventdata, handles);
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function slider_gamma_CreateFcn(hObject, eventdata, handles)
global gamma;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
gamma=(get(hObject,'Value'))
guidata(hObject,handles)

function MyAdjust (hObject, eventdata, handles)
global s;
global ctr;
global gamma;

s=(get(handles.slider_brilho,'Value'))
ctr=(get(handles.slider_contraste,'Value')/2)
gamma=(get(handles.slider_gamma,'Value'))


if s < 0;
    h1= num2str(s-0.001);
else 
    h1= num2str(s+0.001);
end
if s == 0;
    h1= num2str(s);
end
set(handles.brilho_text,'String',h1);
h2= num2str(ctr*2);
set(handles.contraste_text,'String',h2);
h3= num2str(gamma);
set(handles.gamma_text,'String',h3);

global img_actual;
global img_original;

if s <= 0;
    img_actual = imadjust (img_original, [-s 1], [0 1+s]);
else
    img_actual = imadjust (img_original, [0 1-s], [s 1]);
end

if  ctr <= 0;
     img_actual = imadjust (img_actual, [0 1], [-ctr 1+ctr], gamma);
else
    img_actual = imadjust (img_actual, [0+ctr 1.001-ctr], [0 1], gamma);
end

axes(handles.axes2);
imshow (img_actual);  
display_hist(hObject,eventdata,handles,img_actual)


function display_hist(hObject, eventdata, handles, image)
h = imhist (image);
axes (handles.axes3);
plot(h/max(h), 'b');
hold on;
j = cumsum (h);
plot(j/max(j), 'r');
hold off;
legend('Histograma','Histograma Cumulativo')
guidata(hObject,handles)


% --- Executes on button press in repor_original.
function repor_original_Callback(hObject, eventdata, handles)
set(handles.slider_brilho,'Value',0);
set(handles.slider_contraste,'Value',0);
set(handles.slider_gamma,'Value',1);
MyAdjust(hObject, eventdata, handles);
guidata(hObject,handles)

% --- Executes on button press in filtro_on.
function filtro_on_Callback(hObject, eventdata, handles)
% hObject    handle to filtro_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_actual;
global img_filtrada;
global f;
global d;
global p1;
global p2;

switch f;
case 'Media' 
    filtro = fspecial('average',d); 
    img_filtrada = imfilter(img_actual,filtro);
 
case 'Gaussiano' 
    filtro = fspecial('gaussian',d ,p1); 
    img_filtrada = imfilter(img_actual,filtro);

case 'Sobel Horizontal' 
    filtro = fspecial('sobel');
    img_filtrada = imfilter(img_actual,filtro);
 
case 'Sobel Vertical' 
    filtro = fspecial('sobel');
    img_filtrada = imfilter(img_actual,filtro');

case 'Laplaciano' 
    if p1>1 || p1<0
        h=errordlg('Erro! Tente um alpha entre 0 e 1','File Error');
        set(h, 'WindowStyle', 'modal');
        uiwait(h);
        return
         end
    filtro = fspecial('laplacian',p1);
    img_filtrada = imfilter(img_actual,filtro);
case 'Mediano' 
    img_filtrada = medfilt2(img_actual, [p1 p2]);
end

axes(handles.axes2);
imshow(img_filtrada);
display_hist(hObject, eventdata, handles, img_filtrada);

% --- Executes on selection change in filtro.
function filtro_Callback(hObject, eventdata, handles)
% hObject    handle to filtro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filtro contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filtro
global img_actual;
global f;
global d;
global p1;
global p2;
val = get(hObject,'Value');
str = get(hObject, 'String');
set(handles.dimensao, 'String', '');
set(handles.parametro1, 'String', '');
set(handles.parametro2, 'String', '');
f=str{val};
d=3;

switch f; 
case 'Media' 
    set(handles.dimensao,'Enable','on');
    set(handles.parametro1,'Enable','off');
    set(handles.parametro2,'Enable','off');
case 'Gaussiano' 
    s1='Sigma';
    set(handles.dimensao,'Enable','on');
    set(handles.parametro1,'Enable','on');
    set(handles.parametro1_text,'String',s1);
    set(handles.parametro2,'Enable','off');
    p1=1;
case 'Sobel Horizontal'
    set(handles.dimensao,'Enable','off');
    set(handles.parametro1,'Enable','off');
    set(handles.parametro2,'Enable','off');
case 'Sobel Vertical' 
    set(handles.dimensao,'Enable','off');
    set(handles.parametro1,'Enable','off');
    set(handles.parametro2,'Enable','off');
case 'Laplaciano'
    s1='Alpha';
    set(handles.dimensao,'Enable','off');
    set(handles.parametro1,'Enable','on');
    set(handles.parametro2,'Enable','off');
    set(handles.parametro1_text,'String',s1);
    p1=0.2;
case 'Mediano'
    s1='M';
    s2='N';
    set(handles.parametro2,'Enable','on');
    set(handles.parametro1,'Enable','on');
    set(handles.dimensao,'Enable','off');
    set(handles.parametro1_text,'String',s1);
    set(handles.parametro2_text,'String',s2);
    p1=3;
    p2=3;

end

% --- Executes during object creation, after setting all properties.
function filtro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filtro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dimensao_Callback(hObject, eventdata, handles)
% hObject    handle to dimensao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dimensao as text
%        str2double(get(hObject,'String')) returns contents of dimensao as a double
global d;
d = str2double(get(hObject, 'String'));

% --- Executes during object creation, after setting all properties.
function dimensao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimensao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function parametro1_Callback(hObject, eventdata, handles)
% hObject    handle to parametro1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parametro1 as text
%        str2double(get(hObject,'String')) returns contents of parametro1 as a double
global p1;
p1 = str2double(get(hObject, 'String'));

% --- Executes during object creation, after setting all properties.
function parametro1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parametro1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function parametro2_Callback(hObject, eventdata, handles)
% hObject    handle to parametro2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parametro2 as text
%        str2double(get(hObject,'String')) returns contents of parametro2 as a double
global p2;
p2 = str2double(get(hObject, 'String'));

% --- Executes during object creation, after setting all properties.
function parametro2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parametro2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
