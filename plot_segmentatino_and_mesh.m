% PLOT_SEGMENT_AND_MESH
% Visualize MRI-based segmentation volume, plot generated mesh, and overlay
% source–detector grid.
%
% This script:
%   1. Loads a segmented MRI volume and displays it.
%   2. Loads a pre-generated mesh and plots tissue regions with transparency.
%   3. Overlays optical sources and detectors on the mesh.
%   4. Provides instructions for loading the mesh into NIRFAST for simulations.
%
% Requirements:
%   - iso2mesh toolbox (https://www.mathworks.com/matlabcentral/fileexchange/68258-iso2mesh)
%   - CGAL mesh generator (https://doc.cgal.org/latest/Mesh_3/index.html)
%   - brewermap (for colormaps)
%
% Author: Jingyi Wu (2025)

clear
close all

%% Add toolbox
% iso2mesh is required for mesh visualization
% https://www.mathworks.com/matlabcentral/fileexchange/68258-iso2mesh

%% Add path
addpath('utils/');
addpath(genpath('data/'));

%% Show the full segmentation volume
% Full segmented volume derived from MRI scan.
% Note:
% - User can generate their own mesh from this volume.
% - Placenta is not segmented here but can be specify as needed before/after mesh generation.
load('segmentation_full_volume.mat');
volumeViewer(volume, volume);

%% Load mesh information
% Load pre-generated mesh (zoomed-in region) for visualization.
% A smaller cropped volume was chosen to achieve higher resolution with 
% reasonable computation time.
% Mesh generated with RunCGALMeshGenerator:
% https://doc.cgal.org/latest/Mesh_3/index.html
load('mesh_info/mesh_info.mat');

%% Plot mesh and source-detector grid
num_tissue = length(unique(genmesh.ele(:,5)));   % number of tissue labels
cmap = brewermap(12,'Spectral');                 % colormap
cutoff_txt = 'x>0';                              % clipping plane condition
alpha_edge = 0.05;                               % mesh edge transparency
alpha_face = 0.3;                                % mesh face transparency

figure; set(gcf,'Position',[0 50 500 500]); hold on;
for idx_tissue = 1:num_tissue
    iso2mesh_plotmesh( ...
        genmesh.node, ...
        genmesh.ele(genmesh.ele(:,5) == idx_tissue,:), ...
        cutoff_txt, ...
        'FaceColor',cmap(idx_tissue+3,:), ...
        'EdgeAlpha',alpha_edge, ...
        'FaceAlpha',alpha_face);
end

% Overlay sources (red) and detectors (blue)
s1 = scatter3(sources(:,1), sources(:,2)+2, sources(:,3)+3, ...
              25,'ro','filled');
s2 = scatter3(detectors(:,1), detectors(:,2)+1, detectors(:,3)+1, ...
              25,'bo','filled');

xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');

xticks(0:50:200);
yticks(0:50:200);
zticks(0:50:200);

view([230,30]);
lgd = legend([s1,s2],{'Source','Detector'}, ...
             'Location','northeast','FontSize',15);
lgd.Box = "off";
axis equal square
set(gca,'FontWeight','bold','FontSize',15,'LineWidth',1.1,'FontName','Arial');

%% Export mesh for NIRFAST
% To use this mesh (or other generated meshes) in NIRFAST:
%   - Use the load_mesh function, which reads all .elem, .link, .meas,
%     .node, .param, .region, and .source files.
%   - The result is a mesh struct that can be used for simulations.
%   - A reference mesh struct was also saved as mesh.mat.
%
% Example:
%   mesh_location = 'data/mesh_info/mesh';
%   mesh = load_mesh(mesh_location);
