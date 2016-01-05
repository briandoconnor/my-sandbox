# parse_json.pl

## Purpose

Extracts some stats from the [PCAWG index](http://pancancer.info/json.html).

## Running

    wget http://pancancer.info/gnos_metadata/latest/donor_p_160105020209.jsonl.gz
    gunzip donor_p_160105020209.jsonl.gz
    cat donor_p_160105020209.jsonl | perl parse_json.pl
