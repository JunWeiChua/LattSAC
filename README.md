# LattSAC: Design of Heterogeneous Lattice Structures for Acoustic Applications
![AppSplash](https://github.com/user-attachments/assets/5d964894-d2ee-42d3-821e-54631b1f6596)

## What is LattSAC?
LattSAC is a lattice design and modeling application that designs various lattice sound-absorbing materials by inputting only the necessary geometry parameters. The software then calculates the sound absorption coefficients (SAC) of the lattice sound absorber with insights into the mean performances over selected frequency bands.
![LattSAC_LattProp](https://github.com/user-attachments/assets/f1ef7d16-4e65-425f-97b2-dd1ee7457b92)

## How to use LattSAC?
Using this app requires you to have a basic intuition on how a heterogeneous lattice sound absorber is generated. Below is a schematic:
![image](https://github.com/JunWeiChua/LattSAC/assets/71920481/446bf81a-c796-4297-9d74-0765e4a48f12)
### 1. Lattice Properties
Here, one can change the cross-section, sample length or diameter, and number of distinct layers of the overall lattice. The frequency range of interest may also be specified. The default frequency range in the application was set at 1000 – 6300 Hz, similar to the range obtained from experimental testing. Alternatively, one can load pre-made lattice designs from a library, and amend its geometrical parameters. Additionally, a “Reverse” button reverses the order of the lattice layers in the event a user wants to experiment with the effects of layer permutations on SAC.
### 2. Lattice Layer Properties
Next, one proceeds to change the properties of each lattice layer. He can choose the lattice layer to change using the drop-down menu. For each layer, the number of lattice parts to be arranged in parallel is specified and the table will populate with the data of the individual parts. Initially, the lattice parts were initialized with some default geometrical settings. One may double-click one of the rows of the table to change the part properties. Here, one can change the unit cell, cell size, RD, number of repetitions, and surface ratio. The thickness of the lattice sound absorber will be calculated automatically every time changes to the lattice design are made. There are also provisions for a user to save a lattice design into the library so that he may load it in another session. It is noted that there will be instances where the thicknesses of the lattice parts of a particular lattice layer are not equal, or the surface ratios of the parts do not equate to one. In such cases, the user may click the “Refresh” or “Plot Sound Absorption” buttons in the GUI to re-calculate the thicknesses and number of layers for each lattice layer part to align with the part with the largest thickness value. The surface ratios will also be scaled automatically such that the sum will now be equal to one.
### 3. Lattice SAC Plot and Data
Once the lattice design has been confirmed, one can calculate the SAC. The app plots out the SAC and provides statistics on the sound absorption performance of the designed lattice, such as the mean, standard deviation, and noise reduction coefficient (NRC). The NRC is defined as the average of the SACs at 250, 500, 1000, and 2000 Hz. Mean SACs for various frequency bands were shown which aids in lattice sound absorber design for targeted frequency ranges.
### 4. Export Data
One can export the SAC plot and statistics into a figure file and text file respectively. One can also export the lattice design into an external file for reference. The text file contains information on the lattice sound absorber as finetuned in the application itself, as well as information on the individual layers and parts. The file contains all the necessary information for one to draw the whole lattice in another computer-aided design (CAD) software.

## What Unit Cell Designs are available?
![LattSAC_UnitCells](https://github.com/user-attachments/assets/53aefbea-7db2-4d30-bd1d-805006729cc6)

EDIT: Version 1.1.0 contains a collection of 7 strut lattices, 3 plate lattices and 8 TPMS lattices, allowing for more lattice permutations with a wide range of acoustic properties.

As of Version 1.0.0, only seven strut lattices are available. It is desired to add many different types of lattice unit cells into the cell architecture library, such as plate lattices, plates with micro-perforations, hollow strut lattices, TPMS lattices, and hybrids of the above lattice types.

## Relevant References
- Li, X. et al. 3D-Printed Lattice Structures for Sound Absorption: Current Progress, Mechanisms and Models, Structural-Property Relationships, and Future Outlook. Advanced Science 11, e2305232 (2024). https://doi.org/10.1002/advs.202305232
- Lai, Z., Zhao, M., Lim, C. H. & Chua, J. W. Experimental and numerical studies on the acoustic performance of simple cubic structure lattices fabricated by digital light processing. Materials Science in Additive Manufacturing 1 (2022). https://doi.org/10.18063/msam.v1i4.22
- Chua, J. W., Lai, Z., Li, X. & Zhai, W. LattSAC: A Software for the Acoustic Modelling of Lattice Sound Absorbers. Virtual and Physical Prototyping (2024). https://doi.org/10.1080/17452759.2024.2342432

## Contacts
If there are any suggestions or contributions, the user may write to zhaiweigroup@gmail.com. Alternatively (Until May 2025), you can write in directly to me (Chua Jun Wei) at chua.junwei@u.nus.edu.
