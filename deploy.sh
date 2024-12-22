#!/bin/bash
# 2024-12-21 Andrw Shade

# Build the Hugo site
hugo

# Navigate to the public directory
echo "Navigating to the public directory..."
cd public || { echo "Error: 'public' directory not found. Make sure the Hugo build generated it."; exit 1; }

# Add changes to git
echo "Adding changes to git..."
git add .
if [ $? -ne 0 ]; then
  echo "Error: Failed to stage changes."
  exit 1
fi

# Commit changes with a timestamp
commit_message="Deploy Hugo site on $(date +'%Y-%m-%d %H:%M:%S')"
echo -e "\nCommitting changes with message:'$commit_message'"


git commit -m "$commit_message"
if [ $? -ne 0 ]; then
  echo "Error: Failed to commit changes. No changes may need committing."
  exit 1
fi

# Push changes to the main branch
echo "Pushing changes to the main branch..."
git push origin main
if [ $? -ne 0 ]; then
  echo "Error: Failed to push changes to the repository. Check your network connection or repository permissions."
  exit 1
fi

# Return to the root project directory
cd ..

# Confirm successful deployment
echo "Deployment successful! Your site should now be live."
