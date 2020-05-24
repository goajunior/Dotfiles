import shutil
import os


def main():
    """TODO: Docstring for main.
    :returns: TODO

    """
    user_directory = os.path.expanduser('~')

    shutil.copy2(os.path.join(user_directory, '.zshrc'), 'zshrc', )

    shutil.copy2(os.path.join(user_directory, '.ackrc'), 'ackrc', )

    command_copy = 'cp -Rv ~/.config/nvim/ config'
    os.system(command_copy)

    command_copy = 'cp -Rv ~/.config/i3/ config'
    os.system(command_copy)

    command_copy = 'cp -Rv ~/.config/kitty/ config'
    os.system(command_copy)

    command_copy = 'cp -Rv ~/.config/mpd/ config'
    os.system(command_copy)

    command_copy = 'cp -Rv ~/.config/mpv/ config'

    command_copy = 'cp -Rv ~/.config/polybar/ config'
    os.system(command_copy)

    command_copy = 'cp -Rv ~/.config/rofi/ config'
    os.system(command_copy)

    command_copy = 'cp -Rv ~/.config/rofimenu/ config'
    os.system(command_copy)

    command_copy = 'cp -v ~/.local/bin/finder.sh scripts'
    os.system(command_copy)

    command_copy = 'cp -v ~/.local/bin/git_jumper scripts'
    os.system(command_copy)

    command_copy = 'cp -v ~/.local/bin/setbg scripts'
    os.system(command_copy)


if __name__ == "__main__":
    main()
