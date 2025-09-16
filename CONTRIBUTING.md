# Contributing to the Blender FLIP Fluids Build Environment

Thank you for considering contributing to the Blender FLIP Fluids Build Environment! We appreciate your interest in improving this project. To keep things running smoothly, please follow the guidelines below when contributing.

## How to Contribute

### 1. Fork the Repository

If you'd like to contribute to the project, start by forking this repository to your own GitHub account.

### 2. Clone Your Fork

Clone the forked repository to your local machine:

```bash
git clone https://github.com/soos/flip-fluids.git
cd flip-fluids
```

### 3. Create a New Branch

Create a new branch for your feature or bugfix:

```bash
git checkout -b branchy-the-branch
```

### 4. Make Your Changes

Make your changes, whether it's fixing bugs, improving documentation, or adding new features.

### 5. Commit Your Changes

When committing, please follow these guidelines:

- Write clear, concise commit messages.
- If you want to run your image using github actions, please **start your commit message with `act on `**. This will trigger the build process automatically through GitHub Actions. \(unless you modify the [workflow file](.github/workflows/docker-image.yml) to change this behavior, I guess..\)

Example commit message:

```bash
act on fix build error
```

This ensures that your changes are tested in a continuous integration environment.

### 6. Push Your Changes

Push your changes to your forked repository:

```bash
git push origin branchy-the-branch
```

### 7. Create a Pull Request

Once your changes are pushed, create a pull request to the main repository. Ensure that your pull request is well described and linked to any relevant issues.

## Commit Message Guidelines

For clarity and ease of understanding, follow these simple guidelines for commit messages:

- **Use Present Tense**: Describe your change as if you're currently making it (e.g., "Fix bug with Docker build").
- **Reference Issues**: If your commit addresses a specific issue, reference it in the message.

Example:

```
act on update dependencies for latest MinGW version
```

This will trigger the GitHub Actions build to check that your changes do not break anything and meet the project's standards.

## Reporting Issues

If you encounter any bugs or issues, and you don't know how to fix them with a pull request, please create a new issue in the repository and provide as much detail as possible (steps to reproduce, error messages, etc.).

## Code of Conduct

We ask that all contributors follow the project's Code of Conduct to ensure a positive and respectful environment for everyone. Please treat others with respect and kindness. (my boss told me to add this)
