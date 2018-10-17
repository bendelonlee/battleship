import numpy as np
import matplotlib.pyplot as plt

fig, ax = plt.subplots()

y1 = (1, 1, 1, 4, 3, 1, 4, 5, 2, 4, 4, 9, 7, 4, 9, 5, 11, 5, 8, 8, 11, 6, 14, 11, 8, 10, 20, 16, 21, 12, 21, 19, 24, 19, 21, 29, 22, 19, 29, 28, 32,
 38, 24, 25, 23, 30, 35, 28, 30, 29, 23, 29, 34, 29, 27, 26, 25, 20, 18, 13, 5, 1)

x1 = (38, 39, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100)

y2 = (1, 2, 1, 2, 1, 1, 1, 6, 4, 5, 1, 4, 7, 5, 4, 3, 5, 7, 14, 5, 4, 8, 12, 9, 10, 13, 10, 12, 13, 19, 17, 12, 15, 23, 16, 18, 19, 25, 19, 21, 33,
 37, 26, 22, 26, 37, 30, 40, 37, 31, 33, 36, 49, 39, 38, 40, 31, 19, 17, 5)

x2 = (37, 39, 40, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76,
 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100)

x3 = (51, 54, 55, 56, 57, 58, 59, 60, 61, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
 92, 93, 94, 95, 96, 97, 98, 99, 100)

y3 = (1, 1, 1, 3, 2, 1, 3, 2, 2, 3, 2, 7, 6, 5, 3, 7, 9, 5, 8, 13, 12, 13, 18, 21, 25, 28, 27, 36, 35, 26, 39, 43, 36, 43, 42, 61, 64, 58, 61, 60,
56, 45, 39, 21, 7)

x4 = (66, 67, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100)

y4 = (1, 1, 1, 1, 3, 1, 1, 2, 2, 5, 3, 12, 4, 7, 16, 23, 13, 21, 34, 31, 40, 35, 56, 45, 65, 71, 67, 96, 92, 79, 76, 72, 24)


N = 5
cumsum4, moving_aves4 = [0], []
cumsum3, moving_aves3 = [0], []
cumsum2, moving_aves2 = [0], []
cumsum1, moving_aves1 = [0], []

# finding moving average - borrowed code from the internet. Not 100% sure
# exactly what is going on here, but it works

for i, x in enumerate(y4, 1):
    cumsum4.append(cumsum4[i-1] + x)
    if i>=N:
        moving_ave4 = (cumsum4[i] - cumsum4[i-N])/N
        #can do stuff with moving_ave here
        moving_aves4.append(moving_ave4)

for i, x in enumerate(y3, 1):
    cumsum3.append(cumsum3[i-1] + x)
    if i>=N:
        moving_ave3 = (cumsum3[i] - cumsum3[i-N])/N
        #can do stuff with moving_ave here
        moving_aves3.append(moving_ave3)

for i, x in enumerate(y2, 1):
    cumsum2.append(cumsum2[i-1] + x)
    if i>=N:
        moving_ave2 = (cumsum2[i] - cumsum2[i-N])/N
        #can do stuff with moving_ave here
        moving_aves2.append(moving_ave2)

for i, x in enumerate(y1, 1):
    cumsum1.append(cumsum1[i-1] + x)
    if i>=N:
        moving_ave1 = (cumsum1[i] - cumsum1[i-N])/N
        #can do stuff with moving_ave here
        moving_aves1.append(moving_ave1)




ax.plot(x4[2:(len(x4) - N + 3)], moving_aves4, c="g")
ax.plot(x3[2:(len(x3) - N + 3)], moving_aves3, c="r")
ax.plot(x2[2:(len(x2) - N + 3)], moving_aves2, c="b")
ax.plot(x1[2:(len(x1) - N + 3)], moving_aves1, c="orange")

ax.plot(x4, y4, linestyle="None", c="g", alpha=0.1, marker='o')
ax.plot(x2, y2, linestyle="None", c="r", alpha=0.1, marker='v')
ax.plot(x3, y3, linestyle="None", c="b", alpha=0.1, marker='^')
ax.plot(x4, y4, linestyle="None", c="orange", alpha=0.1, marker='>')

ax.legend(['No AI', 'AI V2', 'AI V4', 'AI V6'])

ax.set_xlabel('Shots Required to Win', fontsize=14)
ax.set_ylabel('Number of Games', fontsize=14)
ax.set_title('Number of Games vs. Shots Required to Win', fontsize=14, fontweight='bold')

# ax.text(50, 60, 'Hello World', fontsize=12)

plt.show()
