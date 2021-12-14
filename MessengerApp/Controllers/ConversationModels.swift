//
//  ConversationModels.swift
//  MessengerApp
//
//  Created by Chukwuemeka Jennifer on 01/12/2021.
//

import Foundation
struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}
struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
