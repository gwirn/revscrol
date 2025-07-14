# revscrol

This small "app" reverses the scrolling direction of your mouse without any GUI changes or even changes to the scroll direction settings itself.

### Why another one of these apps?
This should be a minimal app, without the need of a GUI or any other interaction by the user. It should just reverse the scrolling direction if a mouse is connected since one can not set the direction for mouse and trackpad independent from each other on mac.

## Installation

## Compiling

Create a binary called `revscrol` with the following command:
```sh
git clone https://github.com/gwirn/revscrol.git
cd revscrol
swiftc -o revscrol main.swift -framework Cocoa -framework Quartz
```
Change the mouse names you use in `revscrol.sh` in the `mice`array as well as the `revscrolPath` to where you have saved revscrol.

If you use USB mice instead of Bluetooth change the system_profiler to `SPUSBDataType`.

## Start
You can use a cronjob that starts at reboot like so:

`crontab -e` and add `@reboot /bin/bash /PATH/TO/revscrol.sh`

For this to work you need to grant the revscrol binary permissions in `System Settings > Privacy and Security > Accessibility`.

**!!! Be aware - that only checks for a mouse connection for the first 5 minutes after you login - not if you add a mouse later !!!**

To "continuously" check for connected mice add a cronjob like `6 * * * * /bin/bash PATH/TO/revscrol.sh` which checks every minute whether a new mouse is connected.

The `revscrol.sh` script will generate a `revscrol.pid` file where the PID of the revscrol process is stored and a `revscrol.log` file where any information about revscrols execution is stored.

## Stop
To stop the execution of revscrol run the following command:
```sh
kill $(cat /PATH/TO/revscrol.pid)
```
