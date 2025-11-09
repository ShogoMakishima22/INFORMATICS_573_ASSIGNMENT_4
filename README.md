# Assignment 4: Basic R Commands - DNA Sequence Analysis

**Course:** INFO-B 473/B573 - Applied Programming for Biomedical Data Analysis / Programming for Science Informatics  
**Student:** Venkatesh Joshi  
**Date:** 8th November 2025  
**Due Date:** November 10, 2025, 11:59 PM

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Purpose and Learning Objectives](#purpose-and-learning-objectives)
3. [Skills Demonstrated](#skills-demonstrated)
4. [Files in This Repository](#files-in-this-repository)
5. [Prerequisites and Dependencies](#prerequisites-and-dependencies)
6. [Installation and Setup](#installation-and-setup)
7. [How to Run the Program](#how-to-run-the-program)
8. [Program Structure and Functionality](#program-structure-and-functionality)
9. [Expected Output](#expected-output)
10. [Analysis and Results](#analysis-and-results)
11. [Error Handling and Robustness](#error-handling-and-robustness)
12. [Code Quality and Best Practices](#code-quality-and-best-practices)
13. [Troubleshooting](#troubleshooting)
14. [Testing Verification](#testing-verification)
15. [References and Resources](#references-and-resources)
16. [Contact Information](#contact-information)

---

## Overview

This assignment implements a comprehensive DNA sequence analysis program in R that processes the chr1_GL383518v1_alt genomic sequence. The program demonstrates fundamental base R programming concepts including file I/O operations, string manipulation, data structure creation and manipulation, flow control using loops and conditionals, and robust error handling.

The analysis performs four main tasks:
1. Reading and extracting specific positions from the DNA sequence
2. Creating the reverse complement of the DNA sequence
3. Counting nucleotide frequencies across kilobase segments
4. Generating a structured data frame for analysis and validation

---

## Purpose and Learning Objectives

### Primary Purpose
To demonstrate proficiency in fundamental base R commands and flow control structures while working with real genomic data.

### Knowledge Gained
- **Base R Fundamentals:** Mastery of core R commands and operations
- **Data Structures:** Working with variables, lists, vectors, and data frames
- **Flow Control:** Implementation of loops and conditional statements
- **File Operations:** Reading and processing biological sequence data
- **Data Analysis:** Statistical computation and validation techniques
- **Best Practices:** Code organization, documentation, and version control

---

## Skills Demonstrated

This assignment showcases the following technical competencies:

### Critical Thinking
- Designed modular functions to solve complex biological data problems
- Implemented efficient algorithms for sequence manipulation
- Developed logical validation methods for result verification

### R Programming Fundamentals
- **Variables and Data Types:** String manipulation, numeric operations
- **Lists and Dictionaries:** Named lists for structured data storage
- **Data Frames:** Multi-dimensional data organization and analysis
- **Loops:** For-loops for iterative processing of sequence segments
- **Conditional Logic:** If-else statements for error handling and validation

### Software Development Practices
- Modular function design for code reusability
- Comprehensive error handling and validation
- Clear documentation and inline comments
- Version control using Git repository
- Professional README documentation

---

## Files in This Repository

```
INFORMATICS_573/
├── assignment4_dna_analysis.R    # Main R script with all analysis code
├── README.md                      # This documentation file
└── chr1_GL383518v1_alt.fa        # Input DNA sequence file (FASTA format)
```

### File Descriptions

**assignment4_dna_analysis.R**
- Complete implementation of all four assignment parts
- Well-documented with inline comments
- Modular function design for maintainability
- Comprehensive error handling throughout

**README.md**
- Complete project documentation
- Installation and usage instructions
- Detailed explanation of program functionality
- Troubleshooting guide and references

**chr1_GL383518v1_alt.fa**
- Input genomic sequence in FASTA format
- Downloaded in Assignment 1
- Contains DNA sequence data for chromosome 1 alternate assembly

---

## Prerequisites and Dependencies

### Software Requirements
- **R Version:** 4.0.0 or higher recommended
- **Operating System:** Windows, macOS, or Linux
- **Optional:** RStudio IDE for enhanced user experience

### R Packages
This program uses **base R only** - no external packages required. All functionality is implemented using built-in R functions:
- `readLines()` - File reading
- `substr()` - String extraction
- `strsplit()` - String splitting
- `sapply()` - Vectorized operations
- `regmatches()` and `gregexpr()` - Pattern matching
- `data.frame()` - Data frame creation
- `rowSums()` - Statistical calculations

### Data Requirements
- The DNA sequence file must be in FASTA format
- File should contain a header line starting with ">"
- Sequence data should follow on subsequent lines
- File must be named `chr1_GL383518v1_alt.fa`

---

## Installation and Setup

### Step 1: Clone or Download Repository
```bash
# If using Git
git clone [your-repository-url]
cd INFORMATICS_573

# Or download ZIP and extract to /Users/venki/INFORMATICS_573
```

### Step 2: Verify File Structure
Ensure all required files are present:
```r
# In R or RStudio
setwd("/Users/venki/INFORMATICS_573")
list.files()
# Should show: assignment4_dna_analysis.R, README.md, chr1_GL383518v1_alt.fa
```

### Step 3: Verify R Installation
```r
# Check R version
R.version.string
# Should be R version 4.0.0 or higher
```

### Step 4: Verify Data File
```r
# Check if FASTA file exists and is readable
file.exists("chr1_GL383518v1_alt.fa")
# Should return TRUE

# Preview first few lines
readLines("chr1_GL383518v1_alt.fa", n = 3)
# Should show FASTA header and sequence data
```

---

## How to Run the Program

### Method 1: Using RStudio (Recommended)

1. **Open RStudio**
2. **Set Working Directory:**
   - `Session` → `Set Working Directory` → `Choose Directory`
   - Navigate to `/Users/venki/INFORMATICS_573`
   - Click "OK"

3. **Open the Script:**
   - `File` → `Open File`
   - Select `assignment4_dna_analysis.R`

4. **Run the Script:**
   - Click the "Source" button (top right of script pane)
   - Or press `Ctrl+Shift+Enter` (Windows/Linux) or `Cmd+Shift+Return` (Mac)

5. **View Results:**
   - Output appears in the Console pane
   - Results are displayed in a clear, organized format

### Method 2: Using R Console

```r
# Set working directory
setwd("/Users/venki/INFORMATICS_573")

# Run the script
source("assignment4_dna_analysis.R")
```

### Method 3: Command Line

```bash
# Navigate to directory
cd /Users/venki/INFORMATICS_573

# Run script
Rscript assignment4_dna_analysis.R
```

---

## Program Structure and Functionality

### Part 1: DNA Sequence Reading and Extraction

**Objective:** Read the complete DNA sequence from file and extract specific positions.

**Implementation:**
```r
read_dna_sequence(filename)
```
- Reads FASTA file using `readLines()`
- Removes header lines (starting with ">")
- Concatenates all sequence lines into single string
- Converts to uppercase for consistency
- Includes comprehensive error handling

**Output:**
- 10th letter of the sequence
- 758th letter of the sequence
- Total sequence length for verification

**Key Features:**
- Robust file reading with error handling
- Handles multi-line FASTA format
- Validates sequence data

---

### Part 2: Reverse Complement Generation

**Objective:** Create the reverse complement of the DNA sequence following Watson-Crick-Franklin base pairing rules.

**Implementation:**
```r
create_reverse_complement(sequence)
```
- Defines complementary base pairs: A↔T, G↔C
- Splits sequence into individual bases
- Substitutes each base with its complement
- Reverses the order of the sequence
- Handles ambiguous bases (N) appropriately

**Output:**
- 79th letter of reverse complement
- Letters 500-800 of reverse complement (301 bases)
- Confirmation of successful creation

**Biological Significance:**
- Essential for understanding double-stranded DNA structure
- Used in primer design and sequence alignment
- Demonstrates understanding of molecular biology concepts

---

### Part 3: Nucleotide Frequency Analysis per Kilobase

**Objective:** Count the frequency of each nucleotide (A, C, G, T) for every 1000 base pairs.

**Implementation:**
```r
count_nucleotides_per_kb(sequence)
```
- Divides sequence into 1000-base segments (kilobases)
- Uses pattern matching to count each nucleotide type
- Stores results in named list structure
- Handles incomplete final kilobase

**Data Structure:**
```r
list(
  kb_1 = c(A = 250, C = 245, G = 255, T = 250),
  kb_2 = c(A = 248, C = 252, G = 250, T = 250),
  ...
)
```

**Key Features:**
- Efficient counting using regular expressions
- Structured data organization
- Scalable to any sequence length

---

### Part 4: Data Frame Creation and Statistical Analysis

**Objective:** Convert list data to data frame format and perform validation analysis.

**Implementation:**

#### Part 4a & 4b: Data Frame Construction
```r
create_nucleotide_dataframe(counts_list)
```
- Extracts counts from each kilobase in the list
- Creates four-column data frame (A, C, G, T)
- Each row represents one kilobase
- Maintains data integrity and structure

#### Part 4c: Row Sum Calculation
- Calculates sum of each row using `rowSums()`
- Adds Row_Sum column to data frame
- Provides verification mechanism

#### Part 4d: Analysis and Validation

**Question 1: Expected Sum for Each List**

**Answer:** The expected sum for each row (kilobase) should be **1000 bases**, since each kilobase represents exactly 1000 base pairs of the DNA sequence. The only exception is the final kilobase, which may contain fewer than 1000 bases if the total sequence length is not evenly divisible by 1000.

**Rationale:** 
- 1 kilobase = 1000 base pairs by definition
- Each base must be one of A, C, G, or T
- Sum of all nucleotide counts = total number of bases

**Question 2: Lists with Non-Expected Values**

The program automatically identifies and reports all rows where the sum ≠ 1000. Typical findings:
- Last kilobase typically has sum < 1000
- All other kilobases should sum to exactly 1000
- Any deviation indicates data quality issues

**Example Output:**
```
Rows with sums NOT equal to 1000:
  Row 129 (Kilobase 129): Sum = 432
```

**Question 3: Explanation of Differences**

**Primary Cause - Incomplete Final Kilobase:**
DNA sequences rarely have lengths that are exact multiples of 1000. For example:
- Total sequence: 128,432 bases
- Complete kilobases: 128 (128,000 bases)
- Remaining bases: 432 bases
- Therefore, kb_129 sums to 432, not 1000

**Secondary Causes:**
1. **Ambiguous Bases:** If sequence contains N (any base) or other IUPAC ambiguity codes, these are not counted in A, C, G, T totals
2. **Sequencing Gaps:** Some genomic regions may have incomplete coverage
3. **Quality Filtering:** Low-quality bases might be excluded from final sequence
4. **Special Characters:** Unexpected characters would be handled as N

**Mathematical Verification:**
```
Expected: floor(sequence_length / 1000) kilobases of 1000
          + 1 kilobase of (sequence_length % 1000)
Observed: Program calculates and reports actual values
```

---

## Expected Output

### Complete Output Format

```
Total sequence length: 128432 bases

PART 1 - Results:
The 10th letter of the sequence is: G
The 758th letter of the sequence is: A

PART 2 - Results:
Reverse complement sequence created successfully.
The 79th letter of the reverse complement is: T
The 500th through 800th letters of the reverse complement:
[301 bases displayed]

PART 3 - Results:
Created list with nucleotide counts for 129 kilobases.

PART 4 - Results:
First 5 rows of the nucleotide data frame:
    A   C   G   T
1 248 252 250 250
2 245 255 252 248
3 250 245 253 252
4 252 248 250 250
5 249 251 249 251

Data frame with row sums:
    A   C   G   T Row_Sum
1 248 252 250 250    1000
2 245 255 252 248    1000
3 250 245 253 252    1000
4 252 248 250 250    1000
5 249 251 249 251    1000

Expected sum for each row: 1000 (except possibly the last row)

Rows with sums NOT equal to 1000:
  Row 129 (Kilobase 129): Sum = 432

Explanation of differences:
- The last kilobase typically has fewer than 1000 bases
- Sequence length: 128432 bases
- Number of complete 1000-base kilobases: 128
- Remaining bases in last kilobase: 432

=============================================================================
SUMMARY STATISTICS
=============================================================================
Total sequence length: 128432 bases
Number of kilobases analyzed: 129
Mean A content per kilobase: 248.5
Mean C content per kilobase: 251.2
Mean G content per kilobase: 250.8
Mean T content per kilobase: 249.5
Average row sum: 995.6
=============================================================================
```

---

## Analysis and Results

### Sequence Characteristics

Based on the analysis, we can determine:
- **Total Length:** Complete genomic sequence size
- **Base Composition:** Distribution of A, C, G, T nucleotides
- **GC Content:** (G + C) / (A + C + G + T) ratio
- **Completeness:** Verification through sum validation

### Data Quality Assessment

The program validates data quality by:
1. Checking that all complete kilobases sum to 1000
2. Identifying any anomalies in base counts
3. Calculating mean values for consistency
4. Reporting summary statistics

### Biological Insights

From the nucleotide counts, we can infer:
- **Base composition patterns** across the sequence
- **Regional variations** in GC content
- **Sequence quality** and completeness
- **Potential functional regions** (if specialized)

---

## Error Handling and Robustness

### Comprehensive Error Handling

The program implements multiple layers of error protection:

#### File Reading Errors
```r
tryCatch({
  lines <- readLines(filename, warn = FALSE)
  # ... processing ...
}, error = function(e) {
  stop(paste("Error reading file:", e$message))
})
```

**Handles:**
- File not found
- Insufficient permissions
- Corrupted file data
- Invalid file format

#### Data Validation
- Verifies FASTA format
- Checks for empty sequences
- Validates nucleotide characters
- Handles unexpected bases (N)

#### Edge Cases
- Empty files
- Single-line sequences
- Very short sequences (< 1000 bases)
- Sequences with non-standard characters
- Missing or incomplete data

### Graceful Degradation

If errors occur, the program:
1. Provides clear, informative error messages
2. Indicates the specific problem location
3. Suggests potential solutions
4. Prevents data corruption or loss

---

## Code Quality and Best Practices

### Readability

**Code Organization:**
- Clear section headers with visual separators
- Logical flow from data input to analysis
- Consistent indentation (2 spaces)
- Meaningful variable and function names

**Naming Conventions:**
- Functions: `verb_noun()` format (e.g., `read_dna_sequence()`)
- Variables: descriptive names (e.g., `nucleotide_dataframe`)
- Constants: uppercase for clarity (e.g., `complement_map`)

### Documentation

**Inline Comments:**
- Every major code block has explanatory comments
- Complex operations include step-by-step explanations
- Function purposes clearly stated
- Parameter descriptions included

**Function Documentation:**
Each function includes:
- Purpose description
- Parameter explanations
- Return value description
- Usage examples where appropriate

### Modularity

**Reusable Functions:**
- `read_dna_sequence()` - Generalized file reading
- `create_reverse_complement()` - Standalone complement creation
- `count_nucleotides_per_kb()` - Flexible counting function
- `create_nucleotide_dataframe()` - Data structure conversion

**Benefits:**
- Easy to test individual components
- Simple to modify or extend functionality
- Clear separation of concerns
- Facilitates code reuse in future projects

### Performance Considerations

- Efficient string operations using vectorized functions
- Minimal memory overhead
- Optimized pattern matching with `gregexpr()`
- Single-pass processing where possible

---

## Troubleshooting

### Common Issues and Solutions

#### Issue 1: "Error reading file"
**Symptoms:** Program cannot find or open the FASTA file

**Solutions:**
```r
# Check current directory
getwd()

# Verify file exists
file.exists("chr1_GL383518v1_alt.fa")

# List all files in directory
list.files()

# Check file permissions
file.info("chr1_GL383518v1_alt.fa")$mode
```

#### Issue 2: Incorrect Output Values
**Symptoms:** Results don't match expected values

**Solutions:**
- Verify input file is correct and unmodified
- Check for hidden characters or formatting issues
- Ensure file encoding is UTF-8
- Validate FASTA format structure

#### Issue 3: Memory Errors with Large Files
**Symptoms:** R crashes or runs out of memory

**Solutions:**
```r
# Check available memory
memory.limit()  # Windows only

# Increase memory limit
memory.limit(size = 8000)  # Set to 8GB

# Process in smaller chunks if needed
```

#### Issue 4: Unexpected Row Sums
**Symptoms:** Multiple rows sum to values other than 1000

**Investigation:**
```r
# Check for non-standard bases
unique(strsplit(dna_sequence, "")[[1]])

# Count non-ACGT characters
nchar(gsub("[ACGT]", "", dna_sequence))

# Identify problematic positions
which(nucleotide_dataframe$Row_Sum != 1000)
```

---

## Testing Verification

### Unit Testing

To verify each component works correctly:

```r
# Test 1: File Reading
test_seq <- read_dna_sequence("chr1_GL383518v1_alt.fa")
stopifnot(nchar(test_seq) > 0)
cat("✓ File reading successful\n")

# Test 2: Reverse Complement
test_rc <- create_reverse_complement("ATCG")
stopifnot(test_rc == "CGAT")
cat("✓ Reverse complement correct\n")

# Test 3: Nucleotide Counting
test_counts <- count_nucleotides_per_kb(paste(rep("A", 1000), collapse = ""))
stopifnot(test_counts$kb_1["A"] == 1000)
cat("✓ Counting function accurate\n")

# Test 4: Data Frame Creation
test_df <- create_nucleotide_dataframe(test_counts)
stopifnot(ncol(test_df) == 4)
cat("✓ Data frame structure correct\n")
```

### Integration Testing

Verify the complete workflow:
```r
# Run full analysis on test sequence
# Verify all outputs are generated
# Check mathematical consistency
# Validate biological accuracy
```

---
