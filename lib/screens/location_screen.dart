import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:latlong2/latlong.dart'; 
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final MapController _mapController = MapController(); 
  LatLng? _currentPosition;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _errorMessage = 'Layanan lokasi dinonaktifkan. Mohon aktifkan layanan lokasi.';
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorMessage = 'Izin lokasi ditolak. Mohon berikan izin lokasi.';
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorMessage = 'Izin lokasi ditolak secara permanen. Kami tidak dapat meminta izin.';
        _isLoading = false;
      });
      return;
    }

    
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
      if (_currentPosition != null) {
        _mapController.move(_currentPosition!, 15.0);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal mendapatkan lokasi: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Lokasi Teknisi'),
        backgroundColor: Colors.teal[400],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Informasi Lokasi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.teal[50],
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Text(
                        _errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      )
                    : _currentPosition == null
                        ? Text(
                            'Tidak dapat menemukan lokasi saat ini.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Lokasi Anda Saat Ini:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                              Text(
                                'Lon: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
          ),
          // Peta
          Expanded(
            child: _isLoading || _errorMessage.isNotEmpty || _currentPosition == null
                ? Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            _errorMessage.isNotEmpty
                                ? _errorMessage
                                : 'Tidak dapat menampilkan peta tanpa lokasi.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[700], fontSize: 16),
                          ),
                  )
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentPosition!,
                      initialZoom: 15.0,
                      onPositionChanged: (position, hasGesture) {
                        // Opsional: tangani perubahan posisi peta
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.safetyfeapps', // Ganti dengan package name aplikasi Anda
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentPosition!,
                            width: 80,
                            height: 80,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Daftar Teknisi!')),
          );
        },
        label: const Text('Daftar Teknisi'),
        icon: const Icon(Icons.people),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}