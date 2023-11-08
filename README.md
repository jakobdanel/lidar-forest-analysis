# Evaluating Tree Species Diversity in Forest Ecosystems Using LiDAR Data: A Exploration in NRW
Institute for Geoinformatics
```
Spatio-Temporal Modelling Lab
```
### Authors:
- Frederick Bruch: f_bruc03@uni-muenster.de
- Jakob Danel: jdanel@uni-muenster.de

Time frame: Winter Term 2023/2024

### Supervisors
- Dr. Christian Knoth
- Johannes Heisig
- Prof. Dr. Edzer Pebesma


## Topic Description

The combination of tree species is important for the functionality and biodiversity
of a forest [1]. Depending on the particular kind of tree, there are various threats
to both the environment and people. An example therefore is the oak processionary
moth [3] or the bark beetle [2]. Acquiring this knowledge is also necessary to check
a forest’s quality in terms of biodiversity, monocultures, and habitats for specific
species. It is evident that gaining a thorough understanding of forests is crucial,
particularly with regard to the (spatial) distribution of different tree species.
The goal of this project, is to research different parameters of monocultural
forest areas and analyze their potential as a parameter for differentiation between
tree types. Within the four species beech, oak, spruce and pine we want to research
different parameters, such as height, distance between trees or canopy density in
example areas.
The project is dividable into three different topics:

1. Data acquisition: Use data from waldmnoitor.de^1 to identify areas which
    has which are populated by the researched species. This data are generated
    by analyses of Sentinel^2 from 2017 [4]. We will identify such areas for NRW
    automatically if we are provided with the data from the creator of Waldmonitor
    or by hand if we can not get access to this data, following the markings on the
    map.
2. Data Preprocessing: To preprocess the data for their usage, we will down-
    load and retile the datasets, to ensure that the data can easily be handled in
    memory. We want to detect human made artifacts (houses, perches, etc.) and
    remove them from the point cloud. Lastly, we perform a tree detection and a
    segmentation by individual trees.
3. Analyze and differentiation: The following questions we want to answer for each species and analyze the differences between these answers.
    - Are the point patterns of the detected trees randomly distributed, or are
          their clusters/anti-clusters?
    - How are the tree heights distributed?
    - How much distance have a tree to his direct neighbors?
    - How is the intensity of the signals distributed for each tree along the
          z-axis?
    - How are the number of return points distributed within a species?

For solving this problem, we would use R^3 with the package lidR^4. We would sup-
ply R markdown files with the obtained results. We want to ask the owner of
the waldmonitor.de data to gain us access to their data for an exact differentia-
tion between the species areas. As LiDAR data, we want to use data from the
OpenGeodata.NRW^5 portal.
In the end, we want to produce two main results in the project: Firstly, we want
to report and visualize the results of the analysis in a meaningful way, as well as
providing context and limitations for the results. Also, we write an R-Project which

is able to reproduce the analysis within different areas.
- (^1) https://waldmonitor-deutschland.de/ last visited: November 7, 2023
- (^2) https://sentinels.copernicus.eu/web/sentinel/homelast visited: November 7, 2023
- (^3) https://www.r-project.org/last visited: November 7, 2023
- (^4) https://r-lidar.github.io/lidRbook/last visited: November 7, 2023
- (^5) https://www.opengeodata.nrw.de/produkte/geobasis/hm/3dm_l_las/3dm_l_las/ last visited: November 7, 2023


### References

- [1] Akira S. Mori, Kenneth P. Lertzman, and Lena Gustafsson. Biodiversity and ecosystem
services in forest ecosystems: a research agenda for applied forest ecology.Journal of
Applied Ecology, 54(1):12–27, 2017.
- [2] Martin M ̈uller and Nadja Imhof. K ̈aferk ̈ampfe: Borkenk ̈afer und landschaftskonflikte
im nationalpark bayerischer wald. Landschaftskonflikte, pages 313–329, 2019.
- [3] Thomas Sobczyk. Der Eichenprozessionsspinner in Deutschland: Historie, Biologie,
Gefahren, Bekämpfung. Deutschland/Bundesamt f ̈ur Naturschutz, 2014.
- [4] Torsten Welle, Lukas Aschenbrenner, Kevin Kuonath, Stefan Kirmaier, and Jonas
Franke. Mapping dominant tree species of german forests. Remote Sensing, 14(14), 2022.

## Usage

1. `git clone https://github.com/jakobdanel/lidar-forest-analysis` on your local machine
2. Install R (see [R-Project](https://www.r-project.org/))
3. Install the dependencies listed below
4. Run the functions from the root of this project.

## Dependencies
```
GEDIcalibratoR
future
lidR
sf
dplyr
```