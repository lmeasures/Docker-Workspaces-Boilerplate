# How do
1: run `npm i` at the root level

2: run `npm start --workspace=react-app-a`

3: click the button

- State is being instantiated and stored within the common component `Component1`, visible within the button as a numerical value
- State is being instantiated and stored within the parent component within `react-app-a`
  - `react-app-a`'s state is being passed into common component as a value, along with it's dispatch action
  - `Component1` uses the dispatch action as a callback to modify the value of `react-app-a`'s state, using the state value passed into it.
- There are no errors.
- I can't believe I finally got this to work.