import numpy as np
import matplotlib.pyplot as plt

x = (1, 2, 3, 4, 5, 6, 7)
height = (45.8, 50.9, 67.3, 71.1, 77.9, 80.4, 86.9)

fig, ax = plt.subplots(facecolor='#fdfdfe')
ax.set_facecolor('#eafff5')
barlist=ax.bar(x, height)


barlist[0].set_color('xkcd:crimson')
barlist[1].set_color('xkcd:pine green')
barlist[2].set_color('xkcd:salmon')
barlist[3].set_color('xkcd:orange red')
barlist[4].set_color('xkcd:deep blue')
barlist[5].set_color('xkcd:greenish')
barlist[6].set_color('xkcd:blue violet')

ax.set_xlabel('AI Iteration', fontsize=14)
ax.set_ylabel('AI Wins [%]', fontsize=14)
ax.set_ylim(40, 90)
ax.set_title("AI Iteration Vs. Win Percentage", fontsize=18, fontweight='bold')
plt.xticks((1, 2, 3, 4, 5, 6, 7), ('No AI', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'))
plt.show()
