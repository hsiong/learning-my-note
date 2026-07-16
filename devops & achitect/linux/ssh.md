
https://github.com/hsiong/project-init-ubuntu-linux/tree/main/install-linux/ssh.md

# local get remote - local forward to remote

ssh -N -L 18789:127.0.0.1:18789 ubuntu@www.ynfy.tech

# remote get local - connection will be forwarded to port 7890 on your local computer.

ssh -N -R 127.0.0.1:7890:127.0.0.1:7890 ubuntu@www.ynfy.tech