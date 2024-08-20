import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api/models/parcel_model.dart';
import '../api/services/parcel_service.dart';

class ParcelPage extends StatefulWidget {
  @override
  _ParcelPageState createState() => _ParcelPageState();
}

class _ParcelPageState extends State<ParcelPage> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  final ParcelService _parcelService = ParcelService();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) async {
    // Kadastral verileri alın
    try {
      final parcel = await _parcelService.fetchParcelInfo(
          position.latitude, position.longitude);

      if (parcel != null) {
        // Marker ekle
        setState(() {
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId(position.toString()),
              position: position,
              icon: BitmapDescriptor.defaultMarker,
            ),
          );

          // Poligon ekle
          if (parcel.coordinates != null) {
            _polygons.clear();
            _polygons.add(
              Polygon(
                polygonId: PolygonId(parcel.adaNo ?? 'polygon'),
                strokeColor: Colors.blue,
                strokeWidth: 2,
                fillColor: Colors.blue.withOpacity(0.15),
                onTap: () => showParcelInfoDialog(parcel),
              ),
            );
          }
        });

        showParcelInfoDialog(parcel);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Parsel bilgisi alınamadı')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  void showParcelInfoDialog(Parcel parcel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Parsel Bilgisi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('İl: ${parcel.ilAd ?? 'Bilinmiyor'}'),
              Text('İlçe: ${parcel.ilceAd ?? 'Bilinmiyor'}'),
              Text('Mahalle: ${parcel.mahalleAd ?? 'Bilinmiyor'}'),
              Text('Ada: ${parcel.adaNo ?? 'Bilinmiyor'}'),
              Text('Parsel: ${parcel.parselNo ?? 'Bilinmiyor'}'),
              Text('Alan: ${parcel.alan ?? 'Bilinmiyor'} m²'),
              Text('Nitelik: ${parcel.nitelik ?? 'Bilinmiyor'}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parsel Gösterimi'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(39.9334, 32.8597),
          zoom: 5.0,
        ),
        markers: _markers,
        polygons: _polygons,
        onTap: _onTap,
      ),
    );
  }
}
