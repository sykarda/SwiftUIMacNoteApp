//
//  ApplicationMenu.swift
//  SwiftUIMacApp
//
//  Created by Arda Ilgili on 29.08.2023.
//

import Foundation
import SwiftUI

protocol ApplicatonMenuDelegate {
    func notesCountChanged()
}

class ApplicationMenu: NSObject {
    let menu = NSMenu()
    var contentView = ContentView()
    var delegate: ApplicatonMenuDelegate?

    func createMenu() -> NSMenu {
        contentView.delegate = self

        let topView = NSHostingController(rootView: contentView)
        topView.view.frame.size = CGSize(width: 350, height: 250)

        let customMenuItem = NSMenuItem()
        customMenuItem.view = topView.view
        menu.addItem(customMenuItem)

        return menu
    }

    func getNumberOfNotes() -> Int {
        contentView.getNumberOfNotes()
    }
}

extension ApplicationMenu: ContentViewDelegate {
    func notesCountChanged() {
        delegate?.notesCountChanged()
    }
}
