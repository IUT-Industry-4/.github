# Setting Up Automatic Git Pull and Docker Rebuild

1. First, create a script to handle the automation:

[auto-update.sh](auto-update.sh)

2. Make the script executable:

```sh
chmod +x /mnt/D/projects/myGithub/IUT-Industry-4/auto-update.sh
```

3. Set up a cron job to run the script nightly. Open the crontab editor:

```sh
crontab -e
```

4. Add the following line to run the script at 2 AM every night:

```text
0 2 * * * /mnt/D/projects/myGithub/IUT-Industry-4/auto-update.sh
```

## Additional Setup Steps

1. Ensure Git credentials are properly stored to allow automated pulls:

```sh
git config --global credential.helper store
```

2. Do a manual git pull once to save credentials:

```sh
cd /mnt/D/projects/myGithub/IUT-Industry-4
git pull origin main
```

## Monitoring

- Check the log file for updates:

```sh
tail -f /mnt/D/projects/myGithub/IUT-Industry-4/auto-update.log
```

- Check cron job status:

```sh
systemctl status cron
```

## Testing

To test the setup without waiting for the scheduled time:

```sh
/mnt/D/projects/myGithub/IUT-Industry-4/auto-update.sh
```

The system will now:

- Pull from Git repository at 2 AM daily
- Rebuild and restart Docker containers if there are changes
- Log all actions to the log file

Remember to:

- Keep your Git credentials up to date
- Ensure the machine doesn't go to sleep mode
- Check the logs periodically for any issues
