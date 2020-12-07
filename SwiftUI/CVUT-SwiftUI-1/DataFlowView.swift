//
//  DataFlowView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

struct DataFlowView: View {
    // State
    @State var count: Int = 0
    @State var text: String = ""
    @State var isShowingAlert = false

    var body: some View {
        // MARK: - Button + State

//        VStack {
//            Text("\(count)")
//
//            Divider()
//
//            HStack {
//                Button("Increment") {
//                    count += 1
//                }
//
//                Button("Decrement") {
//                    count -= 1
//                }
//            }
//        }

        // MARK: - Button + State + Binding

//        VStack {
//            Text("\(count)")
//
//            Divider()
//
//            ButtonsView(
//                incrementButtonTitle: "Increment",
//                count: $count
//            )
//        }


        // MARK: - TextField + State

//        VStack {
//            Text("Current text: \(text)")
//            TextField("Placeholder", text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }.padding()


        // MARK: - Alert + State

        VStack {
            Spacer()

            Button(action: {
                self.isShowingAlert = true
            }, label: {
                Text("Show alert")
                    .font(.headline)
            })

            Spacer()

            Text("Just some other view")
                .font(.footnote)
        }
        .padding(.vertical, 50)
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Hello"),
                message: Text("Message")
            )

//            Alert(
//                title: Text("Title"),
//                message: Text("Message"),
//                primaryButton: .cancel(),
//                secondaryButton: .destructive(Text("Destruct"), action: { print("destruct") } )
//            )
        }

        // MARK: - Present modal + State

    }
}

struct DataFlowView_Previews: PreviewProvider {
    static var previews: some View {
        DataFlowView()
    }
}

struct ButtonsView: View {
    let incrementButtonTitle: String
    let decrementButtonTitle: String = "Decrement"

    @Binding var count: Int

    var body: some View {
        HStack {
            Button(incrementButtonTitle) {
                count += 1
            }

            Button(decrementButtonTitle) {
                count -= 1
            }
        }
    }
}
