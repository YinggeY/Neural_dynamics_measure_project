%--------------------------------------------------------------------------
%violin.m - Simple violin plot using matlab default kernel density estimation
%v2: extended for accepting also cells of different length
%--------------------------------------------------------------------------
%This function creates violin plots based on kernel density estimation
%using ksdensity with default settings. Please be careful when comparing pdfs 
%estimated with different bandwidth!
%--------------------------------------------------------------------------
%Please cite this function as:
%Hoffmann H, 2013: violin.m - Simple violin plot using matlab default kernel 
%density estimation. INRES (University of Bonn), Katzenburgweg 5, 53115 Germany.
%hhoffmann@uni-bonn.de
%--------------------------------------------------------------------------
%Input:
%X:     either:
% n x m matrix. A 'violin' is plotted for each column m, OR
% 1 x m Cellarry with elements being numerical colums of nx1 length.
%xL:    xlabel. Set either [] or in the form {'txt1','txt2','txt3',...}
%
%varargin:
%fc=[1 0.5 0]%FaceColor: Specify abbrev. or m x 3 matrix (e.g. [1 0 0])
%lc='k'      %LineColor: Specify abbrev. (e.g. 'k' for black)
%alp=0.5     %Alpha value (transparency)   
%mc='k'      %Color of the bars indicating the mean
%medc='r'    %Color of the bars indicating the median
%--------------------------------------------------------------------------
%{
%Example1 (default):
disp('this example uses the statistical toolbox')
X=[rand(1000,1),gamrnd(1,2,1000,1),normrnd(10,2,1000,1),gamrnd(10,0.1,1000,1)];
[h,L,MX,MED]=violin(X,[]); 
ylabel('\Delta [yesno^{-2}]','FontSize',14)
%
%Example2 (specify):
disp('this example uses the statistical toolbox')
X=[rand(1000,1),gamrnd(1,2,1000,1),normrnd(10,2,1000,1),gamrnd(10,0.1,1000,1)];
[h,L,MX,MED]=violin(X,{'a','b','c','d'},[1 1 0;0 1 0;.3 .3 .3;0 0.3 1],'w',0.3,'k','r--')
ylabel('\Delta [yesno^{-2}]','FontSize',14)

%close all, [h,L,MX,MED]=violin(X,{'a','b','c','d'},[0.1 0.3 0.3],'k',1,'w','k--')
%}
%--------------------------------------------------------------------------
function[h,L,MX,MED]=violin(X,xL,varargin)
 %defaults:
 lc='k';
 fc=[1 0.5 0];
 alp=0.5;
 mc='k';
 medc='r';

 %convert everything to cells:
 if iscell(X)==0
     i=1;
     for i=1:size(X,2)
        X2{i}=X(:,i);
     end
      X=X2;
 end
 
 if size(varargin,2)==1
     fc=varargin{1};
 elseif size(varargin,2)==2
     fc=varargin{1};
     lc=varargin{2};
 elseif size(varargin,2)==3
     fc=varargin{1};
     lc=varargin{2};
     alp=varargin{3};
 elseif size(varargin,2)==4
     fc=varargin{1};
     lc=varargin{2};
     alp=varargin{3};
     mc=varargin{4};
 elseif size(varargin,2)==5
     fc=varargin{1};
     lc=varargin{2};
     alp=varargin{3};
     mc=varargin{4};
     medc=varargin{5};
 end
 %-------------------------------------------------------------------------
 if size(fc,1)==1
     fc=repmat(fc,size(X,2),1);
 end
 %-------------------------------------------------------------------------
 i=1;
  for i=1:size(X,2)
    [f, u]=ksdensity(X{i});
    f=f/max(f)*0.3; %normalize
    F(:,i)=f;
    U(:,i)=u;
    MED(:,i)=nanmedian(X{i});
    MX(:,i)=nanmean(X{i});
 end

 %-------------------------------------------------------------------------
 h=figure;
 %set(gcf,'Color','w')
 mp = get(0, 'MonitorPositions');
 set(gcf,'Color','w','Position',[mp(end,1)+50 mp(end,2)+50 800 600])
 %-------------------------------------------------------------------------
 i=1;
 for i=i:size(X,2)
    fill([F(:,i)+0.5*i*2;flipud(2*i*0.5-F(:,i))],[U(:,i);flipud(U(:,i))],fc(i,:),'FaceAlpha',alp,'EdgeColor',lc)
    hold on
    p(1)=plot([interp1(U(:,i),F(:,i)+0.5*i*2,MX(:,i)), interp1(flipud(U(:,i)),flipud(2*i*0.5-F(:,i)),MX(:,i)) ],[MX(:,i) MX(:,i)],mc,'LineWidth',2);
    p(2)=plot([interp1(U(:,i),F(:,i)+0.5*i*2,MED(:,i)), interp1(flipud(U(:,i)),flipud(2*i*0.5-F(:,i)),MED(:,i)) ],[MED(:,i) MED(:,i)],medc,'LineWidth',2);
 end
 %-------------------------------------------------------------------------
 L=legend([p(1) p(2)],'Mean','Median');
 set(L,'box','off','FontSize',14)
 %-------------------------------------------------------------------------
 axis([0.5 size(X,2)+0.5, min(U(:)) max(U(:))]);
 ax=axis;
 OS=[0.001 0.001];
 plot([ax(1)+OS(1) ax(2)-OS(1) ax(2)-OS(1) ax(1)+OS(1) ax(1)+OS(1)],...
     [ax(3)+OS(2) ax(3)+OS(2) ax(4)-OS(2) ax(4)-OS(2) ax(3)-OS(2)],'k-')
 %axis([0.5 size(X,2)+0.5, min(U(:)) max(U(:))])
 %-------------------------------------------------------------------------

 xL2={''};
 i=1;
 for i=1:size(xL,2)
  xL2=[xL2,xL{i},{''}];
 end
 set(gca,'TickLength',[0 0],'FontSize',12)
 box on
 
 %set(gca,'XLimMode','manual')
 if isempty(xL)==0
     set(gca,'XtickLabel',xL2)
 end
 %-------------------------------------------------------------------------
end %of function