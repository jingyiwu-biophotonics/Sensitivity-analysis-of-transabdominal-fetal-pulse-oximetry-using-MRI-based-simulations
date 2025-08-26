# Sensitivity Analysis of Transabdominal Fetal Pulse Oximetry (MRI-Based Simulations)

This repository contains MATLAB code and minimal demo data accompanying the paper:  

**“Sensitivity analysis of transabdominal fetal pulse oximetry using MRI-based simulations.”**  

It provides two main scripts for visualization and simulation of optical signals from MRI-derived tissue segmentations.

---

## Repository Contents

- **`scripts/`**
  - `plot_segment_and_mesh.m`  
    Visualizes segmented MRI volume and pre-generated mesh, and overlays source–detector positions.  
  - `add_noise_and_plot_dod.m`  
    Applies distance-dependent noise to simulated fluence data and plots differential optical density (ΔOD).
- **`utils/`**
  - `fit_one_term_exponential.m`  
    Helper function for fitting distance-dependent exponential noise.
- **`data/`**
  - `segmentation_full_volume.mat` – Example segmented volume (demo only).  
  - `mesh_info/mesh_info.mat` – Pre-generated mesh from cropped region.  
  - `example_fluence_data.mat` – Example fluence simulation (demo only).  

---

## Quick Start

### Requirements
- MATLAB R2021a or newer  
- Toolboxes: Image Processing, Statistics, Signal Processing  
- External tools (optional, for mesh generation):  
  - [iso2mesh](https://www.mathworks.com/matlabcentral/fileexchange/68258-iso2mesh)  
  - [CGAL Mesh Generator](https://doc.cgal.org/latest/Mesh_3/index.html)  
  - NIRFAST/NIRFASTer (if performing simulations beyond demo)

### Run Demo
Clone the repository and open MATLAB:

```matlab
addpath(genpath('utils'));
addpath(genpath('data'));

% Plot MRI segmentation and mesh
scripts/plot_segment_and_mesh

% Apply noise model and plot ΔOD
scripts/add_noise_and_plot_dod
