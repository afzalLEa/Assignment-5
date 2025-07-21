import 'package:flutter/material.dart';

void main() {
  runApp(FeedbackApp());
}

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  double _rating = 5.0;
  String _selectedCategory = '';
  bool _agree = false;

  final _categories = ['Bug Report', 'Feature Request', 'General'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  final List<String> _features = [
    'Easy to Use',
    'Design',
    'Speed',
    'Support',
  ];

  final Map<String, bool> _selectedFeatures = {};

  @override
  void initState() {
    super.initState();
    for (var feature in _features) {
      _selectedFeatures[feature] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Flutter Feedback Form'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Name', _nameController),
            _buildTextField('Roll Number', _rollController),
            _buildTextField('Enter your feedback...', _feedbackController, maxLines: 5),
            const SizedBox(height: 16),
            Text('Rate your experience'),
            Slider(
              value: _rating,
              onChanged: (val) => setState(() => _rating = val),
              divisions: 5,
              max: 5,
              min: 0,
              label: _rating.round().toString(),
            ),
            const SizedBox(height: 10),
            Text('Select a category'),
            DropdownButtonFormField<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              items: _categories.map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat),
              )).toList(),
              hint: Text('Choose a category'),
              onChanged: (val) => setState(() => _selectedCategory = val!),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            Text('What features did you like?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ..._features.map((feature) => CheckboxListTile(
              title: Text(feature),
              value: _selectedFeatures[feature],
              onChanged: (val) => setState(() => _selectedFeatures[feature] = val!),
            )),
            CheckboxListTile(
              title: Text("I agree to the terms and conditions"),
              value: _agree,
              onChanged: (val) => setState(() => _agree = val!),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agree ? () {
                  // Handle form submission
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: InputBorder.none,
        ),
      ),
    );
  }
}