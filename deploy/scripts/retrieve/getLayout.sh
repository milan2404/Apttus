#sh deploy/scripts/retrieve/getLayout.sh
rm -f layout.txt
touch layout.txt

for i in {0..510}
do
    echo "fetching Layout $i"
    sfdx force:data:soql:query --usetoolingapi --resultformat csv -q "SELECT FullName FROM Layout WHERE EntityDefinitionId NOT IN ('CssEdit','CssDetail','DelegatedAccount','ProfileSkill','ProfileSkillUser','ProfileSkillEndorsement') LIMIT 1 OFFSET $i" >> layout.txt
done
gsed -i -r '/^\s*$/d' layout.txt 
gsed -i -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' layout.txt
gsed -i 's/FullName,/Layout:/g' layout.txt