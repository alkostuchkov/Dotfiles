#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess

output = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8").rstrip().split("\n")
print(len(output))

