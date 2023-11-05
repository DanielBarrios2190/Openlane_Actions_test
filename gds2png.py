#!/usr/bin/env python3
import csv
import glob
import json
import logging
import os
import re
import shutil
import subprocess
import typing
import argparse
import logging
import sys
import cairosvg  # type: ignore
import gdstk  # type: ignore
import yaml
#from git.repo import Repo
#import git_utils
#from cells import Cell, load_cells
#from markdown_utils import limit_markdown_headings
CELL_URL = "https://skywater-pdk.readthedocs.io/en/main/contents/libraries/sky130_fd_sc_hd/cells/"
#with open(os.path.join(os.path.dirname(__file__), "tile_sizes.yaml"), "r") as stream:
#    tile_sizes = yaml.safe_load(stream)

# Read and return top-level GDS data from the final GDS file, using gdstk:
def get_final_gds_top_cells():
    gds = glob.glob(
        os.path.join("./gds/*.gds")
    )
    print(gds[0])
    library = gdstk.read_gds(gds[0])
    top_cells = library.top_level()
    return top_cells[0]
# SVG render of the GDS.
# NOTE: This includes all standard GDS layers inc. text labels.
def create_svg():
    top_cells = self.get_final_gds_top_cells()
    op_cells.write_svg("gds_render.svg")
    # Try various QUICK methods to create a more-compressed PNG render of the GDS,
    # and fall back to cairosvg if it doesn't work. This is designed for speed,
    # and in particular for use by the GitHub Actions.
    # For more info, see:
    # https://github.com/TinyTapeout/tt-gds-action/issues/8
logging.info("Loading GDS data...")
top_cells = get_final_gds_top_cells()
# Remove label layers (i.e. delete text), then generate SVG:
sky130_label_layers = [
    (64, 59),  # 64/59 - pwell.label
    (64, 5),  # 64/5  - nwell.label
    (67, 5),  # 67/5  - li1.label
    (68, 5),  # 68/5  - met1.label
    (69, 5),  # 69/5  - met2.label
    (70, 5),  # 70/5  - met3.label
    (71, 5),  # 71/5  - met4.label
]
top_cells.filter(sky130_label_layers)
svg = "gds_render_preview.svg"
logging.info("Rendering SVG without text label layers: {}".format(svg))
top_cells.write_svg(svg, pad=0)
    # We should now have gds_render_preview.svg
    # Try converting using 'rsvg-convert' command-line utility.
    # This should create gds_render_preview.png
png = "gds_render_preview.png"
logging.info("Converting to PNG using rsvg-convert: {}".format(png))
cmd = "rsvg-convert --unlimited {} -o {} --no-keep-image-data".format(svg, png)
logging.debug(cmd)
p = subprocess.run(cmd, shell=True, capture_output=True)
if p.returncode == 127:
    logging.warning(
        'rsvg-convert not found; is package "librsvg2-bin" installed? Falling back to cairosvg. This might take a while...'
    )
        # Fall back to cairosvg:
    cairosvg.svg2png(url=svg, write_to=png)
elif p.returncode != 0 and b"cannot load more than" in p.stderr:
    logging.warning(
        'Too many SVG elements ("{}"). Reducing complexity...'.format(
            p.stderr.decode().strip()
        )
    )
        # Remove more layers that are hardly visible anyway:
sky130_buried_layers = [
    (64, 16),  # 64/16 - nwell.pin
    (65, 44),  # 65/44 - tap.drawing
    (68, 16),  # 68/16 - met1.pin
    (68, 44),  # 68/44 - via.drawing
    (81, 4),  # 81/4  - areaid.standardc
    (70, 20),  # 70/20 - met3.drawing
        # Important:
        # (68,20), # 68/20 - met1.drawing
        # Less important, but keep for now:
        # (69,20), # 69/20 - met2.drawing
]
top_cells.filter(sky130_buried_layers)
svg_alt = "gds_render_preview_alt.svg"
logging.info("Rendering SVG with more layers removed: {}".format(svg_alt))
top_cells.write_svg(svg_alt, pad=0)
logging.info("Converting to PNG using rsvg-convert: {}".format(png))
cmd = "rsvg-convert --unlimited {} -o {} --no-keep-image-data".format(
    svg_alt, png
)
logging.debug(cmd)
p = subprocess.run(cmd, shell=True, capture_output=True)
if p.returncode != 0:
    logging.warning(
        'Still cannot convert to SVG ("{}"). Falling back to cairosvg. This might take a while...'.format(
            p.stderr.decode().strip()
        )
    )
# Fall back to cairosvg, and since we're doing that, might as well use the original full-detail SVG anyway:
cairosvg.svg2png(url=svg, write_to=png)
# By now we should have gds_render_preview.png
# Compress with pngquant:
final_png = "gds_render.png"
quality = "0-30"
logging.info("Compressing PNG further with pngquant to: {}".format(final_png))
cmd = "pngquant --quality {} --speed 1 --nofs --strip --force --output {} {}".format(
    quality, final_png, png
)
logging.debug(cmd)
p = subprocess.run(cmd, shell=True, capture_output=True)
if p.returncode == 127:
    logging.warning(
        'pngquant not found; is package "pngquant" installed? Using intermediate (uncompressed) PNG file'
    )
    os.rename(png, final_png)
elif p.returncode != 0:
    logging.warning(
        'pngquant error {} ("{}"). Using intermediate (uncompressed) PNG file'.format(
            p.returncode, p.stderr.decode().strip()
        )
    )
    os.rename(png, final_png)
logging.info(
    "Final PNG is {} ({:,} bytes)".format(final_png, os.path.getsize(final_png))
)