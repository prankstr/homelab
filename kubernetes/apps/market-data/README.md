# Market data

Archives delayed trades and quotes from Nasdaq Nordic, Spotlight and NGM every
hour for stock-market research. Data is stored on a persistent Piraeus volume
and backed up through Kasten.

Deployed as a CronJob using the official Python image. The collector script is
stored in the `collector.py` field of the `market-data` item in the `Molntuss`
1Password vault and synced by the 1Password Operator.
