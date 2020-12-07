//
//  PresentDemoView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 06.12.2020.
//

import SwiftUI

struct PresentDemoView: View {
    @State private var isShowingDetail = false

    var body: some View {
        Button(
            action: { self.isShowingDetail.toggle() },
            label: { Text("Show Advanced Detail") }
        )
        .sheet(isPresented: $isShowingDetail) {
            NavigationView {
                AdvancedDetailView(isShowingDetail: self.$isShowingDetail)
            }
        }

        // obdoba .present() v UIKit
    }

    struct AdvancedDetailView: View {
        @Environment(\.presentationMode) var presentationMode
        @Binding var isShowingDetail: Bool

        var body: some View {
            VStack(spacing: 20) {
                Button("Presentation mode dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }

                Button("Binding dismiss") {
                    self.isShowingDetail = false
                }

                Divider()

                NavigationLink(destination: AdvancedDetailView(isShowingDetail: self.$isShowingDetail)) {
                    Text("Another Detail View")
                }

            }.navigationBarTitle("Advanced Detail")
        }
    }
}

struct PresentView_Previews: PreviewProvider {
    static var previews: some View {
        PresentDemoView()
    }
}
