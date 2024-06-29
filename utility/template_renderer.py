import platform
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
        self.env = Environment()

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
        with open(src) as file:

            output = self.env.from_string(file.read()).render(values)

            with open(dest.replace(".j2", ""), 'w') as f:
                f.write(output)
                f.close()

