# Automated-Lettuce-Grading-and-Sorting-in-Postharvest-Manufacturing-Setup

This project presents an **automated quality grading system** for iceberg lettuce (*Lactuca sativa var. capitata*), integrating **Genetic Programming (GP)** for parameter estimation and **Fuzzy Logic (FL)** for quality classification.  
The system addresses inefficiencies in manual grading, ensuring **objective, consistent, and non-destructive** quality assessment in line with **hilippine National Standard for Head Lettuce (PNS/BAFPS 19:2005)**

---

# MATLAB Toolbox Requirements

This project integrates **Genetic Programming (GP)** with **Fuzzy Logic (FL)** and hardware control for automated lettuce grading.  
To run the code successfully, the following MATLAB toolboxes and support packages are required:

## ✅ Required Toolbox
- **GPTIPS Toolbox**  
- **Fuzzy Logic Toolbox**  
- **Image Acquisition Toolbox**  
- **Image Processing Toolbox**  
- **Spreadsheet Toolbox / MATLAB Excel Integration**
  
## ✅ Required Support Packages
- **MATLAB Support Package for USB Webcams** 
- **MATLAB Support Package for Arduino Hardware**  

### 🔧 Installation Notes
- Ensure all support packages are installed via **MATLAB Add-On Explorer** (`matlab.addons.install`).

 
---
  
## 📌 Citation and Request

If you find this work useful, kindly cite us. Thanks.
We did not provide the raw images and lab testing in this repository due to privacy reasons but final models are given. Raw data and image is available upon request.  

---

## Directory
```bash
📂 Project Root
├── 📂 fuzzy_modelling # Fuzzy inference system (built in Fuzzy Designer)
│   └── Fuzzy_Finale.fis
│
├── 📂 genetic_models # GP models + reports
│ ├── chla.m
│ ├── moist.m
│ ├── weight.m
│ ├── 📂 chlA_pareto
│ │   ├── chlA_m241g50r50_MR.html
│ │   └── chlA_m241g50r50_pareto.html
│ ├── 📂 moist_pareto
│ │   ├── moist_m2248g50r50_MR.html
│ │   └── moist_m2248g50r50_pareto.html
│ └── 📂 weight_pareto
│     ├── weight_m967g50r50_MR.html
│     └── weight_m967g50r50_pareto.html
│
├── main.m # Main script loop
│
└── 📂 tests # Optional tests for system validation
    ├── Conveyor_Move.asv
    ├── Conveyor_Move.m
    ├── Fuzzy_Test.asv
    ├── Fuzzy_Test.m
    ├── Test_cam.m
    ├── Test_sensor.m
    └── servo_test.m
```
---
# ABOUT THE SYSTEM:
## ✨ Key Features
- Uses **image-derived features** (RGB & HSV) for analysis.
- Estimates **chlorophyll-a**, **moisture content**, and **fresh head weight** via genetic programming (GP) models.
- Classifies lettuce into **three grades** using a **Mamdani-Type 1 fuzzy logic inference system**:
  - **Grade 1 (High Quality)**  
  - **Grade 2 (Medium Quality)**  
  - **Grade 3 (Low Quality)**
- Achieved **90% classification accuracy** on test samples.

---

## 📊 Methodology

### 1. Image Capturing & Processing
- Lettuce heads were photographed in a **controlled chamber (~400 lux)**.  
- Images were pre-processed in MATLAB, with **data augmentation** (scaling, flipping, rotating) to expand the dataset.  
- Extracted **RGB and HSV mean values**, commonly used in crop ripeness and food quality analysis.

### 2. Parameter Extraction
Three key quality parameters were measured in the laboratory:
- **Chlorophyll-a** – extracted using ethanol and quantified with UV-VIS spectrophotometry (663 nm, 645 nm).  
- **Moisture Content** – determined via oven-drying at 80°C for 8 hours.  
- **Fresh Head Weight** – measured directly with an analytical balance.  

### 3. Genetic Programming (GP) Modeling
- Input: RGB & HSV values  
- Output: Predicted values of chlorophyll-a, moisture content, fresh weight.  
- Models evaluated using **R², RMSE, MAE, and complexity**.  
- GP1 (RGB-HSV inputs) outperformed GP2 (HSV-only inputs) in predictive accuracy.

### 4. Fuzzy Logic Classification
- Mamdani-Type 1 fuzzy system with **membership functions**:
  - Inputs: chlorophyll-a, moisture content, fresh head weight.  
  - Output: Grading level (L1, L2, L3).  
- Membership functions:
  - Input parameters → trapezoidal/triangular sets (low, average, high).  
  - Output (grade) → Gaussian functions.  
- Decision rules mapped estimated values to quality grades.

### 5. Results
- **Model accuracies**:
  - Chlorophyll-a: 89.97%  
  - Moisture Content: 92.8%  
  - Fresh Head Weight: 85.38%  
- Overall **system grading accuracy: 90% (27/30 samples correctly classified)**.  
- Minor misclassifications occurred, mostly biasing towards Grade 2 when the true grade was Grade 3.
---

## 🛠️ Authors
- Fernando N. Magallanes Jr.  
- Alexi S. Alberto  
- Romell M. Forones  
- Juan Gabriel L. Galang  
- Elmo F. Mandigma

## Adviser
- Ira C. Valenzuela-Estopia  

---
