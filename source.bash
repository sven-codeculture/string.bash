while read filename; do
    source "${filename}"
done < <(find $STRINGBASH_HOME/src -name '*.bash')
