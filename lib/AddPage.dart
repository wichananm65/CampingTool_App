import 'package:campingtool_app/model/campingtool.dart';
import 'package:campingtool_app/provider/campingtool_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final formKey = GlobalKey<FormState>();
  final toolNameController = TextEditingController();
  final quantityController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();

  final List<String> categorySelect = <String>[
    'การนอน',
    'การทำอาหาร',
    'เฟอร์นิเจอร์',
    'การเดินป่า',
    'เครื่องแต่งกาย',
    'อุปกรณ์ปฐมพยาบาล',
    'อื่นๆ',
  ];

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('เพิ่มอุปกรณ์'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อรายการ'),
                autofocus: true,
                controller: toolNameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกข้อมูล";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'จำนวน'),
                keyboardType: TextInputType.number,
                controller: quantityController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกจำนวน";
                  }
                  try {
                    int quantity = int.parse(value);
                    if (quantity <= 0) {
                      return "กรุณากรอกจำนวนที่มากกว่า 0";
                    }
                  } catch (e) {
                    return "กรุณาป้อนตัวเลขเท่านั้น";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'ระบุวันที่',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาเลือกวันที่";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'หมวดหมู่',
                  border: OutlineInputBorder(),
                ),
                value:
                    categoryController.text.isEmpty
                        ? null
                        : categoryController.text,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      categoryController.text = newValue;
                    });
                  }
                },
                items:
                    categorySelect.map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาเลือกหมวดหมู่";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var provider = Provider.of<CampingtoolProvider>(
                      context,
                      listen: false,
                    );
                    Campingtool item;
                    if (provider.campingTools.isEmpty) {
                      item = Campingtool(
                        keyID: 1,
                        toolName: toolNameController.text,
                        quantity: int.parse(quantityController.text),
                        date: DateFormat(
                          "dd/MM/yyyy",
                        ).parse(dateController.text),
                        category: categoryController.text,
                      );
                    } else {
                      item = Campingtool(
                        keyID: provider.campingTools.last.keyID,
                        toolName: toolNameController.text,
                        quantity: int.parse(quantityController.text),
                        date: DateFormat(
                          "dd/MM/yyyy",
                        ).parse(dateController.text),
                        category: categoryController.text,
                      );
                    }

                    provider.addCampingTool(item);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("เพิ่มอุปกรณ์สำเร็จ!")),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('เพิ่มอุปกรณ์'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
