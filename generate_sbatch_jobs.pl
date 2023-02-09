$num = @ARGV;

$outputfolder = $ARGV[0];


`mkdir -p $outputfolder`;


$cou=0;
for($para=0.01;$para<0.1;$para+=0.01)
{
	$cou++;
	$runfile = "$outputfolder/run_MyTaskname_sublist".$cou.".sh"
	open(SH,">$runfile") || die "Failed to open $runfile";

 	print SH "#!/bin/bash\n";
	##SBATCH --job-name=fgain
	##SBATCH --output=log_fgain_%j.log
	##SBATCH --gpus-per-node=1
	##SBATCH --cpus-per-task=6
	##SBATCH --ntasks-per-node=1
	##SBTACH --time=01:00:00
	##SBATCH --nodes=1
	##SBATCH --mem=20G
	##SBATCH --mail-type=END
	##SBATCH --mail-user=zackary.hopkins@slu.edu
	#
	#module load python3
	#
	#pip install -r requirements.txt
	#
	##List of missing rates
	##Loss functions : "Forward KL", "Reverse KL", "Pearsom Chi-Squared", "Square Hellingr", "Jensen-Shannon", "original"
	#
	##run_GAIN.py -d <dataFilePath> -l <lossFnction> -m <missingRate>
	#python /home/zackary.hopkins/ra-code/run_fGAIN.py -d /data/projects/zackary.hopkins/cellbygene.csv -l original -m .02 
	

        close SH;


}




}

