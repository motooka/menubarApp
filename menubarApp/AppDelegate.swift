//
//  AppDelegate.swift
//  menubarApp
//
//  Created by T. MOTOOKA on 2019/06/07.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        guard let button = statusItem.button else {
            let alert = NSAlert()
            alert.informativeText = "Could not place a button on the menu bar"
            alert.runModal()
            return
        }
        button.image = NSImage(named:NSImage.Name("StatusBarButton"))
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Start Echo Server", action: #selector(startServer(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Stop Echo Server", action: #selector(stopServer(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Debug Window", action: #selector(debugWindow(_:)), keyEquivalent: ""))
        statusItem.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func startServer(_ sender: Any?) {
        print("start server")
    }
    @objc func stopServer(_ sender: Any?) {
        print("stop server")
    }
    @objc func debugWindow(_ sender: Any?) {
        print("open debug window")
    }

}

