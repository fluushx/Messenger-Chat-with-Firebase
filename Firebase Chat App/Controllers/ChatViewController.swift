//
//  ChatViewController.swift
//  Firebase Chat App
//
//  Created by Felipe Ignacio Zapata Riffo on 09-09-21.
//

import UIKit
import MessageKit

struct Message:MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender:SenderType {
    var senderId: String
    var displayName: String
    var photoURL: String
}

struct Media:MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}


class ChatViewController: MessagesViewController {
    
    let currentUser = Sender(senderId: "First", displayName: "First Person", photoURL: "")
    let anotherUser = Sender(senderId: "Second", displayName: "Second Person", photoURL: "")
    var message = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .red
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate =  self
        setUpMessage()
        
    }
    
    func setUpMessage(){
        message.append(Message(sender: currentUser,
                               messageId: "1",
                               sentDate: Date().addingTimeInterval(-86400),
                               kind: .text("hello it's me, it's been a long time")))
        message.append(Message(sender: anotherUser,
                               messageId: "2",
                               sentDate: Date().addingTimeInterval(-86400),
                               kind: .text("hi! how are you?")))
    }
    
     
    
    
}
extension ChatViewController:MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate {
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return message[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        message.count
    }
}
