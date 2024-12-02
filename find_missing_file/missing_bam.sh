#!/bin/bash

set -euo pipefail

# Global variables
INPUT_FILE="/Users/gyongyosilab/Documents/ccfDNA_Projekt/RAW_Data/SampleAllocationP2023-126-MET-LB.txt" # Path to the file containing IDs in the first column
BAM_DIR="/Users/gyongyosilab/Documents/ccfDNA_Projekt/input_test/trimmed_mapped/" # Path to the directory containing .bam files

# Function to validate the input file
validate_input_file() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        printf "Error: Input file '%s' not found\n" "$file" >&2
        return 1
    fi
}

# Function to extract unique IDs from the first column of the input file
extract_ids() {
    local file="$1"

    local ids
    ids=$(awk '{print $1}' "$file" | sort -u)
    if [[ -z "$ids" ]]; then
        printf "Error: No IDs found in file '%s'\n" "$file" >&2
        return 1
    fi

    printf "%s\n" "$ids"
}

# Function to check for missing BAM files
find_missing_bams() {
    local ids="$1"
    local bam_dir="$2"

    if [[ ! -d "$bam_dir" ]]; then
        printf "Error: BAM directory '%s' not found\n" "$bam_dir" >&2
        return 1
    fi

    local id
    local bam_file
    while IFS= read -r id; do
        bam_file="${bam_dir}/${id}.bam"
        if [[ ! -f "$bam_file" ]]; then
            printf "Missing BAM file: %s\n" "$bam_file"
        fi
    done <<< "$ids"
}

# Main function
main() {
    # Validate input file
    if ! validate_input_file "$INPUT_FILE"; then
        return 1
    fi

    # Extract IDs
    local ids
    if ! ids=$(extract_ids "$INPUT_FILE"); then
        return 1
    fi

    # Check for missing BAM files
    if ! find_missing_bams "$ids" "$BAM_DIR"; then
        return 1
    fi
}

main "$@"
