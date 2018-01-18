from subprocess import call

with open('TOPMed.public_samples.manifest.2017.11.30.txt') as f:
    for line in f:
        tokens = line.split('\t')
        print(line)
        call (['gsutil', '-u', 'platform-dev-178517', 'cp',  tokens[3], 'gs://cgp-commons-multi-region-public/topmed_open_access/'])
        call (['gsutil', '-u', 'platform-dev-178517', 'cp',  tokens[4], 'gs://cgp-commons-multi-region-public/topmed_open_access/'])
f.closed
