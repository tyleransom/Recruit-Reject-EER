function hispanicsatyear(X1, YMatrix1, objname)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1,...
    'Color',[0 0 0]);
set(plot1(1),'LineStyle','--','DisplayName','writing<550');
set(plot1(2),'LineWidth',0.1, 'DisplayName','writing 550-590');
set(plot1(3),'LineStyle',':', 'DisplayName','writing 600-640');
set(plot1(4),'LineStyle','-.','DisplayName','writing>640');

% Create ylabel
if strcmpi(objname(end-2:end),'app')
    text(2013,510,'Writing<550');
    text(2014,405 ,'Writing 550-590');
    text(2009.5,410,'Writing 600-640');
    text(2013,1320,'Writing>640');
    ylabel({'Number of Applicants'});
else
    text(2012.0,40  ,'Writing<550');
    annotation('arrow',[0.5 0.5],[0.25 0.11]);
    text(2010  ,10,'Writing 550-590');
    text(2010, 30,'Writing 600-640');
    text(2011.5, 185 ,'Writing>640');
    ylabel({'Number of Admits'});
end

% Create xlabel
xlabel({'Harvard class'});

% Create title
%title({'African American applicants by writing SAT and year'});

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[2009 2016]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[200 1200]);
box(axes1,'on');
% Create legend
%legend1 = legend(axes1,'show');
%set(legend1,...
    %'Position',[0.158831003811944 0.8125 0.129606099110546 0.0836148648648648]);

% Save as pdf fit to image size
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
print('-dpdf','-painters',['../FiguresAndTables/',objname]);

