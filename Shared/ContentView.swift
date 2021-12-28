//
//  ContentView.swift
//  Shared
//
//  Created by Jakob Skov Søndergård on 27/12/2021.
//

import SwiftUI

//struct Field {
//  let id:pos
//  let value:Int
//}
struct pos:Hashable{
  let row:Int
  let col:Int
}

struct ContentView: View {
  @ObservedObject var m = GameModel()
  @FocusState private var isFocused: Bool

    var body: some View {


      VStack {

        Text("Den Lille Tabel").font(.title)
        Text("skriv de manglende tal, feks: 2,4,6,8...")

        VStack {
          ForEach((0...9), id: \.self){row in
            HStack{
              ForEach((0...9), id: \.self){column in
                Field(id: pos(row: row, col: column), model: m)
                  .frame(minWidth: 25, idealWidth: 50, maxWidth: 100, minHeight: 25, idealHeight: 50, maxHeight: 100, alignment: .center).focused($isFocused)
              }
            }
          }
        }

      }.scaledToFit().padding()
        .toolbar {
          ToolbarItem(placement: .keyboard) {
            Button("Done") {
              isFocused = false
            }
          }
        }

    }


  struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView()

      }
  }

  struct Field: View {
    let id:pos
    @ObservedObject var model: GameModel


    var body: some View {
    #if os(macOS)
      let isCorrect = (model.gamestate[id.row][id.col] == model.facit[id.row][id.col])
      TextField("x", value: $model.gamestate[id.row][id.col] ,formatter: NumberFormatter())
        .multilineTextAlignment(.center)
        .background(isCorrect ? Color.green : Color.clear)
    #else

      let isCorrect = (model.gamestate[id.row][id.col] == model.facit[id.row][id.col])
      TextField("x", value: $model.gamestate[id.row][id.col] ,formatter: NumberFormatter())
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .background(isCorrect ? Color.green : Color.clear)
    #endif

    }
  }
}
