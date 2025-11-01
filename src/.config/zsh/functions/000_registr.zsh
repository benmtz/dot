# registr - A function registry for documenting shell functions
# Stores function metadata in memory (session-only)

# Initialize associative arrays for registry data
typeset -gA REGISTR_DESCRIPTIONS
typeset -gA REGISTR_EXAMPLES

registr() {
    case "$1" in
        add)
            if [[ $# -lt 4 ]]; then
                echo "Usage: registr add <function_name> <description> <example>"
                return 1
            fi
            
            local func_name="$2"
            local description="$3"
            local example="$4"
            
            # Store in associative arrays
            REGISTR_DESCRIPTIONS[$func_name]="$description"
            REGISTR_EXAMPLES[$func_name]="$example"
            
            ;;
            
        list)
            if [[ ${#REGISTR_DESCRIPTIONS[@]} -eq 0 ]]; then
                echo "No functions registered yet"
                return 0
            fi
            
            # List all registered functions with aligned columns
            column -t -s '|' <(
                for func_name in ${(k)REGISTR_DESCRIPTIONS}; do
                    echo "$func_name | ${REGISTR_DESCRIPTIONS[$func_name]} | ${REGISTR_EXAMPLES[$func_name]}"
                done | sort
            )
            ;;
            
        *)
            echo "Usage: registr {add|list}"
            echo "  add <function_name> <description> <example> - Register a function"
            echo "  list - List all registered functions"
            return 1
            ;;
    esac
}