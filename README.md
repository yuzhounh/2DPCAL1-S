# 2DPCA with L1-norm for simultaneously robust and sparse modelling

MATLAB comparisons of five PCA methods for face classification and reconstruction with nearest-neighbor classification.

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-D4AF37?style=flat-square)](LICENSE)

Copyright (C) 2013 Jing Wang

Comparison of five dimensionality reduction algorithms in face classification and reconstruction. The five algorithms are: PCA, PCA-L1, 2DPCA, 2DPCA-L1, 2DPCAL1-S. Classifier is chosen to be Nearest Neighbor(NN).  

## Repository Structure

- [demo.m](demo.m): workflow.
- [demo_load_data.m](demo_load_data.m): Yale image loading.
- [demo_classification.m](demo_classification.m) and [demo_reconstruction.m](demo_reconstruction.m): evaluation stages.
- [yalefaces.zip](yalefaces.zip) and [data.zip](data.zip): supplied archives.

## Citation
Haixian Wang and Jing Wang, "2DPCA with L1-norm for simultaneously robust and sparse modelling," Neural Networks, vol. 46, no. 0, pp. 190-198, 2013.

## Prerequisites and Execution

Run from the repository directory in MATLAB with Image Processing Toolbox available: the loader calls `imresize` and `montage`. [demo.m](demo.m) extracts the supplied [yalefaces.zip](yalefaces.zip), loads 15 subjects with 11 images each, performs classification, adds noise, and runs reconstruction. The loader writes `Yale.mat`.

## Quick Start
Run demo.m.

## License

See the existing [GPL-3.0 license](LICENSE).

## Contact
Jing Wang  
wangjing0@seu.edu.cn   
yuzhounh@163.com  
2013-6-15 20:17:43
