import 'package:flutter/material.dart';

class PageSelect extends StatelessWidget{

  const PageSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Olá, usuário!"),
        actions: [IconButton(onPressed: (){
          Navigator.pushNamed(context, '/config');
        }, icon: const Icon(Icons.settings))],
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(onPressed: (){
                Navigator.of(context).pushNamed('/photograph');
              }, icon: const Icon(Icons.photo_camera), label: const Text("Tirar uma foto")),
              ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.file_upload), label: const Text("Escolher da galeria")),
            ],
          ),
        ),
      ),
    );
  }

}

