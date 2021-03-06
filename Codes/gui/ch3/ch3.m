function varargout = ch3(varargin)
% CH3 MATLAB code for ch3.fig
%      CH3, by itself, creates a new CH3 or raises the existing
%      singleton*.
%
%      H = CH3 returns the handle to a new CH3 or the handle to
%      the existing singleton*.
%
%      CH3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CH3.M with the given input arguments.
%
%      CH3('Property','Value',...) creates a new CH3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ch3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ch3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ch3

% Last Modified by GUIDE v2.5 18-Dec-2016 19:02:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ch3_OpeningFcn, ...
                   'gui_OutputFcn',  @ch3_OutputFcn, ...
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


% --- Executes just before ch3 is made visible.
function ch3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ch3 (see VARARGIN)

% Choose default command line output for ch3
handles.output = hObject;
handles.FPD = varargin{1}.newVar1 ;
handles.parent = varargin{1}.thisWin ;
handles.action = 'interpolate' ;
handles.numofpoints = 2 ;
handles.act_type = 1 ;

addpath('interpolation');
addpath('curvefitting') ;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ch3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ch3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in goBack.
function goBack_Callback(hObject, eventdata, handles)
% hObject    handle to goBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf) ;
set(handles.parent , 'Visible' , 'on')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_response = modaldlg('Title','Confirm Close');
switch user_response
    case 'No'
        %are you sure
    case 'Yes'
        close(handles.parent) ;
        close(gcf) ;
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
imshow('black.png')
% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in inter_pop.
function inter_pop_Callback(hObject, eventdata, handles)
% hObject    handle to inter_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.act_type = get(hObject, 'Value') - 1;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns inter_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inter_pop


% --- Executes during object creation, after setting all properties.
function inter_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: inter_pop controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pnum_Callback(hObject, eventdata, handles)
% hObject    handle to pnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pnum as text
%        str2double(get(hObject,'String')) returns contents of pnum as a double
input = str2double(get(hObject, 'String')) ;
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
else
    if(floor(input) ~= input || (input < 2))
        errordlg('You must enter a positive integer between 2 and 10','Invalid Input','modal')
        uicontrol(hObject)
        return
    else
        handles.numofpoints = input ;
    end
end

if handles.numofpoints > 10
    set(hObject, 'String', '10');
end

for i = 3:10
    if i <= handles.numofpoints
        set(findobj( 'Tag', strjoin({'x', int2str(i)},'') ) , 'String', num2str(i));
        set(findobj( 'Tag', strjoin({'y', int2str(i)},'') ) , 'String', num2str(2*i));
    else
       set(findobj( 'Tag', strjoin({'x', int2str(i)},'') ) , 'String', '');
       set(findobj( 'Tag', strjoin({'y', int2str(i)},'') ) , 'String', '');
    end
end
  
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_Callback(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y1 as text
%        str2double(get(hObject,'String')) returns contents of y1 as a double
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end

% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1 as text
%        str2double(get(hObject,'String')) returns contents of x1 as a double

input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end

% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in act.
function act_Callback(hObject, eventdata, handles)
% hObject    handle to act (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numofpoints
    X(i) = str2double(get(findobj( 'Tag', strjoin({'x', int2str(i)},'') ), 'String'));
    Y(i) = str2double(get(findobj( 'Tag', strjoin({'y', int2str(i)},'') ), 'String'));
end

if strcmp(handles.action, 'interpolate')
    handles.x_button.Visible = 'On' ;
    handles.x_enter.Visible = 'On' ;
    handles.x_prompt.Visible = 'On' ;
    handles.result_prompt.Visible = 'On' ;
    handles.result.Visible = 'On' ;
    handles.result_prompt.String = 'Interpolation result is:' ;
    handles.result.String = char(interpolate(X,Y,handles.act_type,handles.FPD)) ;   
else
    handles.x_button.Visible = 'On' ;
    handles.x_enter.Visible = 'On' ;
    handles.x_prompt.Visible = 'On' ;
    handles.result_prompt.Visible = 'On' ;
    handles.result.Visible = 'On' ;
    handles.result_prompt.String = 'Curve fitting result is:' ;
    handles.result.String = char(curve_fit(X,Y,handles.act_type,handles.FPD)) ;
end

guidata(hObject, handles);

function y10_Callback(hObject, eventdata, handles)
% hObject    handle to y10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 10)
    set(handles.y10 , 'String' , '') ;
    uicontrol(hObject)
    return
end

guidata(hObject, handles);    

input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y10 as text
%        str2double(get(hObject,'String')) returns contents of y10 as a double


% --- Executes during object creation, after setting all properties.
function y10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x10_Callback(hObject, eventdata, handles)
% hObject    handle to x10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 10)
    set(handles.x10 , 'String' , '') ;
    uicontrol(hObject)
    return
end
guidata(hObject, handles); 

input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x10 as text
%        str2double(get(hObject,'String')) returns contents of x10 as a double


% --- Executes during object creation, after setting all properties.
function x10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y9_Callback(hObject, eventdata, handles)
% hObject    handle to y9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 9)
    set(handles.y9 , 'String' , '') ;
    uicontrol(hObject)
    return
end

input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y9 as text
%        str2double(get(hObject,'String')) returns contents of y9 as a double


% --- Executes during object creation, after setting all properties.
function y9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x9_Callback(hObject, eventdata, handles)
% hObject    handle to x9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 9)
    set(handles.x9 , 'String' , '') ;
    uicontrol(hObject)
    return
end

input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x9 as text
%        str2double(get(hObject,'String')) returns contents of x9 as a double


% --- Executes during object creation, after setting all properties.
function x9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y8_Callback(hObject, eventdata, handles)
% hObject    handle to y8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 8)
    set(handles.y8 , 'String' , '') ;
    uicontrol(hObject)
    return
end

input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y8 as text
%        str2double(get(hObject,'String')) returns contents of y8 as a double


% --- Executes during object creation, after setting all properties.
function y8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x8_Callback(hObject, eventdata, handles)
% hObject    handle to x8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 8)
    set(handles.x8 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x8 as text
%        str2double(get(hObject,'String')) returns contents of x8 as a double


% --- Executes during object creation, after setting all properties.
function x8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y7_Callback(hObject, eventdata, handles)
% hObject    handle to y7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 7)
    set(handles.y7 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y7 as text
%        str2double(get(hObject,'String')) returns contents of y7 as a double


% --- Executes during object creation, after setting all properties.
function y7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x7_Callback(hObject, eventdata, handles)
% hObject    handle to x7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 7)
    set(handles.x7 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x7 as text
%        str2double(get(hObject,'String')) returns contents of x7 as a double


% --- Executes during object creation, after setting all properties.
function x7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y6_Callback(hObject, eventdata, handles)
% hObject    handle to y6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 6)
    set(handles.y6 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y6 as text
%        str2double(get(hObject,'String')) returns contents of y6 as a double


% --- Executes during object creation, after setting all properties.
function y6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x6_Callback(hObject, eventdata, handles)
% hObject    handle to x6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 6)
    set(handles.x6 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x6 as text
%        str2double(get(hObject,'String')) returns contents of x6 as a double


% --- Executes during object creation, after setting all properties.
function x6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y5_Callback(hObject, eventdata, handles)
% hObject    handle to y5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 5)
    set(handles.y5 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y5 as text
%        str2double(get(hObject,'String')) returns contents of y5 as a double


% --- Executes during object creation, after setting all properties.
function y5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x5_Callback(hObject, eventdata, handles)
% hObject    handle to x5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 5)
    set(handles.x5 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x5 as text
%        str2double(get(hObject,'String')) returns contents of x5 as a double


% --- Executes during object creation, after setting all properties.
function x5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y4_Callback(hObject, eventdata, handles)
% hObject    handle to y4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 4)
    set(handles.y4 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y4 as text
%        str2double(get(hObject,'String')) returns contents of y4 as a double


% --- Executes during object creation, after setting all properties.
function y4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x4_Callback(hObject, eventdata, handles)
% hObject    handle to x4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 4)
    set(handles.x4 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x4 as text
%        str2double(get(hObject,'String')) returns contents of x4 as a double


% --- Executes during object creation, after setting all properties.
function x4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y3_Callback(hObject, eventdata, handles)
% hObject    handle to y3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 3)
    set(handles.y3 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y3 as text
%        str2double(get(hObject,'String')) returns contents of y3 as a double


% --- Executes during object creation, after setting all properties.
function y3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x3_Callback(hObject, eventdata, handles)
% hObject    handle to x3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.numofpoints < 3)
    set(handles.x3 , 'String' , '') ;
    uicontrol(hObject)
    return
end
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x3 as text
%        str2double(get(hObject,'String')) returns contents of x3 as a double


% --- Executes during object creation, after setting all properties.
function x3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_Callback(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of y2 as text
%        str2double(get(hObject,'String')) returns contents of y2 as a double


% --- Executes during object creation, after setting all properties.
function y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_Callback(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x2 as text
%        str2double(get(hObject,'String')) returns contents of x2 as a double


% --- Executes during object creation, after setting all properties.
function x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selection.
function selection_Callback(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selection
if(hObject.Value == 1)
    handles.Prompt_choice.String = 'Type of interpolation' ;
    handles.act.String = 'Interpolate' ;
    handles.action = 'interpolate' ;
    handles.inter_pop.Visible = 'On' ;
    handles.fit_pop.Visible = 'Off' ;
else
    handles.Prompt_choice.String = 'Fit to' ;
    handles.act.String = 'Fit' ;
    handles.action = 'fit' ;
    handles.inter_pop.Visible = 'Off' ;
    handles.fit_pop.Visible = 'On' ;
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: inter_pop controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fit_pop.
function fit_pop_Callback(hObject, eventdata, handles)
% hObject    handle to fit_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.act_type = get(hObject, 'Value') - 1;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns fit_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fit_pop


% --- Executes during object creation, after setting all properties.
function fit_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_enter_Callback(hObject, eventdata, handles)
% hObject    handle to x_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));
if isnan(input) || ~isreal(input)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
end
% Hints: get(hObject,'String') returns contents of x_enter as text
%        str2double(get(hObject,'String')) returns contents of x_enter as a double


% --- Executes during object creation, after setting all properties.
function x_enter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in x_button.
function x_button_Callback(hObject, eventdata, handles)
% hObject    handle to x_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
func = get(handles.result , 'String') ;
y = str2double(get(handles.x_enter , 'String' )) ;
mag = char(calc(func, y )) ;
handles.result_is.Visible = 'On' ;
handles.result_is.String = mag ;
guidata(hObject, handles);



function myfunc_Callback(hObject, eventdata, handles)
% hObject    handle to myfunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');

if(isempty(input) )
    errordlg('You must enter a function here','Input required','modal')
    uicontrol(hObject)
    return
end
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of myfunc as text
%        str2double(get(hObject,'String')) returns contents of myfunc as a double


% --- Executes during object creation, after setting all properties.
function myfunc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to myfunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in myfuncbutton.
function myfuncbutton_Callback(hObject, eventdata, handles)
% hObject    handle to myfuncbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1:10
    if i <= handles.numofpoints
        func = get(handles.myfunc , 'String') ;
        y = str2double(get(findobj( 'Tag', strjoin({'x', int2str(i)},'')) , 'String' )) ;
        
        mag = char(calc(func, y )) ;
        set(findobj( 'Tag', strjoin({'x', int2str(i)},'') ) , 'String', num2str(i));
        set(findobj( 'Tag', strjoin({'y', int2str(i)},'') ) , 'String', mag);
    end
end
  
guidata(hObject, handles);
