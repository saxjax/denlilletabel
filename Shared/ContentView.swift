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

    var body: some View {


      VStack {
        Text("Til min søde Asta Luna").font(.title)
        Text("Den Lille Tabel").font(.title)
        VStack {
          ForEach((0...9), id: \.self){row in
            HStack{
              ForEach((0...9), id: \.self){column in
                Field(id: pos(row: row, col: column), model: m)
                  .frame(minWidth: 25, idealWidth: 50, maxWidth: 100, minHeight: 25, idealHeight: 50, maxHeight: 100, alignment: .center)
              }


            }
          }
        }
      }.scaledToFit().padding()
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
      TextField("x", value: $model.gamestate[id.row][id.col],formatter: NumberFormatter())
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .background((model.gamestate[id.row][id.col] == model.facit[id.row][id.col]) ? Color.green : Color.clear)
    }
  }
}
