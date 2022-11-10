<h1 align=center>Sakura Dotfiles</h1>

<img src="src/thumbnail.png" alt="img" align="right" width="500px">

This is my desktop made with awesomewm! Here's some details:

- **Operating System** - endeavouros
- **Window Manager** - awesomewm
- **File Manager** - nautilus
- **Browser** - librewolf
- **Terminal** - st
- **Shell** - bash
- **Editor** - vim

## Installation

<details>
<summary><b>Arch-based</b></summary>

### Arch

Using archinstall (relevant options):

- User account - Create a user with sudo access
- Profile - `xorg`
- Audio - `pipewire`
- Additional packages - `git`

### EndeavourOS

Install a minimal system without a desktop environment.

### After System Installation

```
$ git clone https://github.com/stardust-kyun/dotfiles ~/dotfiles
$ cd ~/dotfiles
$ ./install.sh

# Install with log
$ script -c ./install.sh ~/dotfiles-log.txt 
```

</details>

Other distributions are not yet supported and may be added in the future.

## Screenshots

<details>
<summary><b>Expand for images!</b></summary>

### Terminal
![terminal](src/terminal.png)

### Graphical
![graphical](src/graphical.png)

### Widget
![widget](src/widget.png)

### Browser
![browser](src/browser.png)

### Launcher
![launcher](src/launcher.png)

</details>

## Contributions

- [Qwickdom](https://github.com/Qwickdom) for help adding brightness support and an installation script.
- [Crylia](https://github.com/Crylia) for massive amounts of help learning awesomewm.
- [Sammy](https://github.com/TorchedSammy) for helping me learn awesomewm's widget system.
- [Jimmy](https://github.com/Jimmysit0) and [Petrolblue](https://github.com/petrolblue) for help with color schemes and lots of support.

### And some projects I used

- [Siduck's st](https://github.com/siduck76/st) for my personal choice of terminal.
- [DmgBlue](https://github.com/davidmogar/lightdm-webkit2-dmg_blue), which I based my greeter on.
- [Materia](https://github.com/nana-4/materia-theme), which I based my gtk themes on.
- [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme), which I based my icon themes on.

## Contact

You can find me on discord at `Stardust-kyun#5994` and matrix at `stardust-kyun:matrix.org`.
