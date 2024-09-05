#!/bin/zsh

## ============================================================ ##
## default
tt=0
## ============================================================ ##
while (( $# )); do
	key="$1"
	case $key in
		-t | --time_shift)
			tt="$2"
		;;
		-r | --response)
			resp="$2"
		;;
		-h | --help)
			echo "-t, --time_shift"
			echo "-r, --response"
		;;
	esac
	shift ##takes one argument
done
## ============================================================ ##
time_shift=`printf "%1.1f" $tt`
## ============================================================ ##
dir_root="/mnt/ext5/DRN"
dir_fmri="$dir_root/fmri_data"
dir_stat="$dir_fmri/stats/GLM/AM/value_function/$resp/shift=${time_shift}s"
## ============================================================ ##
mask=`find $dir_fmri/masks -type f -name "mask.group.n*.frac=0.7.nii"`
## ============================================================ ##
cd $dir_stat
list_fname=(`find DRN?? -type f -name "stats.DRN??.nii"`)
setA=()
 #bucket=()
case $resp in
	'BLOCK(0.5,1)' | 'BLOCK(1,1)')
		for fname in $list_fname
			setA=($setA "${fname}[Val#1_Coef]")

		pname="3dttest++.Val#1_Coef.n$#list_fname.nii"
		3dttest++		\
			-setA $setA	\
			-mask $mask	\
			-prefix $pname
 #		bucket=($bucket $pname)
	;;
	'TENT(2,10,9)')
		for ii in `seq -f '%1g' 0 1 17`
		{
			for fname in $list_fname
				setA=($setA "${fname}[Val#${ii}_Coef]")

			pname="3dttest++.Val#${ii}_Coef.n$#list_fname.nii"
			3dttest++		\
				-setA $setA	\
				-mask $mask	\
				-prefix $pname
 #			bucket=($bucket $pname)
		}
	;;
esac
## ============================================================ ##
 #if [[ $#bucket -gt 1 ]]; then
 #	print $bucket
 #	3dbucket	\
 #		-prefix "3dttest++.bucket.Val_Coef.n$#list_fname.nii"	\
 #		-fbuc $bucket
 #fi
