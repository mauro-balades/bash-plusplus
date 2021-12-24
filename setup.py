import os
from setuptools import setup

# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...
def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()


with open("bashpp/__init__.py") as f:
    info = {}
    for line in f.readlines():
        if line.startswith("VERSION"):
            exec(line, info)
            break


setup(
    name="bashpp",
    version="0.0.0",
    author="",
    author_email="",
    description="",
    license="BSD",
    keywords="example documentation tutorial",
    url="https://github.com/mauro-balades/bash-plusplus",
    packages=["bashpp"],
    entry_points={
        "console_scripts": [
            "bashpp=bashpp.main:main",
        ]
    },
    install_requires=["click"],
    long_description=read("README.md"),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Topic :: Utilities",
        "License :: OSI Approved :: BSD License",
    ],
)
