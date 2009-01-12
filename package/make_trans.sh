#!/bin/sh

# Usage:
# ${1} : name of the package
# ${2} : pattern for scour codes
function refresh_po_files() {

        local _lang _package _pattern
        _package = ${1}
        _pattern = ${2}

        # generate the scout.pot
        xgettext --language=Python --keyword=_ --output=i18n/${_package}.pot ${_pattern}
        # generate the scout.po
        msgen i18n/${_package}.pot > i18n/${_package}.po
        # generate a new scout.po for all of langs
        #for dir in $(find i18n/ -maxdepth 1 -type 'd'); do
        for dif in 'i18n/cs'; do
            _lang=${dir##*/}
            [[ -z ${_lang} ]] && continue;
            msgmerge  i18n/${_lang}/LC_MESSAGES/${_package}.po i18n/${_package}.pot > ${_package}.${lang}.po
            mv ${_package}.${lang}.po i18n/${lang}/LC_MESSAGES/${_package}.po
        done
}

function refresh_mo_files() {
        #for dir in $(find i18n/ -maxdepth 1 -type 'd'); do
        for dif in 'i18n/cs'; do
            lang=${dir##*/}
            [[ -z ${lang} ]] && continue;
            msgfmt -cv i18n/${lang}/LC_MESSAGES/${_package}.po -o i18n/${lang}/LC_MESSAGES/${_package}.mo
        done
}

refresh_po_files
