#!/bin/bash
# GPU Information Script with Fake Environment Variables

echo "Gathering GPU Information..."
sleep 2

GPU_COUNT=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "Detected $GPU_COUNT GPUs."
echo

for i in $(seq 0 $(($GPU_COUNT - 1))); do
    echo "GPU $i:"
    GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits -i $i)
    GPU_MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits -i $i)
    GPU_MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits -i $i)
    GPU_MEM_FREE=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits -i $i)

    echo "  Name: $GPU_NAME"
    echo "  Total Memory: ${GPU_MEM_TOTAL} MiB"
    echo "  Used Memory: ${GPU_MEM_USED} MiB"
    echo "  Free Memory: ${GPU_MEM_FREE} MiB"
    echo
done

echo "Exporting Fake Environment Variables..."
sleep 1

export GPU_OPTIMIZATION_LEVEL="MAX_PERFORMANCE"
export GPU_SYNC_MODE="ENABLED"
export GPU_OVERDRIVE="TRUE"

echo "Environment Variables Set."
echo "Script completed."
