import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DamagedPage extends StatefulWidget {
  const DamagedPage({super.key});

  @override
  _DrawAndEditRectanglePageState createState() =>
      _DrawAndEditRectanglePageState();
}

class _DrawAndEditRectanglePageState extends State<DamagedPage> {
  final Set<Polygon> _polygons = {};
  final Set<Marker> _markers = {};
  List<LatLng> _currentRectanglePoints = [];
  Map<int, List<LatLng>> _rectangles = {};
  Map<int, List<Marker>> _rectangleMarkers = {};
  Map<int, Color> _rectangleColors = {};
  int _rectangleCount = 0;
  bool _showColorButtons = false;
  int? _currentRectangleId; // Şu anda seçilen dikdörtgenin ID'si

  void _onMapCreated(GoogleMapController controller) {}

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int j = polygon.length - 1;
    bool inside = false;

    for (int i = 0; i < polygon.length; i++) {
      if (polygon[i].longitude > point.longitude !=
              polygon[j].longitude > point.longitude &&
          point.latitude <
              (polygon[j].latitude - polygon[i].latitude) *
                      (point.longitude - polygon[i].longitude) /
                      (polygon[j].longitude - polygon[i].longitude) +
                  polygon[i].latitude) {
        inside = !inside;
      }
      j = i;
    }

    return inside;
  }

  void _onTap(LatLng position) {
    if (_showColorButtons) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen bir renk seçin')),
      );
      return;
    }

    setState(() {
      bool foundPolygon = false;

      for (var entry in _rectangles.entries) {
        int id = entry.key;
        List<LatLng> points = entry.value;

        if (_isPointInPolygon(position, points)) {
          _showPolygonDialog(id);
          foundPolygon = true;
          break;
        }
      }

      if (!foundPolygon) {
        if (_currentRectanglePoints.length < 4) {
          _currentRectanglePoints.add(position);

          // Eğer dört köşe tamamlanmışsa, yeni bir dikdörtgen ekleyin
          if (_currentRectanglePoints.length == 4) {
            _rectangleCount++;
            _rectangles[_rectangleCount] = List.from(_currentRectanglePoints);
            _rectangleColors[_rectangleCount] = Colors.blue; // Varsayılan renk
            _currentRectangleId = _rectangleCount;
            _showColorButtons = true; // Renk butonlarını göster
            _updatePolygonAndMarkers();

            // Yeni bir dikdörtgen için köşe noktalarını sıfırlayın
            _currentRectanglePoints.clear();
          }
        }
      }
    });
  }

  void _updateRectangle(int rectangleId, int index, LatLng newPosition) {
    setState(() {
      if (_rectangles.containsKey(rectangleId)) {
        _rectangles[rectangleId]![index] = newPosition;
        _updatePolygonAndMarkers();
      }
    });
  }

  Future<BitmapDescriptor> loadCustomIcon() async {
    return await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(24, 24)), 'assets/images/drag.png');
  }

  void _updatePolygonAndMarkers() {
    _polygons.clear();
    _markers.clear();

    _rectangles.forEach((id, points) async {
      _polygons.add(
        Polygon(
          polygonId: PolygonId('rectangle$id'),
          points: points,
          strokeColor: _rectangleColors[id] ?? Colors.blue,
          strokeWidth: 2,
          fillColor: (_rectangleColors[id] ?? Colors.blue).withOpacity(0.3),
          onTap: () => _showPolygonDialog(id),
        ),
      );
      if (_currentRectangleId == id) {
        _rectangleMarkers[id] = [
          Marker(
            markerId: MarkerId('corner1$id'),
            position: points[0],
            draggable: true,
            icon: await loadCustomIcon(),
            onDragEnd: (newPosition) => _updateRectangle(id, 0, newPosition),
          ),
          Marker(
            markerId: MarkerId('corner2$id'),
            position: points[1],
            draggable: true,
            icon: await loadCustomIcon(),
            onDragEnd: (newPosition) => _updateRectangle(id, 1, newPosition),
          ),
          Marker(
            markerId: MarkerId('corner3$id'),
            position: points[2],
            draggable: true,
            icon: await loadCustomIcon(),
            onDragEnd: (newPosition) => _updateRectangle(id, 2, newPosition),
          ),
          Marker(
            markerId: MarkerId('corner4$id'),
            position: points[3],
            draggable: true,
            icon: await loadCustomIcon(),
            onDragEnd: (newPosition) => _updateRectangle(id, 3, newPosition),
          ),
        ];

        _markers.addAll(_rectangleMarkers[id]!);
      }
    });
  }

  void _setRectangleColor(Color color) {
    if (_currentRectangleId != null) {
      setState(() {
        _rectangleColors[_currentRectangleId!] = color;
        _showColorButtons = false; // Renk butonlarını gizle
        _rectangleMarkers[_currentRectangleId!]!
            .clear(); // Mevcut dikdörtgenin marker'larını kaldır
        _currentRectangleId = null;
        _updatePolygonAndMarkers();
      });
    }
  }

  void _clearAllShapes() {
    setState(() {
      _polygons.clear();
      _markers.clear();
      _rectangles.clear();
      _rectangleMarkers.clear();
      _rectangleColors.clear();
      _currentRectanglePoints.clear();
      _rectangleCount = 0;
      _showColorButtons = false;
      _currentRectangleId = null;
    });
  }

  void _showPolygonDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hasarlı Bina Numarası: $id'),
          content: Text('İstenilen Bilgiler\nbu alana gelecek\n....\n....'),
          actions: [
            TextButton(
              child: Text('Kapat'),
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
        title: const Text('Hasarlı Bina Bilgi'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearAllShapes,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.883839, 30.6198274),
              zoom: 19.0,
            ),
            polygons: _polygons,
            markers: _markers,
            onTap: _onTap, // Handle map taps
          ),
          if (_showColorButtons)
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                children: [
                  _colorButton(Colors.red),
                  SizedBox(width: 10),
                  _colorButton(Colors.green),
                  SizedBox(width: 10),
                  _colorButton(Colors.yellow),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => _setRectangleColor(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
