import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_event.dart';
import 'package:weatherlite/presentation/blocs/location/locations_state.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.length >= 2) {
        context.read<LocationsBloc>().add(SearchCities(query));
      } else {
        context.read<LocationsBloc>().add(ClearSearch());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add City"),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              context.read<LocationsBloc>().add(DetectCurrentLocation());
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search city...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          context.read<LocationsBloc>().add(ClearSearch());
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: BlocBuilder<LocationsBloc, LocationsState>(
              builder: (context, state) {
                if (state is! LocationsLoaded) {
                  return const SizedBox.shrink();
                }

                if (state.isSearching) {
                  return const Center(child: CircularProgressIndicator());
                }

                final results = state.searchResults;

                if (results.isEmpty && _controller.text.length >= 2) {
                  return const Center(child: Text("No cities found"));
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final location = results[index];
                    final subtitle = [
                      if (location.region != null) location.region,
                      location.country,
                    ].join(", ");

                    return ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(location.name),
                      subtitle: Text(subtitle),
                      onTap: () {
                        context.read<LocationsBloc>().add(
                          AddLocation(location),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
