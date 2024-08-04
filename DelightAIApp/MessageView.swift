//
//  MessageView.swift
//  DelightAIApp
//
//  Created by Delight team on 10/7/2024.
//

import SwiftUI

struct MessageView : View {
    var currentMessage: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if !currentMessage.isUser {
                AILogo(text: "AI")
            } else {
                Spacer()
            }
            MessageCell(text: currentMessage.text,
                        isUser: currentMessage.isUser)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}


#Preview {
    MessageView(currentMessage: Message(text: "Welcome to Delight", isUser: false))
}
