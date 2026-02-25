import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service Class
class CallService {
  Future<void> call(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot make call';
    }
  }
}


/// GetIt Locator
GetIt locator = GetIt.instance;


void setup() {
  locator.registerSingleton<CallService>(CallService());
}

/// UI Screen
class CallFunction extends StatefulWidget {
  const CallFunction({super.key});

  @override
  State<CallFunction> createState() => _CallFunctionState();
}

class _CallFunctionState extends State<CallFunction> {
  final CallService service = locator<CallService>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setup(); // register service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call Service")),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: "Enter Phone Number",
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                service.call(controller.text);
              },
              child: const Text("Call Now"),
            ),
          ],
        ),
      ),
    );
  }
}