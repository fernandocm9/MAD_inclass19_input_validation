import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const MyCustomForm(),
      ),
      routes: <String, WidgetBuilder>{
        '/form': (BuildContext context) => const MyCustomForm(),
        '/success': (BuildContext context) => const SuccessPage(),
      },
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: const Center(
        child: Text('Form submitted successfully!'),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your username',
              labelText: 'Username',
            ),
            // The validator receives the text that the user has
            // entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              } else if (value.length < 3) {
                return 'Username must be at least 3 characters';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            // The validator receives the text that the user has
            // entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password must be at least 8 characters:\n1 uppercase, 1 lowercase, 1 number';
              } else if(value.length < 8) {
                return 'Password must be at least 8 characters:\n1 uppercase, 1 lowercase, 1 number';
              } else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(value)) {
                return 'Password must be at least 8 characters:\n1 uppercase, 1 lowercase, 1 number';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid email';
              } else if(value.length < 5) {
                return 'Email must be at least 5 characters';
              } else if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 10,),
          InputDatePickerFormField(firstDate: DateTime(1925, 1, 1), lastDate: DateTime.now(), fieldLabelText: 'Date of Birth', fieldHintText: 'mm/dd/yyy',),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world, you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                    
                  );
                  await Future.delayed(const Duration(seconds: 5));
                  Navigator.pushNamed(context, '/success' );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
