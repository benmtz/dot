import os
from typing import Literal, Optional

def get_current_os() -> Optional[Literal["termux","linux","macos"]]:
    if os.getenv("TERMUX_VERSION"):
        return "termux"
    else:
        return "linux"



