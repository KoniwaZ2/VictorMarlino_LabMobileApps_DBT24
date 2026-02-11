import '../models/user_model.dart';
import '../models/story_model.dart';
import '../models/post_model.dart';
import '../models/message_model.dart';

final List<User> users = [
  User(
    id: '1',
    name: 'Alice Johnson',
    imageURL: 'https://picsum.photos/100/100?random=201',
    lastMessage: 'Hey! How are you?',
  ),
  User(
    id: '2',
    name: 'Bob Smith',
    imageURL: 'https://picsum.photos/100/100?random=202',
    lastMessage: 'Let\'s catch up later.',
  ),
  User(
    id: '3',
    name: 'Catherine Lee',
    imageURL: 'https://picsum.photos/100/100?random=203',
    lastMessage: 'Check out this photo!',
  ),
  User(
    id: '4',
    name: 'David Brown',
    imageURL: 'https://picsum.photos/100/100?random=204',
    lastMessage: 'See you at the meeting.',
  ),
  User(
    id: '5',
    name: 'Eva Green',
    imageURL: 'https://picsum.photos/100/100?random=205',
    lastMessage: 'Happy Birthday!',
  ),
];

final List<Post> posts = [
  Post(
    imageUrls: [
      'https://picsum.photos/600/600?random=1',
      'https://picsum.photos/600/600?random=2',
    ],
    caption: 'Sunset at the beach 🌅',
    timestamp: DateTime.now().subtract(Duration(hours: 2)),
    userId: '1',
  ),
  Post(
    imageUrls: [
      'https://picsum.photos/600/600?random=3',
      'https://picsum.photos/600/600?random=4',
      'https://picsum.photos/600/600?random=5',
    ],
    caption: 'Mountain hiking adventure 🏔️',
    timestamp: DateTime.now().subtract(Duration(days: 1)),
    userId: '2',
  ),
  Post(
    imageUrls: ['https://picsum.photos/600/600?random=6'],
    caption: 'City lights at night 🌃',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
    userId: '3',
  ),
  Post(
    imageUrls: [
      'https://picsum.photos/600/600?random=7',
      'https://picsum.photos/600/600?random=8',
    ],
    caption: 'Delicious homemade meal 🍝',
    timestamp: DateTime.now().subtract(Duration(days: 2)),
    userId: '4',
  ),
  Post(
    imageUrls: [
      'https://picsum.photos/600/600?random=9',
      'https://picsum.photos/600/600?random=10',
      'https://picsum.photos/600/600?random=11',
    ],
    caption: 'Relaxing in the park 🌳',
    timestamp: DateTime.now().subtract(Duration(hours: 10)),
    userId: '5',
  ),
];

final List<Story> stories = [
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=101',
    userName: 'Alice Johnson',
  ),
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=102',
    userName: 'Bob Smith',
  ),
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=103',
    userName: 'Catherine Lee',
  ),
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=104',
    userName: 'David Brown',
  ),
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=105',
    userName: 'Eva Green',
  ),
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=106',
    userName: 'Frank White',
  ),
  Story(
    imageUrl: 'https://picsum.photos/200/200?random=107',
    userName: 'Grace Black',
  ),
];

// Mock messages for each user
Map<String, List<Message>> userMessages = {
  '1': [
    Message(text: 'Hey! How are you?', isMe: false, time: '10:30 AM'),
    Message(text: 'I\'m doing great, thanks!', isMe: true, time: '10:32 AM'),
    Message(text: 'What have you been up to?', isMe: false, time: '10:33 AM'),
    Message(
      text: 'Just working on some Flutter projects',
      isMe: true,
      time: '10:35 AM',
    ),
    Message(text: 'That sounds interesting!', isMe: false, time: '10:36 AM'),
    Message(
      text: 'Yeah, it\'s been fun learning new things',
      isMe: true,
      time: '10:40 AM',
    ),
  ],
  '2': [
    Message(text: 'Hi there!', isMe: false, time: 'Yesterday'),
    Message(text: 'Hello! What\'s up?', isMe: true, time: 'Yesterday'),
    Message(text: 'Let\'s catch up later.', isMe: false, time: 'Yesterday'),
    Message(text: 'Sure, sounds good!', isMe: true, time: 'Yesterday'),
    Message(text: 'How about tomorrow?', isMe: false, time: 'Yesterday'),
  ],
  '3': [
    Message(
      text: 'Did you see my latest post?',
      isMe: false,
      time: '2 hours ago',
    ),
    Message(text: 'Not yet, let me check!', isMe: true, time: '2 hours ago'),
    Message(text: 'Check out this photo! 📸', isMe: false, time: '1 hour ago'),
    Message(text: 'Wow, that\'s amazing!', isMe: true, time: '1 hour ago'),
  ],
  '4': [
    Message(
      text: 'Don\'t forget about our meeting',
      isMe: false,
      time: '3 days ago',
    ),
    Message(text: 'Thanks for the reminder!', isMe: true, time: '3 days ago'),
    Message(text: 'See you at the meeting.', isMe: false, time: '3 days ago'),
    Message(text: 'See you there! 👍', isMe: true, time: '2 days ago'),
  ],
  '5': [
    Message(text: 'Happy Birthday! 🎉', isMe: false, time: 'Last week'),
    Message(text: 'Thank you so much! 🎂', isMe: true, time: 'Last week'),
    Message(
      text: 'Hope you have a wonderful day!',
      isMe: false,
      time: 'Last week',
    ),
    Message(text: 'You\'re the best! ❤️', isMe: true, time: 'Last week'),
  ],
};
