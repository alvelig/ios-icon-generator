#!/bin/bash
#
# Copyright (C) 2014 Wenva <lvyexuwenfa100@126.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

SRC_FILE="$1"
DST_PATH="$2"

BGCOLOR="white"


VERSION=1.0.0

info() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo -e "[${green}INFO${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo -e "[${red}ERROR${normal}] $1"
}

usage() {
cat << EOF
VERSION: $VERSION
USAGE:
    $0 srcfile dstpath

DESCRIPTION:
    This script aim to generate ios app icons easier and simply.

    srcfile - The source png image. Preferably above 1024x1024
    dstpath - The destination path where the icons generate to.

    This script is depend on ImageMagick. So you must install ImageMagick first
    You can use 'sudo brew install ImageMagick' to install it

AUTHOR:
    Pawpaw<lvyexuwenfa100@126.com>

LICENSE:
    This script follow MIT license.

EXAMPLE:
    $0 1024.png ~/123
EOF
}

# Check ImageMagick
command -v convert >/dev/null 2>&1 || { error >&2 "The ImageMagick is not installed. Please use brew to install it first."; exit -1; }

# Check param
if [ $# != 2 ];then
    usage
    exit -1
fi

# Check dst path whether exist.
if [ ! -d "$DST_PATH" ];then
    mkdir -p "$DST_PATH"
fi

# Generate, refer to:https://developer.apple.com/ios/human-interface-guidelines/graphics/app-icon/

# Device or context   Icon size
## iPhone 6s Plus, iPhone 6 Plus   180px by 180px
## iPhone 6s, iPhone 6, iPhone SE  120px by 120px
## iPad Pro    167px by 167px
## iPad, iPad mini 152px by 152px
## App Store   1024px by 1024px

# Device  Spotlight icon size Settings icon size
# iPhone 6s Plus, iPhone 6 Plus   120px by 120px  87px by 87px
# iPhone 6s, iPhone 6, iPhone SE  80px by 80px    58px by 58px
# iPad Pro, iPad, iPad mini   80px by 80px    58px by 58px

info 'App Store Icon...'
convert "$SRC_FILE" -resize 1024x1024 "$DST_PATH/iTunesArtwork@2x.png"

info 'Generating:'
# Check dst path whether exist.
if [ ! -d "$DST_PATH/AppIcon.appiconset" ];then
    mkdir -p "$DST_PATH/AppIcon.appiconset/"
fi

info 'iPhone 6s, iPhone 6, iPhone SE Icon...'
convert "$SRC_FILE" -resize 120x120 "$DST_PATH/AppIcon.appiconset/icon-60@2x.png"
info 'iPhone 6s Plus, iPhone 6 Plus Icon...'
convert "$SRC_FILE" -resize 180x180 "$DST_PATH/AppIcon.appiconset/icon-60@3x.png"
info 'iPad Pro Icon...'
convert "$SRC_FILE" -resize 167x167 "$DST_PATH/AppIcon.appiconset/icon-83.5@2x.png"

info 'icon-76...'
convert "$SRC_FILE" -resize 76x76 "$DST_PATH/AppIcon.appiconset/icon-76.png"
info 'iPad, iPad mini Icon...'
convert "$SRC_FILE" -resize 152x152 "$DST_PATH/AppIcon.appiconset/icon-76@2x.png"

info 'icon-small...'
convert "$SRC_FILE" -resize 29x29 "$DST_PATH/AppIcon.appiconset/icon-small.png"
info 'Generate iPad Pro, iPad, iPad mini, iPhone 6s, iPhone 6, iPhone SE Settings Icon...'
convert "$SRC_FILE" -resize 58x58 "$DST_PATH/AppIcon.appiconset/icon-small@2x.png"

info 'Icon-40...'
convert "$SRC_FILE" -resize 40x40 "$DST_PATH/AppIcon.appiconset/icon-40.png"
info 'Generate iPad Pro, iPad, iPad mini, iPhone 6s, iPhone 6, iPhone SE Spotlight Icon...'
convert "$SRC_FILE" -resize 80x80 "$DST_PATH/AppIcon.appiconset/icon-40@2x.png"

info 'Generate iPad Pro, iPad, iPad mini, iPhone 6s, iPhone 6, iPhone SE Settings Icon...'
convert "$SRC_FILE" -resize 87x87 "$DST_PATH/AppIcon.appiconset/icon-small@3x.png"
info 'Generate iPad Pro, iPad, iPad mini, iPhone 6s, iPhone 6, iPhone SE Spotlight Icon...'
convert "$SRC_FILE" -resize 120x120 "$DST_PATH/AppIcon.appiconset/icon-60@2x.png"

cat <<EOF > $DST_PATH/AppIcon.appiconset/Contents.json
{
  "images" : [
    {
      "idiom" : "iphone",
      "size" : "20x20",
      "scale" : "2x"
    },
    {
      "idiom" : "iphone",
      "size" : "20x20",
      "scale" : "3x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "icon-small@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "icon-small@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "icon-40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "icon-60@2x.png",
      "scale" : "3x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "icon-60@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "icon-60@3x.png",
      "scale" : "3x"
    },
    {
      "idiom" : "ipad",
      "size" : "20x20",
      "scale" : "1x"
    },
    {
      "idiom" : "ipad",
      "size" : "20x20",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "icon-small.png",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "icon-small@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "icon-40.png",
      "scale" : "1x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "icon-40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "icon-76.png",
      "scale" : "1x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "icon-76@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "83.5x83.5",
      "idiom" : "ipad",
      "filename" : "icon-83.5@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "24x24",
      "idiom" : "watch",
      "scale" : "2x",
      "role" : "notificationCenter",
      "subtype" : "38mm"
    },
    {
      "size" : "27.5x27.5",
      "idiom" : "watch",
      "scale" : "2x",
      "role" : "notificationCenter",
      "subtype" : "42mm"
    },
    {
      "size" : "29x29",
      "idiom" : "watch",
      "role" : "companionSettings",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "watch",
      "role" : "companionSettings",
      "scale" : "3x"
    },
    {
      "size" : "40x40",
      "idiom" : "watch",
      "scale" : "2x",
      "role" : "appLauncher",
      "subtype" : "38mm"
    },
    {
      "size" : "44x44",
      "idiom" : "watch",
      "scale" : "2x",
      "role" : "longLook",
      "subtype" : "42mm"
    },
    {
      "size" : "86x86",
      "idiom" : "watch",
      "scale" : "2x",
      "role" : "quickLook",
      "subtype" : "38mm"
    },
    {
      "size" : "98x98",
      "idiom" : "watch",
      "scale" : "2x",
      "role" : "quickLook",
      "subtype" : "42mm"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
EOF

# Check dst path whether exist.
if [ ! -d "$DST_PATH/LaunchImage.launchimage" ];then
    mkdir -p "$DST_PATH/LaunchImage.launchimage/"
fi

info 'Generating extended Default image'
convert "$SRC_FILE" -background white -gravity center -extent 200% "$SRC_FILE.extended"

SRC_FILE="$SRC_FILE.extended"
info "$SRC_FILE"

info 'Generating Launch Screen set...'

info 'iPhone pre 5 Portrait (640x960)...'
convert "$SRC_FILE" -thumbnail 640x960 -background $BGCOLOR -gravity center -extent 640x960 "$DST_PATH/LaunchImage.launchimage/Default@2x~iphone.png"

info 'iPhone 5 Portrait (640x1136)...'
convert "$SRC_FILE" -thumbnail 640x1136 -background $BGCOLOR -gravity center -extent 640x1136 "$DST_PATH/LaunchImage.launchimage/Default-568h@2x~iphone.png"

info 'iPhone 6 Portrait (750x1334)...'
convert "$SRC_FILE" -thumbnail 750x1334 -background $BGCOLOR -gravity center -extent 750x1334 "$DST_PATH/LaunchImage.launchimage/Default-667h.png"

info 'iPhone 6 Portrait (1242x2208)...'
convert "$SRC_FILE" -thumbnail 1242x2208 -background $BGCOLOR -gravity center -extent 1242x2208 "$DST_PATH/LaunchImage.launchimage/Default-736h.png"

info 'iPhone 6 Portrait (2208x1242)...'
convert "$SRC_FILE" -thumbnail 2208x1242 -background $BGCOLOR -gravity center -extent 2208x1242 "$DST_PATH/LaunchImage.launchimage/Default-Landscape-736h.png"

info 'iPad Portrait (768x1024)...'
convert "$SRC_FILE" -thumbnail 768x1024 -background $BGCOLOR -gravity center -extent 768x1024 "$DST_PATH/LaunchImage.launchimage/Default-Portrait~ipad.png"

info 'iPad Landscape (1024x768)...'
convert "$SRC_FILE" -thumbnail 1024x768 -background $BGCOLOR -gravity center -extent 1024x768 "$DST_PATH/LaunchImage.launchimage/Default-Landscape~ipad.png"

info 'iPad Portrait @2x (1536x2048)...'
convert "$SRC_FILE" -thumbnail 1536x2048 -background $BGCOLOR -gravity center -extent 1536x2048 "$DST_PATH/LaunchImage.launchimage/Default-Portrait@2x~ipad.png"

info 'iPad Landscape @2x (2048x1536)...'
convert "$SRC_FILE" -thumbnail 2048x1536 -background $BGCOLOR -gravity center -extent 2048x1536 "$DST_PATH/LaunchImage.launchimage/Default-Landscape@2x~ipad.png"

info 'Contents.json...'
cat <<EOF > $DST_PATH/LaunchImage.launchimage/Contents.json
{
  "images" : [
    {
      "extent" : "full-screen",
      "idiom" : "iphone",
      "subtype" : "736h",
      "filename" : "Default-736h.png",
      "minimum-system-version" : "8.0",
      "orientation" : "portrait",
      "scale" : "3x"
    },
    {
      "extent" : "full-screen",
      "idiom" : "iphone",
      "subtype" : "736h",
      "filename" : "Default-Landscape-736h.png",
      "minimum-system-version" : "8.0",
      "orientation" : "landscape",
      "scale" : "3x"
    },
    {
      "extent" : "full-screen",
      "idiom" : "iphone",
      "subtype" : "667h",
      "filename" : "Default-667h.png",
      "minimum-system-version" : "8.0",
      "orientation" : "portrait",
      "scale" : "2x"
    },
    {
      "orientation" : "portrait",
      "idiom" : "iphone",
      "filename" : "Default@2x~iphone.png",
      "extent" : "full-screen",
      "minimum-system-version" : "7.0",
      "scale" : "2x"
    },
    {
      "extent" : "full-screen",
      "idiom" : "iphone",
      "subtype" : "retina4",
      "filename" : "Default-568h@2x~iphone.png",
      "minimum-system-version" : "7.0",
      "orientation" : "portrait",
      "scale" : "2x"
    },
    {
      "orientation" : "portrait",
      "idiom" : "ipad",
      "filename" : "Default-Portrait~ipad.png",
      "extent" : "full-screen",
      "minimum-system-version" : "7.0",
      "scale" : "1x"
    },
    {
      "orientation" : "landscape",
      "idiom" : "ipad",
      "filename" : "Default-Landscape~ipad.png",
      "extent" : "full-screen",
      "minimum-system-version" : "7.0",
      "scale" : "1x"
    },
    {
      "orientation" : "portrait",
      "idiom" : "ipad",
      "filename" : "Default-Portrait@2x~ipad.png",
      "extent" : "full-screen",
      "minimum-system-version" : "7.0",
      "scale" : "2x"
    },
    {
      "orientation" : "landscape",
      "idiom" : "ipad",
      "filename" : "Default-Landscape@2x~ipad.png",
      "extent" : "full-screen",
      "minimum-system-version" : "7.0",
      "scale" : "2x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
EOF

info 'Generate Done.'
