# Blog Script Setup

This repository contains a simple utility to make the `blog.sh` script globally accessible as the `blog` command.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/blog-script.git
   ```

2. Navigate to the repository directory:
   ```bash
   cd blog-script
   ```

3. Run the setup script:
   ```bash
   chmod +x setup-blog.sh
   ./setup-blog.sh
   ```

4. Activate the changes by either:
   - Restarting your terminal
   - OR running: `source ~/.bashrc`

## What does this do?

The setup script will:
- Create a `~/bin` directory if it doesn't exist
- Create a symbolic link to make `blog.sh` accessible as just `blog`
- Add `~/bin` to your PATH (if not already there)
- Make the necessary files executable

## Usage

After installation, you can run the blog script from anywhere by simply typing:
```bash
blog
```

## Requirements

- Unix-like operating system (Linux, macOS)
- Bash shell
- Git (for cloning the repository)

## Troubleshooting

If you see "command not found" after installation:
1. Make sure you've either restarted your terminal or run `source ~/.bashrc`
2. Verify that `~/bin` is in your PATH by running: `echo $PATH`
3. Check that the symbolic link was created: `ls -l ~/bin/blog`