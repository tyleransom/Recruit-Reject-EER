function blacksatyear(X1, YMatrix1, objname)
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
set(plot1(1),'LineStyle','--','DisplayName','verbal<550');
set(plot1(2),'LineWidth',0.1, 'DisplayName','verbal 550-590');
set(plot1(3),'LineStyle',':', 'DisplayName','verbal 600-640');
set(plot1(4),'LineStyle','-.','DisplayName','verbal>640');

% Create ylabel
if strcmpi(objname(end-2:end),'app')
    text(2014.5,800,'Verbal<550');
    text(2014,380 ,'Verbal 550-590');
    text(2012.5,530,'Verbal 600-640');
    text(2013.8,1050,'Verbal>640');
    ylabel({'Number of Applicants'});
else
    text(2012.0,65  ,'Verbal<550');
    annotation('arrow',[0.5 0.5],[0.35 0.12]);
    text(2010  ,10,'Verbal 550-590');
    text(2010, 35,'Verbal 600-640');
    text(2012, 185 ,'Verbal>640');
    ylabel({'Number of Admits'});
end

% Create xlabel
xlabel({'Harvard class'});

% Create title
%title({'African American applicants by verbal SAT and year'});

box(axes1,'on');
% Create legend
%legend1 = legend(axes1,'show');
%set(legend1,...
    %'Position',[0.132562624795788 0.795378861003861 0.182142857142857 0.117857142857143]);

% Save as pdf fit to image size
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,['../FiguresAndTables/',objname],'eps');
print('-dpdf','-painters',['../FiguresAndTables/',objname]);

