import 'package:credi_q_tech_test/models/game.dart';
import 'package:credi_q_tech_test/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetails extends ConsumerStatefulWidget {
  final Game selectedGame;
  final int? additionalId;

  const GameDetails({super.key, required this.selectedGame, this.additionalId});

  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends ConsumerState<GameDetails> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;
  bool _showProductTitleOnBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double newOpacity = (offset / 100).clamp(0.0, 1.0);
    setState(() {
      _showProductTitleOnBar = offset >= 190;
    });
    if (newOpacity != _appBarOpacity) {
      setState(() {
        _appBarOpacity = newOpacity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final shoppingCart = ref.watch(shoppingCartProvider);
    final shoppingCartNotifier = ref.read(shoppingCartProvider.notifier);

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: screenHeight / 4,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.onPrimary.withValues(alpha: _appBarOpacity),
              elevation: 0,
              title:
                  (_showProductTitleOnBar)
                      ? Text(
                        widget.selectedGame.title,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                      : Container(),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => Navigator.pop(context),
              ),

              /// Imagen del producto
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag:
                      "${widget.selectedGame.id}${(widget.additionalId != null) ? "-${widget.additionalId}" : ""}",
                  child: ClipRect(
                    child: Image.network(
                      widget.selectedGame.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Product Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                widget.selectedGame.title,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                widget.selectedGame.publisher,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.public),
                            onPressed: () {
                              final Uri url = Uri.parse(
                                widget.selectedGame.gameUrl,
                              );
                              launchUrl(url);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      /// Product Description
                      Text(
                        widget.selectedGame.shortDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 20),

                      /// Basic Info
                      Column(
                        spacing: 12,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.category_outlined, size: 30),
                              Text(
                                widget.selectedGame.genre,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.devices, size: 30),
                              Text(
                                widget.selectedGame.platform,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.groups, size: 30),
                              Text(
                                widget.selectedGame.developer,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.calendar_month, size: 30),
                              Text(
                                widget.selectedGame.releaseDate,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),

                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 10,
                        children: [
                          Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/ESRB_Teen.svg/1468px-ESRB_Teen.svg.png",
                            height: 120,
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "Derramamiento de sangre, Humor negro, Lenguaje, Violencia",
                              style: Theme.of(context).textTheme.bodyLarge,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque odio ipsum, gravida et ipsum sed, malesuada accumsan ipsum. Vestibulum at massa ex. Donec quis turpis et mi blandit vehicula sed quis nisl. Ut pretium varius nibh, eget vulputate libero. Aliquam aliquam nisi eu justo aliquet malesuada. Sed placerat convallis nibh a eleifend. Pellentesque eget suscipit neque, quis auctor erat. Nunc ut magna in justo sollicitudin dapibus euismod sed mi. Suspendisse non nunc libero. Donec non condimentum sapien, ac faucibus justo. Quisque sit amet leo nisi. Phasellus eget tellus quis risus fringilla auctor nec nec lorem. Cras vestibulum eu mi ut ultricies. Sed ullamcorper vitae arcu at molestie. Proin congue fringilla justo, vel gravida tortor gravida sit amet. Donec quis turpis quis nisl consequat posuere at et orci. Fusce quis augue eu est fringilla pellentesque quis in sapien. Nullam a magna augue. Praesent arcu purus, rhoncus eget congue a, porta sit amet sapien. Pellentesque in pulvinar nunc. Aenean sodales sapien ut venenatis lobortis. Praesent et nisl a dolor gravida placerat. Vivamus sit amet purus semper, dapibus tortor sit amet, tempus urna. Praesent tempus, libero tempus rutrum fermentum, ante est vestibulum felis, non elementum sem dolor ultricies est. Curabitur sit amet erat id lectus tincidunt bibendum nec in nisi. Aliquam consequat felis augue, vel mollis nisl efficitur nec.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Sticky Bottom Section
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if(!shoppingCart.contains(widget.selectedGame)){
                          shoppingCartNotifier.addNewItem(widget.selectedGame);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF578FCA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          // AppLocalizations.of(context)!.add,
                          !shoppingCart.contains(widget.selectedGame)
                              ? "Agregar"
                              : "En el carrito",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
