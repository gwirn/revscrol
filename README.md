# revscrol

This small app reverses the scrolling direction of your mouse without any GUI interactions or changes to the scroll direction settings.

### Motivation
On a Mac - if you want to use "natural scrolling" when using your trackpad but do not want to use it when you use your mouse or vice versa, you will need to go to the System Settings and turn it on or of depending on what you use because you can not set these settings independently for mouse and trackpad.

### Why is there a need for another one of these apps?
It should be a minimal app that doesn't require a GUI or any other user interaction. It should simply reverse the scrolling direction when a mouse is connected. It should not rely on an apple script to open the System Settings GUI for you and click through all since that often breaks from one OS version to the next.

## Installation

### Compiling

Create a binary called `revscrol` with the following command:
```sh
git clone https://github.com/gwirn/revscrol.git
cd revscrol
swiftc -o revscrol main.swift -framework Cocoa -framework Quartz
```
Change the mouse names you use in `revscrol.sh` in the `mice` array as well as the `revscrolPath` to where you have saved revscrol. These are hard-coded on purpose so the script needs no arguments and is easier to run based on the method you use to start `revscrol.sh` .

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
