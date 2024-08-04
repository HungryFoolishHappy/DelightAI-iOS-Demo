//
//  MessageCell.swift
//  DelightAIApp
//
//  Created by Delight Team on 10/7/2024.
//

import SwiftUI

struct Message: Hashable {
    var id = UUID()
    var text: String
    var isUser: Bool
}

struct MessageCell: View {
    var text: String
    var isUser: Bool
    
    var body: some View {
        Text(text)
            .padding(10)
            .foregroundColor(isUser ? Color.white : Color.black)
            .background(isUser ? Color.blue : Color(UIColor.systemGray6 ))
            .cornerRadius(10)
    }
}

#Preview {
    MessageCell(text: "This is a single message cell.", isUser: true)
}
