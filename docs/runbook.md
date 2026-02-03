# Feature Template Runbook

This runbook provides step-by-step instructions for the **Feature Template** - a comprehensive starter project for developing, deploying, and managing machine learning features and APIs.

## Overview

The Feature Template is designed for teams building:

- **Machine Learning APIs**: Deploy models as containerized web services
- **Device-Local Scripts**: Manage and version scripts on edge devices
- **Data Processing Features**: Containerized ML and data pipelines
- **Microservice Architecture**: Independently deployable feature services

### Architecture

- **FastAPI Backend**: RESTful API with automatic OpenAPI documentation
- **PyTorch Integration**: ML model development and deployment
- **Container-First**: Docker containers with CI/CD automation
- **Version Management**: Semantic versioning with rollback capabilities
- **Dual Environments**: Production (pip) and Development (conda) setups

## Prerequisites

## Prerequisites

- Python 3.9+
- Git
- (Optional) Conda/Miniconda for development environment
- (Optional) Docker for containerized deployment

## Development Workflow

### Branching Strategy

#### Creating Feature Branches

```bash
# Always start from main branch
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name

# Example feature branches:
git checkout -b feature/user-authentication
git checkout -b feature/data-export-api
git checkout -b feature/model-training-pipeline
```

#### Development Process

1. **Setup Environment**:
   ```bash
   conda env create -f environment.yml
   conda activate feature-template
   pip install -e ".[dev,ml]"
   ```

2. **Implement Feature**:
   - Add code in appropriate directories (`src/core/`, `src/api/`, etc.)
   - Write tests in `tests/`
   - Update documentation if needed

3. **Test Locally**:
   ```bash
   # Run all tests
   pytest tests/ -v

   # Run API tests
   pytest tests/test_api.py -v

   # Test manually
   uvicorn src.main:app --reload
   curl http://localhost:8000/health
   ```

4. **Commit Changes**:
   ```bash
   git add .
   git commit -m "feat: add user authentication feature

   - Add login endpoint
   - Add user model
   - Add authentication middleware
   - Add tests for authentication"
   ```

5. **Push and Create PR**:
   ```bash
   git push origin feature/your-feature-name
   # Create pull request on GitHub
   ```

#### Code Quality Checks

Before pushing your branch:

```bash
# Format code
black src/ tests/

# Lint code
flake8 src/ tests/

# Type check
mypy src/

# Run tests with coverage
pytest tests/ --cov=src --cov-report=html
```

### Pull Request Guidelines

- **Title**: Use conventional commits format (feat:, fix:, docs:, refactor:)
- **Description**: Explain what the feature does and why it's needed
- **Tests**: Include tests for new functionality
- **Documentation**: Update docs if API or behavior changes
- **Breaking Changes**: Clearly mark any breaking changes

### Merging

- Use **squash merge** for feature branches
- Delete branch after merge
- Ensure CI/CD pipeline passes before merging

### Branch Naming Convention
- `feature/feature-name` - New features
- `fix/bug-description` - Bug fixes
- `docs/documentation-update` - Documentation changes
- `refactor/code-improvement` - Code refactoring

Example branches:
- `feature/user-authentication`
- `feature/data-export-api`
- `fix/authentication-token-validation`
- `docs/update-api-documentation`
- `refactor/simplify-model-validation`

## Quick Start

### 1. Clone and Setup

```bash
# Clone the repository
git clone <your-repo-url>
cd feature-template

# For development (recommended)
conda env create -f environment.yml
conda activate feature-template

# Or for production/minimal setup
pip install -e .
```

### 2. Run the API (Default Configuration)

```bash
# Start the FastAPI server
uvicorn src.main:app --reload

# The API will be available at:
# - http://localhost:8000 (main endpoint)
# - http://localhost:8000/docs (Swagger UI documentation)
# - http://localhost:8000/redoc (ReDoc documentation)
```

### 3. Test the API

Open a new terminal and test the endpoints:

```bash
# Check health
curl http://localhost:8000/health

# Get all features (initially empty)
curl http://localhost:8000/api/v1/features

# Create a feature
curl -X POST "http://localhost:8000/api/v1/features" \
     -H "Content-Type: application/json" \
     -d '{
       "name": "Example Feature",
       "description": "A sample feature for testing",
       "enabled": true
     }'

# Get the created feature
curl http://localhost:8000/api/v1/features/Example%20Feature

# Update the feature
curl -X PUT "http://localhost:8000/api/v1/features/Example%20Feature" \
     -H "Content-Type: application/json" \
     -d '{
       "name": "Example Feature",
       "description": "Updated description",
       "enabled": false
     }'

# Delete the feature
curl -X DELETE http://localhost:8000/api/v1/features/Example%20Feature
```

## API Tutorial

### Working with Features

The template includes a complete CRUD API for managing features. Here's how to use it:

#### 1. Create Multiple Features

```bash
# Create several features
curl -X POST "http://localhost:8000/api/v1/features" \
     -H "Content-Type: application/json" \
     -d '{"name": "User Authentication", "description": "Login and registration system", "enabled": true}'

curl -X POST "http://localhost:8000/api/v1/features" \
     -H "Content-Type: application/json" \
     -d '{"name": "Data Export", "description": "Export data to CSV/PDF", "enabled": false}'

curl -X POST "http://localhost:8000/api/v1/features" \
     -H "Content-Type: application/json" \
     -d '{"name": "Analytics Dashboard", "description": "Real-time analytics view", "enabled": true}'
```

#### 2. List All Features

```bash
curl http://localhost:8000/api/v1/features
```

Expected response:
```json
[
  {
    "name": "User Authentication",
    "description": "Login and registration system",
    "enabled": true
  },
  {
    "name": "Data Export",
    "description": "Export data to CSV/PDF",
    "enabled": false
  },
  {
    "name": "Analytics Dashboard",
    "description": "Real-time analytics view",
    "enabled": true
  }
]
```

#### 3. Get Specific Feature

```bash
curl "http://localhost:8000/api/v1/features/User%20Authentication"
```

#### 4. Update a Feature

```bash
curl -X PUT "http://localhost:8000/api/v1/features/Data%20Export" \
     -H "Content-Type: application/json" \
     -d '{"name": "Data Export", "description": "Export data to CSV/PDF/JSON", "enabled": true}'
```

#### 5. Delete a Feature

```bash
curl -X DELETE "http://localhost:8000/api/v1/features/Analytics%20Dashboard"
```

## Training Script Tutorial

### Running Training Scripts

If you want to use this template for training ML models instead of API deployment:

#### 1. Remove API Components (Optional)

```bash
# Remove API directory if not needed
rm -rf src/api/
```

#### 2. Modify Main Script

Edit `src/main.py` to add your training logic. The template includes a basic structure.

#### 3. Run Training

```bash
# Run the training script
python -m src.main

# Or use the dedicated training script
python scripts/train.py
```

#### 4. Example Training Output

```
Feature Template v0.1.0
Starting training...
Loading dataset...
Training model...
Epoch 1/10 - Loss: 0.5432
Epoch 2/10 - Loss: 0.4321
...
Training completed successfully!
Model saved to models/trained_model.pkl
```

## Testing

### Run Unit Tests

```bash
# Run all tests
pytest tests/

# Run with verbose output
pytest tests/ -v

# Run specific test file
pytest tests/test_api.py -v

# Run with coverage
pytest tests/ --cov=src --cov-report=html
```

### Manual Testing

```bash
# Test API endpoints manually
curl http://localhost:8000/health
curl http://localhost:8000/api/v1/features

# Test version reporting
curl http://localhost:8000/ | jq .version
```

## Deployment

### Docker Deployment

```bash
# Build the Docker image
docker build -t feature-template .

# Run the container
docker run -p 8000:8000 feature-template

# Check if it's running
curl http://localhost:8000/health
```

### CI/CD Pipeline

The template includes a GitHub Actions workflow that automatically builds and pushes Docker images.

#### Automatic Triggers:
- Push to `main` or `master` branch
- Creating version tags (e.g., `v1.2.3`)
- Pull requests to `main` or `master`

#### Manual Trigger:
You can also manually trigger the workflow from the GitHub Actions tab.

#### What the Pipeline Does:
1. **Build**: Creates Docker image with build cache for faster builds
2. **Test**: Runs the container and tests API endpoints
3. **Push**: Pushes to GitHub Container Registry (ghcr.io)
4. **Attest**: Generates build provenance attestation

#### Using Published Images:

```bash
# Pull from GitHub Container Registry
docker pull ghcr.io/YOUR_USERNAME/YOUR_REPO:latest

# Run the published image
docker run -p 8000:8000 ghcr.io/YOUR_USERNAME/YOUR_REPO:latest

# Or run a specific version
docker run -p 8000:8000 ghcr.io/YOUR_USERNAME/YOUR_REPO:v1.2.3
```

#### Local Container Management:

Use the provided container script for local development:

```bash
# Build locally
./scripts/container.sh build

# Test the build
./scripts/container.sh test

# Run locally
./scripts/container.sh run

# Push to registry (requires login)
./scripts/container.sh push
```

#### Publishing a Release:

```bash
# Update version
echo "1.2.3" > VERSION

# Commit and tag
git add VERSION
git commit -m "Release version 1.2.3"
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin main
git push origin v1.2.3

# The workflow will automatically build and publish the image
```

### Production Deployment

```bash
# Install production dependencies
pip install .

# Run with production server
uvicorn src.main:app --host 0.0.0.0 --port 8000 --workers 4
```

### Device Local Deployment

For deploying to edge devices or local machines:

```bash
# Use the deployment script
bash scripts/deploy.sh

# Check deployed version
cat current/VERSION

# Run deployed script
cd current && python -m src.main
```

## Version Management

### Creating a New Release

```bash
# Update version
echo "0.2.0" > VERSION

# Commit changes
git add .
git commit -m "Release version 0.2.0"

# Create git tag
git tag -a v0.2.0 -m "Release version 0.2.0"

# Push to repository
git push origin main
git push origin v0.2.0
```

### Rolling Back

```bash
# List available backups
ls backups/

# Restore from backup
cp -r backups/backup_20240119_143022_v0.1.0 current/

# Restart service
cd current && python -m src.main
```

## Monitoring

### Health Checks

```bash
# API health check
curl http://localhost:8000/health

# Expected response:
# {"status": "healthy", "version": "0.1.0"}
```

### Logs

```bash
# View application logs
tail -f logs/app.log

# Docker logs
docker logs <container-id>
```

### Version Tracking

```bash
# Check current version
cat VERSION

# Check deployed version
cat current/VERSION

# Check API version
curl http://localhost:8000/ | jq .version
```

## Troubleshooting

### Common Issues

#### API Not Starting
```bash
# Check if port 8000 is available
netstat -tlnp | grep :8000

# Try different port
uvicorn src.main:app --port 8001
```

#### Import Errors
```bash
# Ensure dependencies are installed
pip install -e .

# For development environment
conda activate feature-template
```

#### PyTorch Issues
```bash
# Check PyTorch installation
python -c "import torch; print(torch.__version__)"
python -c "print(torch.cuda.is_available())"

# Reinstall PyTorch for your CUDA version
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
```

#### Test Failures
```bash
# Run tests with detailed output
pytest tests/ -v -s

# Check test environment
python -c "import fastapi; print('FastAPI OK')"
```

### Getting Help

- Check the API documentation at `http://localhost:8000/docs`
- Review the README.md for setup instructions
- Check logs for error messages
- Ensure all dependencies are properly installed

## Next Steps

- Customize the `src/core/models.py` for your domain
- Add authentication to the API
- Implement persistent storage instead of in-memory
- Add logging and monitoring
- Configure CI/CD pipelines
- Set up automated testing