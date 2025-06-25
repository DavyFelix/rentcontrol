import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rentcontrol/providers/casa_provider.dart';
import 'package:rentcontrol/services/location_selector.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AddCasaPage extends StatefulWidget {
  const AddCasaPage({super.key});

  @override
  State<AddCasaPage> createState() => _AddCasaPageState();
}

class _AddCasaPageState extends State<AddCasaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _ruaController = TextEditingController();
  final _locationController = TextEditingController();

  String? _locationText;
  bool _carregandoLocalizacao = false;

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final casaProvider = Provider.of<CasaProvider>(context, listen: false);

      final novaCasa = {
        'nome': _nomeController.text,
        'bairro': _bairroController.text,
        'rua': _ruaController.text,
        'criadoEm': Timestamp.now(),
      };

      casaProvider.adicionarCasa(novaCasa).then((_) {
        Navigator.pop(context);
      });
    }
  }

  Future<void> _buscarEnderecoPorCoordenadas(double lat, double lon) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&addressdetails=1',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'catalogo-jogos-app'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final address = data['address'];

      setState(() {
        _bairroController.text =
            address['suburb'] ??
            address['neighbourhood'] ??
            address['city_district'] ??
            '';
        _ruaController.text = address['road'] ?? '';
        _locationText = data['display_name'] ?? '';
        _locationController.text = _locationText!;
      });
    }
  }

  void _preencherBairroERua(Map<String, dynamic>? local) async {
    if (local == null) return;
    final lat = local['lat'];
    final lon = local['lon'];
    await _buscarEnderecoPorCoordenadas(lat, lon);
  }

  Future<void> _usarLocalizacaoAtual() async {
    setState(() => _carregandoLocalizacao = true);

    try {
      final ativo = await Geolocator.isLocationServiceEnabled();
      if (!ativo) throw Exception('Serviço de localização desativado.');

      LocationPermission permissao = await Geolocator.checkPermission();
      if (permissao == LocationPermission.denied) {
        permissao = await Geolocator.requestPermission();
      }
      if (permissao == LocationPermission.deniedForever ||
          permissao == LocationPermission.denied) {
        throw Exception('Permissão negada.');
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _buscarEnderecoPorCoordenadas(pos.latitude, pos.longitude);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao obter localização: $e')));
    }

    setState(() => _carregandoLocalizacao = false);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _bairroController.dispose();
    _ruaController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;
    final maxWidth = isWide ? 600.0 : double.infinity;

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Casa'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Informações da Casa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 32),

                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nomeController,
                              decoration: const InputDecoration(
                                labelText: 'Nome da Casa',
                                prefixIcon: Icon(Icons.home_outlined),
                              ),
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Informe o nome'
                                          : null,
                            ),
                            const SizedBox(height: 20),

                            ElevatedButton.icon(
                              onPressed:
                                  _carregandoLocalizacao
                                      ? null
                                      : _usarLocalizacaoAtual,
                              icon: const Icon(Icons.my_location),
                              label: Text(
                                _carregandoLocalizacao
                                    ? 'Buscando localização...'
                                    : 'Usar Localização Atual',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(45),
                              ),
                            ),
                            const SizedBox(height: 20),

                            TextFormField(
                              controller: _bairroController,
                              decoration: const InputDecoration(
                                labelText: 'Bairro',
                                prefixIcon: Icon(Icons.location_city_outlined),
                              ),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _ruaController,
                              decoration: const InputDecoration(
                                labelText: 'Rua',
                                prefixIcon: Icon(Icons.streetview_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      onPressed: _salvar,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar Casa'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
