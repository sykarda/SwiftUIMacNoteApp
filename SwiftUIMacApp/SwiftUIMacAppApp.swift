//
//  SwiftUIMacAppApp.swift
//  SwiftUIMacApp
//
//  Created by Arda Ilgili on 28.08.2023.
//

import SwiftUI

@main
struct SwiftUIMacAppApp: App {
    @State var title = ""
    @AppStorage("notes") var notes: Data = Data()

    init() {
        _title = .init(initialValue: returnBarTitle(notesArray: Helpers.dataToStringArray(data: notes) ?? []))
    }

    private func returnBarTitle(notesArray: [String]) -> String {
        notesArray.isEmpty ? "🤗" : notesArray.count.description
    }

    var body: some Scene {
        MenuBarExtra(content: {
            ContentView(barTitle: $title)
        }, label: {
            Text(title)
        }).menuBarExtraStyle(.window)
    }
}
