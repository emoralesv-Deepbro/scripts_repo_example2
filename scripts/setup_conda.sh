#!/usr/bin/env bash
# Setup script for conda development environment

set -e

echo "Setting up conda development environment for Feature Template..."

# Check if conda is installed
if ! command -v conda &> /dev/null; then
    echo "Conda is not installed. Please install Miniconda or Anaconda first."
    echo "Download from: https://docs.conda.io/en/latest/miniconda.html"
    exit 1
fi

# Create environment if it doesn't exist
if ! conda env list | grep -q "feature-template"; then
    echo "Creating conda development environment..."
    conda env create -f ../environment.yml
else
    echo "Environment 'feature-template' already exists."
fi

# Activate environment
echo "Activating environment..."
conda activate feature-template

# Verify installation
echo "Verifying PyTorch installation..."
python -c "import torch; print(f'PyTorch version: {torch.__version__}')"
python -c "print(f'CUDA available: {torch.cuda.is_available()}')"

echo "Development setup complete! Run 'conda activate feature-template' to use the environment."