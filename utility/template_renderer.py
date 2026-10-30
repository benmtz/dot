import platform
import shutil
from typing import Any

from jinja2 import Environment, PackageLoader, select_autoescape

from utility.jinja_templates import hex_to_rgb

globs = {
    "platform": platform.system()
}
filters = {
    "hex_to_rgb": hex_to_rgb
}

class TemplateRenderer:
    def __init__(self):
        self.env = Environment(
            variable_start_string="{<",
            variable_end_string=">}",
            block_start_string="<%",
            block_end_string="%>",
            comment_start_string="{!",
            comment_end_string="!}",
        )

        for g_key in globs:
            print(f"Injecting {g_key}:{globs[g_key]} into globals")
            self.env.globals[g_key] = globs[g_key]

        for f_key in filters:
            print(f"Injecting {f_key}:{filters[f_key]} into filters")
            self.env.filters[f_key] = filters[f_key]


    def render(
        self,
        src: str,
        dest: str,
        values: Any
    ):
        try:
            with open(src, encoding="utf-8") as file:
                output = self.env.from_string(file.read()).render(values)
        except UnicodeDecodeError:
            shutil.copyfile(src, dest)
            shutil.copymode(src, dest)
            return

        with open(dest, "w") as f:
            f.write(output)

        shutil.copymode(src, dest)

