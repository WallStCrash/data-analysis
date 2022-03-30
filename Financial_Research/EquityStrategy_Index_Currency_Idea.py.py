import yfinance as yf
import pandas as pd

from matplotlib import pyplot as plt
from pathlib import Path

loc = Path("C:\\Users\\etc...")

# Trade idea: explore FTSE 100 performance versus GBPUSD pair over 2010s.

# Get Cable data
cable_df = yf.download("GBPUSD=X", start="2010-01-01", end="2019-12-31")

# Get FTSE 100 data
ftse_df = yf.download("^FTSE", start="2010-01-01", end="2019-12-31")

# Plot the two curves in matplotlib
df1 = ftse_df["Close"]
df2 = cable_df["Close"]
               
fig, ax1 = plt.subplots()
color = "tab:red"
ax1.set_xlabel("Date")
ax1.set_ylabel("FTSE 100", color=color)
ax1.plot(df1, color=color)

ax2 = ax1.twinx()
color = "tab:blue"
ax2.set_ylabel("GBPUSD", color=color)
ax2.plot(df2, color=color)

fig.tight_layout()
plt.show()

# Save our dataframes to .csv files so we can read into R later on!
cable_df.to_csv(loc/"cable.csv", sep=",", header="True", index="True")
ftse_df.to_csv(loc/"ftse.csv", sep=",", header="True", index="True")
