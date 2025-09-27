sed 's/),[[:space:]]*/)\n/g' \
| awk '{
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0);                 # trim
    if (length($0)==0) next;
    if (match($0,/cfg_blk_index[[:space:]]*->[[:space:]]*([0-9]+)/,m))
        printf "%09d|%s\n", m[1], $0;                            # key|line
}' \
| sort -t'|' -k1,1n \
| cut -d'|' -f2- \
| uniq
