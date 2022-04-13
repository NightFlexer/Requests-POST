#!/bin/bash
pets=('Jack_20210321' 'Cat_20210321' 'Pet_20210321' 'Tom_20210321')
values=(7 8 9)
for pet in ${!pets[*]}; do
   response=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"name\": \"${pets[$pet]}\"}" https://petstore.swagger.io/v2/pet)
   petID=${response:6:19}
   pets[$pet]+=":$petID"

   for i in ${values[@]}; do
      if [ "${petID: -1}" -eq "$i" ]; then
         curl -s -X DELETE https://petstore.swagger.io/v2/pet/$petID > /dev/null
         pets[$pet]=NULL
      fi
   done
done
for item in ${pets[*]}
do
   printf " %s\n" $item
done