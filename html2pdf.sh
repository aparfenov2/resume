# docker run --rm \
#        --volume "$(pwd):/data" \
#        --user $(id -u):$(id -g) \
#        pandoc/latex Aleksei_Parfenov.html -o Aleksei_Parfenov.pdf
AP=Aleksei_Parfenov
python cli.py -f json ${AP}.html.jinja2 -c resume.json > ${AP}.html
python cli.py -f json ${AP}.md.jinja2 -c resume.json > ${AP}.md
cp ${AP}.md readme.md
chromium --headless --disable-gpu --no-pdf-header-footer --print-to-pdf=${AP}.pdf ${AP}.html
