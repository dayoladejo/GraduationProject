function Users= AddAllUsers(Number_Of_Users,MaximumUserLocation,MinimumUserLocation)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
Users={};                         % array of Users 
for i=1:Number_Of_Users
    u=User(  (MaximumUserLocation-MinimumUserLocation).*rand+MinimumUserLocation,(MaximumUserLocation-MinimumUserLocation).*rand+MinimumUserLocation   );
    Users=[Users,u];
end

end

