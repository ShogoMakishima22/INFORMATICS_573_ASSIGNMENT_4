# INFO-B 473/B573: Assignment 4 - Basic R Commands
# DNA Sequence Analysis for chr1_GL383518v1_alt
# Author: Venkatesh Joshi
# Date: 8th November 2025

# =============================================================================
# PART 1: Read DNA Sequence and Extract Specific Letters
# =============================================================================

# Read the DNA sequence from file
# Replace 'chr1_GL383518v1_alt.fasta' with your actual filename
read_dna_sequence <- function(filename) {
  tryCatch({
    # Read all lines from the file
    lines <- readLines(filename, warn = FALSE)
    
    # Remove the header line (starts with ">")
    sequence_lines <- lines[!grepl("^>", lines)]
    
    # Combine all sequence lines into one string
    sequence <- paste(sequence_lines, collapse = "")
    
    # Convert to uppercase for consistency
    sequence <- toupper(sequence)
    
    return(sequence)
  }, error = function(e) {
    stop(paste("Error reading file:", e$message))
  })
}

# Read the sequence
dna_sequence <- read_dna_sequence("chr1_GL383518v1_alt.fa")

# Print sequence length for verification
cat("Total sequence length:", nchar(dna_sequence), "bases\n\n")

# Extract and print the 10th letter
letter_10 <- substr(dna_sequence, 10, 10)
cat("PART 1 - Results:\n")
cat("The 10th letter of the sequence is:", letter_10, "\n")

# Extract and print the 758th letter
letter_758 <- substr(dna_sequence, 758, 758)
cat("The 758th letter of the sequence is:", letter_758, "\n\n")

# =============================================================================
# PART 2: Create Reverse Complement
# =============================================================================

# Function to create reverse complement of DNA sequence
create_reverse_complement <- function(sequence) {
  # Define Watson-Crick-Franklin base pairs
  complement_map <- c("A" = "T", "T" = "A", "G" = "C", "C" = "G", "N" = "N")
  
  # Split sequence into individual characters
  seq_vector <- strsplit(sequence, "")[[1]]
  
  # Create complement by substituting each base
  complement_vector <- sapply(seq_vector, function(base) {
    if (base %in% names(complement_map)) {
      return(complement_map[base])
    } else {
      return("N")  # Handle any unexpected characters
    }
  })
  
  # Reverse the complement sequence
  reverse_complement <- rev(complement_vector)
  
  # Combine back into a single string
  reverse_complement_seq <- paste(reverse_complement, collapse = "")
  
  return(reverse_complement_seq)
}

# Create reverse complement
reverse_comp_sequence <- create_reverse_complement(dna_sequence)

cat("PART 2 - Results:\n")
cat("Reverse complement sequence created successfully.\n")

# Extract and print the 79th letter of reverse complement
letter_79_rc <- substr(reverse_comp_sequence, 79, 79)
cat("The 79th letter of the reverse complement is:", letter_79_rc, "\n")

# Extract and print letters 500-800 of reverse complement
letters_500_800 <- substr(reverse_comp_sequence, 500, 800)
cat("The 500th through 800th letters of the reverse complement:\n")
cat(letters_500_800, "\n\n")

# =============================================================================
# PART 3: Count Nucleotides per Kilobase
# =============================================================================

# Function to count nucleotides for each kilobase
count_nucleotides_per_kb <- function(sequence) {
  # Initialize list to store counts for each kilobase
  nucleotide_counts_list <- list()
  
  # Get sequence length
  seq_length <- nchar(sequence)
  
  # Calculate number of complete kilobases
  num_kilobases <- ceiling(seq_length / 1000)
  
  # Loop through each kilobase
  for (kb in 1:num_kilobases) {
    # Calculate start and end positions for this kilobase
    start_pos <- (kb - 1) * 1000 + 1
    end_pos <- min(kb * 1000, seq_length)
    
    # Extract subsequence for this kilobase
    kb_sequence <- substr(sequence, start_pos, end_pos)
    
    # Count each nucleotide in this kilobase
    count_A <- lengths(regmatches(kb_sequence, gregexpr("A", kb_sequence)))
    count_C <- lengths(regmatches(kb_sequence, gregexpr("C", kb_sequence)))
    count_G <- lengths(regmatches(kb_sequence, gregexpr("G", kb_sequence)))
    count_T <- lengths(regmatches(kb_sequence, gregexpr("T", kb_sequence)))
    
    # Store counts in a named vector
    kb_counts <- c(A = count_A, C = count_C, G = count_G, T = count_T)
    
    # Add to list with kilobase number as name
    nucleotide_counts_list[[paste0("kb_", kb)]] <- kb_counts
  }
  
  cat("PART 3 - Results:\n")
  cat("Created list with nucleotide counts for", num_kilobases, "kilobases.\n\n")
  
  return(nucleotide_counts_list)
}

# Create the nucleotide counts list
kb_counts_list <- count_nucleotides_per_kb(dna_sequence)

# =============================================================================
# PART 4: Create Data Frame and Analyze
# =============================================================================

cat("PART 4 - Results:\n")

# Part 4a & 4b: Create data frame with all kilobases
create_nucleotide_dataframe <- function(counts_list) {
  # Initialize vectors for each nucleotide
  A_counts <- numeric()
  C_counts <- numeric()
  G_counts <- numeric()
  T_counts <- numeric()
  
  # Extract counts from each kilobase in the list
  for (kb_name in names(counts_list)) {
    kb_data <- counts_list[[kb_name]]
    A_counts <- c(A_counts, kb_data["A"])
    C_counts <- c(C_counts, kb_data["C"])
    G_counts <- c(G_counts, kb_data["G"])
    T_counts <- c(T_counts, kb_data["T"])
  }
  
  # Create data frame with 4 columns
  nucleotide_df <- data.frame(
    A = A_counts,
    C = C_counts,
    G = G_counts,
    T = T_counts
  )
  
  return(nucleotide_df)
}

# Create the data frame
nucleotide_dataframe <- create_nucleotide_dataframe(kb_counts_list)

# Display first few rows
cat("First 5 rows of the nucleotide data frame:\n")
print(head(nucleotide_dataframe, 5))
cat("\n")

# Part 4c: Calculate sum of each row
row_sums <- rowSums(nucleotide_dataframe)

# Add row sums to data frame for clarity
nucleotide_dataframe$Row_Sum <- row_sums

cat("Data frame with row sums:\n")
print(head(nucleotide_dataframe, 5))
cat("\n")

# Part 4d: Answer questions using comments

# Question 1: What is the expected sum for each list?
# ANSWER: The expected sum for each row (kilobase) should be 1000, since each
# kilobase represents 1000 base pairs. However, the last kilobase may have a
# different sum if the total sequence length is not evenly divisible by 1000.

cat("Expected sum for each row: 1000 (except possibly the last row)\n\n")

# Question 2: Are there any lists whose sums are not equal to the expected value?
# Check which rows don't sum to 1000
non_1000_rows <- which(row_sums != 1000)

if (length(non_1000_rows) > 0) {
  cat("Rows with sums NOT equal to 1000:\n")
  for (row_idx in non_1000_rows) {
    cat(sprintf("  Row %d (Kilobase %d): Sum = %d\n", 
                row_idx, row_idx, row_sums[row_idx]))
  }
} else {
  cat("All rows sum to exactly 1000.\n")
}
cat("\n")

# Question 3: Provide a general explanation for differences
# ANSWER: The differences between expected and observed results occur primarily
# in the last kilobase of the sequence. Since DNA sequences rarely have lengths
# that are exact multiples of 1000, the final kilobase will contain fewer than
# 1000 base pairs, resulting in a lower sum. Additionally, if the sequence
# contains any ambiguous bases (N) or other non-standard characters, these would
# not be counted in our A, C, G, T totals, leading to sums less than 1000.

cat("Explanation of differences:\n")
cat("- The last kilobase typically has fewer than 1000 bases\n")
cat("- Sequence length:", nchar(dna_sequence), "bases\n")
cat("- Number of complete 1000-base kilobases:", 
    floor(nchar(dna_sequence) / 1000), "\n")
cat("- Remaining bases in last kilobase:", 
    nchar(dna_sequence) %% 1000, "\n\n")

# Summary statistics
cat("=============================================================================\n")
cat("SUMMARY STATISTICS\n")
cat("=============================================================================\n")
cat("Total sequence length:", nchar(dna_sequence), "bases\n")
cat("Number of kilobases analyzed:", nrow(nucleotide_dataframe), "\n")
cat("Mean A content per kilobase:", mean(nucleotide_dataframe$A), "\n")
cat("Mean C content per kilobase:", mean(nucleotide_dataframe$C), "\n")
cat("Mean G content per kilobase:", mean(nucleotide_dataframe$G), "\n")
cat("Mean T content per kilobase:", mean(nucleotide_dataframe$T), "\n")
cat("Average row sum:", mean(row_sums), "\n")
cat("=============================================================================\n")
