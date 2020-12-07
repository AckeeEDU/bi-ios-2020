//
//  Utilities.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

extension View {
    func redColored() -> some View {
        self
            .background(Color(red: 255, green: 0, blue: 0, opacity: 0.2))
            .border(Color(red: 255, green: 0, blue: 0))
    }

    func greenColored() -> some View {
        self
            .background(Color(red: 0, green: 255, blue: 0, opacity: 0.2))
            .border(Color(red: 0, green: 255, blue: 0))
    }

    func blueColored() -> some View {
        self
            .background(Color(red: 0, green: 0, blue: 255, opacity: 0.2))
            .border(Color(red: 0, green: 0, blue: 255))
    }
}

extension String {
    static var longText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam mattis mauris sed ornare gravida. In congue lorem dui, nec euismod ligula feugiat ut. Maecenas pharetra lacus eget aliquet tristique. Aenean ornare est nec odio scelerisque ullamcorper. Maecenas semper, metus vel vestibulum ullamcorper, est elit maximus risus, sed ultrices elit turpis id urna. Phasellus ut nulla sit amet erat cursus egestas. Nullam pulvinar auctor dui placerat congue. Maecenas a venenatis leo, nec mollis odio. Nunc sit amet cursus orci. Duis sodales sagittis risus, ultrices ornare lorem. Aliquam sed aliquam augue, id iaculis quam. Etiam ut maximus tortor. Integer finibus ex et tortor accumsan pretium. Vivamus consequat leo id ipsum gravida imperdiet. Fusce sem tellus, sodales quis sapien eu, maximus aliquet metus. Nulla laoreet tristique suscipit. Vivamus fermentum semper augue, posuere auctor libero euismod venenatis. Integer nibh purus, vulputate vitae convallis sed, pulvinar faucibus augue. In quis tortor blandit, mollis felis vel, elementum lorem. Ut elementum ligula sit amet nulla mattis vulputate. Nulla convallis, massa a bibendum tincidunt, felis ligula suscipit lacus, a hendrerit massa eros ut erat. Proin id dolor lacinia magna posuere ullamcorper. Duis eu lacinia ante. Nullam non diam faucibus, lacinia mauris a, sagittis felis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris eget luctus purus. Maecenas maximus pretium purus quis blandit. Aliquam felis ligula, ullamcorper semper lobortis id, commodo vel eros. Donec congue dapibus nulla et sodales. Suspendisse neque quam, molestie et leo eu, viverra congue sem. Curabitur ac eros sit amet ex molestie condimentum. Nulla facilisi. Maecenas sit amet urna urna. Proin ullamcorper tempor blandit. Ut sollicitudin orci in massa malesuada, eget luctus velit euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id congue nunc. Suspendisse rhoncus lobortis eros at tempor. In hac habitasse platea dictumst. Nunc eu enim auctor, blandit diam at, ornare arcu. Donec a consectetur urna, non tincidunt libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent eget pretium dolor. Fusce erat sapien, vulputate eget tortor ac, aliquam aliquam magna."
}

struct SizingContainer<Content: View>: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100

    var content: Content

    var body: some View {
        ZStack {
            content
                .redColored()
                .frame(width: width, height: height, alignment: .center)
                .greenColored()
                .padding(.bottom, 20)

            VStack {
                Spacer()

                VStack(alignment: .leading) {
                    HStack {
                        Text("Offered width")
                        Spacer()
                        Text("\(Int(width))")
                    }
                    Slider(value: $width, in: 0...400, step: 1)

                    HStack {
                        Text("Offered height")
                        Spacer()
                        Text("\(Int(height))")
                    }
                    Slider(value: $height, in: 0...400, step: 1)
                }
                .background(Color.white)
            }
            .padding()
            .frame(width: 375, height: 600)
        }
    }

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}
