function run_11_reorgdata(subj)
%Gets the activity in each roi for one subject.
%Written by EG McMahon 02/24/2019

%% Set up Enviornment
if nargin < 1
    subj = 's001';
end
addpath('/software/apps/freesurfer/6.0.0/matlab/');

analysis_path = pwd;
top_path = '/home-2/emcmaho7@jhu.edu/work/mcmahoneg/mri_data_anlys/';
bold_path = ['studies/cont_actions/unpackdata/',subj,'/bold/'];
out_path = ['studies/cont_actions/analysis/ROI_data/',subj,'/'];
if ~exist(out_path,'dir')
    mkdir(out_path)
end 

localizer.names = {'FBO','biomotion','psts'};
localizer.regions = {{'EBA','FFA','LOC'},{'BioMotion','MT'},{'pSTS'}};
localizer.filenames = {{'EBA_surf.nii.gz','FFA_surf.nii.gz','LOC_surf.nii.gz'},...
    {'BioMotion_STS_SubMap.nii.gz','h.MT_exvivo'},...
    {'STS.nii.gz'}};
localizer.contrast = {{'body_object','face_object','object_face'},...
    {'bio_translation','motion_static'},...
    {'interaction'}};

beta_name = 'beta_mni.nii.gz';
loc_name = 'mask_mni.nii.gz';
hemi = {'l','r'};
nruns = 10;

%% Load Data
cd(top_path)
for iloc = 1:length(localizer.names)
    for ireg = 1:length(localizer.regions{iloc})
        for ir = 1:nruns
            both_hemis = [];
            for ih = 1:2
                %Load ROI mask
                loc_path = [bold_path,...
                    localizer.names{iloc},'-surface-',hemi{ih},'h-sm5/'];
                cur_file = [loc_path,...
                    localizer.contrast{iloc}{ireg},'/',loc_name];
                mask = MRIread(cur_file); mask =  logical(mask.vol);
                
                %Load Bets
                analysis_name = ['maintask-surface-',hemi{ih},'h-sm0'];
                run_folders=dir([bold_path,analysis_name,'/pr*']);
                run_path = [bold_path,analysis_name,'/',run_folders(ir).name,'/'];
                betas = MRIread([run_path,beta_name]);
                betas = squeeze(betas.vol);
                betas = betas(:,1:4)'; %First indices are the conditions.
                
                both_hemis = cat(2,both_hemis,betas(:,mask));
            end
            %Save Betas
            out_file = [out_path,...
                localizer.regions{iloc}{ireg},'_run',...
                num2str(ir,'%02d'),'.csv'];
            writematrix(both_hemis,out_file)
        end
    end
end
cd(analysis_path)
end %FUNCTION END

