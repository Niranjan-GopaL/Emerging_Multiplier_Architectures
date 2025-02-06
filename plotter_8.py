import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
# Dataset 3: 8-bit NSGA Found Asymmetric Recursive Multipliers
points3 = np.array([
    [4.75342e+02, 9.31000e-06, 1.30000e+00],
    [3.89424e+02, 8.28000e-06, 2.20000e+00],
    [4.34910e+02, 9.89000e-06, 1.36000e+00],
    [5.48758e+02, 7.94000e-06, 2.10000e+00],
    [3.86232e+02, 8.41000e-06, 2.07000e+00],
    [7.45332e+02, 8.37000e-06, 1.78000e+00],
    [4.32782e+02, 8.83000e-06, 1.57000e+00],
    [5.26148e+02, 9.24000e-06, 1.39000e+00],
    [4.46082e+02, 8.65000e-06, 1.67000e+00]
    # [4.89174e+02, 1.11000e-05, 1.28000e+00],
    # [4.72150e+02, 1.03000e-05, 1.33000e+00],
    # [3.87296e+02, 1.21000e-05, 1.56000e+00],
    # [3.97936e+02, 1.14000e-05, 1.63000e+00],
    # [4.00596e+02, 1.17000e-05, 1.45000e+00],
    # [4.40762e+02, 1.07000e-05, 1.44000e+00],
    # [4.32250e+02, 1.15000e-05, 1.37000e+00],
    # [4.10172e+02, 1.11000e-05, 1.38000e+00],
    # [4.52200e+02, 1.13000e-05, 1.28000e+00]
])
labels3 = [f'8_{i+1}' for i in range(len(points3))]


# Dataset 4: 8-bit Current State-of-the-Art Multipliers
points4 = np.array([
    [357.504, 1.24e-05, 1.74],
    [370.272, 1.24e-05, 5.12],
    [370.272, 1.00e-05, 1.28]
])
labels4 = ['array_8', 'wallace_8', 'dadda_8']

# Create 3D Plot
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection='3d')


# Plot Dataset 3 (8-bit NSGA Found Asym Recur Mult)
ax.scatter(points3[:, 0], points3[:, 1], points3[:, 2], color='green', label='NSGA Found Assym Recur-Mult')
for i, label in enumerate(labels3):
    ax.text(points3[i, 0], points3[i, 1], points3[i, 2], label, color='green')

# Plot Dataset 4 (8-bit State of the Art)
ax.scatter(points4[:, 0], points4[:, 1], points4[:, 2], color='purple', label='8-bit State of Art', marker='s')
for i, label in enumerate(labels4):
    ax.text(points4[i, 0], points4[i, 1], points4[i, 2], label, color='purple')

# Labels and Title
ax.set_xlabel('Area')
ax.set_ylabel('Power')
ax.set_zlabel('Delay')
ax.set_title('3D Plot of Multiplier Designs 8-bit')

# Enable zoom, pan, and rotation
ax.view_init(elev=20, azim=45)
ax.legend()

plt.show()