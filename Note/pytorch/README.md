## Check the environment

### Display `libc6` package status details
```
dpkg -s libc6
```
### Display CUDA version
```
nvcc --version
```
or
```
nvidia-smi
```

## Install pytorch
```
conda install pytorch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 pytorch-cuda=12.4 -c pytorch -c nvidia
```

## Check the validation
```
python -c "import torch; print(torch.cuda.is_available())"
```
If `True` is displayed when you run the above command, the installation was successful.
