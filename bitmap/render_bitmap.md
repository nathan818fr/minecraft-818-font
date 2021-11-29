## Render SVG to bitmap

The ascii.svg file is rendered as a bitmap (png), for each scale.

Currently, the best result I could find requires the use of Adobe Illustrator
(I use version 25).

- Open ascii.svg in Adobe Illustrator
- Go to File > Export > Export for Screens...
- Set the artboard name to `ascii`
- Set PNG Format Settings to:
    - Anti-aliasing: Type Optimized (Hinted)
    - Interlaced: Unchecked
    - Background Color: Transparent
- Set Formats to:
    - *Scale* / *Suffix* / *Format*
    - 0.25x / _x1 / PNG
    - 0.50x / _x2 / PNG
    - 0.75x / _x3 / PNG
    - 1.00x / _x4 / PNG
    - 1.25x / _x5 / PNG
    - 1.50x / _x6 / PNG
    - 1.75x / _x7 / PNG
    - 2.00x / _x8 / PNG
- Then export artboard!

Collect all the exported PNG files and transform them with the following bash
script (requires Imagick):
```bash
mkdir -p ./bitmap
for file in ./ascii_x*.png; do
  convert "$file" -channel A -threshold 60% "./bitmap/$file";
done
```
