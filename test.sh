#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./test.sh /path/to/testing_ssf_file /path/to/trained_model"
    exit
fi
INPUT_FILE_SSF=$1
TRAINED_MODEL=$2
TESTING_FILE="./run/testing.in_$RANDOM"
GOLD_PREDICT_FILE="./run/gold_predict_$RANDOM"
# TESTING_FILE will have the GOLD tag as it's last column, but it won't be taken up as a feature.
cat $INPUT_FILE_SSF | perl ./utils/ssf2bio.pl | awk '{print $1, $2, $NF}' > $TESTING_FILE
crf_test -m $TRAINED_MODEL $TESTING_FILE | awk '{if (NF > 0) printf "%s\t%s\n", $(NF-1), $NF}' > $GOLD_PREDICT_FILE
./utils/evaluate.py $GOLD_PREDICT_FILE
rm -f $TESTING_FILE
rm -f $GOLD_PREDICT_FILE
