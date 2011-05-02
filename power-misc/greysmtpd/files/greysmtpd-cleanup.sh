#!/bin/sh
exec find /var/greysmtpd/ -type f -mtime +0 -delete 
