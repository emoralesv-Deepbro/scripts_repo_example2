# Contributing to Feature Template

Thank you for your interest in contributing to the Feature Template!

## What is Feature Template?

The Feature Template is for developing, deploying, and managing features and APIs. It provides:

- **FastAPI-based REST APIs** with automatic documentation
- **Containerization** with Docker and automated CI/CD
- **Version management** for device-local script deployment

This template is designed for teams building new features.

## Development Workflow and Standards

This section consolidates how we build, review, release, and document changes. It follows a simplified Git Flow model focused on speed, efficiency, and clear communication.

### Guiding Principles

- **Lean over heavy process:** We aim for the minimal viable process that does not slow down development and validation.
- **Ship fast, fix fast:** We prioritize action and quick feedback loops to deliver value rapidly and iterate quickly.
- **Document decisions, not everything:** We focus on capturing the "why" behind key architectural and process choices, rather than documenting every small detail.

### 1. Branching Strategy

Our strategy is optimized for CI/CD and fast-paced development.

#### 1.1 Branch Types and Naming

| Branch Type | Purpose | Source/Target | Naming Convention |
| --- | --- | --- | --- |
| main | Production-ready, stable code | N/A | main |
| Feature | Develop new features | main | feature/<short-description> |
| Hotfix | Quickly patch critical issues in main | main | hotfix/<issue-number> |

#### 1.2 Workflow

- **Start work:** All new work (features and hotfixes) branches off from `main`.
- **Development:** Work happens on the branch. Team members should regularly pull from `main` to keep their branch up-to-date.
- **Completion:** Once a change is complete and passes local testing, open a PR targeting `main`.
- **Integration and deployment:** After a successful code review, the branch is merged into `main`.

All development work should be done on feature or hotfix branches:

```bash
# Create a feature branch from main
git checkout main
git pull origin main
git checkout -b feature/your-feature-name

# Example branch names:
feature/user-authentication
feature/data-export-api
feature/model-training-improvements
hotfix/1234
```

### 2. Development Setup

```bash
# Clone and setup
git clone <repository-url>
cd feature-template

# Setup conda environment
conda env create -f environment.yml
conda activate feature-template

# Install development dependencies
pip install -e ".[dev,ml]"

# Verify setup
pytest tests/
uvicorn src.main:app --reload
```

### 3. Commit Guidelines

Use conventional commit format:

```bash
# Feature commits
git commit -m "feat: add user authentication endpoint"

# Bug fixes
git commit -m "fix: resolve authentication token validation"

# Documentation
git commit -m "docs: update API documentation for v1.2"

# Refactoring
git commit -m "refactor: simplify model validation logic"

# Refactoring
git commit -m "chore: initial commit"


```

### 4. Pull Request (PR) / Code Review Process

1. **Push your branch** to the repository.
2. **Create a Pull Request** with:
   - Clear title using conventional commit format
   - Detailed description of changes
   - Link to any related issues
3. **Address review feedback.**
4. **Ensure CI/CD passes** before merging.
5. **Squash merge** when approved.

### 5 PR Requirements

A PR is ready for review when:

- The branch is up-to-date with the target branch (`main`).
- All automated tests (if any) have passed.
- The PR includes a clear title and a brief description of the changes (the "what") and the motivation (the "why").
- The PR must link to a relevant issue/ticket if one exists.
- A minimum of one approval is required from another team member.

### 6 Reviewer Responsibilities

- **Timeliness:** Reviewers should aim to review PRs within 24 hours to maintain momentum.
- **Focus:** Reviews should focus on logic, architecture, security, and adherence to established standards.
- **Conflict Resolution:** Discussions should remain constructive and focus on the code and model performance. Major disagreements should be moved to a quick sync-up meeting (e.g., "Quick Review Sync: Calendar event").

### 7. Documentation

- Update README.md for user-facing changes
- Update runbook.md for operational changes
- Add docstrings to new functions
- Update API documentation

#### 7.1 README.md

Every repository must have a comprehensive README.md file. It should include:

- Project Title and Status: Clear identification of the project.
- Quick Start: Minimal steps to clone, set up, and run the project locally.
- Architecture/Design: A high-level overview of the project's structure and key components (Document decisions/the "why").
- Prerequisites/Dependencies: List of necessary software or libraries.
- Deployment: Brief notes on how the code is deployed (e.g., "Deployed via [Deployment Tool]").

#### 7.2 Code Comments

- Focus on documenting complex logic, external contract points (APIs), and non-obvious code.
- Avoid commenting on obvious code (e.g., `// Increment counter`).

### 8. Version Management Strategy

Version management applies to all code, especially device local scripts running on EC2, Jetson, and Raspberry Pi devices.

#### 8.1 Git Tags

We will use Git tags on the `main` branch to mark stable releases.

- Format: `v<MAJOR>.<MINOR>.<PATCH>` (e.g., `v1.2.3`)
- Increment Rules:
  - MAJOR: Incompatible API changes or significant architectural overhaul.
  - MINOR: New functionality or features added in a backward-compatible manner.
  - PATCH: Backward-compatible bug fixes.

#### 8.2 Device Local Scripts

- The device configuration management system will pull code based on the latest Git Tag on `main`.
- A configuration file on each device will log the currently deployed Git Tag/Version.


## Code Standards

### Python Style
- Use type hints
- Write descriptive variable/function names
- Keep functions small and focused

### Testing
- Test both success and error cases
- Use descriptive test names
- Mock external dependencies

## Getting Help

- Check existing issues and documentation
- Create an issue for bugs or feature requests
- Ask questions in pull request comments