//
//  FrameView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

struct FrameView: View {
    var body: some View {

        /*
         Frame konkrétního View definuje, jak velké má být View vyrenderováno.
         Pomocí `.frame` můžeme daný frame upravit.
         Z pohledu velikosti existuje celkem 8 parametrů:

         width/height - vynutí určenou výšku a šířku
         minWidth/ minHeight - vynutí minimální výšku a šířku
         idealWidth/idealHeight - definuje doporučenou výšku a šířku s jakou by mělo být dané View ideálně renderováno
         maxWidth/maxHeight - vynutí maximální výšku a šířku
        */


        // MARK: - Bez omezení frame

//        Image(systemName: "star")
//            .redColored()

        /*
         Image s modifikátorem `.resizable` vyplní svého rodiče
         */

//        Image(systemName: "star")
//            .resizable()
//            .redColored()

        /*
         Text se snaží vyplnit svého rodiče, ale nebude větší, pokud by byl text přiliš dlouhý
         */
//        Text(String.longText)
//            .redColored()

//        ScrollView {
//            Text(String.longText)
//                .redColored()
//        }


        // MARK: - Specifikovaná výška a šířka

//        Image(systemName: "star")
//            .resizable()
//            .frame(width: 150, height: 150)
//            .redColored()


        // MARK: - Omezení rodičem

        /*
         Postup renderování:
         - Rodič nabídne VStacku celou obrazovku
         - VStack odpoví, že není potřeba tolik místa, stačí 150x150
         - VStack se vyrenderuje 150x150
         - VStack nabídne 150x150 velikost elementu Image
         - Image chce být tak velký, jako jeho rodič, takže mu 150x150 stačí
         - Image se vyrenderuje 150x150
         */

//        VStack {
//            Image(systemName: "star")
//                .resizable()
//                .redColored()
//        }
//        .frame(width: 150, height: 150)
//        .greenColored()

        /*
         Podstatné je, že rodič pouze "nabízí" velikosti. Pokud chce být potomek větší, tak mu rodič nemůže zabránit.

         Postup renderování:
         - Rodič nabídne VStacku celou obrazovku
         - VStack odpoví, že není potřeba tolik místa, stačí 75x75
         - VStack se vyrenderuje 75x75
         - VStack nabídne 75x75 velikost elementu Image
         - Image odpoví "ne, děkuji, já chci být velký 150x150"
         - Image se vyrenderuje 150x150
         */

//        VStack {
//            Image(systemName: "star")
//                .resizable()
//                .frame(width: 150, height: 150)
//                .redColored()
//        }
//        .frame(width: 75, height: 75)
//        .greenColored()


//        VStack {
//            Image(systemName: "star")
//                .resizable()
//                .frame(minWidth: 150, minHeight: 150)
//                .redColored()
//        }
//        .frame(width: 75, height: 75)
//        .greenColored()

        /*
         MaxWidth, MaxHeight
         */
//
//        Image(systemName: "star")
//            .resizable()
//            .frame(maxWidth: 150, maxHeight: 150)
//            .redColored()

        /*
         `.infinity` je speciální hodnota, kterou lze přiřadit šířce i výšce.
         Specifikujeme tím, že chceme, aby View rostlo co nejvíce, jak může.

         Postup renderování:
         - Rodič nabídne VStacku celou obrazovku
         - VStack se vyrenderuje přes celou obrazovku
         - VStack se vyrenderuje 150x150
         - VStack nabídne 150x150 velikost elementu Image
         - Image chce být tak velký, jako jeho rodič, takže mu 150x150 stačí
         - Image se vyrenderuje 150x150
         */
//
//        VStack {
//            Image(systemName: "star")
//                .resizable()
//                .frame(width: 150, height: 150)
//                .redColored()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .greenColored()

        /*
         Pokud chceme, aby se naše View vždy zobrazovalo tak, jak je pro něj nejlepší = "ideal size", tak lze použít modifikátor `.fixedSize()`
         Dané View přestane poslouchat layout system a bude se renderovat tak, jak uzná za vhodné.

         Každé View má nějakou ideální velikost. Např. u Text se jedná o výšku jednoho řádku a neomezenou šířku

         Proces renderování:

         - Rodič nabídne VStacku celou obrazovku
         - Text odpoví "I couldn't care less"
         - Text se vyrenderuje s výškou jeden řádek a šírkou dle textu
         (- Rodič: :pepehands:)
         */

//        Text("Nobody expects the Spanish inquisition")
//            .font(.system(.largeTitle))
//            .fixedSize()


        /*
         Příklad využití ideální velikosti View může být napřiklad u Text.
         Normální chování v tomto případě by bylo, že se všechny elementy rozdělí na 1/3 výšky VStack, což by znamenalo oříznutí textu.
        */

//        VStack {
//            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam mattis mauris sed ornare gravida. In congue lorem dui, nec euismod ligula feugiat ut. Maecenas pharetra lacus eget aliquet tristique. Aenean ornare est nec odio scelerisque ullamcorper. Maecenas semper, metus vel vestibulum ullamcorper, est elit maximus risus, sed ultrices elit turpis id urna. Phasellus ut nulla sit amet erat cursus egestas. Nullam pulvinar auctor dui placerat congue. Maecenas a venenatis leo, nec mollis odio. Nunc sit amet cursus orci. Duis sodales sagittis risus, ultrices ornare lorem. Aliquam sed aliquam augue, id iaculis quam. Etiam ut maximus tortor.")
//                .fixedSize(horizontal: false, vertical: true)
//                .redColored()
//
//            ForEach(0..<2) { _ in
//                Image(systemName: "flame")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .blueColored()
//            }
//        }
//        .greenColored()


        /*
         Layout priority

         Další možnost jak specifikovat chování jednotlivých View je nastavení jejich priority.
         Vyrenderování se následně řídí těmito prioritami od nejvyšší po nejnižší.
         */

        HStack {
            Spacer()
                .frame(height: 100)
                .blueColored()

            Spacer()
                .frame(height: 100)
                .greenColored()
                .layoutPriority(10)

            Spacer()
                .frame(height: 100)
                .redColored()
                .layoutPriority(10)
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}

struct MarbleView: View {
    static let circleDiameter: CGFloat = 20
    static let circleDiameterWithPadding: CGFloat = 28

    let numberOfCircles: Int

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(self.getRange(width: geometry.size.width)) { _ in
                    Circle()
                        .foregroundColor(.black)
                        .frame(width: Self.circleDiameter, height: Self.circleDiameter)
                }
            }
        }
        .frame(
            idealWidth: CGFloat(numberOfCircles) * Self.circleDiameterWithPadding,
            idealHeight: Self.circleDiameterWithPadding
        )
    }

    func getRange(width proposedWidth: CGFloat) -> Range<Int> {
        let upperBoundary = min(
            Int(floor(proposedWidth/28)),
            numberOfCircles
        )

        return 0..<upperBoundary
    }
}
