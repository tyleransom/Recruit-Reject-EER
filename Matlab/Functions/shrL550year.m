function shrL550year(X1, YMatrix1)
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
set(plot1(1),'LineStyle','--');
set(plot1(2),'LineWidth',0.1 );
set(plot1(3),'LineStyle',':' );
set(plot1(4),'LineStyle','-.');

% Create ylabel
text(2011,7,'Asian American');
text(2010.5,45,'African American');
text(2011,28 ,'Hispanic');
text(2010,17,'White');
ylabel({'Share of Domestic Applicants (%)'});

% Create xlabel
xlabel({'Harvard class'});

% Create title
%title({'African American applicants by math SAT and year'});

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[2009 2016]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[0 50]);
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
saveas(gcf,'../FiguresAndTables/shrL550','eps');
print('-dpdf','-painters','../FiguresAndTables/shrL550');

