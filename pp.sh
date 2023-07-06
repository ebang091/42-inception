

SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
STRING="put your unique phrase here"

echo "${SALT}" > temp.txt

grep -n "put your unique phrase here" ./test.txt | cut -d ':' -f 1 | tail -n 1 | \
xargs -I {} sh -c 'sed -i "{}r temp.txt" test.txt'

echo $STRING | xargs -I {} sh -c 'sed -i "/{}/d" test.txt'


