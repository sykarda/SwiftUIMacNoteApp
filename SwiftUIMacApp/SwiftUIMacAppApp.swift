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
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate!
    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    let menu = ApplicationMenu()

    func applicationDidFinishLaunching(_ notification: Notification) {
        menu.delegate = self
        AppDelegate.instance = self
        statusBarItem.button?.title = getButtonTitle()
        statusBarItem.menu = menu.createMenu()
    }

    private func getButtonTitle() -> String {
        let notesCount = menu.getNumberOfNotes()
        if notesCount > 0 {
            return String(notesCount)
        } else {
            return "🤗"
        }
    }
}

extension AppDelegate: ApplicatonMenuDelegate {
    func notesCountChanged() {
        statusBarItem.button?.title = getButtonTitle()
    }
}
