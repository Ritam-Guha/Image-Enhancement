# Python code for Image Constrast Stretching using Differential Evolution

Code to perform Image Enhancement

### Paper reference: Güraksin, Gür Emre, Utku Köse, and Ömer Deperlıoğlu. "Underwater image enhancement based on contrast adjustment via differential evolution algorithm." 2016 International Symposium on INnovations in Intelligent SysTems and Applications (INISTA). IEEE, 2016.

## Parameters
popsize: population size for Differential Evolution algorithm
maxiter: maximum number of generations
mutation: mutation rate in DE

## Running the Code
Set the image path properly (Sample images are provided in Data folder)
Adjust and tune the parameters in the code
Interactive python users: load the ICE_DE.ipynb file to a interactive python platform
Non-interactive python users: Run the ICE_DE.py file

## Algorithmic Description
To understand the entire concept of this algorithm, please refer to: [Paper](https://ieeexplore.ieee.org/abstract/document/7571849)

## Abstract
Due to the absorption and scattering of light in underwater environment, underwater images have poor contrast and resolution. This situation generally causes to a color, which became more dominant than the other ones. Because of that, analyzing underwater images effectively and identifying any object under the water has become a difficult task. In this paper, an underwater enhancement approach by using differential evolution algorithm was proposed. In the approach, a contrast enhancement in the RGB space is done. By using the approach, both scattering and absorption effects are reduced.

**Note: Although the referred paper used this process for underwater images, the code is applicable for all sorts of images **
