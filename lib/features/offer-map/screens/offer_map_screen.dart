import 'package:corre_aqui/util/images.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OfferMapScreen extends StatefulWidget {
  const OfferMapScreen({Key? key}) : super(key: key);

  @override
  _OfferMapScreenState createState() => _OfferMapScreenState();
}

class _OfferMapScreenState extends State<OfferMapScreen> {

  late GoogleMapController mapController;

  // INFO: Centro do mapa
  final LatLng _center = const LatLng(-11.2999, -41.8568);

  final List<Marker> _markers = [];
  String? _selectedPlaceName;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(72, 95)),
      Images.pinOffer,
    );

    setState(() {
      _markers.addAll([
        Marker(
          markerId: const MarkerId('1'),
          position: const LatLng(-11.3005, -41.8550),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "Marker 1"),
          onTap: () {
            setState(() {
              _selectedPlaceName = "Marker 1";
            });
          },
        ),
        Marker(
          markerId: const MarkerId('2'),
          position: const LatLng(-11.3020, -41.8580),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "Marker 2"),
          onTap: () {
            setState(() {
              _selectedPlaceName = "Marker 2";
            });
          },
        ),
      ]);
    });
  }

  /**
  * Executado quando o mapa é criado.
  *
  * @author Giovane Neves
  */
  void _onMapCreated(GoogleMapController controller) async {

    mapController = controller;

    // INFO: Seleciona o estilo do mapa
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
          if (_selectedPlaceName != null) _buildBottomSheet(),
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
              _selectedPlaceName ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Detalhes sobre este local aparecerão aqui.",
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Lógica para ação do botão
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text("Ver Direções"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
