if ! command -v yq &> /dev/null
then
    echo "YQ is not installed, please install YQ before running this command"
    echo "Additional information can be found in the './scripts/create_new_app-README.md' file."
    exit 1;
fi

if [ $# -eq 0 ]
then 
    echo "No name provided, please provide name after command: 'npm run create <app-name>'"
    exit 1; 
fi

(
    app_name=$1 # Takes first word after command as parameter

    echo "Backing up original files"
    docker_compose_original=$(yq . ./docker-compose.yaml)
    root_package_original=$(jq . ./package.json)

    echo "Creating new app directory"
    mkdir ./$app_name #create new directory using user input app name
    echo "-------------------------------"
    echo "Is this a React or Express app? [react/express]" 
    read app_type #read user input

    if [ "$app_type" != "react" ] && [ "$app_type" != "express" ] 
    then
        echo "App must be react or express"
        rm -r ./$app_name #remove new directory
        exit
    else
        if [ "$app_type" = "express" ]
        then 
            echo "Creating Express Api from template"
            cp -r ../scripts/template_express_api/. "./${app_name}/." #copy express template to new directory
            template_service_path="../scripts/template-express-service.yaml" #get express service template path for later use
        else
            echo "Creating React App from template"
            cp -r ../scripts/template_react_app/. "./${app_name}/." #copy react template to new directory
            template_service_path="../scripts/template-react-service.yaml" #get react service template path for later use
        fi
        echo "Updating new app package.json file"
        echo "$(sed s/example-app-name/$app_name/g ./$app_name/package.json)" > ./$app_name/package.json #modify package.json replacing the example name with user input

        echo "Updating new app dockerfile"
        echo "$(sed s/example-app-name/$app_name/g ./$app_name/dockerfile)" > ./$app_name/dockerfile #modify dockerfile replacing the example name with user input

        echo "Adding new app to workspaces"
        echo "$(jq --arg app_name $app_name '.workspaces += [$app_name]' ./package.json)" > ./package.json #add new app to root workspaces
        npm i #perform an install at root level to establish symlinks and workspaces

        echo "Adding new app to docker-compose.yaml"
        template_yaml=$(yq . $template_service_path | sed s/example-app-name/$app_name/g) # get service template and replace example name with user input name
        compose_yaml=$(template_yaml=$template_yaml yq '.services += env(template_yaml)' ./docker-compose.yaml) # modify existing docker-compose, adding new app's service
        echo "$compose_yaml" > ./docker-compose.yaml # write new docker-compose from variable to existing file (overwrite)

    fi
) ||
(
    echo "an unknown error occurred, rolling back changes"
    rm -rf ./$app_name #remove new directory
    echo "$docker_compose_original" > ./docker-compose.yaml #rewrite docker-compose to backed up version
    echo "$root_package_original" > ./package.json #rewrite root package to backed up version
)

exit 0 #exit app with code 0 (Succeeded)
