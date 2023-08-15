from typing import Any, Dict


def flatten_dict_with_dots(dc: Dict[str, Any], prefix: str = ""):
    result = {}
    for key, value in dc.items():
        target_key = f"{key}" if not prefix else f"{prefix}.{key}"
        if type(value) is dict:
            result.update(flatten_dict_with_dots(value, prefix=target_key))
        else:
            result[target_key] = value
    return result
