import 'package:flutter/material.dart';
import 'quote_card.dart';
import 'task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Quote> quotes = [
    Quote(text: 'The only limit to our realization of tomorrow is our doubts of today.', author: 'Franklin D. Roosevelt'),
    Quote(text: 'In the middle of every difficulty lies opportunity.', author: 'Albert Einstein')
  ];

  void _addQuote(String text, String author) {
    setState(() {
      quotes.add(Quote(text: text, author: author));
    });
  }

  void _updateQuote(int index, String newText, String newAuthor) {
    setState(() {
      quotes[index] = Quote(text: newText, author: newAuthor);
    });
  }

  void _deleteQuote(int index) {
    setState(() {
      quotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    TextEditingController _authorController = TextEditingController();
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tugas PBB')
          
          ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input Quote',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _authorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input Author',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty && _authorController.text.isNotEmpty) {
                  _addQuote(_textController.text, _authorController.text);
                  _textController.clear();
                  _authorController.clear();
                }
              },
              child: Text('Add Quote'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _textController.text = quotes[index].text;
                      _authorController.text = quotes[index].author;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Edit Quote'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _textController,
                                decoration: InputDecoration(labelText: 'Edit Quote'),
                              ),
                              TextField(
                                controller: _authorController,
                                decoration: InputDecoration(labelText: 'Edit Author'),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                _updateQuote(index, _textController.text, _authorController.text);
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: QuoteCard(
                      quote: quotes[index],
                      delete: () => _deleteQuote(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}