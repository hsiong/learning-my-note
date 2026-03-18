#!/usr/bin/env python3
import sys
import requests
from collections import defaultdict

USER = sys.argv[1] if len(sys.argv) > 1 else "hsiong"
TOKEN = sys.argv[2] if len(sys.argv) > 2 else None # todo

if not TOKEN:
    raise RuntimeError("GitHub Personal Access Token is required. ")

session = requests.Session()
headers = {
    "Accept": "application/vnd.github+json",
    "User-Agent": "github-lang-breakdown-script",
}
if TOKEN:
    headers["Authorization"] = f"Bearer {TOKEN}"
session.headers.update(headers)


def get_all_repos(user: str):
    repos = []
    page = 1
    while True:
        url = f"https://api.github.com/users/{user}/repos"
        params = {
            "per_page": 100,
            "page": page,
            "type": "owner",
            "sort": "full_name",
        }
        r = session.get(url, params=params, timeout=30)
        r.raise_for_status()
        data = r.json()
        if not data:
            break
        repos.extend(data)
        page += 1
    return repos


def get_repo_languages(owner: str, repo: str):
    url = f"https://api.github.com/repos/{owner}/{repo}/languages"
    r = session.get(url, timeout=30)
    r.raise_for_status()
    return r.json()


def main():
    repos = get_all_repos(USER)
    if not repos:
        print(f"No repos found for user: {USER}")
        return

    lang_to_repo_bytes = defaultdict(list)
    repo_to_lang_bytes = {}

    for repo in repos:
        repo_name = repo["name"]
        full_name = repo["full_name"]
        try:
            langs = get_repo_languages(USER, repo_name)
        except requests.HTTPError as e:
            print(f"[WARN] Failed to fetch languages for {full_name}: {e}", file=sys.stderr)
            continue

        if not langs:
            continue

        repo_to_lang_bytes[full_name] = langs
        for lang, byte_count in langs.items():
            lang_to_repo_bytes[lang].append((full_name, byte_count))

    # 按语言总字节数排序
    lang_totals = []
    for lang, items in lang_to_repo_bytes.items():
        total = sum(b for _, b in items)
        lang_totals.append((lang, total))
    lang_totals.sort(key=lambda x: x[1], reverse=True)

    print(f"User: {USER}")
    print("=" * 80)
    print("Language -> Repos -> Bytes")
    print("=" * 80)

    for lang, total in lang_totals:
        print(f"\n{lang} (total {total:,} bytes)")
        repos_sorted = sorted(lang_to_repo_bytes[lang], key=lambda x: x[1], reverse=True)
        for full_name, byte_count in repos_sorted:
            print(f"  - {full_name}: {byte_count:,}")

    print("\n" + "=" * 80)
    print("Repo -> Languages -> Bytes")
    print("=" * 80)

    for full_name in sorted(repo_to_lang_bytes):
        print(f"\n{full_name}")
        langs_sorted = sorted(repo_to_lang_bytes[full_name].items(), key=lambda x: x[1], reverse=True)
        for lang, byte_count in langs_sorted:
            print(f"  - {lang}: {byte_count:,}")


if __name__ == "__main__":
    main()