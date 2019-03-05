function varargout = lab1(varargin)
% LAB1 MATLAB code for lab1.fig
%      LAB1, by itself, creates a new LAB1 or raises the existing
%      singleton*.
%
%      H = LAB1 returns the handle to a new LAB1 or the handle to
%      the existing singleton*.
%
%      LAB1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB1.M with the given input arguments.
%
%      LAB1('Property','Value',...) creates a new LAB1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab1

% Last Modified by GUIDE v2.5 26-Feb-2019 10:38:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab1_OpeningFcn, ...
                   'gui_OutputFcn',  @lab1_OutputFcn, ...
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


% --- Executes just before lab1 is made visible.
function lab1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab1 (see VARARGIN)

% Choose default command line output for lab1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


set(handles.uitable2, 'Visible' , 'off')
set(handles.pushbutton3, 'Visible' , 'off')
set(handles.butonDeseneaza, 'Visible' , 'off')
set(handles.axes1, 'Visible' , 'off')

% UIWAIT makes lab1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in alegeN.
function alegeN_Callback(hObject, eventdata, handles)
% hObject    handle to alegeN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns alegeN contents as cell array
%        contents{get(hObject,'Value')} returns selected item from alegeN

n = get(handles.alegeN,'Value') % valoarea selectata din popmenu (2 ,3 sau 4 ) 
set(handles.uitable2, 'Visible' , 'on')
set(handles.uitable2, 'Data', cell(n+1 , n+1)) % seteaza tabelul cu nr de linii si coloane. 
set(handles.uitable2, 'ColumnEditable', true(1,n+1)) % seteaza celulele sa poata fi modificate/adaugate valori , etc. 
set(handles.butonDeseneaza, 'Visible' , 'on') 
set(handles.pushbutton3, 'Visible' , 'on')

% ajusteaza uitable sa nu mai apara spatiu alb. 
table = handles.uitable2;
table.Units = 'pixels';
width = table.Position(3)-31; % subtracting by 31 to account for row header
ncol = size(table.Data, 2);
table.ColumnWidth = num2cell(ones(1,ncol)*width/ncol);
table.Position(3:4) = table.Extent(3:4);
% Sfarsit ajustare tabel.

% --- Executes during object creation, after setting all properties.
function alegeN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alegeN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in butonDeseneaza.
function butonDeseneaza_Callback(hObject, eventdata, handles)
% hObject    handle to butonDeseneaza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla;
dateTabel = (get(handles.uitable2,'Data')); % datele din uitable. 
n = get(handles.alegeN,'Value'); % nr selectat 1, 2, 3 sau 4 .. 
tmp = str2double(dateTabel); % face valorile double 
idx = isnan(tmp); 
str = dateTabel(idx); 
numarCaractere = size(str,1); % afiseaza valorile care nu sunt numere .. 

if isequal(class(dateTabel),'double') % datele generate prin actionarea butonului "Genereaza .. " sunt de tip double iar cele 
    % de la tastatura sunt de tip cell. 
    Gershg(dateTabel);
elseif isequal(class(dateTabel),'cell')
   if verificareCamp(n,dateTabel) > 0 % verifica daca sunt campuri goale. 
       warndlg('Toate campurile sunt obligatorii.')
   elseif numarCaractere > 0 && verificareCamp(n,dateTabel) == 0 % verifica daca au fost introduse date eronate.. 
       warndlg('Au fost introduse date eronate.')
   else
       %operatie = valoare(T);
       set(handles.axes1, 'Visible' , 'on')
       l = 1;
       for i = 1:(n+1)
           for j = 1:(n+1)
              A(i,j) = str2double(dateTabel{l}); % face fiecare element din A de tip double.
              if l <= (n+1)^2
                 l = l+1;
              end
           end
       end
       Gershg(A);   
   end
end

function verificare = verificareCamp(n,dateTabel)
i = 0;
numarElemente = (n+1)^2
for c = 1:numarElemente
    if isempty(dateTabel{c}) == 1;
        i=i+1; % numarul de elemente care nu sunt numere.
    end
end
verificare = i;


% --- Executes when selected cell(s) is changed in uitable2.
function uitable2_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = get(handles.alegeN,'Value');
cla;
set(handles.axes1, 'Visible' , 'on')
A = (15-(-3)).*rand(n+1,n+1) + (-5);
set(handles.uitable2, 'Data' , A)



        
