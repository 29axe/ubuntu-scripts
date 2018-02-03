file="/home/$USER/.bash_aliases"
if [ -f "$file" ]
then
echo "File already exists."
echo "Backing up existing file.."
bk_file=$file".backup.$(date +%Y%m%d-%H%M%S)"
mv $file $bk_file
echo "Backup file: $bk_file"
fi
echo "Copying new file."
cp .bash_aliases $file
echo "Aliases file successfuly updated."
