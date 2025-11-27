#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --gres=gpu:1
#SBATCH --mem 42gb
#SBATCH --time 48:00:00
#SBATCH --output=/home/yourusername/bindcraft_%A.log

# Initialise environment and modules
module load a100
module load anaconda3
source activate BindCraft

SCRIPT_DIR="/data/$USER/BindCraft"

# Parsing command line options
SETTINGS="/path/to/your/target_settings.json"
FILTERS="$SCRIPT_DIR/settings_filters/default_filters.json"
ADVANCED="$SCRIPT_DIR/settings_advanced/default_4stage_multimer.json"

# Ensure that SETTINGS is not empty
if [ -z "$SETTINGS" ]; then
    echo "Error: The -s or --settings option is required."
    exit 1
fi

echo "Running the BindCraft pipeline"
python -u "${SCRIPT_DIR}/bindcraft.py" --settings "${SETTINGS}" --filters "${FILTERS}" --advanced "${ADVANCED}"
