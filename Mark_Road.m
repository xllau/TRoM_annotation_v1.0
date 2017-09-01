function varargout = Mark_Road(varargin)
% MARK_ROAD MATLAB code for Mark_Road.fig
%      MARK_ROAD, by itself, creates a new MARK_ROAD or raises the existing
%      singleton*.
%
%      H = MARK_ROAD returns the handle to a new MARK_ROAD or the handle to
%      the existing singleton*.
%
%      MARK_ROAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MARK_ROAD.M with the given input arguments.
%
%      MARK_ROAD('Property','Value',...) creates a new MARK_ROAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Mark_Road_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Mark_Road_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Mark_Road

% Last Modified by GUIDE v2.5 01-Jan-2017 18:20:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Mark_Road_OpeningFcn, ...
                   'gui_OutputFcn',  @Mark_Road_OutputFcn, ...
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

% --- Executes just before Mark_Road is made visible.
function Mark_Road_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for Mark_Road
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Mark_Road wait for user response (see UIRESUME)
% uiwait(handles.figure_mark);
setappdata(handles.figure_mark,'img_src',0);
setappdata(handles.figure_mark,'index',1);
setappdata(handles.figure_mark,'count',1);
setappdata(handles.figure_mark,'pathname',' ');
setappdata(handles.figure_mark,'list',' ');

 axes(handles.axes_road);imshow(imread('.\pic\road.png'));
 axes(handles.axes_sidewalk);imshow(imread('.\pic\sidewalk.png'));
 axes(handles.axes_nopark);imshow(imread('.\pic\nopark.png'));
 axes(handles.axes_guide);imshow(imread('.\pic\guide.png'));
 axes(handles.axes_police);imshow(imread('.\pic\police.png'));
 axes(handles.axes_lane);imshow(imread('.\pic\lane.png'));
 axes(handles.axes_stop);imshow(imread('.\pic\stop.png'));
axes(handles.axes_warn_sidewalk);imshow(imread('.\pic\warn_sidewalk.png'));
axes(handles.axes_followme);imshow(imread('.\pic\followme.png'));
axes(handles.axes_stop_wait);imshow(imread('.\pic\stop_wait.png'));
axes(handles.axes_none_vehicle);imshow(imread('.\pic\none_vehicle.png'));
axes(handles.axes_src);


% --- Outputs from this function are returned to the command line.
function varargout = Mark_Road_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function m_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [filename, pathname] = uigetfile( ...
%        {'*.txt','All Files (*.*)'; ...
%         '*.*',  'All Files (*.*)'}, ...
%         'Pick an image');
%     if isequal(filename,0) || isequal(pathname,0),
%         return;
%     end
%     
%     axes(handles.axes_src);
%     fpath=[pathname filename];
    global path_image;    global path_list;    global path_save;
    global width;    global height;
    global gt_img;  global  img;
    global list;
    index = 1;
    path_image =  '.\image\';
    path_list = '.\list.txt';
    path_save = '.\gt\';
    list_cell = textread(path_list,'%s');
    list = char(list_cell);
    img=imread([path_image list(index,:)]);
    gt_img = zeros(size(img,1),size(img,2),'uint8');
    width = size(img,1);
    height = size(img,2);
    axes(handles.axes_src);
    filename_gt = [path_save 'gt_' list(index,:)];
    if ~isempty(dir(filename_gt))
        gt_img = imread(filename_gt);
        show_mark(gt_img,img);
    else
        imshow(img);
    end
    set(findobj('tag','m_index'),'string',int2str(index));
    setappdata(handles.figure_mark,'list',list);
    setappdata(handles.figure_mark,'count',size(list,1));
    setappdata(handles.figure_mark,'index',index);

% --- Executes on button press in m_last.
function m_last_Callback(hObject, eventdata, handles)
    global path_image;    global path_list;    global path_save;    global list;
    global width;    global height;
    global gt_img;  global  img;
    index = getappdata(handles.figure_mark,'index');
    index = index - 1;
    axes(handles.axes_src);
    if(index < 1)
        index =1;
    else
        img=imread([path_image list(index,:)]);
        filename_gt = [path_save 'gt_' list(index,:)];
        if ~isempty(dir(filename_gt))
            gt_img = imread(filename_gt);
            show_mark(gt_img,img);
        else
            gt_img(:,:) = 0;
            imshow(img);
        end
    end
    set(findobj('tag','m_index'),'string',int2str(index));
    setappdata(handles.figure_mark,'index',index);

% --- Executes on button press in m_next.
function m_next_Callback(hObject, eventdata, handles)
    global path_image;    global path_list;    global path_save;    global list;
    global width;    global height;
    global gt_img;  global  img;
    index = getappdata(handles.figure_mark,'index');
    count = getappdata(handles.figure_mark,'count');
    index = index + 1;
    if(index > count)
        index =count;
    else
        img=imread([path_image list(index,:)]);
        filename_gt = [path_save 'gt_' list(index,:)];
        if ~isempty(dir(filename_gt))
            gt_img = imread(filename_gt);
            show_mark(gt_img,img);
        else
            gt_img(:,:) = 0;
            imshow(img);
        end
    end
    set(findobj('tag','m_index'),'string',int2str(index));
    setappdata(handles.figure_mark,'index',index);

% --- Executes on button press in m_road.
function m_road_Callback(hObject, eventdata, handles)
    global width;    global height;    global gt_img;  global  img;
    imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 1;
    show_mark(gt_img, img);

% --- Executes on button press in m_sidewalk.
function m_sidewalk_Callback(hObject, eventdata, handles)
    global width;    global height;    global gt_img;  global  img;
    imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 2;
    show_mark(gt_img, img);

 % --- Executes on button press in m_nopark.
function m_nopark_Callback(hObject, eventdata, handles)
    global width;    global height;    global gt_img;  global  img;
    imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 3;
    show_mark(gt_img, img);
 
 % --- Executes on button press in m_guide.
function m_guide_Callback(hObject, eventdata, handles)
    global width;    global height;    global gt_img;  global  img;
    imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 4;
    show_mark(gt_img, img);
    
% --- Executes on button press in m_police.
function m_police_Callback(hObject, eventdata, handles)
    global width;    global height;    global gt_img;  global  img;
    imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 5;
    show_mark(gt_img, img);
    
% --- Executes on button press in m_lane_w_s.
function m_lane_w_s_Callback(hObject, eventdata, handles)
    global width;    global height;    global gt_img;  global  img;
    imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 6;
    show_mark(gt_img, img);

% --- Executes on button press in m_lane_w_d.
function m_lane_w_d_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 7;
    show_mark(gt_img, img);

% --- Executes on button press in m_lane_y_s.
function m_lane_y_s_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 8;
    show_mark(gt_img, img);

% --- Executes on button press in m_lane_y_d.
function m_lane_y_d_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 9;
    show_mark(gt_img, img);

% --- Executes on button press in m_stop.
function m_stop_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 10;
    show_mark(gt_img, img);

% --- Executes on button press in m_warn_sidewalk.
function m_warn_sidewalk_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 11;
    show_mark(gt_img, img);

% --- Executes on button press in m_forward.
function m_forward_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 12;
    show_mark(gt_img, img);

% --- Executes on button press in m_left.
function m_left_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 13;
    show_mark(gt_img, img);

% --- Executes on button press in m_right.
function m_right_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 14;
    show_mark(gt_img, img);

% --- Executes on button press in m_forward_left.
function m_forward_left_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 15;
    show_mark(gt_img, img);

% --- Executes on button press in m_forward_right.
function m_forward_right_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 16;
    show_mark(gt_img, img);

% --- Executes on button press in m_left_right.
function m_left_right_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 17;
    show_mark(gt_img, img);

% --- Executes on button press in m_stop_wait.
function m_stop_wait_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 18;
    show_mark(gt_img, img);

% --- Executes on button press in m_none_vehicle.
function m_none_vehicle_Callback(hObject, eventdata, handles)
global width;    global height;    global gt_img;  global  img;
imshow(img);
    mask = poly(width,height);
    gt_img(find(mask ==true)) = 19;
    show_mark(gt_img, img);


% --- Executes on button press in m_save.
function m_save_Callback(hObject, eventdata, handles)
    global path_save;    global gt_img; global list;
     index = getappdata(handles.figure_mark,'index');
     imwrite(gt_img,[path_save  'gt_'  list(index,:)], 'Mode', 'lossless');

% --- Executes on button press in m_delete.
function m_delete_Callback(hObject, eventdata, handles)
    global gt_img; global  img;
    gt_img(:,:) = 0;
    show_mark(gt_img, img);
