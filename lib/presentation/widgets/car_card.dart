import 'package:flutter/material.dart';
import '../../data/models/car.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final int index;
  final VoidCallback onDelete;
  final Function(String newTitle, String newDesc) onEdit;

  const CarCard({
    super.key,
    required this.car,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image.network(
          car.imageUrl,
          width: 70,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(car.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(car.description),
            const SizedBox(height: 5),
            Text("ID: ${car.id}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                final titleController = TextEditingController(text: car.title);
                final descriptionController = TextEditingController(text: car.description);

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Edit Car"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(labelText: 'Description'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onEdit(titleController.text, descriptionController.text);
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
