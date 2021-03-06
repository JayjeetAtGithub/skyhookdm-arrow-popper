#!/bin/bash
set -e
 
# install the C++ library.
cd cpp
mkdir -p debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug \
        -DARROW_CLS=ON \
        -DARROW_PARQUET=ON \
        -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DARROW_PYTHON=ON \
        -DARROW_BUILD_TESTS=ON \
        -DARROW_DATASET=ON \
        -DARROW_CSV=ON \
        ..
make -j4 install
cp -r /root/dist/lib/. /usr/local/lib
cp -r /root/dist/include/. /usr/local/include

# run C++ unit and integration tests
cp ./debug/libcls_arrow* /usr/lib64/rados-classes/
curl https://gist.githubusercontent.com/JayjeetAtGithub/14580714706493a239082d6d93b22fc8/raw/ffe1219e49367a48729895a8e5a085d2f862d112/micro-osd.sh -o micro-osd.sh
chmod +x micro-osd.sh
./micro-osd.sh test-cluster /etc/ceph
./debug/arrow-dataset-dataset-rados-test
./debug/arrow-cls-cls-arrow-test

# build Python extensions
cd ../../python
pip3 install -r requirements-build.txt -r requirements-test.txt
python3 setup.py build_ext --inplace --bundle-arrow-cpp bdist_wheel
pip3 install dist/*.whl
python3 -c "import pyarrow"
