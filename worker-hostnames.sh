#!/bin/bash
for index in $(seq 0 2); do
    WORKER_HOSTNAME="worker-$index.com-ocp4.sc.ibm.com\n"
    python -c "import base64, json, sys;
ignition = json.load(sys.stdin);
files = ignition['storage'].get('files', []);
files.append({'path': '/etc/hostname', 'mode': 420, 'contents': {'source': 'data:text/plain;charset=utf-8;base64,' + base64.standard_b64encode(b'$WORKER_HOSTNAME').decode().strip(), 'verification': {}}, 'filesystem': 'root'});
ignition['storage']['files'] = files;
json.dump(ignition, sys.stdout)" <worker.ign >"worker-$index-ignition.json"
done
