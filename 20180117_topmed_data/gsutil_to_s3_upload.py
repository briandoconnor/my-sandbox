from subprocess import call

with open('TOPMed.public_samples.manifest.2017.11.30.txt') as f:
    for line in f:
        tokens = line.split('\t')
        print(line)
        #call (['gsutil', '-u', 'platform-dev-178517', 'cp',  tokens[3], '.'], shell=True)
        print ('gsutil -u platform-dev-178517 cp '+tokens[4].rstrip()+' . ')
        call ('gsutil -u platform-dev-178517 cp '+tokens[4].rstrip()+' . ', shell=True)
        call ('aws s3 cp *.cram* s3://cgp-commons-public/topmed_open_access/', shell=True)
        call ('rm *.cram*', shell=True)
f.closed
