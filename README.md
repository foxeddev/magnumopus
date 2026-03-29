# Minecraft Beet project template

A pre-configured GitHub template to quickly set up your [Beet](https://www.github.com/mcbeet/beet) project.

## Features

- Premade VSCode task for automated Beet project building

- Support for [Bolt](https://github.com/mcbeet/bolt)

- Beet plugin for pack installation and uninstallation functions and advancements

- GitHub Workflow for automated error detection

- `.gitignore` template for Beet, Python, and Visual Studio Code

- Beet plugin for inline function tag support

- Multiplayer / Server support

## Installation

1. Click "Use this template" on GitHub to create a new repository on your GitHub account.

2. Clone your new repository to your device with

   ```sh
   git clone https://github.com/<your-username>/<your-repository>.git
   ```

3. Install Python and the [Python requirements](requirements.txt) using

   ```sh
   pip install -r requirements.txt
   ```

   > This should be done automatically if you are using VSCode.

4. Update the [beet.json](beet.json) to use your project's name, description and author.

5. Link Beet to your Minecraft installation with

   ```sh
   beet link --data-pack <path to your data pack folder>
   ```

**Done!** You can now add your custom functions, textures, and other assets.

## Usage

Build and update your project automatically using Beet:

```sh
beet watch
```

If you are using VSCode, this should be done automatically.

Reload the datapack in-game with

```mcfunction
/reload
```

## License

This project is licensed under [MIT License](LICENSE).
