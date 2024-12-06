import glob
import logging
import os
import subprocess
import cairosvg
import gdstk

# Configure logging
logging.basicConfig(level=logging.INFO)

# Input/output paths
GDS_DIR = "./gds"
OUTPUT_SVG = "gds_render_preview.svg"
OUTPUT_PNG = "gds_render_preview.png"
FINAL_PNG = "gds_render.png"

# Layers to filter out (e.g., text labels)
SKY130_LABEL_LAYERS = [
    (64, 59),  # pwell.label
    (64, 5),   # nwell.label
    (67, 5),   # li1.label
    (68, 5),   # met1.label
    (69, 5),   # met2.label
    (70, 5),   # met3.label
    (71, 5),   # met4.label
]

def get_final_gds_top_cells():
    """
    Reads the first GDS file in the directory and returns the top-level cell.
    """
    try:
        gds_files = glob.glob(os.path.join(GDS_DIR, "*.gds"))
        if not gds_files:
            raise FileNotFoundError("No GDS files found in the directory.")
        
        gds_file = gds_files[0]
        logging.info(f"Found GDS file: {gds_file}")
        
        library = gdstk.read_gds(gds_file)
        top_cells = library.top_level()
        if not top_cells:
            raise ValueError("No top-level cells found in the GDS file.")
        
        return top_cells[0]
    except Exception as e:
        logging.error(f"Error while processing the GDS file: {e}")
        raise

def create_svg_and_png():
    """
    Generates an SVG and PNG file from the GDS layout.
    """
    try:
        top_cell = get_final_gds_top_cells()
        
        # Filter out specific layers (e.g., text labels)
        top_cell.filter(SKY130_LABEL_LAYERS)
        
        # Render SVG
        logging.info(f"Rendering SVG: {OUTPUT_SVG}")
        top_cell.write_svg(OUTPUT_SVG, pad=0)
        
        # Convert SVG to PNG
        convert_svg_to_png(OUTPUT_SVG, OUTPUT_PNG)
        
        # Compress PNG
        compress_png(OUTPUT_PNG, FINAL_PNG)
        logging.info(f"Final PNG generated: {FINAL_PNG}")
    except Exception as e:
        logging.error(f"Error during SVG/PNG generation: {e}")
        raise

def convert_svg_to_png(svg_file, png_file):
    """
    Converts an SVG file to PNG using rsvg-convert or cairosvg as a fallback.
    """
    try:
        cmd = f"rsvg-convert --unlimited {svg_file} -o {png_file} --no-keep-image-data"
        result = subprocess.run(cmd, shell=True, capture_output=True)
        
        if result.returncode == 127:
            logging.warning("rsvg-convert not found. Falling back to cairosvg.")
            cairosvg.svg2png(url=svg_file, write_to=png_file)
        elif result.returncode != 0:
            raise RuntimeError(result.stderr.decode())
    except Exception as e:
        logging.warning(f"Failed to convert SVG to PNG: {e}. Falling back to cairosvg.")
        cairosvg.svg2png(url=svg_file, write_to=png_file)

def compress_png(input_png, output_png):
    """
    Compresses a PNG file using pngquant. If pngquant is unavailable, 
    uses the intermediate uncompressed PNG file.
    """
    try:
        quality = "0-30"
        cmd = f"pngquant --quality {quality} --speed 1 --nofs --strip --force --output {output_png} {input_png}"
        result = subprocess.run(cmd, shell=True, capture_output=True)
        
        if result.returncode != 0:
            raise RuntimeError(result.stderr.decode())
    except Exception as e:
        logging.warning(f"Failed to compress PNG: {e}. Using intermediate file.")
        os.rename(input_png, output_png)

if __name__ == "__main__":
    create_svg_and_png()
