import os
from typing import Literal, Optional
from sys import platform

def get_current_os() -> Optional[Literal["termux","linux","macos"]]:
    if os.getenv("TERMUX_VERSION"):
        return "termux"
    elif platform == "darwin":
        return "macos"
    else:
        return "linux"



