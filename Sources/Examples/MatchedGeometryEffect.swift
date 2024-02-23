// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

struct Example_MatchedGeometryEffect: View {
    @Namespace private var animation
    @State private var isZoomed = false

    var frame: Double {
        self.isZoomed ? 300 : 44
    }

    var body: some View {
        VStack {
            Spacer()

            VStack {
                HStack {
                    if self.isZoomed == false {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .matchedGeometryEffect(id: "Color", in: self.animation)
                            .frame(width: 44, height: 44)

                        Text("Taylor Swift – 1989")
                            .matchedGeometryEffect(id: "AlbumTitle", in: self.animation)
                            .font(.headline)
                        Spacer()
                    }
                }

                if self.isZoomed == true {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .matchedGeometryEffect(id: "Color", in: self.animation)
                        .frame(width: 300, height: 300)
                        .padding(.top, 20)

                    Text("Taylor Swift – 1989")
                        .matchedGeometryEffect(id: "AlbumTitle", in: self.animation)
                        .font(.headline)
                        .padding(.bottom, 60)
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    self.isZoomed.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            .background(Color(white: 0.9))
            .foregroundColor(.black)
        }
    }
}

struct Example_MatchedGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        Example_MatchedGeometryEffect()
    }
}
