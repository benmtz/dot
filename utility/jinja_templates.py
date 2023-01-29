def hex_to_rgb(hex: str):
    trimmed =  hex.replace("#","")
    return f"{int(trimmed[0:1], 16)},{int(trimmed[2:3],16)},{int(trimmed[4:5],16)}"


