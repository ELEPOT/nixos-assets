for filepath in "$@"
do
    full_filename=$(basename "$filepath")
    unzip -o "$filepath" -d "/home/elepot/.local/share/bottles/bottles/osu/drive_c/users/elepot/AppData/Local/osu!/Songs/${full_filename%.*}"
done

