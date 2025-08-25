# Automated-Lettuce-Grading-and-Sorting-in-Postharvest-Manufacturing-Setup-

This project presents an **automated quality grading system** for iceberg lettuce (*Lactuca sativa var. capitata*), integrating **Genetic Programming (GP)** for parameter estimation and **Fuzzy Logic (FL)** for quality classification.  
The system addresses inefficiencies in manual grading, ensuring **objective, consistent, and non-destructive** quality assessment.

---

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

## 🚀 Improvements & Future Work
While the system demonstrates strong potential, several enhancements could improve robustness and real-world applicability:

1. **Expand Dataset Size**
   - Current dataset: 56 samples (augmented to 617).  
   - Future: Increase real-world samples across varying lighting, maturity stages, and growing conditions.
2. **Improve Moisture Content Estimation**
   - GP models for moisture showed lower R² (0.43). Consider incorporating more features and other lettuce quality parameters for better accuracy.
3. **Integrate Deep Learning with Interpretability**
   - Current system prioritizes interpretability (GP + FL).  
   - Hybrid models combining **CNNs for feature extraction** + **GP/FL for decision-making** could balance accuracy and transparency.
4. **Hardware Integration**
   - Automate real-time grading at farms or markets.
   - Comparative analysis of the study compared to the traditional postharvest handling. 
5. **Refine Fuzzy Logic Rules**
   - More nuanced membership functions could better capture borderline cases (L2/L3 misclassifications).  
   - Explore **Type-2 fuzzy logic** for uncertainty handling.
6. **Multi-Crop Adaptation**
   - Extend our approach to other leafy vegetables or fruits by retraining GP models and fuzzy rules.

---

## 📌 Citation and Request
If you use this work useful, kindly cite us. Thanks.

We did not provide the raw images and lab testing in this repository due to privacy reasons but final models are given. Raw data and image is available upon request.  
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
