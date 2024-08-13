set -ex
IMG="python:3.8"
[ "$1" == "--ru" ] && {
    _RU="_ru"
    IMG="python:3.8-ru"
}

AP=Aleksei_Parfenov${_RU}

[ "$1" == "--inner" ] && {
    shift
    [ "$1" == "--ru" ] && {
        _RU="_ru"
        AP=${AP}${_RU}
        _LOCALE="--locale ru_RU.UTF-8"
    }
    # python -m venv .venv
    . .venv/bin/activate
    # pip install j2y
    # pip install markupsafe==2.0.1
    # exit 0
    python cli.py ${_LOCALE} -f json ${AP}.html.jinja2 -c resume${_RU}.json > ${AP}.html
    python cli.py ${_LOCALE} -f json ${AP}.md.jinja2 -c resume${_RU}.json > ${AP}.md
    cp ${AP}.md readme${_RU}.md
    exit 0
}

docker run -ti --rm \
    -v $PWD:/cdir \
    -w /cdir \
    ${IMG} bash $0 --inner $@

chromium --headless --disable-gpu --no-pdf-header-footer --print-to-pdf=${AP}.pdf ${AP}.html
