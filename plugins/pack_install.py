__all__ = [
    "PackInstallOptions",
    "pack_install",
]

from typing import Optional
from beet import Context, Advancement, Function, PluginOptions, configurable
from beet.core.utils import JsonDict, TextComponent, normalize_string


class PackInstallOptions(PluginOptions):
    icon: JsonDict = {"id": "minecraft:apple"}
    author_namespace: Optional[str] = None
    author_description: str = ""
    author_skull_owner: Optional[str] = None
    project_namespace: Optional[str] = None
    project_advancement_path: Optional[str] = None

    pack_namespace: Optional[str] = None
    advancement_path: Optional[str] = None
    install_function_path: Optional[str] = None
    install_function_tag: Optional[str] = None
    uninstall_function_path: Optional[str] = None
    uninstall_function_tag: Optional[str] = None
    send_success_messages: bool = False
    send_error_messages: bool = True


def beet_default(ctx: Context):
    ctx.require(pack_install)


@configurable(validator=PackInstallOptions)
def pack_install(ctx: Context, opts: PackInstallOptions):
    author_namespace = opts.author_namespace or normalize_string(ctx.project_author)
    project_namespace = opts.project_namespace or ctx.project_id
    skull_owner = opts.author_skull_owner or ctx.project_author
    project_advancement_path = (
        opts.project_advancement_path or f"{project_namespace}:install"
    )
    namespace = opts.pack_namespace or normalize_string(ctx.project_id)
    install_function_path = opts.install_function_path or f"{namespace}:install"
    install_function_tag = opts.install_function_tag or f"#{namespace}:install"
    uninstall_function_path = opts.uninstall_function_path or f"{namespace}:uninstall"
    uninstall_function_tag = opts.uninstall_function_tag or f"#{namespace}:uninstall"

    # Advancements
    if not ctx.data.advancements.get("global:root"):
        ctx.data.advancements["global:root"] = create_root_advancement()
    if not ctx.data.advancements.get(f"global:{author_namespace}"):
        ctx.data.advancements[f"global:{author_namespace}"] = create_author_advancement(
            ctx.project_author, opts.author_description, skull_owner
        )
    if not ctx.data.advancements.get(project_advancement_path):
        ctx.data.advancements[project_advancement_path] = create_project_advancement(
            ctx.project_name,
            ctx.project_description,
            author_namespace,
            opts.icon,
            install_function_path,
        )

    # Functions
    if not ctx.data.functions.get(install_function_path):
        ctx.data.functions[install_function_path] = Function()
    ctx.data.functions[install_function_path].prepend(
        create_install_function(
            ctx,
            install_function_tag,
            opts.send_success_messages,
            opts.send_error_messages,
        )
    )
    if not ctx.data.functions.get(uninstall_function_path):
        ctx.data.functions[uninstall_function_path] = Function()
    ctx.data.functions[uninstall_function_path].prepend(
        create_uninstall_function(
            ctx,
            uninstall_function_tag,
            opts.send_success_messages,
            opts.send_error_messages,
        )
    )


##  Advancements


def create_root_advancement():
    return Advancement(
        {
            "display": {
                "title": "Installed Datapacks",
                "description": "",
                "icon": {"id": "minecraft:knowledge_book"},
                "background": "minecraft:block/gray_concrete",
                "show_toast": False,
                "announce_to_chat": False,
            },
            "criteria": {"trigger": {"trigger": "minecraft:tick"}},
        }
    )


def create_author_advancement(
    author: TextComponent, author_description: TextComponent, skull_owner: str
):
    return Advancement(
        {
            "display": {
                "title": author,
                "description": author_description,
                "icon": {
                    "id": "minecraft:player_head",
                    "components": {"minecraft:profile": {"name": skull_owner}},
                },
                "show_toast": False,
                "announce_to_chat": False,
            },
            "parent": "global:root",
            "criteria": {"trigger": {"trigger": "minecraft:tick"}},
        }
    )


def create_project_advancement(
    project_name: TextComponent,
    project_description: TextComponent,
    author_namespace: str,
    icon: JsonDict,
    install_function_path: str,
):
    return Advancement(
        {
            "display": {
                "title": project_name,
                "description": project_description,
                "icon": icon,
                "announce_to_chat": False,
                "show_toast": False,
            },
            "parent": f"global:{author_namespace}",
            "criteria": {"trigger": {"trigger": "minecraft:tick"}},
            "rewards": {"function": install_function_path},
        }
    )


## Functions


def create_install_function(
    ctx: Context, function_tag: str, success_messages: bool, error_messages: bool
):
    f = Function()
    if error_messages:
        f.append(
            f'execute unless function {function_tag} run return run tellraw @a {{"text":"Error: Could not install {ctx.project_name}","color":"red"}}'
        )
    else:
        f.append(f"function {function_tag}")
    if success_messages:
        f.append(
            f'tellraw @a {{"text":"Successfully installed {ctx.project_name}!","color":"green"}}'
        )
    return f


def create_uninstall_function(
    ctx: Context, function_tag: str, success_messages: bool, error_messages: bool
):
    f = Function()
    if error_messages:
        f.append(
            f'execute unless function {function_tag} run return run tellraw @a {{"text":"Error: Could not uninstall {ctx.project_name}","color":"red"}}'
        )
    else:
        f.append(f"function {function_tag}")
    if success_messages:
        f.append(
            f'tellraw @a {{"text":"Successfully uninstalled {ctx.project_name}!","color":"green"}}'
        )
    f.append(
        f'datapack disable "file/{ctx.project_id}_{ctx.project_version}_data_pack"'
    )
    f.append(
        f'datapack disable "file/{ctx.project_id}_{ctx.project_version}_data_pack.zip"'
    )

    return f
