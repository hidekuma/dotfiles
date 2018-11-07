#!/bin/bash
echo 'export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"' >> ~/.zsh_profile


# if update MacOS to mojave then apple install mysql8. mysql8 have some problems... 
# so.. i wanna use mysql@5.7
# 1) brew install mysql@5.7
# 2) brew install mysql-connector-c
# 3) pip install msysqlcient
