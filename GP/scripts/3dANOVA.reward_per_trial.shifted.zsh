#!/bin/zsh

## ============================================================ ##
## $# = the number of arguments
while (( $# )); do
	key="$1"
	case $key in
		-t | --time_shift)
			tt="$2"
		;;
		-r | --run)
			run="$2"
		;;
	esac
	shift ##takes one argument
done
## ============================================================ ##
if [ ! $tt ]; then
	tt=0
fi
time_shift=`printf "%.1f\n" $tt`
## ============================================================ ##
case $run in
	1 | 'r01')
		run='r01'
	;;
	2 | 'r02')
		run='r02'
	;;
	3 | 'r03')
		run='r03'
	;;
	*)
		run='rall'
	;;
esac
## ============================================================ ##
dir_GA="/mnt/ext5/GA/fmri_data/stats/AM/GLM.reward_per_trial/${time_shift}s_shifted"
## ============================================================ ##
dir_root="/mnt/ext5/GP"

dir_fmri="$dir_root/fmri_data"
dir_mask="$dir_fmri/masks"
dir_stat="$dir_fmri/stats/AM/GLM.reward_per_trial/${time_shift}s_shifted"

dir_output=$dir_stat/3dANOVA
if [ ! -d $dir_output ]; then
	mkdir -p -m 755 $dir_output
fi
## ============================================================ ##
list_no_stim=(`ls $dir_GA | grep -o 'GA[0-9][0-9]' | grep -o '[0-9][0-9]'`)
list_dlpfc_cTBS=(
	09 10 18 21 22 \
	24 27 34 35 36 \
	38 42 57 59 62 \
	66 67 \
)
list_m1_cTBS=(
	08 11 17 19 20 \
	26 32 33 37 39 \
	40 41 56 58 61 \
	63 65 \
)
 ### GP50은 GP26과 동일인물
 #list_dlpfc_20Hz=(
 #	43 44 45 46 47 48 \
 #	49 51 53 54 55 \
 #)
## ============================================================ ##
mask="$dir_mask/mask.group.day2.n42.frac=0.7.nii"
## ============================================================ ##
setA=()
for nn in $list_no_stim
{
	subj="GA$nn"
	setA=($setA "$dir_GA/$subj/stats.Rew.$subj.$run.nii[Rew#1_Coef]")
}
setB=()
for nn in $list_dlpfc_cTBS
{
	subj="GP$nn"
	setB=($setB "$dir_stat/$subj/stats.Rew.$subj.$run.nii[Rew#1_Coef]")
}
setC=()
for nn in $list_m1_cTBS
{
	subj="GP$nn"
	setC=($setC "$dir_stat/$subj/stats.Rew.$subj.$run.nii[Rew#1_Coef]")
}
 #setD=()
 #for nn in $list_dlpfc_20Hz
 #{
 #	subj="GP$nn"
 #	setd=($setd "$dir_stat/$subj/stats.rew.$subj.$run.nii[rew#1_coef]")
 #}
## ============================================================ ##
cd $dir_output
dsetA="3dbucket.Rew.$run.no_stim.nii"
if [ ! -f $dsetA ]; then
	3dbucket $setA	\
		-prefix $dsetA	\
		-fbuc
fi
dsetB="3dbucket.Rew.$run.dlpfc_cTBS.nii"
if [ ! -f $dsetB ]; then
	3dbucket $setB	\
		-prefix $dsetB	\
		-fbuc
fi
dsetC="3dbucket.Rew.$run.m1_cTBS.nii"
if [ ! -f $dsetC ]; then
	3dbucket $setC	\
		-prefix $dsetC	\
		-fbuc
fi
## ============================================================ ##
cd $dir_output
3dANOVA	\
	-levels 3	\
	-dset 1 $dsetA'[0]'	\
	-dset 1 $dsetA'[1]'	\
	-dset 1 $dsetA'[2]'	\
	-dset 1 $dsetA'[3]'	\
	-dset 1 $dsetA'[4]'	\
	-dset 1 $dsetA'[5]'	\
	-dset 1 $dsetA'[6]'	\
	-dset 1 $dsetA'[7]'	\
	-dset 1 $dsetA'[8]'	\
	-dset 1 $dsetA'[9]'	\
	-dset 1 $dsetA'[10]'	\
	-dset 1 $dsetA'[11]'	\
	-dset 1 $dsetA'[12]'	\
	-dset 1 $dsetA'[13]'	\
	-dset 1 $dsetA'[14]'	\
	-dset 1 $dsetA'[15]'	\
	-dset 1 $dsetA'[16]'	\
	-dset 1 $dsetA'[17]'	\
	-dset 1 $dsetA'[18]'	\
	-dset 1 $dsetA'[19]'	\
	-dset 1 $dsetA'[20]'	\
	-dset 1 $dsetA'[21]'	\
	-dset 1 $dsetA'[22]'	\
	-dset 1 $dsetA'[23]'	\
	-dset 1 $dsetA'[24]'	\
	-dset 1 $dsetA'[25]'	\
	-dset 1 $dsetA'[26]'	\
	-dset 1 $dsetA'[27]'	\
	-dset 1 $dsetA'[28]'	\
	-dset 1 $dsetA'[29]'	\
	-dset 2 $dsetB'[0]'	\
	-dset 2 $dsetB'[1]'	\
	-dset 2 $dsetB'[2]'	\
	-dset 2 $dsetB'[3]'	\
	-dset 2 $dsetB'[4]'	\
	-dset 2 $dsetB'[5]'	\
	-dset 2 $dsetB'[6]'	\
	-dset 2 $dsetB'[7]'	\
	-dset 2 $dsetB'[8]'	\
	-dset 2 $dsetB'[9]'	\
	-dset 2 $dsetB'[10]'	\
	-dset 2 $dsetB'[11]'	\
	-dset 2 $dsetB'[12]'	\
	-dset 2 $dsetB'[13]'	\
	-dset 2 $dsetB'[14]'	\
	-dset 2 $dsetB'[15]'	\
	-dset 2 $dsetB'[16]'	\
	-dset 3 $dsetC'[0]'	\
	-dset 3 $dsetC'[1]'	\
	-dset 3 $dsetC'[2]'	\
	-dset 3 $dsetC'[3]'	\
	-dset 3 $dsetC'[4]'	\
	-dset 3 $dsetC'[5]'	\
	-dset 3 $dsetC'[6]'	\
	-dset 3 $dsetC'[7]'	\
	-dset 3 $dsetC'[8]'	\
	-dset 3 $dsetC'[9]'	\
	-dset 3 $dsetC'[10]'	\
	-dset 3 $dsetC'[11]'	\
	-dset 3 $dsetC'[12]'	\
	-dset 3 $dsetC'[13]'	\
	-dset 3 $dsetC'[14]'	\
	-dset 3 $dsetC'[15]'	\
	-dset 3 $dsetC'[16]'	\
	-mask $mask	\
	-mean 1 no_stim	\
	-mean 2 dlpfc_cTBS	\
	-mean 3 m1_cTBS	\
	-ftr ftr	\
	-bucket 3dANOVA.Rew.$run.nii

