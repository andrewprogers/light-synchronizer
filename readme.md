# Light Synchronizer

## Description

In order to control the lights in my house (which are part of the Phillips HUE system), this application checks against a schedule which is maintained in a web application. The synchronizer is intended to work with a single HUE Bridge and the lights connected to it.

The process polls the web application periodically to find the current schedule of the lights, checks that schedule against the current state of the same lights connected to the bridge, and then issues the relevant commands to update the lights.

## Configuration

TBD

## TODO:

x - initialize project
  x - bundler
  x - gitignore
  x - env
  x - testing
- create light model
  - add relation to a bridge
    - create bridge object
    - add testing for bridge object
  - add ability to change state
  
- create update loop based on local function
