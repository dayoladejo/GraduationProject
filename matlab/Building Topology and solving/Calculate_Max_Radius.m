function R = Calculate_Max_Radius(Kind,Alpha)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if(strcmpi(Kind,'macro')==1)
    R=nthroot((Cell.Pt_macro*Cell.Gt_macro*User.Gr*(Cell.lamda_macro)^2)/(((4*pi)^2)*User.MinPower_Recive_Watt),Alpha);
elseif(strcmpi(Kind,'femto')==1)
    R=nthroot((Cell.Pt_femto*Cell.Gt_femto*User.Gr*(Cell.lamda_femto)^2)/(((4*pi)^2)*User.MinPower_Recive_Watt),Alpha);
else
    R=0;
end
end

