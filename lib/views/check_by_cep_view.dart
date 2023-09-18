import 'package:flutter/material.dart';

class CheckByCepView extends StatelessWidget {
  const CheckByCepView({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      );
}
