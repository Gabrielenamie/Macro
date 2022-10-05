//
//  SpentsDetailsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsDetailsCardView: View {
    var body: some View {
        HStack {
            ZStack {
                Color(EnumColors.essenciaisColor.rawValue)
                    .cornerRadius(10)
                Image(systemName: "car.fill")
                    .foregroundColor(.white)
            }.frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9, alignment: .leading)
            VStack {
                Text("Roda carro")
                    .font(.custom(EnumFonts.medium.rawValue, size: 17))
                Text("25/09/2021")
                    .font(.custom(EnumFonts.light.rawValue, size: 13))
            }
            Spacer()
            Text("R$199,99")
                .font(.custom(EnumFonts.medium.rawValue, size: 20))
                .padding()
        }
    }
}

struct SpentsDetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsDetailsCardView()
    }
}
