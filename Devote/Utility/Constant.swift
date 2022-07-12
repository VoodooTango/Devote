//
//  Constant.swift
//  Devote
//
//  Created by MAC on 11/07/22.
//

import SwiftUI
//MARK: FROMATTER

    let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: UI
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

//MARK: UX

let feedback = UINotificationFeedbackGenerator()
