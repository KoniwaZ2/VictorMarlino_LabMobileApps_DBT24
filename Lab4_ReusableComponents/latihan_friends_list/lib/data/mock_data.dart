import '../models/user_model.dart';
import '../models/message_model.dart';

final List<UserModel> friendsData = [
  UserModel(
    id: "1",
    name: "Vincent",
    imageUrl: "https://example.com/vincent.jpg",
    lastMessage: "Hey there!",
  ),
  UserModel(
    id: "2",
    name: "Sophia",
    imageUrl: "https://example.com/sophia.jpg",
    lastMessage: "Let's catch up soon.",
  ),
  UserModel(
    id: "3",
    name: "Liam",
    imageUrl: "https://example.com/liam.jpg",
    lastMessage: "Did you see the game last night?",
  ),
  UserModel(
    id: "4",
    name: "Olivia",
    imageUrl: "https://example.com/olivia.jpg",
    lastMessage: "Happy Birthday!",
  ),
  UserModel(
    id: "5",
    name: "Noah",
    imageUrl: "https://example.com/noah.jpg",
    lastMessage: "Call me when you're free.",
  ),
];

final List<MessageModel> messagesData = [
  MessageModel(text: "Hello", isMe: true, time: "2024-06-01 10:00:00"),
  MessageModel(text: "Hi there!", isMe: false, time: "2024-06-01 10:01:00"),
  MessageModel(text: "How are you?", isMe: true, time: "2024-06-01 10:02:00"),
  MessageModel(
    text: "I'm good, thanks!",
    isMe: false,
    time: "2024-06-01 10:03:00",
  ),
];
