//
//  ContentView.swift
//  SwiftUIMacApp
//
//  Created by Arda Ilgili on 28.08.2023.
//

import SwiftUI

struct ContentView: View {

    @Binding public var barTitle: String
    @State var notesTextArray: [String] = []
    @State var newNoteText: String = ""

    @AppStorage("notes") var notes: Data = Data()

    var body: some View {
        VStack {
            Group {
                TextField("", text: $newNoteText)
                    .onSubmit {
                        addNewNote()
                    }
                Button {
                    addNewNote()
                } label: {
                    Text("+")
                }
            }

            ForEach(0..<notesTextArray.count, id: \.self) { index in
                HStack {
                    TextField("", text: $notesTextArray[index], axis: .vertical)
                        .onChange(of: notesTextArray) { newValue in
                            saveToStorage()
                        }
                    Button {
                        deleteNote(at: index)
                    } label: {
                        Text("Delete!")
                    }

                }
            }
            Spacer()

        }
        .padding()
        .onAppear {
            notesTextArray = Helpers.dataToStringArray(data: notes) ?? []
            setBarTitle()
        }
        .background(.thinMaterial)
    }

    private func addNewNote() {
        if notesTextArray.count < 5 && !newNoteText.isEmpty {
            notesTextArray.append(newNoteText)
            newNoteText = ""
            saveToStorage()
        }
    }

    private func deleteNote(at index: Int) {
        notesTextArray.remove(at: index)
        saveToStorage()
    }

    private func saveToStorage() {
        notes = Helpers.stringArrayToData(stringArray: notesTextArray) ?? Data()
        setBarTitle()
    }

    func getNumberOfNotes() -> Int {
        let array = Helpers.dataToStringArray(data: notes) ?? []
        return array.count
    }

    private func setBarTitle() {
        barTitle = notesTextArray.isEmpty ? "🤗" : notesTextArray.count.description
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(barTitle: .constant(""))
    }
}
