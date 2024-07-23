set -ex
# docker run --rm \
#        --volume "$(pwd):/data" \
#        --user $(id -u):$(id -g) \
#        pandoc/latex Aleksei_Parfenov.html -o Aleksei_Parfenov.pdf
AP=Aleksei_Parfenov

[ "$1" == "--inner" ] && {
    # python -m venv .venv
    . .venv/bin/activate
    # pip install j2y
    # pip install markupsafe==2.0.1
    # exit 0
    python cli.py -f json ${AP}.html.jinja2 -c resume.json > ${AP}.html
    python cli.py -f json ${AP}.md.jinja2 -c resume.json > ${AP}.md
    cp ${AP}.md readme.md
    exit 0
}

docker run -ti --rm \
    -v $PWD:/cdir \
    -w /cdir \
    python:3.8 bash $0 --inner

chromium --headless --disable-gpu --no-pdf-header-footer --print-to-pdf=${AP}.pdf ${AP}.html
