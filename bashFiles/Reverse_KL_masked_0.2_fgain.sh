#!/bin/bash
#SBATCH --job-name=fgain
#SBATCH --output=fgain_Reverse_KL_masked_0.2__%j.log
#SBATCH --cpus-per-task=8
#SBATCH --ntasks-per-node=1
#SBTACH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --mem=20G
#SBATCH --mail-type=END
#SBATCH --mail-user=zackary.hopkins@slu.edu

module load python3


pip install -r requirements.txt

#run_GAIN.py -d <dataFilePath> -l <lossFnction> -m <missingRate>
python /home/zackary.hopkins/ra-code/run_fGAIN.py -d /data/projects/zackary.hopkins/genebycell.csv -m /data/projects/zackary.hopkins/masked_0.2.csv -l "Reverse_KL"
