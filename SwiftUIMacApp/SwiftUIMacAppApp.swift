//
//  SwiftUIMacAppApp.swift
//  SwiftUIMacApp
//
//  Created by Arda Ilgili on 28.08.2023.
//

import SwiftUI

@main
struct SwiftUIMacAppApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Text("Hello, world!")
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var popover: NSPopover!
    static private(set) var instance: AppDelegate!
    private lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var contentView: ContentView!

    func applicationDidFinishLaunching(_ notification: Notification) {
        initContentView()
        initPopover()
        AppDelegate.instance = self
        initStatusBarItem()
    }

    private func initContentView() {
        let contentView = ContentView()
        self.contentView = contentView
        self.contentView.delegate = self
    }

    private func initPopover() {
        let popover = NSPopover()
        popover.contentSize = CGSize(width: 400, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: self.contentView)
        self.popover = popover
    }

    private func initStatusBarItem() {
        statusBarItem.button?.title = getButtonTitle()
        statusBarItem.button?.action = #selector(togglePopover(_:))
    }

    private func getButtonTitle() -> String {
        let notesCount = contentView.getNumberOfNotes()
        if notesCount > 0 {
            return String(notesCount)
        } else {
            return "🤗"
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}

extension AppDelegate: ContentViewDelegate {
    func notesCountChanged() {
        statusBarItem.button?.title = getButtonTitle()
    }
}
