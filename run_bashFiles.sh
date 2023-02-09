#!/bin/bash
#SBATCH --job-name=fgain
#SBATCH --output=fgain_Forward_KL_masked_0.1__%j.log
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=1
#SBTACH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --mem=1M
#SBATCH --mail-type=END
#SBATCH --mail-user=zackary.hopkins@slu.edu

for file in ./bashFiles/*; do 
    sbatch $file
    sleep 5
done