gappsarch=x64
if [[ $1 == "--variant=pico" ]]; then
gappsvariant=pico
elif [[ $1 == "--variant"* ]]; then
echo "$red invalid value. Pico selected $white"
gappsvariant=pico
else
"red"
fi
echo python3.9 ./opengapps.py -a \"$gappsarch\" -va \"$gappsvariant\"