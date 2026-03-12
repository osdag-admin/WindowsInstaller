import os
import shutil
import subprocess
from distutils.dir_util import copy_tree
import importlib

def Path(name):
    """Check whether `name` is on PATH and marked as executable."""

    # from whichcraft import which
    from shutil import which

    return which(name)

path=Path('tex')
if path is not None:
        path=path[:-22]
        print(path)
        src = './packages/'
        copy_tree(src, path)

subprocess.call("ref_latex.bat")
