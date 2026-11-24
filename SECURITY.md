# Security

`neotopia-offline.md` tells an AI agent to download files and run commands on your computer. Use a version that you can check.

## Use a released version
1. Use a link with a version number, not the `main` branch. Example:
   `https://raw.githubusercontent.com/neotopia-foundation/offline/v0.1.1/neotopia-offline.md`
2. Each release lists the SHA-256 of the file. Check it before you give the file to your agent:
   - macOS and Linux: `shasum -a 256 neotopia-offline.md`
   - Windows PowerShell: `Get-FileHash neotopia-offline.md`
3. Read what the agent plans to do. The guide tells the agent to show the file list and the total size and to wait for your "yes".

## What the guide does not do
- It sends no data to the foundation. It has no telemetry.
- It contains no binaries. The agent downloads programs from their publishers and checks the publishers' checksums.
- It does not ask for passwords or personal documents.

## Report a problem
Report these privately:
- a dangerous instruction in the guide,
- a link to a changed or unsafe file,
- a sign that someone changed this repository without review.

Open a private security advisory in this repository: Security > Report a vulnerability. Do not post it in a public issue.
