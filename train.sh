#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo 'Usage: ./train.sh /path/to/training_ssf_file $name_of_model'
    exit
fi
INPUT_FILE_SSF=$1
MODEL_NAME=$2
TRAINING_FILE="./run/training.in_$RANDOM"
cat $INPUT_FILE_SSF | perl ./utils/ssf2bio.pl | awk '{print $1, $2, $NF}'> $TRAINING_FILE
crf_learn template $TRAINING_FILE ${MODEL_NAME}.model
rm -f $TRAINING_FILE
