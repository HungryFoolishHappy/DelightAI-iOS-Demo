//
//  AILogo.swift
//  DelightAIApp
//
//  Created by Delight Team on 10/7/2024.
//

import SwiftUI

struct AILogo: View {

    let text: String
    @State private var radius: CGFloat = .zero

    var body: some View {
        
        return ZStack {
            Image(
                "DelightChatbotAI",
                label: Text("DelightChatbotAI")
            ).resizable()
                .frame(width: 40, height: 40)
            
        }
     
    }
}

#Preview {
    AILogo(text: "AI")
}
