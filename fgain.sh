#!/bin/bash
#SBATCH --job-name=fgain
#SBATCH --output=log_fgain_%j.log
#SBATCH --cpus-per-task=8
#SBATCH --ntasks-per-node=1
#SBTACH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --mem=20G
#SBATCH --mail-type=END
#SBATCH --mail-user=zackary.hopkins@slu.edu

module load python3

pip install -r requirements.txt

#run_GAIN.py -d <dataFilePath> -l <lossFnction> -m <missingRate>
python /home/zackary.hopkins/ra-code/run_fGAIN.py -d /data/projects/zackary.hopkins/cellbygene.csv -m /data/projects/zackary.hopkins/masked_0.1.csv -l original 