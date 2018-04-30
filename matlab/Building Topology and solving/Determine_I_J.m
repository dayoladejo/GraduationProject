function [I,J] = Determine_I_J(Area,Macro_Cell_Area)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Number_Of_MacroCells=ceil(Area/Macro_Cell_Area);
% tipical values
% (I,J)==>(0,1),(1,0),(1,1),(0,2),(1,2),(2,1),(2,2),(0,3),(3,0),(1,3),(3,1)
%           1     1     3     4     7     7     12    9     9     13    13
% (I,J)==>(2,3),(3,2),(3,3),(3,4),(4,5),(5,4)
%           19    19   27     37    61   61
switch  Number_Of_MacroCells
    case 1
        I=0;
        J=1;
    case num2cell(2:3)
        I=1;
        J=1;
    case 4
        I=0;
        J=2;
    case num2cell(5:7)
        I=1;
        J=2;
    case num2cell(8:9)
        I=0;
        J=3;
    case num2cell(10:12)
        I=2;
        J=2;
    case 13
        I=1;
        J=3;
    case num2cell(14:19)
        I=2;
        J=3;
    case num2cell(20:27)
        I=3;
        J=3;
    case num2cell(28:37)
        I=3;
        J=4;
    case num2cell(37:61)
        I=4;
        J=5;
    otherwise
        I=0;
        J=0;
end

end

