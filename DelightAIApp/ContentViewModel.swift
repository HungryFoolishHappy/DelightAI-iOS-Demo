//
//  ContentViewModel.swift
//  DelightAIApp
//
//  Created by Delight Team on 2/7/2024.
//
import Foundation
import DelightAI

final class ContentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var chatList = [Message(text: "Welcome", isUser: false)]
    @Published var isSending = false

    func sendChat(text: String, webhookId: String, userId: String, username: String) {
        isLoading = true
        
        Task { @MainActor [weak self] in
            guard let self else { return }
            let waitingRepsonseText = "waiting for the response ..."
            chatList.append(Message(text: text, isUser: true))
            chatList.append(Message(text: waitingRepsonseText, isUser: false))
            
            var tryAttemp = 30
            
            let delight = DelightAI()
            do {
                let result = try await delight.sendChat(text: text,
                                                    webhookId: webhookId,
                                                    userId: userId,
                                                    username: username)
                
                var isContinue = true
                while(isContinue){
                    tryAttemp = tryAttemp - 1
                    
                    let pollingResult = try await delight.polling(pollingUrl: result.poll)

                    var new_tokens = ""
                    if let _ = pollingResult.new_tokens {
                        new_tokens = pollingResult.new_tokens!
                    }
                    if (pollingResult.completed) {
                        chatList[chatList.count - 1] = Message(text: pollingResult.text!, isUser: false)
                        isContinue = false
                        isLoading = false
                    } else if (new_tokens != "") {
                        var content = chatList[chatList.count - 1].text
                        if (chatList[chatList.count - 1].text == waitingRepsonseText) {
                            content = ""
                        }
                        chatList[chatList.count - 1] = Message(text: "\(content) \(pollingResult.new_tokens!)", isUser: false)
                    }
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    if (tryAttemp == 0) {
                        isContinue = false
                        isLoading = false
                        chatList[chatList.count - 1] = Message(text: "Error, please try later.", isUser: false)
                    }
                }
                
                
//                switch result {
//                case .success(let success):
//                    chatList[chatList.count - 1] = Message(text: success.text!, isUser: false)
//                case .failure(let error):
//                    chatList[chatList.count - 1] =
//                    Message(text: error.localizedDescription, isUser: false)
//                }
            } catch {
                chatList[chatList.count - 1] = Message(text: error.localizedDescription, isUser: false)
                isLoading = false
            }
        }
    }
}
