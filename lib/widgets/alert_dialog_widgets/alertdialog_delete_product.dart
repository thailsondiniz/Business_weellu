import 'package:flutter/material.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/profile/profile_user_store.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;

class AlertDialogDeleteProduct extends StatefulWidget {
  final Item item;
  final String userId;
  final String dadosUser;
  const AlertDialogDeleteProduct(
      {super.key,
      required this.item,
      required this.userId,
      required this.dadosUser});

  @override
  State<AlertDialogDeleteProduct> createState() =>
      _AlertDialogDeleteProductState();
}

class _AlertDialogDeleteProductState extends State<AlertDialogDeleteProduct> {
  void deleteItem(String itemId, String imageUrl) async {
    final url = Uri.parse('${ApiRota.baseApi}itens/$itemId');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('item excluido com sucesso');
      // loadCatalogItems();
      functionDestaque();
    } else {
      print('Erro ao excluir o item: ${response.statusCode}');
    }
  }

  List<dynamic> dados = [];
  functionDestaque() async {
    final destaqueCatalog = await LoadDestaques().Destaques();
    setState(() {
      dados = destaqueCatalog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff343434),
      title: const Text(
        'Confirm deletion',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text('Are you sure you want to delete this item?',
          style: TextStyle(color: Colors.white)),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Delete', style: TextStyle(color: Colors.white)),
          onPressed: () async {
            try {
              deleteItem(widget.item.itemId.toString(),
                  widget.item.imageUrl.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('Produto excluido com sucesso!')),
              );
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('Erro ao excluir o produto: $error')),
              );
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileUserStore(
                  dadosUser: widget.dadosUser,
                  userId: widget.userId,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
