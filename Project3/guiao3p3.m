function varargout = guiao3p3(varargin)
% GUIAO3P3 MATLAB code for guiao3p3.fig
%      GUIAO3P3, by itself, creates a new GUIAO3P3 or raises the existing
%      singleton*.
%
%      H = GUIAO3P3 returns the handle to a new GUIAO3P3 or the handle to
%      the existing singleton*.
%
%      GUIAO3P3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIAO3P3.M with the given input arguments.
%
%      GUIAO3P3('Property','Value',...) creates a new GUIAO3P3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiao3p3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiao3p3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiao3p3

% Last Modified by GUIDE v2.5 13-Oct-2016 10:00:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiao3p3_OpeningFcn, ...
                   'gui_OutputFcn',  @guiao3p3_OutputFcn, ...
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


% --- Executes just before guiao3p3 is made visible.
function guiao3p3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiao3p3 (see VARARGIN)
% Choose default command line output for guiao3p3
handles.output = hObject;
handles.s=0;
axes (handles.axes1);
guidata(hObject, handles);

% UIWAIT makes guiao3p3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiao3p3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Abrir_Imagem.
function Abrir_Imagem_Callback(hObject, eventdata, handles)
[handles.filename1,handles.pathname1]= uigetfile('*.jpg', '*.bmp');
handles.name1 = strcat(handles.pathname1,handles.filename1);
handles.img=imread(handles.name1);

axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)


% --- Executes on button press in Gravar_Imagem.
function Gravar_Imagem_Callback(hObject, eventdata, handles)
[handles.filename2,handles.pathname2]=uiputfile('*.jpg');
handles.name2 = strcat(handles.pathname2,handles.filename2,'.jpeg');
imwrite(handles.img, handles.name2);
guidata(hObject,handles)



% --- Executes on button press in Brilho_Mais.
function Brilho_Mais_Callback(hObject, eventdata, handles)
handles.img = imadjust (handles.img,[0;0.9] ,[0.1; 1], 1);
axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)


% --- Executes on button press in Brilho_Menos.
function Brilho_Menos_Callback(hObject, eventdata, handles)
handles.img = imadjust (handles.img,[0.1; 1] ,[0; 0.9], 1);
axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)


% --- Executes on button press in Contraste_Mais.
function Contraste_Mais_Callback(hObject, eventdata, handles)
global Ctr_mais
Ctr_mais =+ 0.1;
handles.img = imadjust (handles.img, [Ctr_mais 1-Ctr_mais], [0 1], 1);

axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)


% --- Executes on button press in Contraste_Menos.
function Contraste_Menos_Callback(hObject, eventdata, handles)
global Ctr_menos
Ctr_menos =+ 0.1;
handles.img = imadjust (handles.img, [0 1], [Ctr_menos 1-Ctr_menos], 1);

axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)

% --- Executes on button press in Gamma_Mais.
function Gamma_Mais_Callback(hObject, eventdata, handles)
global G
G =2;
handles.img = imadjust (handles.img, [], [], G);

axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)


% --- Executes on button press in Gamma_Menos.
function Gamma_Menos_Callback(hObject, eventdata, handles)
global G
G =0.8;
handles.img = imadjust (handles.img, [], [], G);
axes (handles.axes1);
imshow(handles.img)
guidata(hObject,handles)


% --- Executes on button press in hist.
function hist_Callback(hObject, eventdata, handles)
global h;
h = imhist (handles.img);
axes (handles.axes2);
plot(h, 'b')
guidata(hObject,handles)
