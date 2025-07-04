#!/bin/bash

# Global variables
SCRIPT_NAME="Hello Bash Script"
OUTPUT_DIR="output"
LOGS_DIR="logs"

# Function to print greeting message
print_greeting() {
    echo "Hello from Bash!"
}

# Function to get current date and time
get_current_datetime() {
    date
}

# Function to count regular files in output directory
count_files_in_output() {
    local file_count
    if [ -d "$OUTPUT_DIR" ]; then
        file_count=$(find "$OUTPUT_DIR" -maxdepth 1 -type f | wc -l)
    else
        file_count=0
    fi
    echo "Number of regular files in $OUTPUT_DIR directory: $file_count"
}

# Function to create log file with timestamp
create_log_file() {
    local log_filename="$1"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    
    # Use provided filename or default timestamp-based filename
    if [ -z "$log_filename" ]; then
        log_filename="log-${timestamp}.txt"
    fi
    
    local log_path="$LOGS_DIR/$log_filename"
    
    # Create logs directory if it doesn't exist
    mkdir -p "$LOGS_DIR"
    
    # Create log file with all output
    {
        echo "=== $SCRIPT_NAME Log ===" 
        echo "Timestamp: $(date)"
        echo ""
        print_greeting
        echo ""
        echo "Current date and time:"
        get_current_datetime
        echo ""
        count_files_in_output
    } > "$log_path"
    
    echo "Log file created: $log_path"
}

# Main execution function
main() {
    local log_filename="$1"
    
    echo "=== $SCRIPT_NAME ==="
    echo ""
    
    # Execute main tasks
    print_greeting
    echo ""
    
    echo "Current date and time:"
    get_current_datetime
    echo ""
    
    count_files_in_output
    echo ""
    
    # Create log file
    create_log_file "$log_filename"
}

# Execute main function with all arguments
main "$@"