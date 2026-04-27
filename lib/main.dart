import 'package:flutter/material.dart';

void main() {
  runApp(const KampalaNightsApp());
}

class KampalaNightsApp extends StatelessWidget {
  const KampalaNightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kampala Nights',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0E1116),
      ),
      home: const EventsHomeScreen(),
    );
  }
}

class Event {
  const Event({
    required this.title,
    required this.venue,
    required this.date,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  final String title;
  final String venue;
  final String date;
  final String price;
  final String imageUrl;
  final String category;
  final String description;
}

void _navigateToBookingSuccess(BuildContext context, Event event) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => BookingProcessingScreen(event: event),
    ),
  );
}

const List<String> categories = <String>[
  'All',
  'Afrobeats',
  'Amapiano',
  'Live Band',
  'DJ Sets',
  'Rooftop',
];

const List<Event> events = <Event>[
  Event(
    title: 'Afro Pulse Fridays',
    venue: 'Nexus Lounge, Kololo',
    date: 'Fri, 8:00 PM',
    price: 'UGX 25,000',
    imageUrl: 'https://images.unsplash.com/photo-1470229538611-16ba8c7ffbd7',
    category: 'Afrobeats',
    description:
        'Kick off your weekend with Kampala\'s hottest Afrobeats DJs, laser lights, and signature cocktails.',
  ),
  Event(
    title: 'Amapiano Skyline',
    venue: 'Altitude Rooftop',
    date: 'Sat, 9:30 PM',
    price: 'UGX 35,000',
    imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30',
    category: 'Amapiano',
    description:
        'A premium rooftop experience with deep Amapiano grooves and a panoramic city view.',
  ),
  Event(
    title: 'Live Jazz & Soul Night',
    venue: 'Theatre La Bonita',
    date: 'Sun, 7:00 PM',
    price: 'UGX 20,000',
    imageUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819',
    category: 'Live Band',
    description:
        'Unwind with Kampala\'s finest live band performances featuring jazz, neo-soul, and unplugged sets.',
  ),
];

class EventsHomeScreen extends StatefulWidget {
  const EventsHomeScreen({super.key});

  @override
  State<EventsHomeScreen> createState() => _EventsHomeScreenState();
}

class _EventsHomeScreenState extends State<EventsHomeScreen> {
  String selectedCategory = 'All';

  List<Event> get filteredEvents {
    if (selectedCategory == 'All') {
      return events;
    }
    return events.where((Event e) => e.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: <Widget>[
            const Icon(Icons.location_on_outlined, size: 20),
            const SizedBox(width: 6),
            Text(
              'Kampala',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: <Widget>[
          _SearchBar(),
          const SizedBox(height: 16),
          _CategoryChips(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: (String category) {
              setState(() => selectedCategory = category);
            },
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'Featured Tonight',
            subtitle: 'Top picks around the city',
          ),
          const SizedBox(height: 12),
          _FeaturedCarousel(featuredEvents: events.take(2).toList()),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'Popular Events',
            subtitle: '${filteredEvents.length} events available',
          ),
          const SizedBox(height: 12),
          ...filteredEvents.map((Event event) => _EventCard(event: event)),
        ],
      ),
    );
  }
}
