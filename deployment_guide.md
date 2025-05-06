Deploying WhatsApp MCP with VeyraX
This guide will walk you through deploying the WhatsApp-MCP tool using VeyraX's platform.
Prerequisites

A GitHub account
Access to the VeyraX deployment platform
Your VeyraX API key

Step 1: Fork or Clone the Repository

Go to https://github.com/lharries/whatsapp-mcp
Fork the repository to your own GitHub account by clicking the "Fork" button in the top right
This will create a copy in your account that you can modify

Step 2: Add the veyrax.yaml Configuration File

In your forked repository, create a new file named veyrax.yaml in the root directory
Copy the contents from the veyrax.yaml file I provided
Commit the changes to your repository

Step 3: Access the VeyraX Deployment UI

Navigate to the deployment section of the VeyraX platform
You'll need to log in with your VeyraX credentials

Step 4: Deploy Your Repository

Insert your GitHub repository URL (e.g., https://github.com/yourusername/whatsapp-mcp)
Click the "Fetch" button to start repository inspection
VeyraX will detect the veyrax.yaml configuration file and use it for deployment

Step 5: Set Environment Variables

After fetching, VeyraX will auto-detect required environment variables
Make sure to configure:

VEYRAX_API_KEY: Your VeyraX API key
Any other environment variables you might need for your specific setup

Step 6: Click Deploy

Once your environment is configured, click the "Deploy" button
The deployment process takes about 2 minutes

Step 7: Monitor Deployment Status

Go to the Development tab to observe the deployment progress
Possible statuses: building, ready, failed

Step 8: Access Your MCP Instance

After deployment completes, the Overview tab will show a link to your running instance
This instance is now live and accessible via all VeyraX-supported methods

Step 9: Connect to Your MCP Instance
Your deployed WhatsApp MCP instance can now be accessed through:

Claude
Cursor IDE
Windserf
VS Code (via CLI integration)
Any other MCP-compatible client

Important Notes

Authentication: When the WhatsApp bridge runs for the first time, you'll need to authenticate by scanning a QR code. The deployment logs will show how to access this.
Re-authentication: After approximately 20 days, you might need to re-authenticate.
Troubleshooting: If you encounter any issues, check the VeyraX deployment logs for details.
Database Persistence: Make sure your deployment is configured to persist the SQLite database to maintain your message history.
Media Handling: FFmpeg is included in the deployment configuration for handling audio messages.

Congratulations! You've successfully deployed the WhatsApp MCP using VeyraX.
