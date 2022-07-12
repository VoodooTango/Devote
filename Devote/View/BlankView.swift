//
//  BlankView.swift
//  Devote
//
//  Created by MAC on 11/07/22.
//

import SwiftUI

struct BlankView: View {
    //MARK: PROPERTIES
    var backgroundColor: Color
    var backgroundOppacity: Double
    
    
    //MARK: BODY
    var body: some View {
        VStack{
            Spacer()
        }//: VSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOppacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}
  //MARK: PREVIEW
struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, backgroundOppacity: 0.3)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
