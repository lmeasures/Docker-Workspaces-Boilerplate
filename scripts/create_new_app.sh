app_name=$1

mkdir ./$app_name

echo "Is this a React or Express app?"
read app_type #read user input
app_type="${app_type,,}" # Set to lowercase

if [ "$app_type" != "react" ] && [ "$app_type" != "express" ] 
then
    echo "App must be react or express"
    rm -r ./$app_name
    exit
else
    if [ "${app_type}" == "express" ]
    then 
        cp -r ../scripts/template_express_api/. "./${app_name}/."
    else
        cp -r ../scripts/template_react_app/. "./${app_name}/."
    fi
    echo "$(sed s/example-app-name/$app_name/g ./$app_name/package.json)" > ./$app_name/package.json #modify package.json replacing the name with user input
    echo "$(sed s/example-app-name/$app_name/g ./$app_name/dockerfile)" > ./$app_name/dockerfile #modify dockerfile replacing the name with user input

    echo "$(jq --arg app_name $app_name '.workspaces += [$app_name]' ./package.json)" > ./package.json #add new app to root workspaces
    npm i
    # # Add new values to docker-compose???????
fi


exit 1
