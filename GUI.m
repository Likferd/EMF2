function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 01-Dec-2014 22:25:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Hide undesired elements on input
set(handles.text4, 'Visible', 'off');
set(handles.popupmenu3, 'Visible', 'off');

%Make Inputs not visible
set(handles.text5, 'Visible', 'off');
set(handles.text6, 'Visible', 'off');
set(handles.text8, 'Visible', 'off');
set(handles.text9, 'Visible', 'off');
set(handles.text10, 'Visible', 'off');
set(handles.text11, 'Visible', 'off');
set(handles.text19, 'Visible', 'off');
set(handles.text21, 'Visible', 'off');
set(handles.text20, 'Visible', 'off');
set(handles.text23, 'Visible', 'off');
set(handles.edit8, 'Visible', 'off');
set(handles.edit10, 'Visible', 'off');
set(handles.edit9, 'Visible', 'off');
set(handles.edit12, 'Visible', 'off');
set(handles.pushbutton4, 'Visible', 'off');
set(handles.edit1, 'Visible', 'off');
set(handles.edit2, 'Visible', 'off');
set(handles.edit4, 'Visible', 'off');
set(handles.edit5, 'Visible', 'off');
set(handles.edit6, 'Visible', 'off');
set(handles.edit7, 'Visible', 'off');


%Make Output not visible
set(handles.text14, 'Visible', 'off');
set(handles.text15, 'Visible', 'off');
set(handles.text17, 'Visible', 'off');
set(handles.text18, 'Visible', 'off');
set(handles.text22, 'Visible', 'off');
drawnow();




% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
transmission_line_type = get(handles.popupmenu1, 'Value');
switch transmission_line_type
    case 1
        handles.transmission_line_type = 'Stripline';
    case 2
        handles.transmission_line_type = 'Coaxial';
    case 3
        handles.transmission_line_type = 'Microstrip';
end
display(handles.transmission_line_type);
circuit_type  = get(handles.popupmenu2, 'Value');
switch circuit_type
    case 1
        handles.circuit_type = 'Wilkinson';
    case 2
        handles.circuit_type = 'Quadrature';
    case 3
        handles.circuit_type = 'Rat-Race';
    case 4
        handles.circuit_type = 'Quarter-Wave';
    case 5
        handles.circuit_type =  'General';
end
display(handles.circuit_type);

% Reveal Output options
set(handles.text4, 'Visible', 'on');
set(handles.popupmenu3, 'Visible', 'on');
%Set Input options to be unchangable
set(handles.pushbutton1, 'Enable', 'off');
drawnow();

guidata(hObject,handles);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(hObject, 'Value')
    case 1
        handles.desired_output = 'Width';
    case 2
        handles.desired_output = 'Length';
    case 3
        handles.desired_output = 'Impedance';
    case 4
        handles.desired_output = 'Propagation Constant';
        if(strcmp(handles.circuit_type,'Quarter-Wave'))
            set(handles.edit12, 'Visible', 'on');
            set(handles.text23, 'Visible', 'on');
        end
    case 5
        handles.desired_output = 'Guide Wavelength';
end
%set inputs visible
set(handles.text5, 'Visible', 'on');
set(handles.text6, 'Visible', 'on');
set(handles.text8, 'Visible', 'on');
set(handles.text9, 'Visible', 'on');
set(handles.text10, 'Visible', 'on');
set(handles.text11, 'Visible', 'on');
set(handles.text19, 'Visible', 'on');
set(handles.text21, 'Visible', 'on');
set(handles.text20, 'Visible', 'on');
set(handles.edit8, 'Visible', 'on');
set(handles.edit10, 'Visible', 'on');
set(handles.edit9, 'Visible', 'on');
set(handles.pushbutton4, 'Visible', 'on');
set(handles.edit1, 'Visible', 'on');
set(handles.edit2, 'Visible', 'on');
set(handles.edit4, 'Visible', 'on');
set(handles.edit5, 'Visible', 'on');
set(handles.edit6, 'Visible', 'on');
set(handles.edit7, 'Visible', 'on');

guidata(hObject,handles)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Re-Enable starting elements
set(handles.pushbutton1, 'Enable', 'on');
set(handles.text4, 'Visible', 'off');
set(handles.popupmenu3, 'Visible', 'off');

%Make Inputs not visible
set(handles.text5, 'Visible', 'off');
set(handles.text6, 'Visible', 'off');
set(handles.text8, 'Visible', 'off');
set(handles.text9, 'Visible', 'off');
set(handles.text10, 'Visible', 'off');
set(handles.text11, 'Visible', 'off');
set(handles.text19, 'Visible', 'off');
set(handles.text21, 'Visible', 'off');
set(handles.text20, 'Visible', 'off');
set(handles.text23, 'Visible', 'off');
set(handles.edit8, 'Visible', 'off');
set(handles.edit10, 'Visible', 'off');
set(handles.edit9, 'Visible', 'off');
set(handles.edit12, 'Visible', 'off');
set(handles.pushbutton4, 'Visible', 'off');
set(handles.pushbutton4, 'Enable', 'on');
set(handles.edit1, 'Visible', 'off');
set(handles.edit2, 'Visible', 'off');
set(handles.edit4, 'Visible', 'off');
set(handles.edit5, 'Visible', 'off');
set(handles.edit6, 'Visible', 'off');
set(handles.edit7, 'Visible', 'off');

%Make Output not visible
set(handles.text14, 'Visible', 'off');
set(handles.text15, 'Visible', 'off');
set(handles.text17, 'Visible', 'off');
set(handles.text18, 'Visible', 'off');
set(handles.text22, 'Visible', 'off');
drawnow();


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
characteristic_impedance = get(handles.edit1, 'String');
try
    handles.input.characteristic_impedance = str2double(characteristic_impedance);
catch
    handles.input.characteristic_impedance = 0;
end
substrate_thickness = get(handles.edit2, 'String');
try
    handles.input.substrate_thickness = str2double(substrate_thickness);
catch
    handles.input.substrate_thickness = 0;
end
metal_thickness = get(handles.edit4, 'String');
try
    handles.input.metal_thickness = str2double(metal_thickness);
catch
    handles.input.metal_thickness = 0;
end
relative_permittivity = get(handles.edit8, 'String');
try
    handles.input.relative_permittivity = str2double(relative_permittivity);
catch
    handles.input.relative_permittivity = 0;
end
phase_shift = get(handles.edit10, 'String');
try
    handles.input.phase_shift = str2double(phase_shift);
catch
    handles.input.phase_shift = str2double(phase_shift);
end
metal_conductivity = get(handles.edit5, 'String');
try
    handles.input.metal_conductivity = str2double(metal_conductivity);
catch
    handles.input.metal_conductivity = 0;
end
frequency = get(handles.edit6, 'String');
try
    handles.input.frequency = str2double(frequency);
catch
    handles.input.frequency = 0;
end
coupling_ratio = get(handles.edit7, 'String');
try
    handles.input.coupling_ratio = str2double(coupling_ratio);
catch
    handles.input.coupling_ratio = 0;
end
relative_permeability = get(handles.edit9, 'String');
try
    handles.input.relative_permeability = str2double(relative_permeability);
catch
    handles.input.relative_permeability = 0;
    
end
load_impedance = get(handles.edit12, 'String');
if(strcmp(handles.circuit_type,'Quarter-Wave'))
    try
        handles.input.load_impedance = str2double(load_impedance);
    catch
        handles.input.load_impedance = 0;
    end
else
    handles.input.load_impedance = 0;
end
set(hObject, 'Enable', 'off');
drawnow();
%Calculate Output
handles.transmission_line_type;
[result1, result2, result3, result4, result5] = calculateGUIOutput(handles.desired_output, handles.transmission_line_type, handles.circuit_type, handles.input.characteristic_impedance, handles.input.substrate_thickness, handles.input.metal_thickness, handles.input.metal_conductivity, handles.input.relative_permittivity, handles.input.relative_permeability, handles.input.frequency, handles.input.coupling_ratio, handles.input.phase_shift, handles.input.load_impedance);

%Set Result 1
set(handles.text14,'String', result1);

%Set Result 2
set(handles.text15, 'String', result2);

%Set Result 3
set(handles.text17, 'String', result3);

%Set Result 4
set(handles.text18, 'String', result4);

%Set Result 5
set(handles.text22, 'String', result5);

%Make Output visible
set(handles.text14, 'Visible', 'on');
set(handles.text15, 'Visible', 'on');
set(handles.text17, 'Visible', 'on');
set(handles.text18, 'Visible', 'on');
set(handles.text22, 'Visible', 'on');
drawnow();

guidata(hObject,handles);



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
