#!/usr/bin/expect -f

spawn security find-generic-password -a anesterov -s acer-server -w
expect -re "(.*)\n"
set password "$expect_out(1,string)"
# Test:
# send_user "password: $password\r\n"
# Actual:
spawn ssh-add $env(HOME)/.ssh/acer
expect "Enter passphrase"
send "$password\n"
expect "Identity added"

spawn ssh-add $env(HOME)/.ssh/id_rsa_git
expect "Enter passphrase"
send "$password\n"
expect "Identity added"

