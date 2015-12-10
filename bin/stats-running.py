import sys
from ascii_graph import Pyasciigraph
from collections import OrderedDict
from datetime import date, datetime, timedelta
from tabulate import tabulate


def main(in_file, out_file):
    stats = dict()
    with open(in_file) as fh:
        for l in fh.readlines():
            if not l.strip():
                continue
            date, dist, speed, cal = l.strip().split(";")
            dist = float(dist)
            date = datetime.strptime(date, "%Y-%m-%d")
            stats[date] = dist

    # Date stuff
    now = date.today()
    last_monday_date = now - timedelta(now.isoweekday())
    previous_monday_date = now - timedelta(now.isoweekday() + 7)
    number_of_days = (now - min(stats.keys())).days

    report_data = OrderedDict()
    total_km = sum(stats.values())
    report_data['Total Km'] = total_km
    report_data['This week'] = sum(v for d, v in stats.items()
                                   if d >= last_monday_date)
    report_data['Last week'] = sum(v for d, v in stats.items()
                       if last_monday_date > d >= previous_monday_date)
    report_data['Avg km/day'] = round(total_km / number_of_days, 2)
    report_data['Avg km/week'] = round(report_data['Avg km/day'] * 7, 2)

    graph_data = sorted(([(d.strftime("%Y-%m-%d"), v) for d, v in stats.items()]))
    graph = Pyasciigraph().graph("Progress", graph_data)
    with open(out_file, "w+") as fh:
        fh.write(tabulate([report_data.keys(),
                           (str(i) for i in report_data.values())],
                          tablefmt="fancy_grid").encode("utf-8"))
        fh.write("\n\n")
        for l in graph:
            fh.write(l.encode("utf-8") + "\n")

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
