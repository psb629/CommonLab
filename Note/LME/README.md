## Creating a virtual environment for LME analysis

```
conda create --name LME python=3.9
conda activate LME
```

```
pip install pandas scipy ipykernel
python -m ipykernel install --user --name LME --display-name LME
```

```
conda install -c conda-forge statsmodels
conda install -c ejolly -c conda-forge -c defaults pymer4
```
