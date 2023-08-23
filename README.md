# Codeshare POC w/ Docker and Scripted Automation

## What's in this boilerplate?
- Example Common library
- Example CRA React Apps
- ((Example API)) TODO
- ((Example MongoDB)) TODO
- Code sharing across apps using NPM Workspaces & Craco
  - Craco provides ability to resolve directories outside of each CRA's src directory.
- Containerised development environment using Docker
- Dockerignore file to reduce context transfer load
<br/>
- NPM packages installed in the root package.json are visible to all workspaces under it's umbrella <br/>
- NPM packages installed in individual workspace package.jsons are visible to only that workspace <br/>
<br/>
- Automated app creation for Express APIs and React Apps
  - Including setup of dockerfiles, workspaces, docker-compose and installations


## What's in this as a Proof of Concept?

- State is being instantiated and stored within the common component `Component1`, visible within the button as a numerical value
- State is being instantiated and stored within the parent component within `react-app-a`
  - `react-app-a`'s state is being passed into common component as a value, along with it's dispatch action
  - `Component1` uses the dispatch action as a callback to modify the value of `react-app-a`'s state, using the state value passed into it
- Docker container environment(s) setup with hot-reloading
  - context minimalisation included to reduce load on builds and build times
