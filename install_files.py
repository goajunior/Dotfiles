import shutil
import os
import glob


def recursive_copy(src, dst):
    """
    funcao que copia recursivamente os arquivos do diretorio fonte (src) para o
    diretorii destino dst
    """

    os.system('cd ' + src)
    command_copy = 'cd config ;cp -Rv ' + '.' + ' ' + dst
    print(command_copy)

    os.system(command_copy)


def main():
    """TODO: Docstring for main.
    :returns: TODO

    """
    user_directory = os.path.expanduser('~')

    path_config = os.path.join(user_directory, '.config')
    path_scripts = os.path.join(user_directory, '.local/bin')

    current_directory = os.getcwd()
    src_config = current_directory + '/config/'

    recursive_copy(src_config, path_config)

    for files in glob.glob(os.path.join(os.getcwd(), 'scripts/*')):  # glob permite o uso de wildcards
        shutil.copy2(files, path_scripts)

    shutil.copy2('zshrc', os.path.join(user_directory, '.zshrc'))

    shutil.copy2('ackrc', os.path.join(user_directory, '.ackrc'))


if __name__ == "__main__":
    main()
