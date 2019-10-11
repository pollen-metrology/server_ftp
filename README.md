# server_ftp

# Running the container
docker run -it --net=host -d --name pollenftp  -v /home/docker/pollenftp/data:/home/ -v /home/docker/pollenftp/ftpd.passwd:/etc/proftpd/ftpd.passwd pollenm/server_ftp

# Passive mode note
--net=host - required for passive mode connections.

# Persistent users
to make the users persistent share the passwords file with the host or a data
-v /home/docker/pollenftp/data/ftpd.passwd:/etc/proftpd/ftpd.passwd


# Adding new user
docker exec -it  pollenftp ftpasswd --file=/etc/proftpd/ftpd.passwd --passwd --shell=/bin/false  --name=username --uid=1001 --home=/home/username

#User permissions note
--uid - needs to be set to a user id that has permissions to read and write to the home directory

# Deleting user
docker exec -it pollenftp ftpasswd --passwd --file /etc/proftpd/ftpd.passwd --delete-user --name username

# Example with persistent users
docker run --restart=always --net=host -d --name pollenftp -v /home/docker/pollenftp/data:/home/ -v /home/docker/pollenftp/ftpd.passwd:/etc/proftpd/ftpd.passwd pollenm/server_ftp
