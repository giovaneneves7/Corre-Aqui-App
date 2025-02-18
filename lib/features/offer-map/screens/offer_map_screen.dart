import 'package:corre_aqui/features/category/controllers/category_controller.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/images.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since V0.0.1
 */
class OfferMapScreen extends StatefulWidget {
  const OfferMapScreen({Key? key}) : super(key: key);

  @override
  _OfferMapScreenState createState() => _OfferMapScreenState();
}

class _OfferMapScreenState extends State<OfferMapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-11.2999, -41.8568);
  final List<Marker> _markers = [];
  Store? _selectedPlace;
  BitmapDescriptor? _customIcon;
  int? _selectedCategoryId;


  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  /**
   * Carrega o ícone do marcador personalizado.
   */
  Future<void> _loadCustomMarker() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(72, 95)),
      Images.pinOffer,
    );

    setState(() {
      _customIcon = icon;
    });

    _loadStores();
  }

  /**
   * Carrega as lojas do controller e cria os marcadores no mapa.
   */
  Future<void> _loadStores() async {
    final storeController = Get.find<StoreController>();
    await storeController.getStoreList();

    if (_customIcon == null) return;

    setState(() {
      _markers.clear();
      for (var store in storeController.stores) {
        if (_selectedCategoryId == null || store.categoryId == _selectedCategoryId) {
          _markers.add(
            Marker(
              markerId: MarkerId(store.id.toString()),
              position: LatLng(
                (store.latitude != 0) ? store.latitude : -11.3 + store.id * 0.001,
                (store.longitude != 0) ? store.longitude : -41.85,
              ),
              icon: _customIcon!,
              infoWindow: InfoWindow(title: store.name),
              onTap: () {
                setState(() {
                  _selectedPlace = store;
                });
              },
            ),
          );
        }
      }
    });
  }

  Widget _buildCategoryFilter() {
    final categoryController = Get.find<CategoryController>();

    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: GetBuilder<CategoryController>( // <-- Alterado para GetBuilder
          builder: (categoryController) {
            if (categoryController.categoryList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return DropdownButton<int>(
              value: _selectedCategoryId,
              hint: const Text("Filtrar por categoria"),
              isExpanded: true,
              underline: const SizedBox(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                  _loadStores();
                });
              },
              items: [
                const DropdownMenuItem<int>(
                  value: null,
                  child: Text("Todas as Categorias"),
                ),
                ...categoryController.categoryList.map((category) {
                  return DropdownMenuItem<int>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }


  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String style = await DefaultAssetBundle.of(context).loadString('assets/maps/map_style.json');
    mapController.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            markers: Set.from(_markers),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          _buildCategoryFilter(),
          if (_selectedPlace?.name != null) _buildBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedPlace!.name ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _selectedPlace!.description ?? 'Nenhuma descrição foi adicionada',
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: _selectedPlace!.id));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text("Ir para Estabelecimento",),
              ),
            ),
          ],
        ),
      ),
    );
  }
}