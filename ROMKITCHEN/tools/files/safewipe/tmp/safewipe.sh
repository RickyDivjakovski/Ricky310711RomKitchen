#!/tmp/bash

cd /data
FILES=(*)
for i in "${FILES[@]}"; do
if [ "$i" != "media" ]
then rm -R "$i"
fi
done
cd ..

exit

