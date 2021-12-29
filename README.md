# Intro
This is a project built from source code since there seem to be old packages in the APT repo.
This project aims to make upgrades easier to keep up with security patching and having consistency.

This project assumes you have Docker and docker-compose installed.

## Configuration
To update the version of the SMB4 - just change the SMBVER argument in the to the version desired.

# TIPs
1. The end result is a container with a minimal requirements for SMB to run. Upgrading between versions may require to add a more dependencies.

