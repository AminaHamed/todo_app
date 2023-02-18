import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(

        padding: EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add new Task',style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,),
            TextFormField(
            decoration: InputDecoration(
               hintText: 'Title'
            ),

            ),SizedBox(height: 10,),

            TextFormField(
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Description'
            ),
            ),
            SizedBox(height: 15,),
            Text('Select time:',style: Theme.of(context).textTheme.headline6,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(onTap: (){
                showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate:  DateTime.now().add(Duration(days: 365))

                );
              },
                  child: Text('15/7/2022',textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.grey
                      )
                  )),
            ),
            ElevatedButton(onPressed: (){}, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
