//
//  LayoutView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

struct LayoutView: View {
    var body: some View {
        sizingView
    }

    /*
    Existují 4 různé typy chování, jak View určují svou velikost:

    - View, která využijí prostor, který jim byl nabídnut
    - View, která určí velikost podle svých potomků
    - View, která se zvětší tak, aby odpovídaly nabízenému prostoru
    - View, která mohou být větší než rodič
    */

    // MARK: - View, která využijí prostor, který jim byl nabídnut (Text)
    /*
    Text se vždy snaží vyplnit prostor, který byl nabídnut.
    Je zde však podmínka, že Text vždy zobrazí minimálně jeden řádek.
    */

//    let sizingView = SizingContainer() {
//        Text("Nobody expects the Spanish inquisition")
//    }

    // MARK: - View, která určí velikost podle svých potomků (HStack, VStack, ZStack)

//    let sizingView = SizingContainer() {
//        HStack {
//            Text("Nobody")
//            Text("expects")
//            Text("the")
//            Text("Spanish")
//            Text("inquisition")
//        }
//    }

//    let sizingView = SizingContainer() {
//        VStack {
//            Text("Nobody")
//            Text("expects")
//            Text("the")
//            Text("Spanish")
//            Text("inquisition")
//        }
//    }

//    let sizingView = SizingContainer() {
//        ZStack {
//            Text("Nobody")
//            Text("expects")
//            Text("the")
//            Text("Spanish")
//            Text("inquisition")
//        }
//    }

    // MARK: - View, která se zvětší tak, aby odpovídaly nabízenému prostoru
    /*
    Circle, Rectangle, Ellipse, Capsule...
    */

//    let sizingView = SizingContainer() {
//        Rectangle()
//    }

//    let sizingView = SizingContainer() {
//        Rectangle()
//            .rotation(.degrees(45))
//    }

//    let sizingView = SizingContainer() {
//        Spacer()
//    }

    /// Téměř vše ve SwiftUI je View

//    let sizingView = SizingContainer() {
//        Color.black
//    }

    // MARK: - View, která mohou být větší než rodič
    /*
     Příkladem může být Path, která se zobrazí bez ohledu na svého rodiče
     */

//    let sizingView = SizingContainer {
//        Path { path in
//            let values = [20, 30, 50, 100, 120, 300, 250, 210, 160, 40, 50, 80, 100]
//
//            values.enumerated().map { index, value in
//                path.addRect(
//                    CGRect(
//                        x: (index - 1) * 10,
//                        y: 100,
//                        width: 10,
//                        height: -value
//                    )
//                )
//            }
//        }
//    }

    /*
     Image se vždy zobrazí ve výchozí velikosti (v tomto případě font size)
     */

//    let sizingView = SizingContainer() {
//        Image(systemName: "hare")
//    }


//    let sizingView = SizingContainer() {
//        Image(systemName: "hare")
//            .resizable()
//            .aspectRatio(1.5, contentMode: .fit)
//    }

//    let sizingView: some View = SizingContainer() {
//        Image(systemName: "hare")
//            .resizable()
//            .aspectRatio(1.5, contentMode: .fit)
//    }

    let sizingView: some View = SizingContainer() {
        Image(systemName: "hare")
            .resizable()
            .aspectRatio(1.5, contentMode: .fill)
    }

}

struct LayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
