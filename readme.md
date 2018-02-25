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
  x - add relation to a bridge
    x - create bridge object
    x - add testing for bridge object
  - sync model with actual light state
    -get base uri from bridge
  - put state to light

- create update loop based on local function
