function createfigure(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 19-Apr-2019 11:29:57

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,...
    'Color',[0 0 0]);
set(plot1(1),'LineStyle','--');
set(plot1(2),'LineWidth',0.1);
set(plot1(3),'LineStyle',':');
set(plot1(4),'LineStyle','-.');
set(plot1(5),'LineWidth',1);
text(2002.0,20.7,'African American');
text(2001.2,16.9,'Hispanic');
text(2004.2,7.5,'Asian American');
text(2012.4,10.0,'White');
text(2003  ,11.6,'Total');
%line([2008.5 2008.5],get(axes1,'YLim'),'Color',[0 0 0]);
%line([2011.5 2011.5],get(axes1,'YLim'),'Color',[0 0 0]);
%line([2015.5 2015.5],get(axes1,'YLim'),'Color',[0 0 0]);

% Create ylabel
ylabel('Admit Rate (%)');

% Create xlabel
xlabel('Harvard Class');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[2000 2017]);
box(axes1,'on');
% Create legend
%legend1 = legend(axes1,'show');
%set(legend1,...
%    'Position',[0.686607142857142 0.852380952380953 0.2125 0.0630952380952381]);

% Save as pdf fit to image size
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
print -dpdf -painters ../FiguresAndTables/admRatesAll
%The first two lines measure the size of your figure (in inches). The next line configures the print paper size to fit the figure size. The last line uses the print command and exports a vector pdf document as the output.


