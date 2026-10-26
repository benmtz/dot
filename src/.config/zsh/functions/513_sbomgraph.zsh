registr add sbomgraph "Render a CycloneDX SBOM as a graph image in the terminal" "sbomgraph build/bom.cdx.json"
function sbomgraph() {
    if [[ $# -lt 1 ]]; then
        echo "usage: sbomgraph <cdx.json>"
        return 1
    fi

    local dot_file png_file
    dot_file=$(mktemp --suffix=.dot)
    png_file=$(mktemp --suffix=.png)

    sbom2dot -i "$1" -o "$dot_file" \
        && dot -Tpng "$dot_file" -o "$png_file" \
        && chafa "$png_file"

    rm -f "$dot_file" "$png_file"
}
