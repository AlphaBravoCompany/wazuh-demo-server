# Wazuh Demo Server

## About Wazuh

Wazuh is a security platform that provides unified XDR and SIEM protection for endpoints and cloud workloads. The solution is composed of a single universal agent and three central components: the Wazuh server, the Wazuh indexer, and the Wazuh dashboard.

Wazuh is free and open source. Its components abide by the GNU General Public License, version 2, and the Apache License, Version 2.0 (ALv2).

- Wazuh Website: https://wazuh.com/
- Docs: https://documentation.wazuh.com/current/index.html
- Git Repo: https://github.com/wazuh
- Wazuh Community Slack: https://join.slack.com/t/wazuh/shared_invite/zt-weqjjmw3-Md50_N3q7PKglVXB3TsgXw

## Learn more about Wazuh

- Wazuh Official YouTube Channel: https://www.youtube.com/c/wazuhsecurity/videos
- FREE SIEM Stack in Seconds! - Deploy a Wazuh SIEM Within Seconds with Docker!: https://www.youtube.com/watch?v=8DuptAc5GdE

## Intended usage of this script

This script is for demo purposes only. It deploys a bare minimum, single-node Docker host and Wazuh stack running as a docker-compose stack.

## Prerequisites

- Ubuntu 20.04+ Server
- Minimum Recommended 8vCPU and 8GB (16GB may be better if you want to monitor a large number of agents workloads) of RAM (Try Hetzner or DigitalOcean)
- DNS or Hosts file entry pointing to server IP

## Installed as part of script

- Docker
- Docker-Compose
- Wazuh 4.3 Docker Stack

## Full Server Setup

1. `git clone https://github.com/AlphaBravoCompany/wazuh-demo-server.git`
2. `cd wazuh-demo-server`
3. `chmod +x install-wazuh.sh`
4. `./install-wazuh.sh subdomain.yourdomain.tld`
5. Install will take approximately 2 minutes and will output links and login information for Wazuh.
6. Details for accessing Wazuh will be printed to the screen once the script completes and saved to `server-details.txt`

## Add Agents

Wazuh Agent Enrollment: https://documentation.wazuh.com/current/user-manual/agent-enrollment/index.html 

Wazuh Agent Management: https://documentation.wazuh.com/current/user-manual/agents/index.html 

1. Login to the Wazuh UI
2. Select the "v" arrow next to the Wazuh logo in the upper left and select "Agents"
3. Select "Deploy New Agents" and define the target system using the following variables:
    - Target Operating System
    - Architecture
    - Wazuh Server Address - The IP or DNS Name (if you created one) of the Wazuh server
    - Agent Group - Out of the box, only the "Default" group exists, but you can add additional groups under the dropdown "Management -> Administration -> Groups"
4. Copy the agent enrollment command and run against the agents you want to join the Wazuh server
5. Copy the agent start command and run against your agents
6. Navigate back to the "Modules Directory" and you should see your agent count reflecting the new agents you joined.

## Enable Additional Scans

To enable additional agent scanning for Rootkits, OSQuery, CIS Benchmarks and others as well as custom agent configs, you need to edit the `/var/ossec/etc/ossec.conf` or `/var/ossec/etc/shared/default/agent.conf` files on the manager. Since this is running in Docker, follow the instructions below to locate and modify these files.

### Manager File
The Wazuh Manager config file is mapped to file `wazuh-demo-server/wazuh-docker/single-node/config/wazuh_cluster/wazuh_manager.conf` in the docker-compose file.

Make the required changes to the file, thens in the `wazuh-demo-server/wazuh-docker/single-node` folder run `docker-compose restart`.

### Agent Files

Agent files in the Docker installation need to be modified inside the container.

Follow the instructions here to `exec` into the container with a bash shell: https://documentation.wazuh.com/current/deployment-options/docker/container-usage.html

Then modify the centralized agent files per the instruction here: https://documentation.wazuh.com/current/user-manual/reference/centralized-configuration.html?highlight=agent.conf

### Recommended manager and agent file changes.

- Enable agent vulnerability scan on all OSes: https://documentation.wazuh.com/current/user-manual/capabilities/vulnerability-detection/running-vu-scan.html?highlight=vulnerability
- Slack Webhook alerting for events above a certain score: https://documentation.wazuh.com/current/proof-of-concept-guide/poc-integrate-slack.html?highlight=slack
- Email alerts: https://documentation.wazuh.com/current/user-manual/manager/manual-email-report/index.html?highlight=email
- Real Time File integrity monitoring with who-data: https://documentation.wazuh.com/current/user-manual/capabilities/file-integrity/fim-configuration.html#configuring-who-data-monitoring 

## Next Steps

Follow some of the Proof-of-Concept guides provided by Wazuh to learn more about the platform capabilities: https://documentation.wazuh.com/current/proof-of-concept-guide/index.html

If you like the platform and want to scale Wazuh better, follow the production installation steps: https://wazuh.com/install/

## Uninstall Methods

1. From within the `wazuh-demo-server/wazuh-docker/single-node/` directory, run `docker-compose down -v` (removes all Wazuh components and volumes).

## About Alphabravo

**AlphaBravo** provides products, services, and training for Cybersecurity, Kubernetes, Cloud, and DevSecOps.

Contact **AB** today to learn how we can help you.

* **Web:** https://alphabravo.io
* **Email:** info@alphabravo.io
* **Phone:** 301-337-8141
