import 'package:flutter/material.dart';

class ConnectionLost extends StatelessWidget {
  final Future<void> Function(BuildContext) onRefresh;
  const ConnectionLost({
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 3,
      child: Column(
        children: [
          const Icon(
            Icons.wifi_off,
            size: 50,
          ),
          const SizedBox(height: 10),
          const Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => onRefresh(context),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
