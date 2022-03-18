clear
load Data/satovertime;

%-----------------------------
% Data processing
%-----------------------------
admit=rawdata(:,1);
year=rawdata(:,2);
subject=rawdata(:,3);
range=rawdata(:,4);
race=rawdata(:,5);
obs=rawdata(:,6);

n=size(admit,1);
scoreshare=zeros(n,1);
scoresharedom=zeros(n,1);
i=1;

while i<n+1
    flag=(range==range(i)).*(year==year(i)).*(subject==subject(i)).*(admit==admit(i)).*(race==9);
    flagint=(range==range(i)).*(year==year(i)).*(subject==subject(i)).*(admit==admit(i)).*(race==8);
    scoreshare(i)=obs(i)./max(sum(obs(flag==1)),eps);
    scoresharedom(i)=obs(i)./max(sum(obs(flag==1))-sum(obs(flagint==1)),eps);
    i=i+1;
end

%now making the time series shares and levels

i=2009;

raceb=race((year==2009).*(subject==1).*(admit==1)==1);

mathadmshr=raceb;
verbaladmshr=raceb;
writingadmshr=raceb;
mathappshr=raceb;
verbalappshr=raceb;
writingappshr=raceb;
mathadm=raceb;
verbaladm=raceb;
writingadm=raceb;
mathapp=raceb;
verbalapp=raceb;
writingapp=raceb;

while i<2018
    
    mathadmshr=[mathadmshr scoresharedom((year==i).*(subject==1).*(admit==1)==1)];
    verbaladmshr=[verbaladmshr scoresharedom((year==i).*(subject==2).*(admit==1)==1)];
    writingadmshr=[writingadmshr scoresharedom((year==i).*(subject==3).*(admit==1)==1)];
    mathappshr=[mathappshr scoresharedom((year==i).*(subject==1).*(admit==0)==1)];
    verbalappshr=[verbalappshr scoresharedom((year==i).*(subject==2).*(admit==0)==1)];
    writingappshr=[writingappshr scoresharedom((year==i).*(subject==3).*(admit==0)==1)];
    mathadm=[mathadm obs((year==i).*(subject==1).*(admit==1)==1)];
    verbaladm=[verbaladm obs((year==i).*(subject==2).*(admit==1)==1)];
    writingadm=[writingadm obs((year==i).*(subject==3).*(admit==1)==1)];
    mathapp=[mathapp obs((year==i).*(subject==1).*(admit==0)==1)];
    verbalapp=[verbalapp obs((year==i).*(subject==2).*(admit==0)==1)];
    writingapp=[writingapp obs((year==i).*(subject==3).*(admit==0)==1)];
    i=i+1;
end

mathappg=mathapp(:,3:9)./mathapp(:,2:8);
verbalappg=verbalapp(:,3:9)./verbalapp(:,2:8);
writingappg=writingapp(:,3:9)./writingapp(:,2:8);
mathadmg=mathadm(:,3:9)./mathadm(:,2:8);
verbaladmg=verbaladm(:,3:9)./verbaladm(:,2:8);
writingadmg=writingadm(:,3:9)./writingadm(:,2:8);

mathappg=mathapp(:,3:9)./mathapp(:,2);
verbalappg=verbalapp(:,3:9)./verbalapp(:,2);
writingappg=writingapp(:,3:9)./writingapp(:,2);
mathadmg=mathadm(:,3:9)./mathadm(:,2);
verbaladmg=verbaladm(:,3:9)./verbaladm(:,2);
writingadmg=writingadm(:,3:9)./writingadm(:,2);

matharm=mathadm(:,2:9)./mathapp(:,2:9);
verbalarm=verbaladm(:,2:9)./verbalapp(:,2:9);
writingarm=writingadm(:,2:9)./writingapp(:,2:9);

mathcshrapp=zeros(64,8);
verbalcshrapp=zeros(64,8);
writingcshrapp=zeros(64,8);
mathcshradm=zeros(64,8);
verbalcshradm=zeros(64,8);
writingcshradm=zeros(64,8);
j=1;
mathadm2=zeros(24,8);
mathapp2=zeros(24,8);
verbaladm2=zeros(24,8);
verbalapp2=zeros(24,8);
mathadm3=zeros(32,8);
mathapp3=zeros(32,8);
verbaladm3=zeros(32,8);
verbalapp3=zeros(32,8);
writingadm3=zeros(32,8);
writingapp3=zeros(32,8);
while j<9
    mathcshrapp(1+(j-1)*8:j*8,:)=cumsum(mathapp(1+(j-1)*8:j*8,2:9))./sum(mathapp(1+(j-1)*8:j*8,2:9));
    verbalcshrapp(1+(j-1)*8:j*8,:)=cumsum(verbalapp(1+(j-1)*8:j*8,2:9))./sum(verbalapp(1+(j-1)*8:j*8,2:9));
    writingcshrapp(1+(j-1)*8:j*8,:)=cumsum(writingapp(1+(j-1)*8:j*8,2:9))./sum(writingapp(1+(j-1)*8:j*8,2:9));
    mathcshradm(1+(j-1)*8:j*8,:)=cumsum(mathadm(1+(j-1)*8:j*8,2:9))./sum(mathadm(1+(j-1)*8:j*8,2:9));
    verbalcshradm(1+(j-1)*8:j*8,:)=cumsum(verbaladm(1+(j-1)*8:j*8,2:9))./sum(verbaladm(1+(j-1)*8:j*8,2:9));
    writingcshradm(1+(j-1)*8:j*8,:)=cumsum(writingadm(1+(j-1)*8:j*8,2:9))./sum(writingadm(1+(j-1)*8:j*8,2:9));
    mathadm2(1+(j-1)*3,:)=sum(mathadm(1+(j-1)*8:3+(j-1)*8,2:9));
    mathadm2(2+(j-1)*3,:)=sum(mathadm(4+(j-1)*8:5+(j-1)*8,2:9));
    mathadm2(3+(j-1)*3,:)=sum(mathadm(6+(j-1)*8:8+(j-1)*8,2:9));
    mathapp2(1+(j-1)*3,:)=sum(mathapp(1+(j-1)*8:3+(j-1)*8,2:9));
    mathapp2(2+(j-1)*3,:)=sum(mathapp(4+(j-1)*8:5+(j-1)*8,2:9));
    mathapp2(3+(j-1)*3,:)=sum(mathapp(6+(j-1)*8:8+(j-1)*8,2:9));
    verbaladm2(1+(j-1)*3,:)=sum(verbaladm(1+(j-1)*8:3+(j-1)*8,2:9));
    verbaladm2(2+(j-1)*3,:)=sum(verbaladm(4+(j-1)*8:5+(j-1)*8,2:9));
    verbaladm2(3+(j-1)*3,:)=sum(verbaladm(6+(j-1)*8:8+(j-1)*8,2:9));
    verbalapp2(1+(j-1)*3,:)=sum(verbalapp(1+(j-1)*8:3+(j-1)*8,2:9));
    verbalapp2(2+(j-1)*3,:)=sum(verbalapp(4+(j-1)*8:5+(j-1)*8,2:9));
    verbalapp2(3+(j-1)*3,:)=sum(verbalapp(6+(j-1)*8:8+(j-1)*8,2:9));
    mathadm3(1+(j-1)*4,:)=sum(mathadm(1+(j-1)*8:3+(j-1)*8,2:9));
    mathadm3(2+(j-1)*4,:)=mathadm(4+(j-1)*8,2:9);
    mathadm3(3+(j-1)*4,:)=mathadm(5+(j-1)*8,2:9);
    mathadm3(4+(j-1)*4,:)=sum(mathadm(6+(j-1)*8:8+(j-1)*8,2:9));
    mathapp3(1+(j-1)*4,:)=sum(mathapp(1+(j-1)*8:3+(j-1)*8,2:9));
    mathapp3(2+(j-1)*4,:)=mathapp(4+(j-1)*8,2:9);
    mathapp3(3+(j-1)*4,:)=mathapp(5+(j-1)*8,2:9);
    mathapp3(4+(j-1)*4,:)=sum(mathapp(6+(j-1)*8:8+(j-1)*8,2:9));
    verbaladm3(1+(j-1)*4,:)=sum(verbaladm(1+(j-1)*8:3+(j-1)*8,2:9));
    verbaladm3(2+(j-1)*4,:)=verbaladm(4+(j-1)*8,2:9);
    verbaladm3(3+(j-1)*4,:)=verbaladm(5+(j-1)*8,2:9);
    verbaladm3(4+(j-1)*4,:)=sum(verbaladm(6+(j-1)*8:8+(j-1)*8,2:9));
    verbalapp3(1+(j-1)*4,:)=sum(verbalapp(1+(j-1)*8:3+(j-1)*8,2:9));
    verbalapp3(2+(j-1)*4,:)=verbalapp(4+(j-1)*8,2:9);
    verbalapp3(3+(j-1)*4,:)=verbalapp(5+(j-1)*8,2:9);
    verbalapp3(4+(j-1)*4,:)=sum(verbalapp(6+(j-1)*8:8+(j-1)*8,2:9));
    writingadm3(1+(j-1)*4,:)=sum(writingadm(1+(j-1)*8:3+(j-1)*8,2:9));
    writingadm3(2+(j-1)*4,:)=writingadm(4+(j-1)*8,2:9);
    writingadm3(3+(j-1)*4,:)=writingadm(5+(j-1)*8,2:9);
    writingadm3(4+(j-1)*4,:)=sum(writingadm(6+(j-1)*8:8+(j-1)*8,2:9));
    writingapp3(1+(j-1)*4,:)=sum(writingapp(1+(j-1)*8:3+(j-1)*8,2:9));
    writingapp3(2+(j-1)*4,:)=writingapp(4+(j-1)*8,2:9);
    writingapp3(3+(j-1)*4,:)=writingapp(5+(j-1)*8,2:9);
    writingapp3(4+(j-1)*4,:)=sum(writingapp(6+(j-1)*8:8+(j-1)*8,2:9));
    j=j+1;
end
    



%-----------------------------
% Figures
%-----------------------------
%code to create Figure 3(a) and 3(b)
blacksatyearmath([2009:2016]',mathapp3(5:8,:)','mathapp')
blacksatyearmath([2009:2016]',mathadm3(5:8,:)','mathadm')

%code to create Figure 4(a)
mathL550 = mathapp3([1:4:end],:);
mathL550([4 7],:) = [];
shrL550 = mathL550./repmat(sum(mathL550,1),[size(mathL550,1) 1]).*100;
shrL550year([2009:2016]',shrL550([1:3 6],:))

%code to create Figure 4(b)
mathG750 = mathapp(8:8:end,2:end);
mathG750([4 7],:) = [];
shrG750 = mathG750./repmat(sum(mathG750,1),[size(mathG750,1) 1]).*100;
shrG750year([2009:2016]',shrG750([1:3 6],:))

%code to create Figure 5(b)
topadmallyearmath([2009:2016]',(mathadm([8 16 24 64],2:end)'./mathapp([8 16 24 64],2:end)').*100,'mathadmrate')

%code to create Appendix Figure A4(a) and A4(b)
blacksatyearverbal([2009:2016]',verbalapp3(5:8,:)','verbapp')
blacksatyearwriting([2009:2016]',writingapp3(5:8,:)','writapp')

%code to create Appendix Figure A5(a) and A5(b)
blacksatyearverbal([2009:2016]',verbaladm3(5:8,:)','verbadm')    
blacksatyearwriting([2009:2016]',writingadm3(5:8,:)','writadm')

%code to create Appendix Figure A6(a) and A6(b)
hispanicsatyearmath([2009:2016]',mathapp3(9:12,:)','Hmathapp')
hispanicsatyearmath([2009:2016]',mathadm3(9:12,:)','Hmathadm')

%code to create Appendix Figure A7(a) and A7(b)
hispanicsatyearverbal([2009:2016]',verbalapp3(9:12,:)','Hverbapp')
hispanicsatyearwriting([2009:2016]',writingapp3(9:12,:)','Hwritapp')

%code to create Appendix Figure A8(a) and A8(b)
hispanicsatyearverbal([2009:2016]',verbaladm3(9:12,:)','Hverbadm')    
hispanicsatyearwriting([2009:2016]',writingadm3(9:12,:)','Hwritadm')

%code to create Appendix Figure A9(b)
topadmratioallyearmath([2009:2016]',((mathadm([8 16 24 64],2:end)'./mathapp([8 16 24 64],2:end)')./(mathadm(56,2:end)'./mathapp(56,2:end)')),'mathadmrate')




