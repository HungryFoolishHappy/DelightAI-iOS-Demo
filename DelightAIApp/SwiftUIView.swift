//
//  SwiftUIView.swift
//  DelightAIApp
//
//  Created by Delight Team on 10/7/2024.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var webhookId: String = "a4b404d4-5f9a-4617-a5a4-8ea338352eb4"
    @State private var userId: String = "Wi-iOS-9937-491d-aefd-02e6b89ff0aa"
    @State private var username: String = "Wi-iOS-9937-491d-aefd-02e6b89ff0aa"
    
    var body: some View {
        NavigationStack{
            Image("DelightLogo", label: Text("DelightLogo"))            
            Spacer()
            Text("Delight Demo").font(.title2)
            
            Form {
                HStack{
                    Text("Webhook Id").frame(width: 100, alignment: .leading)
                    TextField("Required", text: $webhookId)
                }
                
                HStack{
                    Text("Username").frame(width: 100, alignment: .leading)
                    TextField("Required", text: $username)
                }
                
                HStack{
                    Text("User Id").frame(width: 100, alignment: .leading)
                    TextField("Required", text: $userId)
                }
            }
            
            NavigationLink(destination: ContentView(webhookId: webhookId, userId: userId, username: username)) {
                Text("Submit")
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
