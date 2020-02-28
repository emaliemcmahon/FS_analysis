function run_10_probROIs(subj)
%Selects the most active voxels with the ROI parcellations.
%Written by EG McMahon 02/24/2020

if nargin < 1
    subj = 's001';
end
addpath('/software/apps/freesurfer/6.0.0/matlab/');

analysis_path = pwd; 
top_path = '/home-2/emcmaho7@jhu.edu/work/mcmahoneg/mri_data_anlys/';
fsaverage_path = 'subjects/fsaverage/labels/';
bold_path = ['studies/cont_actions/unpackdata/',subj,'/bold/'];
dyloc_path = 'subjects/dyloc/';
si_path = 'subjects/BenDeen_SocialInteraction_surf/';

localizer.names = {'FBO','biomotion','psts'};
localizer.regions = {{'EBA','FFA','LOC'},{'BioMotion','MT'},{'pSTS'}};
localizer.filenames = {{'EBA_surf.nii.gz','FFA_surf.nii.gz','LOC_surf.nii.gz'},...
    {'BioMotion_STS_SubMap.nii.gz','h.MT_exvivo'},...
    {'STS.nii.gz'}};
localizer.contrast = {{'body_object','face_object','object_face'},...
    {'bio_translation','motion_static'},...
    {'interaction'}};
localizer.paths = {{dyloc_path,dyloc_path,dyloc_path},...
    {si_path,fsaverage_path},...
    {si_path}};

hemi = {'l','r'};

file_name = 'sig_mni.nii.gz';
out_name = 'mask_mni.nii.gz';

cd(top_path)
for iloc = 1:length(localizer.names)
    for ih = 1:2
        loc_path = [bold_path,...
            localizer.names{iloc},'-surface-',hemi{ih},'h-sm5/'];
        for icontrast = 1:length(localizer.contrast{iloc})
            %Sets the current paths.
            cur_path = [loc_path,...
                localizer.contrast{iloc}{icontrast},'/'];
            cur_file = [cur_path,file_name];
            out_file = [cur_path,out_name];
            
            %Load the p-values for the localizer contrast.
            sig = MRIread(cur_file);
            sig = sig.vol;
            
            %load the parcellation
            if strcmp(localizer.regions{iloc}{icontrast},'MT')
                %The MT exvivo label need to be opened 
                %with a different function. 
                parcel_temp = read_label('fsaverage',...
                    [hemi{ih},localizer.filenames{iloc}{icontrast}]);
                parcel = zeros(size(sig));
                parcel(1,parcel_temp(:,1)+1) = 1; %vertex labels in FS uses 0 indexing
            else
                parcel = MRIread([localizer.paths{iloc}{icontrast},...
                    hemi{ih},localizer.filenames{iloc}{icontrast}]);
                parcel = parcel.vol;
            end
            
            if range(parcel) ~= 1
                %Some of the parcels are probabilistic rather 
                %than binary. This makes them binaray. 
                parcel(parcel > median(parcel(parcel ~= 0))) = 1;
                parcel(parcel ~= 1) = 0;
            end
            parcel = logical(parcel);
            
            %Select the top 10% most active voxels in the parcel.
            %Smallest p-values in the parcel.
            n_vox = floor(length(sig(parcel)) * .1);
            sig(~parcel) = 1000;
            [~,i] = mink(abs(sig),n_vox);
            sig(i) = 1; 
            sig(sig ~= 1) = 0;
            
            fprintf('ROI size: %d \n',size(sig(sig ~= 0),2))
            
            mask.vol = sig;
            fprintf([out_file,'\n'])
            MRIwrite(mask,out_file);
            clear mask
        end
    end
end
cd(analysis_path)
end
