#!/bin/bash

set -euo pipefail

# Global variables
BAM_DIR="."               # Directory containing BAM files (current directory by default)
OUTPUT_FILE="flagstat.txt" # Output file for the consolidated flagstat report

# Function to run flagstat for each BAM file
generate_flagstat_reports() {
    local bam_dir="$1"
    local output_file="$2"

    # Ensure the output file is empty or create it
    : > "$output_file"

    # Iterate over BAM files in the directory
    local bam_file
    for bam_file in "$bam_dir"/*.bam; do
        if [[ -f "$bam_file" ]]; then
            printf "=== Flagstat Report for %s ===\n" "$(basename "$bam_file")" >> "$output_file"
            if ! samtools flagstat -@ 22 "$bam_file" >> "$output_file"; then
                printf "Error: Failed to generate flagstat for '%s'\n" "$bam_file" >&2
                continue
            fi
            printf "\n" >> "$output_file"
        fi
    done
}

# Main function
main() {
    generate_flagstat_reports "$BAM_DIR" "$OUTPUT_FILE"
    printf "Flagstat reports written to: %s\n" "$OUTPUT_FILE"
}

main "$@"
