from bs4 import BeautifulSoup
import pandas as pd
import requests
from typing import Optional

BASE_URL = "https://www.boxofficemojo.com/title/{}/?ref_=bo_se_r_1"

# Reuse session (faster)
session = requests.Session()
session.headers.update({"User-Agent": "Mozilla/5.0"})


def clean_money(value: str) -> int:
    if not value or value.strip() in ["-", "â€“"]:
        return 0
    return int(value.replace("$", "").replace(",", "").strip())


def clean_pct(value: str) -> float:
    if not value or value.strip() in ["-", ""]:
        return 0.0
    return float(value.replace("%", "").strip())


def parse_box_office(tconst: str) -> Optional[dict]:
    url = BASE_URL.format(tconst)

    try:
        response = session.get(url, timeout=10)
        response.raise_for_status()
    except requests.RequestException:
        return None

    soup = BeautifulSoup(response.content, "html.parser")

    summary = soup.find(
        "div",
        class_="a-section a-spacing-none mojo-performance-summary-table"
    )

    if not summary:
        return None

    data = {
        "link": url,
        "US_pct": None,
        "US_Lifetime_Gross": None,
        "Rest_world_pct": None,
        "Rest_world_Lifetime_Gross": None,
        "Worldwide_Lifetime_Gross": None
    }

    # ✅ KEY CHANGE: parse rows instead of splitting text
    rows = summary.find_all("div", recursive=False)

    for row in rows:
        text = row.get_text(" ", strip=True)

        # Domestic
        if "Domestic" in text:
            parts = text.split()
            for p in parts:
                if "$" in p:
                    data["US_Lifetime_Gross"] = clean_money(p)
                if "%" in p:
                    data["US_pct"] = clean_pct(p)

        # International
        elif "International" in text:
            parts = text.split()
            for p in parts:
                if "$" in p:
                    data["Rest_world_Lifetime_Gross"] = clean_money(p)
                if "%" in p:
                    data["Rest_world_pct"] = clean_pct(p)

        # Worldwide
        elif "Worldwide" in text:
            parts = text.split()
            for p in parts:
                if "$" in p:
                    data["Worldwide_Lifetime_Gross"] = clean_money(p)

    return data


def rev_get(df: pd.DataFrame) -> pd.DataFrame:
    results = []

    for row in df.itertuples(index=False):
        scraped = parse_box_office(row.tconst)
        base = row._asdict()

        if scraped:
            results.append({**base, **scraped})
        else:
            results.append({
                **base,
                "link": None,
                "US_pct": None,
                "US_Lifetime_Gross": None,
                "Rest_world_pct": None,
                "Rest_world_Lifetime_Gross": None,
                "Worldwide_Lifetime_Gross": None
            })

    return pd.DataFrame(results)




df_in = SAS.sasdata2dataframe('WORK.BEST_NOT_BO')
df_out = rev_get(df_in)
SAS.df2sd(df_out, "work.Best_Film");
