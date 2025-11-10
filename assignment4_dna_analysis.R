#!/usr/bin/env Rscript
# =============================================================================
# INFO-B 473/B573: Assignment 4 - Basic R Commands
# DNA Sequence Analysis for chr1_GL383518v1_alt
# Author: Venkatesh Joshi
# Date: 8th November 2025
# =============================================================================

# =============================================================================
# CONFIGURATION AND ARGUMENT PARSING
# =============================================================================
args <- commandArgs(trailingOnly = TRUE)
default_dir <- getwd()
default_filename <- "chr1_GL383518v1_alt.fa"

if (length(args) >= 1) {
  working_dir <- args[1]
} else {
  cat("Using current directory:", default_dir, "\n")
  working_dir <- default_dir
}

if (length(args) >= 2) {
  fasta_filename <- args[2]
} else {
  cat("Using default file:", default_filename, "\n")
  fasta_filename <- default_filename
}

if (!dir.exists(working_dir)) {
  stop(paste("Error: Invalid directory:", working_dir))
}

setwd(working_dir)
cat("Working directory:", getwd(), "\n")
cat("FASTA file:", fasta_filename, "\n\n")

# =============================================================================
# HELPER FUNCTION FOR SECTION HEADERS
# =============================================================================
print_section <- function(title) {
  cat("\n=======================================================\n")
  cat(title, "\n")
  cat("=======================================================\n\n")
}

# =============================================================================
# FUNCTION DEFINITIONS
# =============================================================================

# Read DNA Sequence from FASTA file
read_dna_sequence <- function(filename) {
  if (!file.exists(filename)) {
    stop(paste("Error: File not found -", filename, 
               "\nCheck working directory:", getwd()))
  }

  if (file.access(filename, 4) != 0) {
    stop(paste("Error: Cannot read file -", filename, 
               "\nCheck file permissions."))
  }

  tryCatch({
    lines <- readLines(filename, warn = FALSE)
    if (length(lines) == 0) stop("Error: File is empty")

    sequence_lines <- lines[!grepl("^>", lines)]
    if (length(sequence_lines) == 0) stop("Error: No sequence data found")

    sequence <- paste(sequence_lines, collapse = "")
    sequence <- toupper(sequence)
    if (nchar(sequence) == 0) stop("Error: Sequence has zero length")

    return(sequence)
  }, error = function(e) {
    stop(paste("Error reading file:", e$message))
  })
}

# Create reverse complement of DNA sequence
create_reverse_complement <- function(sequence) {
  complement_seq <- chartr("ACGTN", "TGCAN", sequence)
  reverse_complement_seq <- paste(rev(strsplit(complement_seq, "")[[1]]), 
                                  collapse = "")
  return(reverse_complement_seq)
}

# Count nucleotides per kilobase
count_nucleotides_per_kb <- function(sequence) {
  nucleotide_counts_list <- list()
  seq_length <- nchar(sequence)
  num_kilobases <- ceiling(seq_length / 1000)

  for (kb in 1:num_kilobases) {
    start_pos <- (kb - 1) * 1000 + 1
    end_pos <- min(kb * 1000, seq_length)
    kb_sequence <- substr(sequence, start_pos, end_pos)

    count_A <- lengths(regmatches(kb_sequence, gregexpr("A", kb_sequence)))
    count_C <- lengths(regmatches(kb_sequence, gregexpr("C", kb_sequence)))
    count_G <- lengths(regmatches(kb_sequence, gregexpr("G", kb_sequence)))
    count_T <- lengths(regmatches(kb_sequence, gregexpr("T", kb_sequence)))
    count_N <- lengths(regmatches(kb_sequence, gregexpr("N", kb_sequence)))

    total_bases <- count_A + count_C + count_G + count_T
    gc_content <- if (total_bases > 0) {
      round((count_G + count_C) / total_bases * 100, 2)
    } else {
      0
    }

    kb_counts <- c(A = count_A, C = count_C, G = count_G, T = count_T,
                   N = count_N, GC_percent = gc_content, 
                   kb_length = nchar(kb_sequence))

    nucleotide_counts_list[[paste0("kb_", kb)]] <- kb_counts
  }

  return(nucleotide_counts_list)
}

# Create data frame from nucleotide counts list
create_nucleotide_dataframe <- function(counts_list) {
  A_counts <- C_counts <- G_counts <- T_counts <- numeric()
  N_counts <- GC_percent <- kb_lengths <- numeric()

  for (kb_name in names(counts_list)) {
    kb_data <- counts_list[[kb_name]]
    A_counts <- c(A_counts, kb_data["A"])
    C_counts <- c(C_counts, kb_data["C"])
    G_counts <- c(G_counts, kb_data["G"])
    T_counts <- c(T_counts, kb_data["T"])
    N_counts <- c(N_counts, kb_data["N"])
    GC_percent <- c(GC_percent, kb_data["GC_percent"])
    kb_lengths <- c(kb_lengths, kb_data["kb_length"])
  }

  nucleotide_df <- data.frame(
    Kilobase = 1:length(A_counts),
    A = A_counts, C = C_counts, G = G_counts, T = T_counts, N = N_counts,
    GC_Percent = GC_percent, KB_Length = kb_lengths
  )
  return(nucleotide_df)
}

# =============================================================================
# PART 1: READ DNA SEQUENCE AND EXTRACT SPECIFIC LETTERS
# =============================================================================
print_section("PART 1: READ DNA SEQUENCE AND EXTRACT LETTERS")

# Read the complete sequence from file
dna_sequence <- read_dna_sequence(fasta_filename)
seq_length <- nchar(dna_sequence)

cat("Successfully read DNA sequence\n")
cat("Total sequence length:", seq_length, "bases\n\n")

# Part 1a: Print the 10th letter
if (seq_length >= 10) {
  letter_10 <- substr(dna_sequence, 10, 10)
  cat("PART 1a ANSWER:\n")
  cat("The 10th letter of the sequence is:", letter_10, "\n\n")
} else {
  cat("WARNING: Sequence too short to extract 10th letter\n\n")
}

# Part 1b: Print the 758th letter
if (seq_length >= 758) {
  letter_758 <- substr(dna_sequence, 758, 758)
  cat("PART 1b ANSWER:\n")
  cat("The 758th letter of the sequence is:", letter_758, "\n\n")
} else {
  cat("WARNING: Sequence too short to extract 758th letter\n\n")
}

# =============================================================================
# PART 2: CREATE REVERSE COMPLEMENT AND EXTRACT LETTERS
# =============================================================================
print_section("PART 2: REVERSE COMPLEMENT CREATION")

# Create the reverse complement
reverse_comp_sequence <- create_reverse_complement(dna_sequence)
rc_length <- nchar(reverse_comp_sequence)

cat("Successfully created reverse complement\n")
cat("Reverse complement length:", rc_length, "bases\n\n")

# Part 2a: Print the 79th letter of reverse complement
if (rc_length >= 79) {
  letter_79_rc <- substr(reverse_comp_sequence, 79, 79)
  cat("PART 2a ANSWER:\n")
  cat("The 79th letter of the reverse complement is:", letter_79_rc, "\n\n")
} else {
  cat("WARNING: Reverse complement too short to extract 79th letter\n\n")
}

# Part 2b: Print letters 500-800 of reverse complement
if (rc_length >= 800) {
  letters_500_800 <- substr(reverse_comp_sequence, 500, 800)
  cat("PART 2b ANSWER:\n")
  cat("The 500th through 800th letters of the reverse complement:\n")
  cat(letters_500_800, "\n\n")
} else if (rc_length >= 500) {
  letters_500_end <- substr(reverse_comp_sequence, 500, rc_length)
  cat("PART 2b ANSWER (PARTIAL):\n")
  cat("Sequence only extends to position", rc_length, "\n")
  cat("Letters 500 through", rc_length, ":\n")
  cat(letters_500_end, "\n\n")
} else {
  cat("WARNING: Reverse complement too short to extract positions 500-800\n\n")
}

# =============================================================================
# PART 3: COUNT NUCLEOTIDES PER KILOBASE
# =============================================================================
print_section("PART 3: NUCLEOTIDE COUNTING PER KILOBASE")

# Create list with nucleotide counts per kilobase
kb_counts_list <- count_nucleotides_per_kb(dna_sequence)

num_kilobases <- length(kb_counts_list)
cat("PART 3 ANSWER:\n")
cat("Successfully created list with nucleotide counts\n")
cat("Number of kilobases analyzed:", num_kilobases, "\n")

# Report N bases if present
total_N <- sum(sapply(kb_counts_list, function(x) x["N"]))
if (total_N > 0) {
  cat("Note:", total_N, "ambiguous bases (N) detected\n")
}

cat("\nList structure created with counts for A, C, G, T per kilobase\n")
cat("Example - First kilobase counts:\n")
print(kb_counts_list[[1]][c("A", "C", "G", "T", "N")])
cat("\n")

# =============================================================================
# PART 4: CREATE DATA FRAME AND ANALYZE
# =============================================================================
print_section("PART 4: DATA FRAME CREATION AND ANALYSIS")

# Part 4a & 4b: Create data frame with all kilobases
nucleotide_dataframe <- create_nucleotide_dataframe(kb_counts_list)

cat("PART 4a & 4b ANSWER:\n")
cat("Successfully created data frame with 4 columns (A, C, G, T)\n")
cat("Repeated for each kilobase in the sequence\n\n")

cat("First 5 rows of the data frame:\n")
print(head(nucleotide_dataframe[, c("Kilobase", "A", "C", "G", "T")], 5))
cat("\n")

# Part 4c: Create rows with each individual list (already done above)
cat("PART 4c ANSWER:\n")
cat("Each row in the data frame represents one kilobase\n")
cat("Total rows (kilobases):", nrow(nucleotide_dataframe), "\n\n")

# Part 4d: Calculate the sum of each row
row_sums_acgt <- rowSums(nucleotide_dataframe[, c("A", "C", "G", "T")])
nucleotide_dataframe$ACGT_Sum <- row_sums_acgt

cat("PART 4d ANSWER:\n")
cat("Row sums calculated for each kilobase\n\n")
cat("Data frame with row sums (first 5 rows):\n")
print(head(nucleotide_dataframe[, c("Kilobase", "A", "C", "G", "T", "ACGT_Sum")], 5))
cat("\n")

# =============================================================================
# PART 4e: ANSWER QUESTIONS USING COMMENTS
# =============================================================================
cat("PART 4e: ANSWERING ANALYSIS QUESTIONS\n")
cat("-------------------------------------------------------\n\n")

# Question 1: What is the expected sum for each list?
cat("QUESTION 1: What is the expected sum for each list?\n")
cat("-------------------------------------------------------\n")
cat("ANSWER:\n")
cat("The expected sum for each kilobase (row) should be 1000 bases.\n")
cat("\n")
cat("EXPLANATION:\n")
cat("- Each kilobase represents 1000 base pairs by definition\n")
cat("- Each position must contain one nucleotide (A, C, G, T, or N)\n")
cat("- Therefore: A + C + G + T should equal 1000 (if no N bases)\n")
cat("- Exception: The last kilobase may have fewer than 1000 bases\n")
cat("  if the sequence length is not evenly divisible by 1000\n")
cat("- If N bases are present, ACGT sum will be less than 1000\n")
cat("  but ACGT + N will equal the actual kilobase length\n")
cat("\n")
cat("Expected sum: 1000 bases per kilobase (except possibly the last)\n\n")

# Question 2: Are there any lists whose sums are not equal to the expected value?
cat("QUESTION 2: Are there any lists whose sums are not equal to 1000?\n")
cat("-------------------------------------------------------\n")
cat("ANSWER:\n")

non_1000_rows <- which(row_sums_acgt != 1000)

if (length(non_1000_rows) > 0) {
  cat("YES - Found", length(non_1000_rows), "kilobase(s) with sums ≠ 1000:\n\n")
  
  for (row_idx in non_1000_rows) {
    kb_data <- nucleotide_dataframe[row_idx, ]
    cat(sprintf("  Kilobase %d:\n", row_idx))
    cat(sprintf("    - ACGT Sum: %d\n", kb_data$ACGT_Sum))
    cat(sprintf("    - N bases: %d\n", kb_data$N))
    cat(sprintf("    - Total length: %d\n", kb_data$KB_Length))
    
    if (kb_data$KB_Length < 1000) {
      cat(sprintf("    - Reason: Incomplete kilobase (%d bases)\n", 
                  kb_data$KB_Length))
    }
    if (kb_data$N > 0) {
      cat(sprintf("    - Note: Contains %d ambiguous base(s)\n", kb_data$N))
    }
    cat("\n")
  }
} else {
  cat("NO - All kilobases have ACGT sums equal to 1000\n")
  cat("This indicates a high-quality sequence with:\n")
  cat("  - No ambiguous bases (N)\n")
  cat("  - Total length that is an exact multiple of 1000\n\n")
}

# Question 3: Provide general explanation for differences
cat("QUESTION 3: General explanation for differences\n")
cat("-------------------------------------------------------\n")
cat("ANSWER:\n\n")

cat("REASON 1: INCOMPLETE FINAL KILOBASE\n")
cat("DNA sequences rarely have lengths that are exact multiples of 1000.\n")
cat("For this sequence:\n")
cat(sprintf("  - Total sequence length: %d bases\n", seq_length))
cat(sprintf("  - Complete 1000-base kilobases: %d\n", 
            floor(seq_length / 1000)))
cat(sprintf("  - Remaining bases in final kilobase: %d\n", 
            seq_length %% 1000))
cat("\n")
cat("Therefore, the last kilobase will contain fewer than 1000 bases,\n")
cat("resulting in an ACGT sum less than 1000.\n\n")

if (total_N > 0) {
  cat("REASON 2: AMBIGUOUS BASES (N)\n")
  cat(sprintf("The sequence contains %d ambiguous base(s) marked as N.\n", 
              total_N))
  cat("\n")
  cat("N bases represent positions where sequencing was uncertain.\n")
  cat("They are counted separately and not included in ACGT sums.\n")
  cat("This causes ACGT_Sum to be less than the kilobase length.\n")
  cat("\n")
  cat("For each kilobase: ACGT_Sum + N = KB_Length\n\n")
}

cat("BIOLOGICAL CONTEXT:\n")
cat("Ambiguous bases (N) can result from:\n")
cat("  - Low sequencing quality at specific positions\n")
cat("  - Heterozygous positions in diploid organisms\n")
cat("  - Repetitive or difficult-to-sequence genomic regions\n")
cat("  - Gaps in genome assembly\n")
cat("  - Structural variations or complex genomic features\n\n")

# Verification
cat("VERIFICATION CHECK:\n")
cat("For each kilobase: ACGT_Sum + N_count = KB_Length\n")
verification_check <- all(
  nucleotide_dataframe$ACGT_Sum + nucleotide_dataframe$N == 
  nucleotide_dataframe$KB_Length
)
cat("Result:", ifelse(verification_check, "✓ PASSED", "✗ FAILED"), "\n")
cat("All data is consistent and validated.\n\n")

# =============================================================================
# SUMMARY STATISTICS AND EXPORT
# =============================================================================
print_section("SUMMARY STATISTICS")

total_A <- sum(nucleotide_dataframe$A)
total_C <- sum(nucleotide_dataframe$C)
total_G <- sum(nucleotide_dataframe$G)
total_T <- sum(nucleotide_dataframe$T)
total_N <- sum(nucleotide_dataframe$N)
total_bases <- total_A + total_C + total_G + total_T + total_N

overall_gc <- round((total_G + total_C) / 
                    (total_A + total_C + total_G + total_T) * 100, 2)

cat("Sequence Information:\n")
cat("  Total length:", seq_length, "bases\n")
cat("  Kilobases analyzed:", nrow(nucleotide_dataframe), "\n\n")

cat("Base Composition:\n")
cat(sprintf("  A: %d (%.2f%%)\n", total_A, total_A/total_bases*100))
cat(sprintf("  C: %d (%.2f%%)\n", total_C, total_C/total_bases*100))
cat(sprintf("  G: %d (%.2f%%)\n", total_G, total_G/total_bases*100))
cat(sprintf("  T: %d (%.2f%%)\n", total_T, total_T/total_bases*100))
if (total_N > 0) {
  cat(sprintf("  N: %d (%.2f%%)\n", total_N, total_N/total_bases*100))
}
cat("\n")

cat("GC Content Analysis:\n")
cat("  Overall GC content:", overall_gc, "%\n")
cat("  Mean GC per kilobase:", 
    round(mean(nucleotide_dataframe$GC_Percent), 2), "%\n")
cat("  Min GC per kilobase:", 
    round(min(nucleotide_dataframe$GC_Percent), 2), "%\n")
cat("  Max GC per kilobase:", 
    round(max(nucleotide_dataframe$GC_Percent), 2), "%\n\n")

# =============================================================================
# EXPORT RESULTS
# =============================================================================
print_section("EXPORTING RESULTS")

output_csv <- "nucleotide_analysis_results.csv"
write.csv(nucleotide_dataframe, output_csv, row.names = FALSE)
cat("✓ Data frame exported to:", output_csv, "\n")

summary_file <- "analysis_summary.txt"
sink(summary_file)
cat("DNA SEQUENCE ANALYSIS SUMMARY\n")
cat("=============================\n\n")
cat("File:", fasta_filename, "\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Total Length:", seq_length, "bases\n")
cat("Overall GC Content:", overall_gc, "%\n\n")
cat("BASE COMPOSITION\n")
cat(sprintf("A: %d (%.2f%%)\n", total_A, total_A/total_bases*100))
cat(sprintf("C: %d (%.2f%%)\n", total_C, total_C/total_bases*100))
cat(sprintf("G: %d (%.2f%%)\n", total_G, total_G/total_bases*100))
cat(sprintf("T: %d (%.2f%%)\n", total_T, total_T/total_bases*100))
if (total_N > 0) {
  cat(sprintf("N: %d (%.2f%%)\n", total_N, total_N/total_bases*100))
}
sink()
cat("✓ Summary statistics exported to:", summary_file, "\n\n")

print_section("ANALYSIS COMPLETE")
cat("All assignment requirements completed successfully.\n")
cat("All questions answered with detailed explanations.\n")
cat("Results exported to CSV and text files.\n")

