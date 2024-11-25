import 'package:app_deia/controller/ct_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageConfig extends StatefulWidget{
  const PageConfig({super.key});

  @override
  State<PageConfig> createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {

  

  @override
  Widget build(BuildContext context) {

    OptionsController optionsController =
        Provider.of<OptionsController>(context, listen: true);

    int currModel = optionsController.getActiveModel();
    List<int> listOfModels = optionsController.getListOfModels();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selecione o modelo", style: Theme.of(context).textTheme.titleLarge,),
            const Divider(),
            ListView.separated(itemBuilder: (BuildContext context, int index) {
                    int model = listOfModels[index];
                    return ListTile(
                      leading: Icon(model == currModel ? Icons.check_box_outlined : Icons.check_box_outline_blank),
                      title: Text(optionsController.getModelName(listOfModels[index])),
                      onTap: (){
                        optionsController.switchModel(model);
                      },
                    );
                  }, separatorBuilder: (BuildContext conntext, int index) {
                    return const SizedBox(
                      height: 5,
                    );
                  }, itemCount: listOfModels.length, shrinkWrap: true,)
            
        
          ],
        ),
      ),
    );
  }
}