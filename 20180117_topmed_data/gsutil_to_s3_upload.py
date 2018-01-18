from subprocess import call

with open('TOPMed.public_samples.manifest.2017.11.30.txt') as f:
    for line in f:
        tokens = line.split('\t')
        print(line)

        call (['gsutil', '-u', 'platform-dev-178517', 'cp',  tokens[3], '.'])
        call (['gsutil', '-u', 'platform-dev-178517', 'cp',  tokens[4], '.'])
        call (['aws', 's3', 'cp', '*.cram*',  's3://cgp-commons-public/topmed_open_access'])
f.closed
