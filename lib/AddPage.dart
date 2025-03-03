import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final formKey = GlobalKey<FormState>();
  final toolNameController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('เพิ่มอุปกรณ์'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(label: const Text('ชื่อรายการ')),
              autofocus: true,
              controller: toolNameController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  print('value : $value');
                  return "กรุณากรอกข้อมูล";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(label: const Text('จำนวน')),
              keyboardType: TextInputType.number,
              controller: quantityController,
              validator: (String? value) {
                try {
                  int quantity = int.parse(value!);
                  if (quantity <= 0) {
                    return "กรุณากรอกจำนวนที่มากกว่า 0";
                  }
                } catch (e) {
                  return "กรุณาป้อนตัวเลขเท่านั้น";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print("object");
                }
              },
              child: const Text('เพิ่มข้อมูล'),
            ),
          ],
        ),
      ),
    );
  }
}
