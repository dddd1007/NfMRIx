# The new fMRI analysis workflow by xIA

本 repo 尝试使用新的工作流程来对 fMRI 数据进行分析。尝试使用新的标准（如 BIDS ）或分析工具（如 fMRIprep ）来完善现有的工作流程，提高研究的复用性。

## Step 1 DCM文件的数据转换与存储

中心获取数据为 DICOM 格式文件，将其转换为符合 BIDS 的结构。

BIDS 是将传统的 DICOM 转换为 Niftis 格式后，重新按照一定的文件结构进行整理，并使用 json 文件记录扫描参数和相关实验信息，使得后续的分析过程能够自动化，也便于不同研究者之间分享的文件结构。详情请参阅 BIDS 官方网站。

在试用 [heudiconv](https://github.com/nipy/heudiconv)，dcm2niix 以及 dicm2nii 三种工具后，