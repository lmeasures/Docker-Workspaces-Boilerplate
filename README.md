# First time use:
- In the root directory, run: <br/>
1: run `npm i` at the root level <br/>
2: run `npm start --workspace=react-app-a` <br/>
2: alternative custom run command added: `npm run app <app-name>` <br/>

---

# What's in this Proof of Concept?

- State is being instantiated and stored within the common component `Component1`, visible within the button as a numerical value
- State is being instantiated and stored within the parent component within `react-app-a`
  - `react-app-a`'s state is being passed into common component as a value, along with it's dispatch action
  - `Component1` uses the dispatch action as a callback to modify the value of `react-app-a`'s state, using the state value passed into it.
- There are no errors.
- I can't believe I finally got this to work.

--- 

# Creating a new app

- At root level: <br/>
1: Run `npx create-react-app <app-name> --template="typescript"` <br/>
2: Run `npm init -w <app-name>` <br/>
2.1: Accept all default values, _except for_ `entry point`, this must be set to `index.js` <br/>
2.1.1: The reason for this is that after running `npm init -w ..`, npm may assume that `craco.config.js` is your entrypoint. <br/>
~~3: Update the `package.json` 'scripts' section, adding a command as follows: `"<app-name>": "npm start --workspace=<app-name>"`~~
<br/>| This step is no longer necessary as a custom command has been added to run apps from root: `npm run app <app-name>` 
- Within the new app's directory `./<app-name>`: <br/>
1: Run `npm i -D @craco/craco` <br/>
2: Copy `craco.config.js.example` from the root folder to the app directory <br/>
3: Update the `package.json` 'scripts' section, replacing `react-scripts` with `craco` <br/>
3.1: Leave `react-scripts eject` as it is, do not change this to `craco eject` <br/>

- You can now run the app from the root level using `npm run <app-name>`