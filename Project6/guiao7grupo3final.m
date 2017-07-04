function varargout = guiao7grupo3final(varargin)
% guiao7grupo3final MATLAB code for guiao7grupo3final.fig
%      guiao7grupo3final, by itself, creates a new guiao7grupo3final or raises the existing
%      singleton*.
%
%      H = guiao7grupo3final returns the handle to a new guiao7grupo3final or the handle to
%      the existing singleton*.
%
%      guiao7grupo3final('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in guiao7grupo3final.M with the given input arguments.
%
%      guiao7grupo3final('Property','Value',...) creates a new guiao7grupo3final or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiao7grupo3final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiao7grupo3final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiao7grupo3final

% Last Modified by GUIDE v2.5 24-Nov-2016 12:33:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiao7grupo3final_OpeningFcn, ...
                   'gui_OutputFcn',  @guiao7grupo3final_OutputFcn, ...
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


% --- Executes just before guiao7grupo3final is made visible.
function guiao7grupo3final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiao7grupo3final (see VARARGIN)

% Choose default command line output for guiao7grupo3final
handles.output = hObject;

global img_phantom;
global senograma;
global img_recon;

img_phantom = '';
senograma = '';
img_recon = '';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiao7grupo3final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiao7grupo3final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function projections_Callback(hObject, eventdata, handles)
global projections;
global senograma;
global degree;
global actual;


projections=str2double(get(hObject,'String'));


    if(projections<181)
      actual=radon(actual,0:180/projections:180);
    elseif (projections>180 && projections<361)
	  actual=radon(actual,0:180/projections:180);
    else h=errordlg('Erro! Tem de ser menor que 360','File Error');
      set(h, 'WindowStyle', 'modal');
      uiwait(h);
      return
    end
degree = 0:180/projections:180;
axes(handles.axes2);
imshow(imresize(actual', [200 200]),[]);



% --- Executes during object creation, after setting all properties.
function projections_CreateFcn(hObject, eventdata, handles)
% hObject    handle to projections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function noise_Callback(hObject, eventdata, handles)
global noise;
global actual;
noise= str2double(get(hObject,'String'));
actual = im2double(actual);
actual = actual + rand(size(actual))*((noise/100)*max(max(actual)));
axes(handles.axes2);
imshow(imresize(actual', [200 200]),[]);


% --- Executes during object creation, after setting all properties.
function noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botao_gravar_senograma.
function botao_gravar_senograma_Callback(hObject, ~, handles)
% hObject    handle to botao_gravar_senograma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global senogramagravar;
global actual;
global name1;

senogramagravar = ( actual / max(max(actual)));
[filename1,pathname1]=uiputfile('*.bmp');
name2 = strcat(pathname1,filename1);
imwrite(senogramagravar, name1,'bmp');
guidata(hObject,handles)



% --- Executes on button press in botao_abrir_senograma.
function botao_abrir_senograma_Callback(hObject, eventdata, handles)
global filename1;
global pathname1;
global name1;
global actual;
global senograma;

[filename1,pathname1]= uigetfile('*.bmp', 'ABRIR SENOGRAMA');
name1 = strcat(pathname1,filename1);
if(isequal(filename1,0)||isequal(pathname1,0))
    disp('Utilizador cancelou');
else
senograma=imread(name1);
actual = senograma;
axes (handles.axes2);
imshow(imresize(senograma', [200 200]),[]);
guidata(hObject,handles)
end
% hObject    handle to botao_abrir_senograma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botao_abrir_senograma_teste.
function botao_abrir_senograma_teste_Callback(hObject, eventdata, handles)
global img_phantom;
global actual;
global degree;
actual = radon(img_phantom, degree);
axes(handles.axes2);
imshow(imresize(actual', [200 200]),[]);

% hObject    handle to botao_abrir_senograma_teste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popup_interpolacao.
function popup_interpolacao_Callback(hObject, eventdata, handles)
% hObject    handle to popup_interpolacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_interpolacao contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_interpolacao

global interpol;
interpol=get(handles.popup_interpolacao,'Value');

switch(interpol)
    case 1
        interpol='nearest';
    case 2
        interpol = 'spline';
    case 3
        interpol = 'linear';
end


% --- Executes during object creation, after setting all properties.
function popup_interpolacao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_interpolacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_filtro.
function popup_filtro_Callback(hObject, eventdata, handles)
% hObject    handle to popup_filtro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_filtro contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_filtro
global actual;
global interpol;
global filtro;
global degree;
global img_recon;


filtro = get(handles.popup_filtro,'Value');
switch(filtro)
    case 1
        filtro ='Ram-Lak';
    case 2
        filtro = 'Shepp-Logan';
    case 3
        filtro ='Cosine';
end
img_recon=iradon(actual,degree,interpol,filtro);
axes(handles.axes3);
imshow(img_recon);

% --- Executes during object creation, after setting all properties.
function popup_filtro_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botao_gravar_reconstrucao.
function botao_gravar_reconstrucao_Callback(hObject, eventdata, handles)
% hObject    handle to botao_gravar_reconstrucao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_recon;
global filename1;
global pathname1;
global name1;
[filename1,pathname1]=uiputfile('*.bmp');
name1= strcat(pathname1,filename1);
imwrite(img_recon, name1,'bmp');
guidata(hObject,handles)

% --- Executes on selection change in popup_phantom.
function popup_phantom_Callback(hObject, eventdata, handles)
global ph;
global img_phantom;
val = get(hObject,'Value');
str = get(hObject, 'String');
ph=str{val};
img_phantom=phantom(ph);
axes(handles.axes1);
imshow(img_phantom);

function popup_phantom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_phantom_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popup_phantom_dimension.
function popup_phantom_dimension_Callback(hObject, eventdata, handles)
global ph;
global n;
global img_phantom;
val = get(hObject,'Value');
str = get(hObject, 'String');
n_str=str{val};
n=str2double(n_str);
img_phantom=phantom(ph,n);
axes(handles.axes1);
imshow(img_phantom);


% --- Executes during object creation, after setting all properties.
function popup_phantom_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_phantom_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botao_gravar_phantom.
function botao_gravar_phantom_Callback(hObject, eventdata, handles)
global img_phantom;
global filename1;
global pathname1;
global name1;
[filename1,pathname1]=uiputfile('*.bmp');
name1 = strcat(pathname1,filename1);
imwrite(img_phantom, name1,'bmp');
guidata(hObject,handles)
