# The new fMRI analysis workflow by xIA

本 repo 尝试使用新的工作流程来对 fMRI 数据进行分析。尝试使用新的标准（如 BIDS ）或分析工具（如 fMRIprep ）来完善现有的工作流程，提高研究的复用性。

## Step 0 环境配置

- 开发机（ThinkPad X1 Extreme 2018 i7-32G-1050）
  - Windows 10 Pro Insider 1903 Slow Ring
    - Ubuntu 18.04 LTS (WSL)
      - Neurodebian
      - Anaconda 2019.03
      - Docker.io
    - Docker 2.0.0.3 Stable
- 主力机（Alienware Aurora R8 i9-32G-2080）
  - Windows 10 Workstation
    - Ubuntu 18.04 LTS (WSL)
      - Neurodebian
      - Anaconda 2019.03
      - Docker.io
    - Docker 2.0.0.3 Stable

## Step 1 DCM文件的数据转换与存储

中心获取数据为 DICOM 格式文件，将其转换为符合 BIDS 的结构。

BIDS 是将传统的 DICOM 转换为 Niftis 格式后，重新按照一定的文件结构进行整理，并使用 json 文件记录扫描参数和相关实验信息，使得后续的分析过程能够自动化，也便于不同研究者之间分享的文件结构。详情请参阅 BIDS 官方网站。

使用 APT 包管理安装 dcm2niix，使用 pip 安装 dcm2bids。在试用 heudiconv，dcm2niix 以及 dicm2nii 三种工具后，最终选择了基于 dcm2niix 的 dcm2bids。该工具只需编写 json 文件便能够识别大多数的 Niftis 文件。

### Install

`sudo apt install dcm2niix`

`pip install dcm2bids`

### Usage

该工具的使用逻辑是，首先在导出文件夹中使用 dcm2bids_scaffold 生成符合 BIDS 协议的基本文件夹，然后使用 dcm2bids_helper 生成示例 nii 文件。按照生成的文件与实验设计，在 code 文件夹中编写 dcm2bids_config.json 配置文件，遵循规则 https://cbedetti.github.io/Dcm2Bids/tutorial/#building-the-configuration-file。随后便可对所有被试进行批量转换。

## Step 2 数据预处理

比较多种工具后，选择基于nipype工具的fmriprep作为预处理工具。(分析过程待编写)