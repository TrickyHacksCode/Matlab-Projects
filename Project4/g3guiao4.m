function varargout = g3guiao4(varargin)
% g3guiao4 MATLAB code for g3guiao4.fig
%      g3guiao4, by itself, creates a new g3guiao4 or raises the existing
%      singleton*.
%
%      H = g3guiao4 returns the handle to a new g3guiao4 or the handle to
%      the existing singleton*.
%
%      g3guiao4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in g3guiao4.M with the given input arguments.
%
%      g3guiao4('Property','Value',...) creates a new g3guiao4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before g3guiao4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to g3guiao4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help g3guiao4

% Last Modified by GUIDE v2.5 19-Oct-2016 17:01:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @g3guiao4_OpeningFcn, ...
                   'gui_OutputFcn',  @g3guiao4_OutputFcn, ...
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


% --- Executes just before g3guiao4 is made visible.
function g3guiao4_OpeningFcn(hObject, eventdata, handles, varargin)
global img_actual;
global img_original;

img_actual=0;
img_original=imread('rosa.jpg');
axes (handles.axes1);
imshow(img_original);
handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes g3guiao4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = g3guiao4_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in ler_imagem.
function ler_imagem_Callback(hObject, eventdata, handles)
global img_original;
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
    img_actual = imadjust (img_original, [-s 1], [0 1+s], gamma);
else
    img_actual = imadjust (img_original, [0 1-s], [s 1], gamma);
end

if  ctr <= 0;
     img_actual = imadjust (img_actual, [0 1], [-ctr 1+ctr], gamma);
else
    img_actual = imadjust (img_actual, [0+ctr 1.001-ctr], [0 1], gamma);
end

axes(handles.axes2);
imshow (img_actual);  
h = imhist (img_actual);
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
