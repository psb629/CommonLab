#!/bin/zsh

## ============================================================ ##
## $# = the number of arguments
while (( $# )); do
	key="$1"
	case $key in
##		pattern)
##			sentence
##		;;
		-s | --subject)
			subj="$2"
		;;
		-t | --time_shift)
			tt="$2"
		;;
	esac
	shift ##takes one argument
done
## ============================================================ ##
gg=$subj[1,2]
## ============================================================ ##
if [ ! $tt ]; then
	tt=0
fi
time_shift=`printf "%.1f\n" $tt`
stat="${time_shift}s_shifted"
## ============================================================ ##
dir_script="/home/sungbeenpark/Github/labs/GP/scripts"

dir_root="/mnt/ext5/GP/fmri_data/stats/AM/GLM.reward_per_trial/$stat/Zstat.r03-r01"
## ============================================================ ##
dir_output="$dir_root"
if [ ! -d $dir_output ]; then
	mkdir -p -m 755 $dir_output
fi
## ============================================================ ##
3dcalc \
	-a /mnt/ext5/$gg/fmri_data/stats/AM/GLM.reward_per_trial/$stat/$subj/Rew#1_Zstat.r01.$subj.nii \
	-b /mnt/ext5/$gg/fmri_data/stats/AM/GLM.reward_per_trial/$stat/$subj/Rew#1_Zstat.r03.$subj.nii \
	-expr '(b-a)' \
	-prefix $dir_output/Zstat.$subj.r03-r01.nii
