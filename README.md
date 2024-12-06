# OpenLane_in_Actions
## What does it do?
This repository runs the complete [RTL2GDSII OpenLane](https://github.com/efabless/openlane) flow via Github Actions and generates a GLTF render of the 
final gds by using a [GDS2GLTF](https://github.com/mbalestrini/GDS2glTF) which can be seen in a [GLTF Viewer](https://github.com/mbalestrini/tinytapeout_gds_viewer) hosted in Github.
## How can I use it?
### Set Up Github
First of all fork or clone this repository and then enable both [Github Actions](./../../actions) and [Github Pages](./../.../settings/pages) by setting the values of **"Source"** to **"Github Actions"**. 
This lets us set up a "Workflow" which will run the necessary commands to install OpenLane and its flow without needing to be in a Linux machine.
### Set Up The Files
The files that will alter the results are inside the **"my_project"** folder. Here you will need to add your own Verilog Files to the **verilog** folder. Then you want to change the **"config.json"** to refer to your
files, and also (if desired) change the flow options. For more information refer to the [OpenLane Variables.](https://openlane.readthedocs.io/en/latest/reference/configuration.html). I recommend
to not change the my_project folder name as this will require to change the workflow file.
### Run the Flow
After your files are good to use, go once again to [Github Actions](./../../actions), and click on the **"openlane"** option on the left. Then on the top right you will see a **"run workflow"**
option, which will start to first install OpenLane on the "virtual machine" and then run its own test. This creates a cache file, meaning the first run will take way longer than the next ones.
Then the flow starts to run, and after it finishes, you will be able to download the results and logs of the run, as well as the direct gds file.
If you wish to see a 3D Model of your final gds, you can go to the **"gdsviewer"** option. Then running this workflow will generate a page, a png and a gltf file with which you can see your results.

# About the Sample Project

## Project Description:

Implementation of a digital flow using OpenLane for a **Single Cycle RISC-V** processor with support for basic operations such as add, addi, jal, lui, etc. Additionally, the design includes three peripherals: a switch/button, an LED, and an on/off IR sensor.

The schematic used for this project is depicted in the following image, adapted from the book [*'Digital Design and Computer Architecture RISC-V Edition'*](https://pages.hmc.edu/harris/ddca/ddcarv.html) by Harris & Harris.

![DatapathPeriferico.png](Media/DatapathPeriferico.png)

The latter design was created by [Nicolás Orcasitas](https://github.com/NicolasOrcasitas) and [Jorge Angarita](https://github.com/Gior-gio) for the subject '**Computer Architecture**' during the 2023-I semester at **UIS**.

## Final Result in KLayout:

This was generated using a series of .yaml files adapted from the [**Tiny Tapeout 5**](https://github.com/TinyTapeout/tt05-submission-template) and [**10 editions**](https://github.com/TinyTapeout/tt10-verilog-template) repositories by Uri Shaked, Matt Venn, and others. 

![GDS_Klayout](Media/GDS_Klayout.png)
