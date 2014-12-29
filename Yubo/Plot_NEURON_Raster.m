function [spktimes figH] = Plot_NEURON_Raster(data,t,th,cellname,color,fs)

% FUNCTION DESCRIPTION

% This function does two things:
% 1) First it interpolates the approximate spike time from continuous
% voltage traces by taking the halfway point of data between endpoints
% defined by the threshold (th)
% 2) Then it plots a rasterplot of the interpolated spike times

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% INPUTS:
% data  - data matrix of membrane volatge (ntp x ncells)
% t     - time vector
% th    - spike threshold (mV)
% color - color of plot
% fs    - font size for plot labels
%
% OUTPUTS:
% spktimes - cell array of spike times (ms)
% figH     - figure handle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Interpolate spikes from continuous data

thdata = data > th; % threshold raw data
nc = size(data,2); % nuber of cells given by number of columns

spktimes = cell(nc,1);

for n = 1:nc
    
    spk_on = find(thdata(:,n) == 1,1,'first'); % index of 1st spike onset
    ind = 1; % reset index to 1 for each cell
    si = 1; % start index (increases as we step through each spike event)
    
    while isempty(spk_on) == 0
        
        % find spike offset index relative to spike onset
        spk_off = find(thdata((si+spk_on-1):end,n) == 0,1,'first');
        % update spike time as 20% between spk_on and spk_off
        spktimes{n}(ind) = t(si+spk_on-1) + ...
            0.2*(t(si+spk_on-1 + spk_off-1) - t(si+spk_on-1));
        % update start index
        si = si + spk_on + spk_off - 2;
        %NOTE: -2 is needed to account for compound indexing of spk_on and spk_off
        
        % find spike onset index relative to start index
        spk_on = find(thdata(si:end,n) == 1,1,'first');
        % update spike index
        ind = ind + 1;
    end
end

% % check if interpolated spikes match raw thresholded data (for debugging
% % only)
% plot(t(1:3000),40*thdata(1:3000),spktimes{1}(1:4),40*ones(4,1),'.',t(1:3000),data(1:3000))
% set(gca,'fontsize',14)
% xlabel('time (ms)')
% legend('Thresholded data','Interpolated spike time','Raw data')
% legend boxoff



%% plot spike raster

scrsz = get(0,'ScreenSize');
figH = figure;
set(figH,'position',[0,400,scrsz(3)-0.4*scrsz(3),scrsz(4)-0.6*scrsz(4)]);
cla;
hold on;
title(cellname,'fontsize',16);
for ii = 1:nc
    for jj = 1:length(spktimes{ii})
        spkx = [spktimes{ii}(jj),spktimes{ii}(jj)];
        spky = [ii,ii + 0.9];
        line(spkx,spky,'color',color,'LineWidth',1);
    end
end

axis([0,t(end),0,nc + 2]);
set(gca,'fontsize',fs)
xlabel('time (ms)','fontsize',fs);
ylabel('neuron','fontsize',fs);
