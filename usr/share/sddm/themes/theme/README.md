![Screenshot of the interface of the Sugar Dark theme for SDDM](Previews/Mockup.jpg "The default interface of the Sugar Dark theme for SDDM")

# Sugar Dark login theme for SDDM

Sugar is extremely customizable and so sweet it will probably cause you diabetes just from looking at it. Sweeten the login experience for your users, your family and yourself. Sugar is cross platform and all about user experience and functionality.
With those principles in mind Sugar was written completely from scratch making it clean and simple not only by looks but by design too.  
All controls use the **[latest Qt Quick Controls 2](http://doc.qt.io/qt-5/qtquickcontrols2-index.html)** for [increased performance](https://blog.qt.io/blog/2015/03/31/qt-quick-controls-for-embedded/) on low end or even embedded systems and beautiful color transitions.

To learn how to control sugar levels you should check the [Sugar Wiki on Github](https://github.com/MarianArlt/sddm-sugar-light/wiki/Before-you-begin) or the very well documented and included [`theme.conf`](theme.conf).
Here are some previews of nifty variable names you can set/unset/change to customize your sugar:
`ThemeColor`, `Font`, `HourFormat`, `ForceRightToLeft`, `TranslateUsernamePlaceholder`
This is just a teaser. There are 27 customizable variables in total! This sugar will be yours and only yours.  
Sugar comes in two flavors. This one is for the bitter sweet. You can also check out [Sugar Light](https://www.opendesktop.org/p/1272119/).  

### Dependencies

[`sddm >= 0.18.0`](https://github.com/sddm/sddm), [`qt5 >= 5.11.0`](http://doc.qt.io/qt-5/index.html), [`qt5-quickcontrols2 >= 5.11.0`](http://doc.qt.io/qt-5/qtquickcontrols2-index.html), [`qt5-svg >= 5.11.0`](https://doc.qt.io/qt-5/qtsvg-index.html)

*Make sure these are up to date!*

### Installing the theme

###### From KDE Plasma

If you are on [KDE Plasma](https://www.kde.org/plasma-desktop)—by default [openSuse](https://www.opensuse.org/), [Neon](https://neon.kde.org/), [Kubuntu](https://kubuntu.org/), [KaOS](https://kaosx.us/) or [Chakra](https://www.chakralinux.org/) for example—you are lucky and can simply go to your system settings and under "Startup and Shutdown" followed by "Login Screen (SDDM)" click "Get New Theme". From there search for "Sugar Dark" and install.

If for some reason you cannot find the category named "Login Screen (SDDM)" in your system settings then you are missing `sddm-kcm`. Install this little helper with your package manager first. You will be grateful you did.

###### From other desktop environments

[Download the tar archive from openDesktop](https://www.opendesktop.org/p/1272122) and extract the contents to the theme directory of SDDM *(change the path for the downloaded file if necessary)*:
```
$ sudo tar -xzvf ~/Downloads/sugar-dark.tar.gz -C /usr/share/sddm/themes
```
This will extract all the files to a folder called "sugar-dark" inside of the themes directory of SDDM.  

After that you will have to point SDDM to the new theme by editing its config file, preferrably at `/etc/sddm.conf.d/sddm.conf` *(create if necessary)*. You can take the default config file of SDDM as a reference: `/etc/sddm.conf/usr/lib/sddm/sddm.conf.d/sddm.conf`.  

In the `[Theme]` section simply add the themes name: `Current=sugar-dark`. Also see the [Arch wiki on SDDM](https://wiki.archlinux.org/index.php/SDDM).

### Theming the theme

Sugar is extremely customizable by editing its included `theme.conf` file. You can change the colors and images used, the time and date formats, the appearance of the whole interface and even how it works.  
And as if that wouldn't still be enough you can translate every single button and label because SDDM is still lacking behind with localization and clearly [needs your help](https://github.com/sddm/sddm/wiki/Localization)!

Please read the [Sugar Wiki on Github](https://github.com/MarianArlt/sddm-sugar-light/wiki/Before-you-begin) for a detailed description of every variable available, what it does and the values it accepts. The `theme.conf` itself is also very well commented for you to get right at it.

### Legal Notice

Copyright (C) 2018 Marian Arlt.  

Sugar Dark is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.  

Sugar Dark is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.  

You should have received a copy of the GNU General Public License along with Sugar Dark. If not, see <https://www.gnu.org/licenses/>.

[Mockup psd created by Qeaql-studio - Freepik.com](https://www.freepik.com/free-photos-vectors/mockup)

### Other awesome projects

- [Chili—the hottest login theme for KDE Plasma](https://www.opendesktop.org/p/1214121)
- [Chili stand-alone fork for SDDM only](https://www.opendesktop.org/p/1240784)
- [Flat OSX like aurorae window decorations for your Linux desktop](https://www.opendesktop.org/p/1199822) and [its high contrast version](https://www.opendesktop.org/p/1246756)
- [Finely crafted folder icons for Linux](https://www.opendesktop.org/p/1228310)
- [Inline clock widget for KDE Plasma](https://www.opendesktop.org/p/1245902)

### Motivate a developer

In the past years I have spent quite some hours on open source projects. If you are the type of person who digs attention to detail, know how much work is involved in it and/or simply likes to support makers with a coffee or a beer I would greatly appreciate your donation on my [PayPayl](https://www.paypal.me/marianarlt) account.  
Alternatively downloading my themes directly from opendesktop or with the kde sddm system settings module will at least help me a little to be able to attend your issues and requests.  
Please consider helping developers you think are worth a penny or two, literally.
