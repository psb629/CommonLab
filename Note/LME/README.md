## Linear Mixed Effects Models

Linear Mixed Effects models are used for regression analyses involving dependent data. Such data arise when working with longitudinal and other study designs in which multiple observations are made on each subject. Some specific linear mixed effects models are

- _Random intercepts models_, where all responses in a group are additively shifted by a value that is specific to the group.
- _Random slopes models_, where the responses in a group follow a (conditional) mean trajectory that is linear in the observed covariates, with the slopes (and possibly intercepts) varying by group.
- _Variance components models_, where the levels of one or more categorical covariates are associated with draws from distributions. These random terms additively determine the conditional mean of each observation based on its covariate values.

The statsmodels implementation of LME is primarily group-based, meaning that random effects must be independently-realized for responses in different groups. There are two types of random effects in our implementation of mixed models: (i) random coefficients (possibly vectors) that have an unknown covariance matrix, and (ii) random coefficients that are independent draws from a common univariate distribution. For both (i) and (ii), the random effects influence the conditional mean of a group through their matrix/vector product with a group-specific design matrix.

A simple example of random coefficients, as in (i) above, is:
```math
Y_{ij}=\beta_{0}+\beta_{1}X_{ij}+\gamma_{0i}+\gamma_{1i}X_{ij}+\epsilon_{ij}
```

Here, $Y_{ij}$ is the $j^{th}$ measured response for subject $i$, and $X_{ij}$ is a covariate for this response. The “fixed effects parameters” $\beta_{0}$ and $\beta_{1}$ are shared by all subjects, and the errors $\epsilon_{ij}$ are independent of everything else, and identically distributed (with mean zero). The “random effects parameters” $\gamma_{0i}$ and $\gamma_{1i}$ follow a bivariate distribution with mean zero, described by three parameters: $\tt{var}(\gamma_{0i})$, $\tt{var}(\gamma_{1i})$, and $\tt{cov}(\gamma_{0i},\gamma_{1i})$. There is also a parameter for $\tt{var}(\epsilon_{ij})$.

A simple example of variance components, as in (ii) above, is:
```math
Y_{ijk}=\beta_{0}+\eta_{1i}+\eta_{2j}+\epsilon_{ijk}
```

Here, $Y_{ijk}$ is the $k^{th}$ measured response under conditions $i$, $j$. The only “mean structure parameter” is $\beta_{0}$. The $\eta_{1i}$ are independent and identically distributed with zero mean, and variance $\tau_{1}^{2}$, and the $\eta_{2j}$ are independent and identically distributed with zero mean, and variance $\tau_{2}^{2}$.

statsmodels MixedLM handles most non-crossed random effects models, and some crossed models. To include crossed random effects in a model, it is necessary to treat the entire dataset as a single group. The variance components arguments to the model can then be used to define models with various combinations of crossed and non-crossed random effects.

The statsmodels LME framework currently supports post-estimation inference via Wald tests and confidence intervals on the coefficients, profile likelihood analysis, likelihood ratio testing, and AIC.

```
In [1]: import statsmodels.api as sm

In [2]: import statsmodels.formula.api as smf

In [3]: data = sm.datasets.get_rdataset("dietox", "geepack").data

In [4]: md = smf.mixedlm("Weight ~ Time", data, groups=data["Pig"])

In [5]: mdf = md.fit()

In [6]: print(mdf.summary())
         Mixed Linear Model Regression Results
========================================================
Model:            MixedLM Dependent Variable: Weight
No. Observations: 861     Method:             REML
No. Groups:       72      Scale:              11.3669
Min. group size:  11      Log-Likelihood:     -2404.7753
Max. group size:  12      Converged:          Yes
Mean group size:  12.0
--------------------------------------------------------
             Coef.  Std.Err.    z    P>|z| [0.025 0.975]
--------------------------------------------------------
Intercept    15.724    0.788  19.952 0.000 14.179 17.268
Time          6.943    0.033 207.939 0.000  6.877  7.008
Group Var    40.394    2.149
========================================================

```

---

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
