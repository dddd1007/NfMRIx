# The new fMRI analysis workflow by xIA

本 repo 尝试使用新的工作流程来对 fMRI 数据进行分析。尝试使用新的标准（如 BIDS ）或分析工具（如 fMRIprep ）来完善现有的工作流程，提高研究的复用性。

## Step 1 DCM文件的数据转换与存储

中心获取数据为 DICOM 格式文件，将其转换为符合 BIDS 的结构。

BIDS 是将传统的 DICOM 转换为 Niftis 格式后，重新按照一定的文件结构进行整理，并使用 json 文件记录扫描参数和相关实验信息，使得后续的分析过程能够自动化，也便于不同研究者之间分享的文件结构。详情请参阅 BIDS 官方网站。

在试用 [heudiconv](https://github.com/nipy/heudiconv)，dcm2niix 以及 dicm2nii 三种工具后，最终选择了基于dcm2niix的dcm2bids。该工具只需编写json文件便能够识别大多数的Niftis文件。

### Usage

该工具的使用逻辑是，首先在导出文件夹中使用 dcm2bids_scaffold 生成符合BIDS协议的基本文件夹，然后使用dcm2bids_helper 生成示例nii文件。按照生成的文件与实验设计，在code文件夹中编写dcm2bids_config.json配置文件，遵循规则<https://cbedetti.github.io/Dcm2Bids/tutorial/#building-the-configuration-file>。随后便可对所有被试进行批量转换。