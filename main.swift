import Cocoa
import Quartz

// Callback function for event tap
func eventTapCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    if type == .scrollWheel {
        let scrollY = event.getIntegerValueField(.scrollWheelEventDeltaAxis1)
        let scrollX = event.getIntegerValueField(.scrollWheelEventDeltaAxis2)

        event.setIntegerValueField(.scrollWheelEventDeltaAxis1, value: -scrollY)
        event.setIntegerValueField(.scrollWheelEventDeltaAxis2, value: -scrollX)
    }

    return Unmanaged.passRetained(event)
}

// Set up event tap
let eventMask = (1 << CGEventType.scrollWheel.rawValue)
guard let eventTap = CGEvent.tapCreate(
    tap: .cghidEventTap,
    place: .headInsertEventTap,
    options: .defaultTap,
    eventsOfInterest: CGEventMask(eventMask),
    callback: eventTapCallback,
    userInfo: nil
) else {
    print("Failed to create event tap")
    exit(1)
}

let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
CGEvent.tapEnable(tap:eventTap, enable: true)
CFRunLoopRun()
