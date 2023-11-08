json=$(curl http://api.open-notify.org/iss-now.json | jq .)

echo $json

#keys=$(echo $json | jq '.iss_position | keys')

#echo $keys


# below works
echo "------------method 1------------"
for k in $(echo $json | jq -r '.iss_position | keys | .[]'); do
    echo $k
    value=$(echo $json | jq -r .iss_position.$k)
    echo $value
done 

echo "------------method 2------------"
for k in $(echo $json | jq -r '.iss_position | keys | .[]'); do
    echo $k
    value=$(echo $json | jq -r .iss_position.${k})
    echo $value
done 

echo "------------method 3------------"
# below also works
for k in $(jq -r '.iss_position | keys | .[]' <<< $json); do
    echo $k
    value=$(jq -r ".iss_position.$k" <<< $json)
    echo $value
done 


