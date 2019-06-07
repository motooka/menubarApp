//
//  AppDelegate.swift
//  menubarApp
//
//  Created by T. MOTOOKA on 2019/06/07.
//

import Cocoa
import SwiftSocket;

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuItemValidation {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let menuStartServer : NSMenuItem
    let menuStopServer : NSMenuItem
    let menuDebugWindow : NSMenuItem
    
    let serverQueue : DispatchQueue
    var serverPort : Int32?
    var tcpServer : TCPServer?
    
    override init() {
        serverQueue = DispatchQueue.global(qos: .background)
        serverPort = nil
        menuStartServer = NSMenuItem(title: "Start Echo Server", action: #selector(startServer(_:)), keyEquivalent: "")
        menuStopServer = NSMenuItem(title: "Stop Echo Server", action: #selector(stopServer(_:)), keyEquivalent: "")
        menuDebugWindow = NSMenuItem(title: "Debug Window", action: #selector(debugWindow(_:)), keyEquivalent: "")
        super.init()
    }

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
        menu.addItem(menuStartServer)
        menu.addItem(menuStopServer)
        menu.addItem(menuDebugWindow)
        statusItem.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func startServer(_ sender: Any?) {
        print("start server")
        serverPort = 30000
        let server = TCPServer(address: "127.0.0.1", port: serverPort!)
        switch server.listen() {
        case .success:
            serverQueue.async {
                while true {
                    if let client = server.accept() {
                        print("New Client from:\(client.address)[\(client.port)]")
                        let d = client.read(10) // read 10 bytes
                        client.send(data: d!)
                        client.close()
                    } else {
                        print("accept error")
                        break
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
        tcpServer = server
    }
    @objc func stopServer(_ sender: Any?) {
        print("stop server")
        serverPort = nil
        if let server = tcpServer {
            server.close()
        }
    }
    @objc func debugWindow(_ sender: Any?) {
        print("open debug window")
    }
    
    // MARK: -
    // MARK: protocol NSMenuItemValidation
    
    // see https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MenuList/Articles/EnablingMenuItems.html
    // see https://developer.apple.com/documentation/objectivec/nsobject/1518160-validatemenuitem
    // see https://asciiwwdc.com/2018/sessions/209
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        let isStarted = (serverPort != nil)
        if menuItem == menuStartServer {
            return !isStarted
        }
        else if menuItem == menuStopServer {
            return isStarted
        }
        return true
    }

}

