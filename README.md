# skyhookdm-arrow-popper


Instructions for building and testing SkyhookDM arrow with Popper on the local machine.

* Clone uccross fork of Arrow.
```
git clone --branch rados-dataset-dev https://github.com/uccross/arrow
cd arrow/
```

* Install Popper
```
pip install popper
```

* Clone the Popper workflow.
```
git clone https://github.com/JayjeetAtGithub/skyhookdm-arrow-popper .
```

* Interactively build, install, and run the C++ and Python APIs.
```
popper sh -f wf.yml test

# build and install the C++ and Python libraries.
./build.sh

# writing objects and running queries interactively.
python3 code.py
```
