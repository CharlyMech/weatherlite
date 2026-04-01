import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherlite/core/router/app_router.dart';
import 'package:weatherlite/presentation/blocs/location/locations_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_event.dart';
import 'package:weatherlite/presentation/blocs/location/locations_state.dart';
import 'package:weatherlite/presentation/widgets/common/adaptive_back_button.dart';

class SavedLocationsPage extends StatelessWidget {
  const SavedLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: const Text('Saved Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRoutes.addCity),
          ),
        ],
      ),
      body: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          if (state is! LocationsLoaded || state.locations.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_off,
                    size: 48,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No saved locations',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                        ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => context.push(AppRoutes.addCity),
                    icon: const Icon(Icons.add),
                    label: const Text('Add City'),
                  ),
                ],
              ),
            );
          }

          final locations = state.locations;

          return ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: locations.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              final reordered = List.of(locations);
              final item = reordered.removeAt(oldIndex);
              reordered.insert(newIndex, item);
              context
                  .read<LocationsBloc>()
                  .add(ReorderLocations(reordered));
            },
            itemBuilder: (context, index) {
              final location = locations[index];
              final subtitle = [
                if (location.region != null) location.region,
                location.country,
              ].where((s) => s != null && s.isNotEmpty).join(', ');

              return Dismissible(
                key: ValueKey(location.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  color: Theme.of(context).colorScheme.error,
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                onDismissed: (_) {
                  context
                      .read<LocationsBloc>()
                      .add(RemoveLocation(location.id));
                },
                child: ListTile(
                  leading: Icon(
                    location.isCurrentLocation
                        ? Icons.my_location
                        : Icons.location_city,
                  ),
                  title: Text(location.name),
                  subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                  onTap: () {
                    // Navigate back to home — the user can swipe to find it
                    context.go(AppRoutes.home);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
