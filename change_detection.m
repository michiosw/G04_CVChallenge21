function change_detection(path, environment, varargin)
%CHANGE_DETECTION Summary of this function goes here
%   Input arguments: environment folder, in case of direct comparison:
%   names of pictures to be compared

if nargin > 4
    error("Too many inputs!");
elseif nargin == 4
    direct_comparison(path, environment, varargin{1}, varargin{2});
elseif nargin == 3
    error("Input argument missing!");
elseif nargin == 2
    sequential_comparison(path, environment);
else 
    error("Input arguments missing!");
end

end

