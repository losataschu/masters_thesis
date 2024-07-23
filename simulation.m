close all

% Create geometry model with three equations
model = createpde(3);

% Domain coordinates
xCoords = [-1 1 1 -1]';  
yCoords = [0 0 0.1 0.1]';

% Geometry description
geomDescription = [2;length(xCoords);xCoords;yCoords]; 

% Name of the geometric object.
% Here it is a single rectangle representing the Petri Shell
namePetri = char('P1')';

% Set formula
setFormula = 'P1';

% create geometry
geometry = decsg(geomDescription,setFormula,namePetri);
geometryFromEdges(model, geometry);

%pdegplot(geometry,'EdgeLabels','on') % to see edge labels

% define coefficient functions
specifyCoefficients(model,'m',0,'d',1,'c',@c_coef,'a',@a_coef,'f',@f_coef);

qBoundary = [0 0 0;0 0 0;0 0 0];
gBoundary = [0;0;0];

applyBoundaryCondition(model,'neumann','Edge',[1,3],'q',0,'g',0);
applyBoundaryCondition(model, 'mixed', 'Edge', 4, 'u', 0.01, 'Equationindex', 2, 'q', qBoundary, 'g', gBoundary);
applyBoundaryCondition(model, 'mixed', 'Edge', 2, 'u', 0.001, 'EquationIndex', 2, 'q', qBoundary, 'g', gBoundary);


%% 4. Specify Initial Condition 
uInitial = @u0;
setInitialConditions(model, uInitial); 

%% 5. Solve PDE
% create mesh
mshs = generateMesh(model);
%pdeplot(model)

% call solver 
tList = linspace(0,210,2100);
result = solvepde(model,tList);
% tList2 = linspace(0,4,40);
% result2 = solvepde(model,tList2);

%% 6. Visualize solution
% 
% AN = model.Mesh.Nodes;
% numnod = length(AN(1,:));
scr_siz = get(0,'ScreenSize');

Pf1 = 140;
% centers = zeros(2,Pf1);
salt1 = length(tList)/Pf1;
finalFigure = figure('Position', [scr_siz(3)/4 0 2*scr_siz(3)/3 scr_siz(4)]);

for i = 1:Pf1
%     centercell = [0;0];
%     masscell = 0;
    ki = salt1*i;
    u1 = result.NodalSolution(:,1,ki);
    u2 = result.NodalSolution(:,2,ki);
    u3 = result.NodalSolution(:,3,ki);

%     for j = 1:numnod
%        d1 = u1(j);
%        cen1 = d1*AN(:,j);
%        centercell = centercell + cen1;
%        masscell = masscell + d1;
%     end
%     centercell = [centercell(1)/masscell;centercell(2)/masscell];
%     centers(:,i) = centercell;
% 
%     subplot(1,1,1)
%     pdeplot(model,'XYData',u1,'ZData',u1,'ColorMap','turbo')
%     view(0,5)
%     %tit = title(sprintf('cell density n(t,x) at t=%.2f', tList(salto*i)));
%     %tit.FontSize = 16;
%     c = colorbar;
%     ax = gca;
%     ax.YAxis.Visible = 'off';
%     ax.ZTick = [0 1.8 6 9];
%     ax.FontSize = 32;
%     c.Position = [0.92 0.45 0.02 0.2];
%     c.Ticks = [0 9];
%     ax.XLabel.Position = [1.2,0.0045,0];
%     xlabel('x_1');
%     zlabel('n(t,x_1)')    
%     xlim([-1 1])
%     ylim([0 0.01])
%     zlim([0 9])
%     clim([0 9])
% 
%     tatata = sprintf('model_%d', ki);
%     saveas(finalFigure,tatata,'jpg');
%     
%     pause(0.05)
% 
% end
%     
    subplot(3,1,1)
    pdeplot(model,'XYData',u1,'ZData',u1,'ColorMap','turbo')
    view(0,5)
    c = colorbar;
    ax = gca;
    ax.YAxis.Visible = 'off';
    ax.ZTick = [0 1.8 6 9];
    ax.FontSize = 28;
    c.Position = [0.92 0.78 0.02 0.12];
    c.Ticks = [0 9];
    ax.XLabel.Position = [1.105,0.0045,0];
    xlabel('x_1');
    zlabel('n(t,x_1)')    
    xlim([-1 1])
    ylim([0 0.01])
    zlim([0 9])
    clim([0 9])
    
    subplot(3,1,2)
    pdeplot(model,'XYData',u2,'ZData',u2,'ColorMap','turbo')
    view(0,5)
    %title(sprintf('fMLF concentration at t=%f', tList(ki)));
    c = colorbar;
    ax = gca;
    ax.YAxis.Visible = 'off';
    ax.ZTick = [0.001 0.005 0.01];
    ax.FontSize = 28;
    c.Position = [0.92 0.48 0.02 0.12];
    c.Ticks = [0 0.01];
    ax.XLabel.Position = [1.105,0.0045,0];
    xlabel('x_1');
    zlabel('f(t,x_1)')    
    xlim([-1 1])
    ylim([0 0.01])
    zlim([0 0.01])
    clim([0 0.01])
    
    subplot(3,1,3)
    pdeplot(model,'XYData',u3,'ZData',u3,'ColorMap','turbo')
    view(0,5)
    %title(sprintf('ROS concentration r(t,x) at t=%.2f', tList(ki)));
    c = colorbar;
    ax = gca;
    ax.YAxis.Visible = 'off';
    ax.ZTick = [0 0.01 0.02 0.03];
    ax.FontSize = 28;
    c.Position = [0.92 0.18 0.02 0.12];
    c.Ticks = [0 0.02];
    ax.XLabel.Position = [1.105,0.0045,0];
    xlabel('x_1');
    zlabel('r(t,x_1)')    
    xlim([-1 1])
    ylim([0 0.01])
    zlim([0 0.03])
    clim([0 0.02])
        
    %sgtitle("r0=0.2; rM=1x10^6");
%    [i;ki;tList(ki)];
    tatata = sprintf('modelall_%d', ki);
    saveas(finalFigure,tatata,'jpg');
    
    pause(0.06)
    %close(f)
end
