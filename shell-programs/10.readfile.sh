$(grep '.modules/' 'C:/Users/udayk/Desktop/temp/main.tf' > output.txt)

while IFS= read -r line


do
    echo "$line"
    module_name=$(echo "$line" | grep -oP '(?<=modules/).*(?=\?ref)')
    ref=$(echo "$line" | grep -oP '(?<=\?ref=).*(?=")')

    echo $module_name
    echo $ref

done < output.txt

do
    echo "$line"
    module_name=$(echo "$line" | sed -e 's/.*modules\/\(.*\)?ref.*/\1/' )
    ref=$(echo "$line" | sed -e 's/.*ref=\(.*\)"/\1/' )

    echo $module_name
    echo $ref

done < output.txt
