#!/usr/bin/env bash
# Container management script
# Usage: ./scripts/container.sh [build|test|push|run]

set -e

IMAGE_NAME="feature-template"
REGISTRY="ghcr.io"
REPO_NAME="${REGISTRY}/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')"
VERSION=$(cat VERSION)

case "$1" in
    build)
        echo "Building Docker image..."
        docker build -t "${IMAGE_NAME}:latest" -t "${IMAGE_NAME}:${VERSION}" .
        ;;

    test)
        echo "Testing Docker image..."
        # Start container
        docker run -d --name test-container -p 8000:8000 "${IMAGE_NAME}:latest"

        # Wait for startup
        sleep 10

        # Test endpoints
        echo "Testing health endpoint..."
        curl -f http://localhost:8000/health

        echo "Testing API endpoint..."
        curl -f http://localhost:8000/api/v1/features

        # Cleanup
        docker stop test-container
        docker rm test-container

        echo "Container tests passed!"
        ;;

    push)
        echo "Pushing to registry..."
        # Tag for registry
        docker tag "${IMAGE_NAME}:latest" "${REPO_NAME}:latest"
        docker tag "${IMAGE_NAME}:${VERSION}" "${REPO_NAME}:${VERSION}"

        # Login and push
        echo "Please ensure you're logged in: docker login ${REGISTRY}"
        docker push "${REPO_NAME}:latest"
        docker push "${REPO_NAME}:${VERSION}"

        echo "Pushed ${REPO_NAME}:${VERSION}"
        ;;

    run)
        echo "Running container..."
        docker run -p 8000:8000 "${IMAGE_NAME}:latest"
        ;;

    *)
        echo "Usage: $0 {build|test|push|run}"
        echo "  build  - Build Docker image"
        echo "  test   - Test the built image"
        echo "  push   - Push to container registry"
        echo "  run    - Run the container locally"
        exit 1
        ;;
esac