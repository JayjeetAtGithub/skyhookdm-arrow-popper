# skyhookdm-arrow-popper


Instructions for building and testing SkyhookDM arrow with Popper on the local machine.

* Clone the [uccross](https://github.com/uccross) fork of Arrow.
```
git clone --branch rados-dataset-dev https://github.com/uccross/arrow
cd arrow/
```

* Install the [Popper](https://getpopper.io) workflow engine.
```
pip install popper
```

* Clone the Popper workflow into the Arrow root.
```
git clone https://github.com/JayjeetAtGithub/skyhookdm-arrow-popper .
```

* Running the below command will put you inside a container, with the `$PWD` folder bind-mounted to `/workspace` inside the container.
Here the Arrow root will be mounted in the workspace.
```
popper sh -f wf.yml test
```

* Now, build and install the C++ and Python libraries by executing this script.
```
./build.sh
```

* Finally, run this example Python script to write objects and run queries interactively.
```
python3 code.py
```
