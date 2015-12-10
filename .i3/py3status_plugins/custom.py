# -*- coding: utf-8 -*-
import json
import os
import requests
import yaml
from datetime import datetime

SCRIPT_ROOT = os.path.dirname(os.path.realpath(__file__))
CONFIG = yaml.load(open(SCRIPT_ROOT + "/config.yml", "r"))


def jenkins_build(jobName):
    """Get Jenkins build state"""
    jenkinsUrl = CONFIG['jenkins_url']
    jenkinsStream = requests.get(jenkinsUrl + jobName + "/lastBuild/api/json")
    buildStatusJson = json.loads(jenkinsStream.content.decode("utf-8"))
    color = "#FFFF00"
    names = []
    if "result" in buildStatusJson and buildStatusJson['result']:
        if buildStatusJson['result'] != "SUCCESS":
            names = [c['fullName'].split('.')[0]
                     for c in buildStatusJson['culprits']]
            color = "#FF0000"
        else:
            color = "#00FF00"
    if names and len(names) == 1:
        culprits = ": (" + ", ".join(names) + ")"
    elif names:
        culprits = ": (" + ", ".join(names[0:1]) + ", ...)"
    else:
        culprits = ""
    return {'full_text': buildStatusJson['fullDisplayName'] + culprits,
            'color': color, 'name': "jenkins_%s" % jobName,
            'instance': buildStatusJson['url']}


def audiotel_ca(namedcmd):
    month = datetime.now().strftime("%b")[0:3].capitalize()
    url = CONFIG['mdt_ca_url']
    ca_data = requests.get(url).json()
    k = "today"
    today_str = "Today: %.2f (D:%.2f, O:%.2f, M:%.2f)" % (ca_data["total"][k],
                                                          ca_data["dolead"][k],
                                                          ca_data["optelo"][k],
                                                          ca_data["mixway"][k])
    k = "month"
    month_str = "%s: %.2f (D:%.2f, O:%.2f, M:%.2f)" % (month,
                                                       ca_data["total"][k],
                                                       ca_data["dolead"][k],
                                                       ca_data["optelo"][k],
                                                       ca_data["mixway"][k])
    return {"full_text": today_str + " | " + month_str,
            "name": "audiotel",
            "instance": namedcmd}


def mk_status(namedcmd):
    def bz_status(self, json, i3status_config):
        if namedcmd == "audiotel":
            return audiotel_ca(namedcmd)
        return jenkins_build(namedcmd)
    return bz_status


class Py3status:
    audiotel = mk_status("audiotel")
    jenkins_cf = mk_status("CampaignFactory")
    jenkins_bidding = mk_status("Bidding")
    jenkins_corev3 = mk_status("CoreV3")
    jenkins_statistic = mk_status("IntegrationTests")

    def on_click(self, json, i3status_config, event):
        import os
        url = "%s" % event["instance"]
        os.system("firefox --new-tab '{}'".format(url))
