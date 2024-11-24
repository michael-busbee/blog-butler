#!/bin/bash

# Function to convert string to kebab case (lowercase with hyphens)
to_kebab_case() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-zA-Z0-9-]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//'
}

# Function to create new blog post
create_new_post() {
    # Get current date
    current_date=$(date +"%Y-%m-%d")
    
    # Get blog title from user
    echo "Enter blog post title:"
    read post_title
    
    # Convert title to kebab case
    kebab_title=$(to_kebab_case "$post_title")
    
    # Create filenames with date
    post_filename="${current_date}-${kebab_title}.md"
    image_dirname="${current_date}-${kebab_title}"
    
    # Create directories and files
    mkdir -p "_posts"
    mkdir -p "assets/img/posts/${image_dirname}"
    
    # Create blog post with front matter
    cat > "_posts/${post_filename}" << EOF
---
layout: post
title: "${post_title}"
date: ${current_date}
categories: 
description: 
---

EOF
    
    echo "Created blog post: _posts/${post_filename}"
    echo "Created image directory: assets/img/posts/${image_dirname}"
}

# Function to publish changes
publish_changes() {
    # Check if commit message was provided as argument
    if [ -z "$1" ]; then
        echo "Enter commit message:"
        read commit_message
    else
        commit_message="$1"
    fi
    
    # Check if commit message is empty
    if [ -z "$commit_message" ]; then
        echo "Error: Commit message cannot be empty"
        exit 1
    fi
    
    # Run git commands
    git add .
    git commit -m "$commit_message"
    git push origin main
    
    echo "Changes published successfully!"
}

# Function to print help message
print_help() {
    echo "Usage:"
    echo "  blog new                    - Create a new blog post"
    echo "  blog publish [message]      - Publish changes with optional commit message"
    echo "  blog help                   - Display this help message"
    echo "  blog upgrade                - Upgrade this script from it's github script"
    exit 1
}

# Function to upgrade blog script from github source
upgrade() {
    curl "https://raw.githubusercontent.com/michael-busbee/blog-butler/refs/heads/main/blog.sh" > ~/bin/blog
    chmod +x ~/bin/blog
}

# Main script logic
case "$1" in
    "new")
        create_new_post
        ;;
    "publish")
        publish_changes "$2"
        ;;
    "help")
        print_help
        ;;
    "upgrade")
        upgrade
        ;;
    *)
        print_help
        ;;
esac