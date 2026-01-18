#!/bin/bash

tmp1=`xinput list | grep SynPS/2\ Synaptics\ TouchPad`
tmp2=${tmp1#*id=}
id=${tmp2::3}
echo $id
