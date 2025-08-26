# Sensitivity Analysis of Transabdominal Fetal Pulse Oximetry Using MRI-Based Simulations

This repository contains example MATLAB code and data accompanying the paper:  
[**“Sensitivity analysis of transabdominal fetal pulse oximetry using MRI-based simulations.”**](https://doi.org/10.1364/BOE.531149)  

It provides two main scripts for visualization and simulation of optical signals from MRI-derived tissue segmentations.

## Repository Contents

- **`scripts/`**
  - `plot_segment_and_mesh.m`  
    Visualizes segmented MRI volume and pre-generated mesh, and overlays source–detector positions.  
  - `add_noise_and_plot_dod.m`  
    Applies distance-dependent noise to simulated fluence data and plots change in optical density (ΔOD) due to fetal pulsation.
- **`utils/`**
  - `fit_one_term_exponential.m`  
    Helper function for fitting distance-dependent exponential noise.
  - `brewermap.m`  
    Helper function for colormaps (see file header for attribution and license).
- **`data/`**
  - `segmentation_full_volume.mat` – Example segmented volume (demo only).  
  - `mesh_info/mesh_info.mat` – Pre-generated mesh from cropped region.  
  - `example_fluence_data.mat` – Example fluence simulation (demo only).  

## Quick Start

### Requirements
- MATLAB R2021a or newer  
- [iso2mesh](https://www.mathworks.com/matlabcentral/fileexchange/68258-iso2mesh)

**Optional (for mesh generation and simulation beyond the demo):**
- [CGAL Mesh Generator](https://doc.cgal.org/latest/Mesh_3/index.html)  
- [NIRFAST / NIRFASTer](https://github.com/nirfaster/NIRFASTer)

### Run Demo

Clone the repository and open MATLAB:

```matlab
addpath(genpath('utils'));
addpath(genpath('data'));

% Plot MRI segmentation and mesh
scripts/plot_segment_and_mesh

% Apply noise model and plot ΔOD
scripts/add_noise_and_plot_dod
```

## License

- Code: MIT License (see `LICENSE`)  
- Demo data: Creative Commons Attribution 4.0 (same as the journal publication)  

If you use the demo code or data, please maintain attribution to the author(s), article title, journal citation, and DOI:  
[Wu et al., Biomedical Optics Express, 2024, DOI:10.1364/BOE.531149](https://doi.org/10.1364/BOE.531149).


## Contact

For questions, please contact: **Jingyi Wu** (jingyiwu@andrew.cmu.edu).
