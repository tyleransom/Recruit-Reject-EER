clear; clc;
% app refers to apply
% adm refers to admit
% mat refers to matriculant
% int refers to international
% tot is the total including international
% nlna refers to neither legacy nor athlete
% la refers to legacy or athlete
% dom refers to domestic
% all data can be found in D042.pdf or D030.pdf, D031.pdf, D033.pdf

bigyear = [];
load Data/harvardaggBYrace
load Data/harvardHistoricalaggBYrace
load Data/harvardSAT

%-----------------------------
% Data processing
%-----------------------------
% Overall application growth
apptotgrow=(apptot./apptot(1))-1;

% Share of applicants and admits who are African American
appshareblack = app2./apptot*100;
bigappshareblack = bigapp2./bigapptot*100;
admshareblack = adm2./admtot*100;
bigadmshareblack = bigadm2./bigadmtot*100;

% Share of applicants and admits who are Hispanic
appsharehisp = app3./apptot*100;
bigappsharehisp = bigapp3./bigapptot*100;
admsharehisp = adm3./admtot*100;
bigadmsharehisp = bigadm3./bigadmtot*100;

% Share of applicants and admits who are Asian American
appshareasian = app1./apptot*100;
bigappshareasian = bigapp1./bigapptot*100;
admshareasian = adm1./admtot*100;
bigadmshareasian = bigadm1./bigadmtot*100;

% Share of applicants and admits who are Hispanic
appsharehisp = app3./apptot*100;
bigappsharehisp = bigapp3./bigapptot*100;
admsharehisp = adm3./admtot*100;
bigadmsharehisp = bigadm3./bigadmtot*100;

% SAT score data
SATappblack = SATdata(SATdata(:,2)==2,3);
SATapphispa = SATdata(SATdata(:,2)==3,3);
SATadmblack = SATdata(SATdata(:,2)==2,4);
SATadmhispa = SATdata(SATdata(:,2)==3,4);
SATappasian = SATdata(SATdata(:,2)==1,3);
SATappwhite = SATdata(SATdata(:,2)==7,3);
SATadmasian = SATdata(SATdata(:,2)==1,4);
SATadmwhite = SATdata(SATdata(:,2)==7,4);

% Admission rate data
admRateTot=(admtot./apptot.*100);
admRateAsian=(adm1./app1.*100);
admRateBlack=(adm2./app2.*100);
admRateHispa=(adm3./app3.*100);
admRateWhite=(adm7./app7.*100);
bigAdmRateTot  =(bigadmtot./bigapptot.*100);
bigAdmRateAsian=(bigadm1./bigapp1.*100);
bigAdmRateBlack=(bigadm2./bigapp2.*100);
bigAdmRateHispa=(bigadm3./bigapp3.*100);
bigAdmRateTot  =[bigAdmRateTot(1:20);admRateTot];
bigAdmRateAsian=[bigAdmRateAsian(1:20);admRateAsian];
bigAdmRateBlack=[bigAdmRateBlack(1:20);admRateBlack];
bigAdmRateHispa=[bigAdmRateHispa(1:20);admRateHispa];
bigAdmRateWhite=[nan(20,1);admRateWhite];

% Yield rates
yieldasian = matnlna1./admnlna1*100;
yieldblack = matnlna2./admnlna2*100;
yieldhispa = matnlna3./admnlna3*100;
yieldwhite = matnlna7./admnlna7*100;



%-----------------------------
% Create Figures
%-----------------------------
%code to create Figure 1
applicationsAggFig(year,[apptotgrow]);

%code to create Figure 2(a)
bigAppAdmShrAfrAmFig(bigyear(1:end-1),[[bigappshareblack(1:20);appshareblack] [bigadmshareblack(1:20);admshareblack]]);

%code to create Figure 2(b)
SATafrAmFig(year,[SATappblack SATadmblack]);

%code to create Figure 5(a)
admRatesAllFig(year,[admRateAsian admRateBlack admRateHispa admRateWhite admRateTot]);

%code to create Appendix Figure A1
bigAppAdmShrHispFig(bigyear(1:end-1),[[bigappsharehisp(1:20);appsharehisp] [bigadmsharehisp(1:20);admsharehisp]]);

%code to create Appendix Figure A2
bigAppAdmShrAsianFig(bigyear(1:end-1),[[bigappshareasian(1:20);appshareasian] [bigadmshareasian(1:20);admshareasian]]);

%code to create Appendix Figure A3
SATallappfig(year,[SATappblack SATapphispa SATappasian SATappwhite]);
SATalladmfig(year,[SATadmblack SATadmhispa SATadmasian SATadmwhite]);

%code to create Appendix Figure A4
yieldfig(year,[yieldasian yieldblack yieldhispa yieldwhite]);

%code to create Appendix Figure A9(a)
bigAdmRatesRatiosAllFig(bigyear(1:end-1),[bigAdmRateAsian./bigAdmRateTot bigAdmRateBlack./bigAdmRateTot bigAdmRateHispa./bigAdmRateTot bigAdmRateWhite./bigAdmRateTot]);





% vestigial code

% %code to create bigAdmitRatesAll.fig
% bigAdmRatesAllFig(bigyear(1:end-1),[bigAdmRateAsian bigAdmRateBlack bigAdmRateHispa bigAdmRateWhite bigAdmRateTot]);
% 
% %code to create admits.fig
% admdomgrow=(admnlnadom./admnlnadom(1))-1;
% admasiangrow=(admnlna1./admnlna1(1))-1;
% admblackgrow=(admnlna2./admnlna2(1))-1;
% admhispagrow=(admnlna3./admnlna3(1))-1;
% admwhitegrow=(admnlna7./admnlna7(1))-1;
% admitsfig(year,[admasiangrow admblackgrow admhispagrow admwhitegrow admdomgrow]);
% 
% %code to create admitsAll.fig
% admtotgrow=(admtot./admtot(1))-1;
% admasiangrow=(adm1./adm1(1))-1;
% admblackgrow=(adm2./adm2(1))-1;
% admhispagrow=(adm3./adm3(1))-1;
% admwhitegrow=(adm7./adm7(1))-1;
% admitsAllFig(year,[admasiangrow admblackgrow admhispagrow admwhitegrow admtotgrow]);
% 
% %code to create matriculations.fig
% matdomgrow=(matnlnadom./matnlnadom(1))-1;
% matasiangrow=(matnlna1./matnlna1(1))-1;
% matblackgrow=(matnlna2./matnlna2(1))-1;
% mathispagrow=(matnlna3./matnlna3(1))-1;
% matwhitegrow=(matnlna7./matnlna7(1))-1;
% matriculationsfig(year,[matasiangrow matblackgrow mathispagrow matwhitegrow matdomgrow]);
% 
% %code to create matriculationsAll.fig
% mattotgrow=(mattot./mattot(1))-1;
% matasiangrow=(mat1./mat1(1))-1;
% matblackgrow=(mat2./mat2(1))-1;
% mathispagrow=(mat3./mat3(1))-1;
% matwhitegrow=(mat7./mat7(1))-1;
% matriculationsAllFig(year,[matasiangrow matblackgrow mathispagrow matwhitegrow mattotgrow]);
% 
% %code to create app/adm share for Afr Am only
% appAdmShrAfrAmDomFig(year,[appsharedomblack admsharedomblack]);
% 
% %code to create yields.fig
% yieldblack = mat2./adm2*100;
% yieldhispa = mat3./adm3*100;
% yieldAllFig(year,[yieldblack yieldhispa]); % includes LA
% 
% 
% load PubHSraceShares
% %code to create shareHSgrads.fig
% HSshrfig(year(4:end),[HSshrB HSshrH]);
