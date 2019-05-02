# The new fMRI analysis workflow by xIA

![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg) ![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)

本 repo 尝试使用新的工作流程来对 fMRI 数据进行分析。尝试使用新的标准（如 BIDS ）或分析工具（如 fMRIprep ）来完善现有的工作流程，提高研究的复用性。

本项目内容禁止用于商业目的或进行发表，欢迎用于自学，并提交 issue 进行讨论。

## Step 0 环境配置

- 开发机（ThinkPad X1 Extreme 2018 i7-32G-1050）
  - Windows 10 Pro Insider 1903 Slow Ring
    - Ubuntu 18.04 LTS (WSL)
      - Neurodebian
      - Anaconda 2019.03
      - Docker.io
    - Docker 2.0.0.3 Stable
    - PowerShell RC6-1
- 主力机（Alienware Aurora R8 i9-32G-2080）
  - Windows 10 Workstation
    - Pengwin
      - Neurodebian
      - Anaconda 2019.03
      - Docker.io
    - Docker 2.0.0.3 Stable
    - PowerShell RC6-1

## Step 1 DCM文件的数据转换与存储

中心获取数据为 DICOM 格式文件，将其转换为符合 BIDS 的结构。

BIDS 是将传统的 DICOM 转换为 Niftis 格式后，重新按照一定的文件结构进行整理，并使用 json 文件记录扫描参数和相关实验信息，使得后续的分析过程能够自动化，也便于不同研究者之间分享的文件结构。详情请参阅 BIDS 官方网站。

使用 APT 包管理安装 dcm2niix，使用 pip 安装 dcm2bids。在试用 heudiconv，dcm2niix 以及 dicm2nii 三种工具后，最终选择了基于 dcm2niix 的 dcm2bids。该工具只需编写 json 文件便能够识别大多数的 Niftis 文件。

### Install

`sudo apt install dcm2niix`

`pip install dcm2bids`

### Usage

该工具的使用逻辑是，首先在导出文件夹中使用 dcm2bids_scaffold 生成符合 BIDS 协议的基本文件夹，然后使用 dcm2bids_helper 生成示例 nii 文件。按照生成的文件与实验设计，在 code 文件夹中编写 dcm2bids_config.json 配置文件，遵循规则 https://cbedetti.github.io/Dcm2Bids/tutorial/#building-the-configuration-file 。随后便可对所有被试进行批量转换。

## Step 2 数据预处理

比较多种工具后，选择基于 nipype 工具的 fmriprep 作为预处理工具。（文档编写时，版本号为 Ver.1.3.2）。

### Install

按照方式包括使用容器或手动配置环境。官方强烈推荐使用容器。本机验证建议使用 Docker，HPC 环境下建议使用 Singularity 。

1. 安装 Docker：<https://www.docker.com/products/docker-desktop>
2. 配置本地 Python 环境，推荐使用 Anaconda
3. 使用 pip 安装 fmriprep-docker

### Usage

fmriprep 可以直接在命令行调用，会直接调用容器进行后续分析。基本命令为：

`fmriprep-docker /input_bids_dir /output_dir participant`

其中 /input_bids_dir 与 /output_dir 需要自行修改位置。“participant” 无需修改，原样填写。

### Attention

- 使用中可能会出现 /tmp 无法写入或空间不足的情况，请在 Docker 的 Setting 中开启 C 盘的 Share，并增加镜像可使用空间。
- 大部分的 warning 可以忽视。同时程序结束后会报 'Error in atexit._run_exitfuncs' 的错误。查阅少量资料后，了解该问题与多线程处理结束后清理分析环境有关，可以忽略。
- Windows 环境下推荐使用 PowerShell 调用 fmriprep，此时文件夹定位按照 Windows 下路径填写即可，无需以 Docker 的共享路径 "/mnt_c/..." 方式填写。