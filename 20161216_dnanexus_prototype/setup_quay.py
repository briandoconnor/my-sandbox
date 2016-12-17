#!/usr/bin/env python3

import argparse
import subprocess
import requests
import json
import sys
import os
import requests

def main():
    endpoint = "https://quay.io/api/v1/repository"
    host = os.getenv("QUAY_HOST", "https://quay.io")
    token = os.getenv("QUAY_TOKEN", "token")
    headers = {"Authorization": "Bearer {}".format(token)}
    namespace = os.getenv('QUAY_NAMESPACE', "ucsccgl")
    #repositories_response = http_request_factory(host, "GET", endpoint, headers=self.headers, params=params)
    params = {'namespace':namespace}
    r = requests.get(endpoint, headers=headers, params=params)
    print(r.url)
    print (r.text)
    # lets try to register a new one
    data = {
        "namespace": namespace,
        "visibility": "public",
        "repository": "test_repository",
        "description": "this is a test"
    }
    r = requests.post(endpoint, headers=headers, json=data)
    print(r.url)
    print (r.text)

main()
