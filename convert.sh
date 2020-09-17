fileName=${@%.*}

cd images
for f in *; do
  docker run --rm -v `pwd`:/latex sotetsuk/platex extractbb -x $f
done
cd ../

docker run --rm -v `pwd`/:/latex/ sotetsuk/platex build "$@"

if [ "${2}" != "travis" ]; then
    echo "remove"
    rm -f ${fileName}.aux
    rm -f ${fileName}.dvi
    rm -f ${fileName}.synctex.gz
    rm -f ${fileName}.log
fi

