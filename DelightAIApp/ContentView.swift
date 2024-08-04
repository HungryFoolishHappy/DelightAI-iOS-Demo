//
//  ContentView.swift
//  DelightAIApp
//
//  Created by Delight Team on 2/7/2024.
//
import SwiftUI

struct ContentView: View {
    var webhookId: String = "a4b404d4-5f9a-4617-a5a4-8ea338352eb4"
    var userId: String = "Wi-123-123-123-123"
    var username: String = "test"
    
    @ObservedObject private var viewModel = ContentViewModel()
    @State var text = ""
    @State var chatList = [Message]()
    @State var isLoading = false
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView() {
                    VStack(spacing: 0) {
                        ForEach(viewModel.chatList, id: \.self) {
                            message in
                            MessageView(currentMessage: message).id(message.id)
                        }
                    }
                }.onChange(of: viewModel.chatList[viewModel.chatList.count - 1].text) {
                    proxy.scrollTo(viewModel.chatList[viewModel.chatList.count - 1].id, anchor: .bottom)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                HStack {
                    TextField("Ask me anything ...", text: $text)
                    Button("Send") {
                        if (!isLoading) {
                            viewModel.sendChat(text: text, webhookId: webhookId, userId: userId, username: username)
                            text = ""
                        }
                        
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
