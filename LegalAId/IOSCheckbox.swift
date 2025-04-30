//
//  IOSCheckbox.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/24/25.
//
import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()

        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")

                configuration.label
            }
        })
        .foregroundColor(.black)
    }
}
