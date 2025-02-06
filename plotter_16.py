import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# First set of points (order: area, power, delay)
points1 = np.array([
    [2.911636e+03, 8.610000e-05, 2.190000e+00],
    [2.083312e+03, 6.540000e-05, 2.210000e+00],
    [3.135874e+03, 6.460000e-05, 2.230000e+00],
    [2.913232e+03, 8.490000e-05, 2.180000e+00]
])
labels1 = ['16_1', '16_2', '16_3', '16_4']

# Second set of points (order: area, delay, power), rearranged to area, power, delay
points2 = np.array([
    [1701.602, 7.81e-05, 5.78],
    [1650.53, 7.13e-05, 2.52],
    [1701.602, 5.27e-05, 1.99]
])
labels2 = ['wallace_16', 'array_16', 'dadda_16']

# Create 3D Plot
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Plot first dataset
ax.scatter(points1[:, 0], points1[:, 1], points1[:, 2], color='blue', label='NSGA found assym recur-mult')
for i, label in enumerate(labels1):
    ax.text(points1[i, 0], points1[i, 1], points1[i, 2], label, color='blue')

# Plot second dataset
ax.scatter(points2[:, 0], points2[:, 1], points2[:, 2], color='red', label='current state of art', marker='^')
for i, label in enumerate(labels2):
    ax.text(points2[i, 0], points2[i, 1], points2[i, 2], label, color='red')

# Labels and Title
ax.set_xlabel('Area')
ax.set_ylabel('Power')
ax.set_zlabel('Delay')
ax.set_title('3D Plot of  16 bit mult')

# Enable zoom, pan, and rotation
ax.view_init(elev=20, azim=30)
ax.legend()

plt.show()
