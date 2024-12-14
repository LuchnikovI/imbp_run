#!/usr/bin/env bash

#SBATCH --mail-user=ilia.luchnikov@tii.ae
#SBATCH --job-name=tfi_on_complex_latices
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=16
#SBATCH --nodes=4
#SBATCH --time=4-00:00:00
#SBATCH --mem=32GB
#SBATCH --mail-type=END,FAIL

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Execute job steps
srun --ntasks=1 --nodes=1 --cpus-per-task=$SLURM_CPUS_PER_TASK "${script_dir}/runner.sh heavy_hex_ibm" &
srun --ntasks=1 --nodes=1 --cpus-per-task=$SLURM_CPUS_PER_TASK "${script_dir}/runner.sh hex" &
srun --ntasks=1 --nodes=1 --cpus-per-task=$SLURM_CPUS_PER_TASK "${script_dir}/runner.sh square" &
srun --ntasks=1 --nodes=1 --cpus-per-task=$SLURM_CPUS_PER_TASK "${script_dir}/runner.sh diamond" &
wait