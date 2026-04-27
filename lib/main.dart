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

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search events, venues, DJs...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _FeaturedCarousel extends StatelessWidget {
  const _FeaturedCarousel({required this.featuredEvents});

  final List<Event> featuredEvents;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.88),
        itemCount: featuredEvents.length,
        itemBuilder: (BuildContext context, int index) {
          final Event event = featuredEvents[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(event.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${event.venue} · ${event.date}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.04),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => EventDetailsScreen(event: event),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  event.imageUrl,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.venue,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white60,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Text(
                          event.price,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            _navigateToBookingSuccess(context, event);
                          },
                          child: const Text('Book Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(event.title),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(event.imageUrl, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      Chip(label: Text(event.category)),
                      Chip(label: Text(event.date)),
                      Chip(label: Text(event.price)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('Venue'),
                    subtitle: Text(event.venue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'About this event',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        _navigateToBookingSuccess(context, event);
                      },
                      icon: const Icon(Icons.confirmation_number_outlined),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Book Now'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
