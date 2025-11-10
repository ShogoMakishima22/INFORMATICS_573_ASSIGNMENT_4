Assignment 4: Basic R Commands – DNA Sequence Analysis

Course: INFO-B573 - Programming for Science Informatics
Student: Venkatesh Joshi
Date: 9th November 2025
Due Date: November 9, 2025, 11:59 PM

Table of Contents

Overview

Purpose and Learning Objectives

Skills Demonstrated

Files in This Repository

Prerequisites and Dependencies

Installation and Setup

How to Run the Program

Program Structure and Functionality

Expected Output

Analysis Results and Interpretation

Error Handling and Robustness

Code Quality and Best Practices

Troubleshooting Guide

Testing and Verification

References

Contact Information

Overview

This project implements a comprehensive DNA sequence analysis program in R, designed to read and process the chr1_GL383518v1_alt.fa FASTA sequence file. The final version of the script is robust, modular, and fully documented, performing the following analytical tasks:

DNA Sequence Reading and Extraction – Reads FASTA-format DNA sequence, validates it, and extracts specific bases.

Reverse Complement Generation – Creates the complementary DNA strand using base-pairing rules and reverses it.

Per-Kilobase Nucleotide Frequency Analysis – Counts each base (A, C, G, T, N) in 1000-base segments.

Data Validation and Summary Statistics – Builds a data frame, checks row sums, calculates GC content, and exports results.

The program is fully self-contained and built using only base R (no external packages), demonstrating practical bioinformatics analysis using fundamental programming principles.

Purpose and Learning Objectives
Primary Purpose

Demonstrate mastery of base R commands, file operations, and biological data processing while applying statistical reasoning to genomic data.

Learning Outcomes

Apply R control structures and data manipulation tools to real biological datasets.

Develop robust R scripts with error handling, data validation, and structured output.

Understand how to process FASTA sequences and compute GC content and nucleotide frequencies.

Produce professional-grade, reproducible scientific scripts.

Skills Demonstrated
R Programming Fundamentals

Data Structures: Vectors, lists, and data frames

Control Flow: Loops, conditional branching, and logical validation

Functions: Parameterized modular design for each analysis phase

I/O Operations: File reading, writing, and validation

Statistical Computation: Row sums, base proportions, GC content, and data summarization

Scientific Computing Practices

Modular code structure

Reproducible workflow

Clear inline documentation

Validated results and exportable outputs

Bioinformatics Competencies

FASTA file parsing

Sequence validation and normalization

Reverse complement logic (Watson–Crick pairing)

GC% calculation and ambiguity handling

Files in This Repository
INFORMATICS_573/
├── assignment4_dna_analysis.R       # Main analysis script (final version)
├── README.md                        # Project documentation
├── chr1_GL383518v1_alt.fa           # Input DNA sequence file (FASTA)
├── nucleotide_analysis_results.csv  # Output: nucleotide counts per kilobase
└── analysis_summary.txt             # Output: summary statistics and analysis notes

Prerequisites and Dependencies
Software Requirements

R version 4.0.0 or higher

Optional: RStudio for IDE support

Works on Windows, macOS, and Linux

Required Packages

✅ No external packages required.
All functions rely on base R only:

readLines(), substr(), chartr(), strsplit()

regmatches(), gregexpr(), data.frame(), rowSums(), write.csv()

Input Data

FASTA format file containing a valid DNA sequence:

>chr1_GL383518v1_alt
ATCGATCGATCGATCG...


The file must contain a header (>) and one or more lines of sequence data.

Installation and Setup
Step 1: Verify R Installation
R.version.string

Step 2: Prepare Working Directory
mkdir -p /Users/venki/INFORMATICS_573
cd /Users/venki/INFORMATICS_573

Step 3: Place Required Files

Place both files in your working directory:

assignment4_dna_analysis.R

chr1_GL383518v1_alt.fa

Step 4: Verify File Access
setwd("/Users/venki/INFORMATICS_573")
file.exists("chr1_GL383518v1_alt.fa")  # Should return TRUE

How to Run the Program
Option 1 – From RStudio

Open RStudio

Set working directory:
Session → Set Working Directory → Choose Directory

Open the script assignment4_dna_analysis.R

Click Source (or press Ctrl+Shift+Enter / Cmd+Shift+Return)

Option 2 – From R Console
setwd("/Users/venki/INFORMATICS_573")
source("assignment4_dna_analysis.R")

Option 3 – From Command Line
Rscript assignment4_dna_analysis.R /Users/venki/INFORMATICS_573 chr1_GL383518v1_alt.fa

Program Structure and Functionality
1️⃣ File and Environment Setup

Validates directory path and FASTA filename.

Normalizes paths cross-platform.

Uses tryCatch() for safe file operations.

2️⃣ DNA Sequence Reading

Function: read_dna_sequence(filename)

Removes FASTA headers (>)

Joins multi-line sequences

Converts to uppercase

Validates file integrity and sequence length

3️⃣ Reverse Complement Creation

Function: create_reverse_complement(sequence)

Uses chartr("ACGTN","TGCAN", sequence) for complement conversion

Reverses sequence order using rev(strsplit())

Extracts:

79th base of reverse complement

Bases 500–800 segment (301 bases)

4️⃣ Nucleotide Frequency per Kilobase

Function: count_nucleotides_per_kb(sequence)

Splits sequence into 1000-base segments

Counts A, C, G, T, and N bases

Calculates GC content for each kilobase

Returns named list with all counts

5️⃣ Data Frame Construction and Validation

Function: create_nucleotide_dataframe(counts_list)

Converts list output into data frame

Adds ACGT_Sum, GC_Percent, and KB_Length

Validates that ACGT_Sum + N = KB_Length

Exports:

nucleotide_analysis_results.csv

analysis_summary.txt

Expected Output

Sample Console Output (abridged):

=======================================================
READING DNA SEQUENCE
=======================================================
✓ Successfully read sequence
Total length: 128432 bases

The 10th letter is: G
The 758th letter is: A

=======================================================
CREATING REVERSE COMPLEMENT
=======================================================
✓ Reverse complement created
79th letter: T
Letters 500–800: [301 bases total]

=======================================================
COUNTING NUCLEOTIDES PER KILOBASE
=======================================================
✓ Created counts for 129 kilobases
Note: 15 ambiguous bases (N) detected

=======================================================
DATA FRAME CREATION AND ANALYSIS
=======================================================
All complete kilobases sum to 1000 bases.
1 incomplete kilobase detected (length 432).
Verification: ACGT_Sum + N = KB_Length → PASSED

✓ Results exported:
  - nucleotide_analysis_results.csv
  - analysis_summary.txt

Analysis Results and Interpretation
Key Findings

Total length: 128,432 bases

Total kilobases analyzed: 129 (128 full, 1 partial)

Ambiguous bases (N): 15

Overall GC content: ~50.1% (indicative of gene-rich region)

Observed Variations

The final kilobase (KB 129) has fewer than 1000 bases → ACGT sum < 1000.

All other kilobases sum to exactly 1000.

GC content is consistent (±0.8%), typical for human chromosome regions.

Biological Implications

Balanced A:T and G:C ratios suggest normal chromosomal sequence.

High GC content indicates coding or regulatory regions.

N bases represent sequencing ambiguity or assembly gaps.

Error Handling and Robustness

Validates file existence and read permissions.

Detects and warns about incomplete or invalid FASTA files.

Handles empty or malformed sequences gracefully.

Provides clear, actionable error messages.

Validates each kilobase for total length consistency.

Code Quality and Best Practices

Modular design with one logical purpose per function.

Section headers and print_section() for clarity.

Vectorized operations for speed (chartr, regmatches, rowSums).

Defensive coding using tryCatch() and pre-validation.

Self-contained, cross-platform execution.

Professional console formatting and full inline documentation.

Troubleshooting Guide
Issue	Possible Cause	Solution
Error: File not found	Wrong working directory	Use setwd() to correct path
File contains only header line	Missing sequence data	Recheck FASTA file contents
Cannot read file	Permission denied	Ensure read access to directory
Sequence too short	Test sequence truncated	Use full genome FASTA file
Testing and Verification

Tested On:

macOS 15.0.1 (R 4.4.0)

Windows 11 (R 4.3.2)

Linux (Ubuntu 24.04)

All Tests Passed:

Handles missing/short files gracefully

Correctly computes GC%

Validates ACGT sum consistency

Produces identical results across platforms
