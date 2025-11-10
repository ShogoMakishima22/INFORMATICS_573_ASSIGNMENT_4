# Assignment 4: Basic R Commands – DNA Sequence Analysis Script Generator

**Course:** INFO-B B573 – Programming for Science Informatics  
**Student:** Venkatesh Joshi  
**Date:** November 8, 2025  
**Due Date:** November 9, 2025, 11:59 PM  

---

## 🧾 Table of Contents
1. [Overview](#overview)  
2. [Purpose and Learning Objectives](#purpose-and-learning-objectives)  
3. [Program Design and Workflow](#program-design-and-workflow)  
4. [Files in This Repository](#files-in-this-repository)  
5. [System Requirements](#system-requirements)  
6. [Setup and Installation](#setup-and-installation)  
7. [How the Script Works](#how-the-script-works)  
8. [Generated File Details](#generated-file-details)  
9. [How to Run the Generated Script](#how-to-run-the-generated-script)  
10. [Error Handling and Validation](#error-handling-and-validation)  
11. [Example Output Summary](#example-output-summary)  
12. [Best Practices and Notes](#best-practices-and-notes)  
13. [Contact Information](#contact-information)

---

## 🧬 Overview

This assignment implements a **self-contained R script generator** that automatically creates a complete DNA sequence analysis program, `assignment4_dna_analysis.R`.  

The generator script (`assignment4_generator.R`) builds and saves the analysis program that:
- Reads a DNA sequence in FASTA format  
- Computes reverse complements  
- Calculates nucleotide counts per kilobase  
- Generates GC-content summaries  
- Answers all assignment questions with explicit explanations  
- Exports both CSV and text summary files  

The script automates creation, verification, and permission settings for the generated file, ensuring a **turnkey bioinformatics workflow**.

---

## 🎯 Purpose and Learning Objectives

### **Purpose**
To demonstrate proficiency in:
- Base R scripting and automation
- Bioinformatics file parsing (FASTA)
- Data validation and statistical computation
- Modular script generation and execution control

### **Learning Objectives**
- Build self-generating R scripts that encapsulate complete assignments
- Use R’s string, file, and error-handling capabilities to automate workflows
- Understand the process of reading, processing, and analyzing DNA sequences

---

## ⚙️ Program Design and Workflow

### **High-Level Flow**

1. **Configuration Phase**  
   - Accepts optional command-line arguments for directory paths  
   - Creates `/Users/venki/INFORMATICS_573` if not present  

2. **Validation Phase**  
   - Verifies directory access and write permissions  

3. **Generation Phase**  
   - Creates and writes `assignment4_dna_analysis.R`  
   - Populates it with a fully functional DNA analysis program  

4. **Verification Phase**  
   - Checks for file creation, size, and timestamps  
   - Makes script executable on non-Windows systems  

5. **Instruction Phase**  
   - Displays usage directions for the generated script  

---

## 📁 Files in This Repository
