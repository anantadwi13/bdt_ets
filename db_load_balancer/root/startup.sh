#!/bin/bash

# Copying haproxy configuration
cp /root/haproxy.cfg /etc/haproxy/haproxy.cfg

service haproxy restart
