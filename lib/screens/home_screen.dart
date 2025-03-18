import 'package:cached_network_image/cached_network_image.dart';
import 'package:credi_q_tech_test/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../services/game_service.dart';
import '../models/game.dart';
import 'game_details.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late GameService gameService;
  List<Game> games = [];
  List<Game> carouselGames = []; // For the carousel section

  @override
  void initState() {
    super.initState();
    gameService = GameService();
    loadGames();
  }

  void loadGames() async {
    try {
      List<Game> fetchedGames = await gameService.fetchGames();
      setState(() {
        games = fetchedGames;
        carouselGames = games.take(5).toList(); // Select a few games for the carousel
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load games: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(shoppingCartProvider);
    final itemCount = cartItems.length;

    double screenWidth = MediaQuery.of(context).size.width;
    int gridCount =
        screenWidth < 600
            ? 2
            : screenWidth < 1000
            ? 3
            : 4;

    return Scaffold(
      body:
          games.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  // Section with image, text, and button
                  Container(
                    color: Colors.blueGrey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://media.istockphoto.com/id/2151742586/photo/abstract-3d-composition-of-blue-purple-and-glass-shapes-floating-in-the-air-against-a-grey.jpg?s=1024x1024&w=is&k=20&c=uRrumQaVkW1Uw3m6epehgKdTG-6RU9JVxTAHcv5OXnc=',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                          errorWidget:
                              (context, url, error) => Icon(Icons.error),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to the NeoGame',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Explore and enjoy a wide variety of games!',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal: 20,
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF578FCA),
                                                borderRadius: BorderRadius.circular(
                                                  20,
                                                ),
                                              ),
                                              child: Text(
                                                // AppLocalizations.of(context)!.add,
                                                "Explora más",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Carousel Section
                  Container(
                    height: 250, // Set the height for the carousel
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: carouselGames.length,
                      itemBuilder: (context, index) {
                        final game = carouselGames[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => GameDetails(
                                      selectedGame: game,
                                      additionalId: null,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            width: 150,
                            child: Column(
                              children: [
                                Hero(
                                  tag: game.id,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: game.thumbnail,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  game.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Grid View Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      // To make the grid scrollable within the list
                      physics: NeverScrollableScrollPhysics(),
                      // Prevent scrolling within GridView
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final game = games[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => GameDetails(
                                      selectedGame: game,
                                      additionalId: 2,
                                    ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: "${game.id}-2",
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: game.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            shape: CircleBorder(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.shopping_cart), Text("${itemCount}")],
            ),
          ),
        ],
      ),
    );
  }
}
