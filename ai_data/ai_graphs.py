import numpy as np
import matplotlib.pyplot as plt

x = (1, 2, 3, 4, 5, 6, 7)
height = (45.8, 50.9, 67.3, 71.1, 77.9, 80.4, 86.9)


plt.bar(x, height)
plt.xticks((1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5), ('No AI', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'))
plt.show()
