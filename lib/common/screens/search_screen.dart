import 'package:corre_aqui/common/widgets/no_data_found_widget.dart';
import 'package:corre_aqui/common/widgets/components/search_result_card_widget.dart';
import 'package:corre_aqui/features/event/controllers/event_controller.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  bool _isListening = false;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          if (_isListening) {
            _animationController.forward();
          }
        }
      });
  }

  void _startListening() {
    if (!_isListening) {
      setState(() {
        _isListening = true;
        _animationController.forward();
      });
    }
  }

  void _stopListening() {
    if (_isListening) {
      setState(() {
        _isListening = false;
      });
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
          decoration: InputDecoration(
            hintText: "Buscar produtos, lojas e mais...",
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: GestureDetector(
              onTapDown: (_) => _startListening(),
              onTapUp: (_) => _stopListening(),
              child: ScaleTransition(
                scale: _animationController,
                child: Icon(
                  Icons.mic,
                  color: _isListening ? Colors.red : Colors.grey,
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<StoreController>(
          builder: (storeController) {
            return GetBuilder<EventController>(
              builder: (eventController) {
                return GetBuilder<OfferController>(
                  builder: (offerController) {
                    if (_searchQuery.isEmpty) {
                      return const Center(
                        child: Text("Digite algo para iniciar a busca."),
                      );
                    }

                    final searchResults = [
                      ...storeController.stores
                          .where((store) => store.name.toLowerCase().contains(_searchQuery))
                          .map((store) => _buildSearchItem(store.name, "Loja", store.imageUrl)),
                      ...eventController.eventList
                          .where((event) => event.name.toLowerCase().contains(_searchQuery))
                          .map((event) => _buildSearchItem(event.name, "Evento", event.imageUrl)),
                      ...offerController.offerList
                          .where((offer) => offer.name.toLowerCase().contains(_searchQuery))
                          .map((offer) => _buildSearchItem(offer.name, "Oferta", offer.imageUrl)),
                    ];

                    return searchResults.isNotEmpty
                        ? ListView(
                            children: searchResults.toList(),
                          )
                        : Center(
                            child: NoDataFoundWidget(),
                          );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchItem(String title, String category, String imageUrl) {
    return SearchResultCardWidget(
      imageUrl: imageUrl,
      title: title,
      category: category,
    );
  }

}
