#!/usr/bin/env python
# -*- coding: utf-8 -*-
import hashlib
import json
import os
import re
import requests
import time
import yaml
from collections import Counter
from datetime import date, datetime
from unidecode import unidecode

SCRIPT_ROOT = os.path.dirname(os.path.realpath(__file__))
CONFIG = yaml.load(open(SCRIPT_ROOT + "/config.yml", "r"))


def get_dolead_audiotel_ca():
    token = CONFIG['dolead_api_token']

    end = int(time.time())
    now = datetime.now()
    first_month_day = datetime(now.year, now.month, 1)
    diff = now - first_month_day
    nb_secs = diff.days * 3600 * 24 + diff.seconds
    start = end - nb_secs
    domain = "http://affiliate.dolead.com"
    uri = "/statistic/get/"
    url_no_hash = "%s%stoken/%s/timestamp_start/%s/timestamp_end/%s" % (domain,
                                                                        uri,
                                                                        token,
                                                                        start,
                                                                        end)
    urlhash = hashlib.md5(url_no_hash.encode('utf-8')).hexdigest()
    url = url_no_hash + "/hash/" + urlhash
    lines = requests.get(url).content

    ca_month = 0
    ca_today = 0
    for l in lines.splitlines()[1:]:
        _, _, dt, _, _, _, ca = unidecode(l.decode('utf-8')).split(';')[:7]
        ca = float(re.sub(r"([1-9.]+).*", r"\1", ca, flags=re.UNICODE))
        ca_month += ca
        if now.strftime("%Y-%m-%d") == dt[:10]:
            ca_today += ca
    return Counter({"today": round(ca_today, 2),
                    "month": round(ca_month, 2)})


def get_mixway_audiotel_ca(month=None, year=None):
    api_key = CONFIG['mixway_api_token']
    api_url = 'http://webvoice.newtech.fr/poolnum/get_cdr'
    uri = '?client=%s&date=%s%s%d&callernum=true&dialstate=true&withtag=true' \
          '&withbill=true'

    if not year:
        year = date.today().year
    else:
        year = int(year)
    if not month:
        month = str(date.today().month).zfill(2)
    else:
        month = str(int(month)).zfill(2)
    today = date.today().day
    nb_call_month = 0
    nb_call_today = 0
    for int_day in range(1, today + 1):
        day = str(int_day).zfill(2)
        r = requests.get((api_url + uri) % (api_key, day, month, year))
        r = r.json()
        for call in r['cdr']:
            if call['billed']:
                nb_call_month += 1
                if int_day == today:
                    nb_call_today += 1

    if nb_call_month > 3000:
        price_by_call = 1.35
    else:
        price_by_call = 1.30

    ca_month = round(price_by_call * nb_call_month, 2)
    ca_today = round(price_by_call * nb_call_today, 2)
    return Counter({"today": ca_today,
                    "month": ca_month})


def get_optelo_audiotel_ca():

    def get_next_line_ca(page, breaker):
        it_is_next = False
        ca = None
        for l in page.splitlines():
            if it_is_next:
                ca = re.sub(r'.*>([0-9,.]+).*',
                            r'\1', l.strip()).replace(',', '.')
                break
            if breaker in l:
                it_is_next = True
        return round(float(ca), 2)

    login = CONFIG['optelo']['login']
    password = CONFIG['optelo']['password']
    login_page = "https://www.optelo.com/boc6/index.php?o=2"
    home_page = "https://www.optelo.com/boc6/index.php?o=100"
    stat_page = "https://www.optelo.com/boc6/index.php?o=90031"
    payload = {"email": login,
               "mdp": password,
               "TYPE": "info",
               "MSG": "",
               "PHPSESSID": ""}
    with requests.Session() as s:
        # Login
        lp = s.get(login_page)
        sessid_line = [l for l in lp.content.splitlines()
                       if '"PHPSESSID"' in l][0]
        sessid = re.sub(r'.*name="PHPSESSID" value="([a-f0-9]+)".*', r'\1',
                        sessid_line)
        payload['PHPSESSID'] = sessid
        s.post(login_page, data=payload)
        home = s.get(home_page).content
        stats = s.get(stat_page).content

    ca_today = get_next_line_ca(home, "Aujourd'hui")
    ca_month = get_next_line_ca(stats, "<td>Total</td>")
    return Counter({"today": ca_today,
                    "month": ca_month})


def audiotel_ca(output_format="json", month=None, year=None):
    if month:
        print("%.2f" % get_mixway_audiotel_ca(month, year)['month'])
        return
    ca = dict()
    tries = 0
    ca['dolead'] = get_dolead_audiotel_ca()
    # Retry 2 times on 0 CA for the month
    while ca["dolead"].get("month", 0) == 0 and tries != 2:
        ca['dolead'] = get_dolead_audiotel_ca()
        tries += 1
    ca['optelo'] = get_optelo_audiotel_ca()
    ca['mixway'] = get_mixway_audiotel_ca()
    ca['total'] = sum(ca.values(), Counter())
    if output_format == "python":
        return ca
    else:
        return json.dumps({k: dict(v) for k, v in ca.items()})


def audiotel_ca_formatted():
    ca_data = audiotel_ca(output_format="python")
    month = datetime.now().strftime("%b")[0:3].capitalize()
    k = "today"
    today_str = "Today: %.2f (D:%.2f, O:%.2f, M:%.2f)" % (ca_data["total"].get(k, 0),
                                                          ca_data["dolead"].get(k, 0),
                                                          ca_data["optelo"].get(k, 0),
                                                          ca_data["mixway"].get(k, 0))
    k = "month"
    month_str = "%s: %.2f (D:%.2f, O:%.2f, M:%.2f)" % (month,
                                                       ca_data["total"].get(k, 0),
                                                       ca_data["dolead"].get(k, 0),
                                                       ca_data["optelo"].get(k, 0),
                                                       ca_data["mixway"].get(k, 0))
    return today_str + " | " + month_str


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--output_format', help='Output format, default is json. Can be "string"')
    parser.add_argument('--month', nargs="?", help='Give the month for which you want to see CA (1-12). Output forced to "string"')
    parser.add_argument('--year', nargs="?", default=datetime.now().year,
                        help='Give the yearfor which you want to see CA (2015-...). Output forced to "string"')
    args = parser.parse_args()
    if args.month:
        audiotel_ca(month=args.month, year=args.year)
    elif args.output_format == "string":
        print(audiotel_ca_formatted())
    else:
        print(audiotel_ca())
