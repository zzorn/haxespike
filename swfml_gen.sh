#!/bin/bash

# Script to generate resource files and sources from images,
# by Colin Lieberman, http://www.cactusflower.org/learning-flash-with-haxe
# with corrections from Sergey.
# Preliminary audio support and other modifications by zzorn.
# LibraryIndex by zzorn.

if [[ -z $1 ]]; then
    echo "first arg is path of resource dir"
    exit 1
fi

src_dir="src/generated"

mkdir -p $src_dir

class_file="$src_dir/LibraryClasses.hx"
index_file="$src_dir/LibraryIndex.hx"


#escape * so it doesn't try to sub with file names in local dir
# Ignore hidden files
gfx=`find $1 -name [^~.]\*.png -or -name \*.jpg`
audio=`find $1 -name [^~.]\*.mp3`
swfs=`find $1 -name [^~.]\*.swf`
fonts=`find $1 -name [^~.]\*.ttf`

if [[ -z $gfx && -z $audio && -z $fonts && -z $swfs ]]; then
    echo "no matching files found in $1"
    exit 1
fi

#function to upcase first letter
function up_first
{
    #TODO: take an arg instead of only reading from pipe
    while read line; do
        first=`echo $line | sed -e 's/^\(.\).*$/\1/'`
        first_up=`echo $first | tr '[a-z]' '[A-Z]'`
        echo `echo $line | sed -e "s/^$first/$first_up/"`
    done
}

# escape slashes is dir paths for use in regexes
function escape_dir
{
    if [[ -z $1 ]]; then
        while read line; do
            echo `echo $line | sed -e 's/\//\\\\\//g'`
        done;
    else
        echo `echo $1 | sed -e 's/\//\\\\\//g'`
    fi
}

# generate unique id by replace / and . in filenames with _
# it's unique because it's namespaced with directory names
function make_id
{
    #replace / with _ in file names so i can use base as regex
    #this will still have the trailing / from find, so get rid of it
    base_name=`echo "$1/" | sed -e "s/\//\_/g"`
    file_name=`echo "$2" | sed -e "s/\//\_/g"`
    
    #always upcase the first char of the file name
    echo "$file_name" | sed -e "s/$base_name//" | sed -e "s/\./\_/g" | up_first 
}

#get a file path with the extra / removed after the dir that we did find on
function clean_base_dir
{
    #remove trailing / and escape for use in regex
    clean_base=`echo "$1" | sed -e "s/\/$//" | escape_dir`
    #escape original for use in regex
    old_base=`escape_dir $1`
    echo "$2" | sed -e "s/$old_base/$clean_base/"
}

#make .hx class file for each resource
function write_class_file
{
    # $1 is Class name (id) and $2 is file type and $3 is file name
    if [[ $2 == "swf" ]]; then
        echo "class $1 extends MovieClip { public function new() { super(); } }" >> $3
        echo "        movies.set(\"$1\", new $1());" >> $4
    else if [[ $2 == "audio" ]]; then
        echo "class $1 extends Sound { public function new() { super(); } }" >> $3
        echo "        sounds.set(\"$1\", new $1());" >> $4
    else #bitmap files
        echo "class $1 extends Bitmap { public function new() { super(); } }" >> $3
        echo "        bitmaps.set(\"$1\", new $1());" >> $4
    fi    
    fi
}

echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
echo "<movie version=\"9\">"
echo -e "\t<background color=\"#ffffff\"/>"
echo -e "\t<frame>"
echo -e "\t\t<library>"

#remove old class file
if [[ -f $class_file ]]; then
    rm $class_file
fi
if [[ -f $index_file ]]; then
    rm $index_file
fi

# Pacakge declaration
echo "package generated;" >> $class_file
echo "package generated;" >> $index_file

#put default info in class file
if [[ ! -z $gfx ]]; then
    echo "import flash.display.Bitmap;" >> $class_file
fi

if [[ ! -z $audio ]]; then
    echo "import flash.media.Sound;" >> $class_file
fi

if [[ ! -z $swfs ]]; then
    echo "import flash.display.MovieClip;" >> $class_file
fi

echo "import flash.display.Bitmap;" >> $index_file
echo "import flash.media.Sound;" >> $index_file
echo "import flash.display.MovieClip;" >> $index_file
echo "import LibraryClasses;" >> $index_file

#add a blank line after includes
echo "" >> $class_file
echo "" >> $index_file

# Index file structure
echo "class LibraryIndex {" >> $index_file
echo "    private var bitmaps: Hash<Bitmap>;" >> $index_file
echo "    private var sounds: Hash<Sound>;" >> $index_file
echo "    private var movies: Hash<MovieClip>;" >> $index_file
echo "    public function bitmap(name: String): Bitmap { return bitmaps.get(name); }" >> $index_file
echo "    public function sound(name: String): Sound { return sounds.get(name); }" >> $index_file
echo "    public function movie(name: String): MovieClip { return movies.get(name); }" >> $index_file
echo "    public function new() { " >> $index_file
echo "        bitmaps = new Hash<Bitmap>();" >> $index_file
echo "        sounds  = new Hash<Sound>();" >> $index_file
echo "        movies  = new Hash<MovieClip>();" >> $index_file
echo "        " >> $index_file


cl_path=$1

for file in $gfx; do
    #remove the last / that find adds to the base dir
    path=`clean_base_dir $cl_path $file`
    id=`make_id $cl_path $file`
    write_class_file $id "bmp" $class_file $index_file
    echo -e "\t\t\t<bitmap id=\"$id\" import=\"$path\"/>"
done

for file in $audio; do
    #remove the last / that find adds to the base dir
    path=`clean_base_dir $cl_path $file`
    id=`make_id $cl_path $file`
    write_class_file $id "audio" $class_file $index_file
    echo -e "\t\t\t<sound id=\"$id\" import=\"$path\"/>"
done

for swf in $swfs; do
    path=`clean_base_dir $cl_path $swf`
    id=`make_id $cl_path $file`
    write_class_file $id "swf" $class_file $index_file
    echo -e "\t\t\t<clip id=\"$id\" import=\"path\"/>"
done

echo -e "\t\t</library>"

for font_file in $fonts; do
    path=`clean_base_dir $cl_path $font_file`
    id=`make_id $cl_path $font_file`
    #TODO: how do fonts go in the class file?
    #TODO: figure out if i need a more complete set of glyphs
    echo -e "\t\t<font id=\"$id\" import=\"$path\" glyphs=\"abcdefghijklmnopqrstuvwxyz1234567890 .,:;!?'<=>+-*/()[]{}%&$#@_~\"/>"
done

echo "    }" >> $index_file
echo "}" >> $index_file

echo -e "\t</frame>"
echo "</movie>"
