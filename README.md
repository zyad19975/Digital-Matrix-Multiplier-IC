# Digital Matrix-Multiplier IC


1. Grab a copy of this repository to your computer's local folder (i.e. C:\projects):

    ```sh
    $ cd projects
    $ git clone https://github.com/zyad19975/Matrix-Multiplier
    ```
2. Use Visual Studio Code (VSC) to edit and view the design files:

    ```sh
    $ cd projects
    $ code .
    ```
    Click on the Top level.vhd file in the left pane to view its contents.
    
3. From the VSC View menu, choose Terminal, in the VCS Terminal, create a "work" library:

    ```sh
    $ vlib work
    ```
    
4. Compile any of the design units, For example, to compile the binary counter design and its testbench:

    ```sh
    $ vcom adder_4bit.vhd
    $ vcom adder_8bit.vhd
    $ vcom dadda_multi.vhd
    $ vcom dadda_utils.vhd
    $ vcom dff_4bit.vhd
    $ vcom dff_8bit.vhd
    $ vcom ramA.vhd
    $ vcom ramB.vhd
    $ vcom ramc.vhd
    $ vcom subtractor.vhd
    $ vcom Tlc.vhd
    $ vcom Top level.vhd
    $ vcom Top_level_tb.vhd
    ```
    
5. Simulate your design. For example, to simulate the binary counter testbench:

    ```sh
    $ vsim work.top_level_tb
    ```
    
6. Synthesis your design. For example, to synthesis the binary counter, first create a working folder for the Quartus Prime Tool:

    ```sh
    $ mkdir quartus/top_level
    ```

7.  Run the Quartus&reg; Prime Tool to synthesis the binary counter design, then:
    - From the Menu, choose File -> New Project Wizard
    - Click: Next
    - For the working directory, fill with: "path to your projects folder"/projects/quartus/top_level
    - For the project name, fill with: top_level
    - Click: Next
    - Click: Next
    - In the File name field, browse and select all the .vhd files except top_level_tp.vhd
    - Click: Add
    - Click: Next
    - From Device family, choose: Cyclone IV E
    - From Available devices, choose: EP4CE22F17C6
    - Click: Next
    - From Simulation, choose Tool Name: ModelSim-Intel and Format: VHDL
    - Click: Next
    - Click: Finish
    - From the Menu, choose Processing -> Start Compilation
    - Wait until compilation completes

8. Run timing simulation for your design. For example, to simulate the binary counter testbench after synthesizing the binary counter component:

    ```sh
    $ vcom ./quartus/top_level/simulation/modelsim/top_level.vho
    $ vsim work.top_level_tb -sdftyp /dut=./quartus/top_level/simulation/modelsim/top_level_vhd.sdo
    ```
