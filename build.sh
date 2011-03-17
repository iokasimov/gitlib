set -e
if [ ! -d libgit2 ]
then
    echo "Cloning libgit2 from github"
    git clone https://github.com/libgit2/libgit2.git libgit2
fi

echo 
echo "Building and installing libgit2 library"
pushd libgit2
./waf configure
./waf build
./waf test
popd

echo 
echo "Generating bindings"
./create_bindings.rb

echo 
echo "Starting to build haskell bindings"
cabal configure --user --enable-test
cabal build
cabal test
cabal install --user
