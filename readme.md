# Light Synchronizer

## Description

In order to control the lights in my house (which are part of the Phillips HUE system), this application checks against a schedule which is maintained in a web application. The synchronizer is intended to work with a single HUE Hub and the lights connected to it.

The process polls the web application periodically to find the current schedule of the lights, checks that schedule against the current state of the same lights connected to the hub, and then issues the relevant commands to update the lights.

## Configuration

TBD

## TODO:

x - initialize project
  x - bundler
  x - gitignore
  x - env
  x - testing
- create light model
- create update loop based on local function
