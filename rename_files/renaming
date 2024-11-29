RENAME FILE by REMOVING spec. string					
====================================
		#!/bin/bash

		# Loop through all files in the current directory
		  for file in *; do
    	# Check if the file name contains '_1_val' or '_2_val'
    	  if [[ "$file" == *"_1_val"* || "$file" == *"_2_val"* ]]; then
        # Remove '_1_val' or '_2_val' from the file name
          new_name="${file//_1_val/}"
          new_name="${new_name//_2_val/}"
        # Rename the file, keeping the rest of the name intact
          mv "$file" "$new_name"
          echo "Renamed: $file -> $new_name"
    	fi
		done

		echo "All matching files have been renamed."					
		
`Filename Matching:` The script checks if a file name contains *_1_val* or *_2_val* using `if [[ "$file" == *"_1_val"* || "$file" == *"_2_val"* ]];`
`Substring Removal:` It removes the exact substrings *_1_val* and *_2_val* using parameter substitution:
 					
					${file//_1_val/} removes _1_val.
					${new_name//_2_val/} removes _2_val.
					
Make it executable:

				chmod +x rename_files.sh
				
Run the script in the directory with the files:
		
				./rename_files.sh
