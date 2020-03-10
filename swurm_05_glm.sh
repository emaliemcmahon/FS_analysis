sid=$1

#sbatch run_05_glm.sh ${sid} maintask-surface-lh-sm0 -run-wise
#sbatch run_05_glm.sh ${sid} maintask-surface-rh-sm0 -run-wise

#sbatch run_05_glm.sh ${sid} biomotion-surface-lh-sm5
#sbatch run_05_glm.sh ${sid} biomotion-surface-rh-sm5

sbatch run_05_glm.sh ${sid} psts-surface-lh-sm5
sbatch run_05_glm.sh ${sid} psts-surface-rh-sm5
