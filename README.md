# revscrol

This small app reverses the scrolling direction of your mouse without any GUI interactions or changes to the scroll direction settings.

### Why is there a need for another one of these apps?
It should be a minimal app that doesn't require a GUI or any other user interaction. It should simply reverse the scrolling direction when a mouse is connected, since it is not possible to set the direction for the mouse and trackpad independently of each other on a Mac.

## Installation

### Compiling

Create a binary called `revscrol` with the following command:
```sh
git clone https://github.com/gwirn/revscrol.git
cd revscrol
swiftc -o revscrol main.swift -framework Cocoa -framework Quartz
```
Change the mouse names you use in `revscrol.sh` in the `mice` array as well as the `revscrolPath` to where you have saved revscrol.

If you use USB mice instead of Bluetooth change (or extend)$the system_profiler to `SPUSBDataType`.

### Start
You can use a cronjob that starts at reboot like so:

`crontab -e` and add `@reboot /bin/bash /PATH/TO/revscrol.sh`

For this to work you need to grant the revscrol binary permissions in `System Settings > Privacy and Security > Accessibility`.

**!!! Be aware - that only checks for a mouse connection for the first 5 minutes after you login - not if you add a mouse later !!!**

To "continuously" check for connected mice add a cronjob like `6 * * * * /bin/bash PATH/TO/revscrol.sh` which checks every minute whether a new mouse is connected.

The `revscrol.sh` script will generate a `revscrol.pid` file where the PID of the revscrol process is stored and a `revscrol.log` file where any information about revscrols execution is stored.

### Stop
To stop the execution of revscrol run the following command:
```sh
kill $(cat /PATH/TO/revscrol.pid)
```
