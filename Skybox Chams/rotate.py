from PIL import Image
import os

def main():
    transform_values = {
        "ft": [1, 90],
        "bk": [2, -90],
        "lf": [3, 180],
        "rt": [4, 0  ],
        "up": [5, 0  ],
        "dn": [6, 180]
    }

    dir = input()

    for file in os.listdir(dir):
        if file[-4:] == ".png":
            face = file[-6: -4]
            full_path = os.path.join(dir, file)

            image = Image.open(full_path)
            rotated = image.rotate(transform_values[face][1])
            rotated.save(os.path.join(dir, f"{transform_values[face][0]}.png"))

    print("Done")


if __name__ == "__main__":
    main()