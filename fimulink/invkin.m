clear
clc
close all
%Dimensions

%             100
%      A _____________ B
%  90   /             \   90
%    F /               \ C
%      \               /
%       \             /
%        \           /
%    170  \         /  170
%          \       /
%           \_____/  
%          E       D
%              50

%AB = L5 | BC = L4 | CD = L3 | DE = L6 | EF = L2 | AF = L1
L1 = 90;
L2 = 170;
L3 = 170;
L4 = 90;
L5 = 100;
L6 = 50;

data_log = [];
time_data = 0;

%Input
Tx_data = linspace(-100,100,25);
Ty_data = linspace(-200,-200,25);
Tz_data = linspace(-125,125,25);

hold on
for i=1:length(Tx_data)
    Tx = Tx_data(i);
    Ty = Ty_data(i);
    %for theta1
    A1 = Tx^2 + Ty^2 + L1^2 - L2^2 + 0.25*L5^2 + 0.25*L6^2;
    B1 = 2*Tx*L1 + L1*L5 - L1*L6;
    C1 = 2*Ty*L1;
    D1 = Tx*L5 - Tx*L6 - 0.5*Ty*L6;

    sigma = (-B1 + sqrt(B1^2 - (A1 - C1 + D1)*(A1 + C1 + D1)))/(A1 - C1 + D1);

    theta1 = pi/2 - 2*atan(sigma) - pi/4;

    %for theta4
    A2 = Tx^2 + Ty^2 + L4^2 - L3^2 + 0.25*L5^2 + 0.25*L6^2;
    B2 = -2*Tx*L4 + L4*L5 - L1*L6;
    C2 = 2*Ty*L4;
    D2 = -Tx*L5 + Tx*L6 - 0.5*Ty*L6;

    rho = (-B2 + sqrt(B2^2 - (A2 - C2 + D2)*(A2 + C2 + D2)))/(A2 - C2 + D2);

    theta4 = 2*atan(rho) - pi/4;

    time_data = time_data + 0.05;

    if isreal(theta1) && isreal(theta4)
        axis([-300 300 -300 100]);
        A = transl(-50,0,0);
        B = transl(50,0,0);
        ax1 = transl(50,0,0)*trotz(theta4)*transl(90,0,0);
        ax2 = transl(-50,0,0)*trotz(theta1)*transl(-90,0,0);
        scatter(A(1,4),A(2,4),'bx')
        scatter(B(1,4),B(2,4),'rx')
        scatter(ax1(1,4),ax1(2,4),'r.')
        scatter(ax2(1,4),ax2(2,4),'b.')
        scatter(Tx,Ty,'k.');
        data_log = [data_log;time_data,Tx,Ty,theta1*180/pi,theta4*180/pi];
        pause(0.005)
    end
end
hold off