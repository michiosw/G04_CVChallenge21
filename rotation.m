function Tform = rotation(theta, delta_x, delta_y, scale)

T_trans = [1 0 0;0 1 0; delta_x delta_y 1];
T_rot = [cosd(theta) sind(theta) 0;-sind(theta) cosd(theta) 0;0 0 1];
T_scale = [scale 0 0;0 scale 0;0 0 1];

Tform = affine2d(T_trans * T_rot* T_scale);
end

