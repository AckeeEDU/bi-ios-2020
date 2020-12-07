//
//  BasicsView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

struct BasicsView: View {

    var body: some View {
        // VStack
//        VStack(alignment: .leading, spacing: 0) {
//            Text("VStack")
//            Text("lays")
//            Text("things")
//            Text("out")
//            Text("vertically")
//        }

        // HStack
//        HStack {
//            Text("HStack")
//            Text("does")
//            Text("the same")
//            Text("horizontally")
//        }

        // ZStack
//        ZStack {
//            Circle()
//                .foregroundColor(.yellow)
//                .frame(width: 200, height: 200)
//            Text("ZStack Uses the Y axis!")
//        }

        // Image + SF Symbols
//        Image(systemName: "flame")
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 100)

        // Shapes
//        VStack(spacing: 16) {
//            Rectangle()
//                .foregroundColor(.blue)
//                .frame(width: 100, height: 50)
//
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundColor(.yellow)
//                .frame(width: 100, height: 50)
//
//            Circle()
//                .foregroundColor(.red)
//                .frame(width: 100, height: 50)
//
//            Capsule()
//                .foregroundColor(.green)
//                .frame(width: 100, height: 50)
//
//            Path { path in
//                path.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 50))
//            }
//            .foregroundColor(.purple)
//            .frame(width: 100, height: 50)
//        }

        // TabView

//        TabView {
//            RedView()
//                .tabItem {
//                    Image(systemName: "list.dash")
//                    Text("Tab 1")
//                }
//
//            BlueView()
//                .tabItem {
//                    Image(systemName: "square.and.pencil")
//                    Text("Tab 2")
//                }
//        }

        // NavigationView + List
//
//        NavigationView {
//            List(0...50, id: \.self) { index in
//                NavigationLink(destination: DetailView(title: "\(index)")) {
//                    Text("List row \(index)")
//                }
//            }
//            .navigationBarTitle("Messages")
//        }

        // NavigationView + ForEach

//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    ForEach(0...50, id: \.self) { index in
//                        NavigationLink(destination: DetailView(title: "\(index)")) {
//                            HStack {
//                                Text("List row \(index)")
//                                Spacer()
//                                Image(systemName: "arrow.right")
//                            }.padding()
//                        }.buttonStyle(PlainButtonStyle())
//                    }
//                }
//            }
//            .navigationBarTitle("Title of the list")
//            .navigationBarItems(trailing: Button("Help") { print("Help") })
//        }

        // ScrollView + LazyVGrid, LazyHGrid - iOS 14+

        /*
         GridItem
         - .flexible
         - .adaptive
         - .fixed
         */

//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(data, id: \.self) { item in
//                    Text(item)
//                        .padding()
//                        .border(Color.blue, width: 1)
//                }
//            }
//            .animation(.easeInOut)
//            .padding(.horizontal)
//        }

        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridLayout, alignment: .center) {
                    ForEach(data, id: \.self) { item in
                        Group {
                            Text(item)
                                .padding()
                                .border(Color.blue, width: 1)
                                .redColored()
                        }
                        .padding()
                        .greenColored()
                    }
                }
                .blueColored()
                .animation(.easeInOut)
            }

            Button("Magic") {
                self.gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 4 + 1)
            }
        }
    }

    let data = (1...1000).map { "Item \($0)" }

//    let columns = [
//        GridItem(.adaptive(minimum: 80))
//    ]

//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]

//    let columns = [
//        GridItem(.fixed(100)),
//        GridItem(.flexible()),
//    ]

    @State var gridLayout = [GridItem(.fixed(100))]
}

struct BasicsContentView_Previews: PreviewProvider {
    static var previews: some View {
        BasicsView()

    }
}

struct RedView: View {
    var body: some View {
        Text("Tab 1")
            .background(Color.red)
    }
}
struct BlueView: View {
    var body: some View {
        Text("Tab 2")
            .background(Color.blue)
    }
}

struct DetailView: View {
    let title: String

    var body: some View {
        Text("Detail of index \(title)")
            .navigationBarTitle("Detail title", displayMode: .inline)
    }
}
