#sh getProfiles.sh
rm -f profile.txt
touch profile.txt

for i in {0..20}
do
    echo "fetching Profile $i"
    sfdx force:data:soql:query --usetoolingapi --resultformat csv -q "SELECT FullName FROM Profile LIMIT 1 OFFSET $i" >> profile.txt
done
gsed -i -r '/^\s*$/d' profile.txt 
gsed -i -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' profile.txt
gsed -i 's/FullName,/Profile:/g' profile.txt