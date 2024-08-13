bash ./gen_en.sh --ru
exit 0
AP=Aleksei_Parfenov_ru
python cli.py -f json ${AP}.html.jinja2 -c resume_ru.json > ${AP}.html
python cli.py -f json ${AP}.md.jinja2 -c resume_ru.json > ${AP}.md
cp ${AP}.md readme_ru.md
chromium --headless --disable-gpu --no-pdf-header-footer --print-to-pdf=${AP}.pdf ${AP}.html
