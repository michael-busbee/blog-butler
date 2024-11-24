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

# Main script logic
case "$1" in
    "new")
        create_new_post
        ;;
    "publish")
        publish_changes "$2"
        ;;
    *)
        echo "Usage:"
        echo "  blog.sh new                   - Create a new blog post"
        echo "  blog.sh publish [message]     - Publish changes with optional commit message"
        exit 1
        ;;
esac