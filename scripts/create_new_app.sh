app_name=$1
docker_compose_original=$(yq . ./docker-compose.yaml)
root_package_original=$(jq . ./package.json)
echo "Backing up original files"
(

    echo "Creating new app directory"
    mkdir ./$app_name
    echo "-------------------------------"
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
            echo "Creating Express Api from template"
            cp -r ../scripts/template_express_api/. "./${app_name}/."
            template_service_path="../scripts/template-express-service.yaml"
        else
            echo "Creating React App from template"
            cp -r ../scripts/template_react_app/. "./${app_name}/."
            template_service_path="../scripts/template-react-service.yaml"
        fi
        echo "Updating new app package.json file"
        echo "$(sed s/example-app-name/$app_name/g ./$app_name/package.json)" > ./$app_name/package.json #modify package.json replacing the name with user input
        echo "Updating new app dockerfile"
        echo "$(sed s/example-app-name/$app_name/g ./$app_name/dockerfile)" > ./$app_name/dockerfile #modify dockerfile replacing the name with user input

        echo "Adding new app to workspaces"
        echo "$(jq --arg app_name $app_name '.workspaces += [$app_name]' ./package.json)" > ./package.json #add new app to root workspaces
        npm i

        echo "Adding new app to docker-compose.yaml"
        template_yaml=$(yq . $template_service_path | sed s/example-app-name/$app_name/g)
        compose_yaml=$(template_yaml=$template_yaml yq '.services += env(template_yaml)' ./docker-compose.yaml)
        echo "$compose_yaml" > ./docker-compose.yaml

    fi
) ||
(
    echo "an unknown error occurred, rolling back changes"
    rm -rf ./$app_name
    echo "$docker_compose_original" > ./docker-compose.yaml
    echo "$root_package_original" > ./package.json
)

exit 0
