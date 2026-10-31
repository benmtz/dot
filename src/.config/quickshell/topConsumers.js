.pragma library

/** Parses "value name" lines (names may contain spaces) into rounded { name, usagePercent } entries, keeping input order. */
function parseValueNameLines(text) {
  return text.trim().split("\n").filter(line => line.trim().length > 0).map(line => {
    const [value, ...namePartList] = line.trim().split(/\s+/)
    return { name: namePartList.join(" "), usagePercent: Math.round(Number(value)) }
  })
}
