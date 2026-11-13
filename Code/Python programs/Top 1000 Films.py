from bs4 import BeautifulSoup
import requests
import pandas as pd
import re

dfs = []

urls = [
    "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?area=XWW",
    "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?area=XWW&offset=200",
    "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?area=XWW&offset=400",
    "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?area=XWW&offset=600",
    "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?area=XWW&offset=800"
]

session = requests.Session()

for url in urls:

    response = session.get(url)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, "html.parser")

    table = soup.find("table")
    rows = table.find_all("tr")

    headers = [
        th.get_text(strip=True)
        for th in rows[0].find_all("th")
    ]

    data = []

    for row in rows[1:]:

        cols = row.find_all("td")

        if not cols:
            continue

        record = [c.get_text(strip=True) for c in cols]

        link = row.find("a", href=re.compile(r"^/title/"))

        record.append(link["href"] if link else None)

        data.append(record)

    df = pd.DataFrame(
        data,
        columns=headers + ["links"]
    )

    dfs.append(df)

# Combine all pages
all_films = pd.concat(dfs, ignore_index=True)

# Extract IMDb id
all_films["tconst"] = (
    all_films["links"]
        .str.extract(r"/title/(tt\d+)/")
)

# Send to SAS
SAS.df2sd(all_films, "work.allfilms_link")