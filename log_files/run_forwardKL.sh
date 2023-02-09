#!/bin/bash
#!/bin/bash
#SBATCH --job-name=fgain
#SBATCH --output=forwardKL_run_%j.log
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=1
#SBTACH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --mem=1M
#SBATCH --mail-type=END
#SBATCH --mail-user=zackary.hopkins@slu.edu

for file in ./bashFiles/Forward_KL*; do 
    sbatch $file
    sleep 5
done
