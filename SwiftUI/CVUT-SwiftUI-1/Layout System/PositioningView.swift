//
//  PositioningView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

struct PositioningView: View {
    var body: some View {

        /// Vycentrování
        /// Veškeré elementy jsou automaticky vycentrované (V + H)
        Group {
            Group {
                Text("I am centered")
                    .redColored()
            }
            .frame(width: 150, height: 50)
            .greenColored()
        }
        .frame(width: 250, height: 500)
        .blueColored()


        /// Zarovnání
        /// `.frame` modifier umožňuje přepsání výchozího zarovnání
//        Group {
//            Text("I am aligned")
//                .padding()
//                .redColored()
//        }
//        .frame(width: 250, height: 500, alignment: .topTrailing)
//        .greenColored()

        /// Spacer
        /// Vyplňuje prázdná místa a roztahuje elementy ve stacku
//        VStack {
//            Spacer()
//
//            HStack {
//                Text("My")
//
//                Spacer()
//            }
//
//            Text("hovercraft")
//
//            HStack {
//                Spacer()
//
//                Text("is full of eels")
//            }
//        }
//        .greenColored()


        /// Absolutní pozice
        /// `.position` lze definovat absolutní pozici pomocí souřadnic
//        HStack {
//            Text("Should I stay")
//            Text("Or should I go")
//        }
//        .greenColored()
//        .position(CGPoint(x: 60, y: 100))


        /// Odsazení
        /// Pokud chcete zachovat relativní pozicování, ale zároveň trochu odsadit
        /// Neovlivňuje frame rodiče
//            HStack {
//                Text("Should I stay")
//                Text("Or should I go")
//                    .redColored()
//                    .offset(x: 50, y: 100)
//            }
//            .greenColored()

    }
}

struct PositioningContentView_Previews: PreviewProvider {
    static var previews: some View {
        PositioningView()
    }
}
